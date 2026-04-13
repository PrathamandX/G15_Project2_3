#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define NWORKERS 3
#define MAXLINE  256
#define MAXNAME  64
#define MAXDATA  128

#define FM_READ  0
#define FM_WRITE 1

enum {
  OP_NONE = 0,
  OP_READ,
  OP_WRITE,
  OP_COPY,
  OP_RENAME,
  OP_DELETE,
  OP_META,
  OP_COMPRESS,
  OP_DECOMPRESS,
  OP_STOP
};

struct task {
  int op;
  char a[MAXNAME];
  char b[MAXNAME];
  char data[MAXDATA];
};

static void
appendstr(char *dst, char *src, int max)
{
  int n = strlen(dst);
  int i = 0;

  while(n + i < max - 1 && src[i]){
    dst[n + i] = src[i];
    i++;
  }
  dst[n + i] = 0;
}

static void
copystr(char *dst, char *src, int max)
{
  int i;
  for(i = 0; i < max - 1 && src[i]; i++)
    dst[i] = src[i];
  dst[i] = 0;
}


static int
endswith(char *s, char *suffix)
{
  int n = strlen(s);
  int m = strlen(suffix);
  if(m > n)
    return 0;
  return strcmp(s + n - m, suffix) == 0;
}

static int
build_rle_name(char *src, char *dst)
{
  int n = strlen(src);
  if(n + 4 >= MAXNAME)
    return -1;

  copystr(dst, src, MAXNAME);
  dst[n]   = '.';
  dst[n+1] = 'r';
  dst[n+2] = 'l';
  dst[n+3] = 'e';
  dst[n+4] = 0;
  return 0;
}

static int
build_decomp_name(char *src, char *dst)
{
  int n = strlen(src);

  if(endswith(src, ".rle")){
    if(n - 4 <= 0 || n - 4 >= MAXNAME)
      return -1;
    memmove(dst, src, n - 4);
    dst[n - 4] = 0;
    return 0;
  }

  if(n + 4 >= MAXNAME)
    return -1;

  copystr(dst, src, MAXNAME);
  dst[n]   = '.';
  dst[n+1] = 'o';
  dst[n+2] = 'u';
  dst[n+3] = 't';
  dst[n+4] = 0;
  return 0;
}

static void
log_result(char *op, char *a, char *b, int rc)
{
  int fd;
  char junk[64];

  if(fmlock("fops.log", FM_WRITE) < 0)
    return;

  fd = open("fops.log", O_CREATE | O_RDWR);
  if(fd >= 0){
    while(read(fd, junk, sizeof(junk)) > 0)
      ;
    fprintf(fd, "tick=%d pid=%d op=%s a=%s b=%s rc=%d\n",
        uptime(), getpid(), op, a ? a : "-", b ? b : "-", rc);
    close(fd);
  }

  fmunlock("fops.log", FM_WRITE);
}

static int
lock_two(char *a, int ma, char *b, int mb)
{
  if(strcmp(a, b) == 0){
    if(ma != mb)
      return -1;
    return fmlock(a, ma);
  }

  if(strcmp(a, b) < 0){
    if(fmlock(a, ma) < 0)
      return -1;
    if(fmlock(b, mb) < 0){
      fmunlock(a, ma);
      return -1;
    }
  } else {
    if(fmlock(b, mb) < 0)
      return -1;
    if(fmlock(a, ma) < 0){
      fmunlock(b, mb);
      return -1;
    }
  }

  return 0;
}

static void
unlock_two(char *a, int ma, char *b, int mb)
{
  if(strcmp(a, b) == 0){
    fmunlock(a, ma);
    return;
  }
  fmunlock(a, ma);
  fmunlock(b, mb);
}

static int
op_read(struct task *t)
{
  int fd, n, rc = -1;
  char buf[64];

  if(fmlock(t->a, FM_READ) < 0)
    goto out;

  fd = open(t->a, O_RDONLY);
  if(fd < 0)
    goto out_unlock;

  printf("\n[%d] read %s:\n", getpid(), t->a);
  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  printf("\n");

  close(fd);
  rc = 0;

out_unlock:
  fmunlock(t->a, FM_READ);
out:
  log_result("read", t->a, "", rc);
  return rc;
}

static int
op_write(struct task *t)
{
  int fd, rc = -1;

  if(fmlock(t->a, FM_WRITE) < 0)
    goto out;

  unlink(t->a);
  fd = open(t->a, O_CREATE | O_WRONLY);
  if(fd < 0)
    goto out_unlock;

  if(write(fd, t->data, strlen(t->data)) != strlen(t->data))
    goto out_close;

  write(fd, "\n", 1);
  rc = 0;

out_close:
  close(fd);
out_unlock:
  fmunlock(t->a, FM_WRITE);
out:
  log_result("write", t->a, "", rc);
  return rc;
}

static int
op_copy(struct task *t)
{
  int sfd = -1, dfd = -1, n, rc = -1;
  char buf[64];

  if(strcmp(t->a, t->b) == 0)
    goto out;

  if(lock_two(t->a, FM_READ, t->b, FM_WRITE) < 0)
    goto out;

  sfd = open(t->a, O_RDONLY);
  if(sfd < 0)
    goto out_unlock;

  unlink(t->b);
  dfd = open(t->b, O_CREATE | O_WRONLY);
  if(dfd < 0)
    goto out_close_src;

  while((n = read(sfd, buf, sizeof(buf))) > 0){
    if(write(dfd, buf, n) != n)
      goto out_close_both;
  }

  rc = 0;

out_close_both:
  close(dfd);
out_close_src:
  close(sfd);
out_unlock:
  unlock_two(t->a, FM_READ, t->b, FM_WRITE);
out:
  log_result("copy", t->a, t->b, rc);
  return rc;
}

static int
op_rename(struct task *t)
{
  int rc = -1;

  if(strcmp(t->a, t->b) == 0)
    return 0;

  if(lock_two(t->a, FM_WRITE, t->b, FM_WRITE) < 0)
    goto out;

  if(link(t->a, t->b) < 0)
    goto out_unlock;

  if(unlink(t->a) < 0){
    unlink(t->b);
    goto out_unlock;
  }

  rc = 0;

out_unlock:
  unlock_two(t->a, FM_WRITE, t->b, FM_WRITE);
out:
  log_result("rename", t->a, t->b, rc);
  return rc;
}

static int
op_delete(struct task *t)
{
  int rc = -1;

  if(fmlock(t->a, FM_WRITE) < 0)
    goto out;

  if(unlink(t->a) < 0)
    goto out_unlock;

  rc = 0;

out_unlock:
  fmunlock(t->a, FM_WRITE);
out:
  log_result("delete", t->a, "", rc);
  return rc;
}

static char*
typename(short type)
{
  if(type == T_DIR)    return "DIR";
  if(type == T_FILE)   return "FILE";
  if(type == T_DEVICE) return "DEVICE";
  return "UNKNOWN";
}

static int
op_meta(struct task *t)
{
  int fd, rc = -1;
  struct stat st;

  if(fmlock(t->a, FM_READ) < 0)
    goto out;

  fd = open(t->a, O_RDONLY);
  if(fd < 0)
    goto out_unlock;

  if(fstat(fd, &st) < 0)
    goto out_close;

  printf("[%d] meta %s: type=%s ino=%d nlink=%d size=%d\n",
       getpid(), t->a, typename(st.type), st.ino, st.nlink, (int)st.size);

  rc = 0;

out_close:
  close(fd);
out_unlock:
  fmunlock(t->a, FM_READ);
out:
  log_result("meta", t->a, "", rc);
  return rc;
}

static int
op_compress(struct task *t)
{
  int sfd = -1, dfd = -1, n, rc = -1, count;
  char dst[MAXNAME];
  unsigned char prev, cur;
  unsigned char pair[2];

  if(build_rle_name(t->a, dst) < 0)
    goto out;
  if(strcmp(t->a, dst) == 0)
    goto out;

  if(lock_two(t->a, FM_READ, dst, FM_WRITE) < 0)
    goto out;

  sfd = open(t->a, O_RDONLY);
  if(sfd < 0)
    goto out_unlock;

  unlink(dst);
  dfd = open(dst, O_CREATE | O_WRONLY);
  if(dfd < 0)
    goto out_close_src;

  n = read(sfd, &prev, 1);
  if(n < 0)
    goto out_close_both;
  if(n == 0){
    rc = 0;
    goto out_close_both;
  }

  count = 1;
  while((n = read(sfd, &cur, 1)) == 1){
    if(cur == prev && count < 255){
      count++;
    } else {
      pair[0] = (unsigned char)count;
      pair[1] = prev;
      if(write(dfd, pair, 2) != 2)
        goto out_close_both;
      prev = cur;
      count = 1;
    }
  }

  pair[0] = (unsigned char)count;
  pair[1] = prev;
  if(write(dfd, pair, 2) != 2)
    goto out_close_both;

  rc = 0;

out_close_both:
  close(dfd);
out_close_src:
  close(sfd);
out_unlock:
  unlock_two(t->a, FM_READ, dst, FM_WRITE);
out:
  log_result("compress", t->a, dst, rc);
  return rc;
}

static int
op_decompress(struct task *t)
{
  int sfd = -1, dfd = -1, i, rc = -1;
  char dst[MAXNAME];
  unsigned char pair[2];

  if(build_decomp_name(t->a, dst) < 0)
    goto out;
  if(strcmp(t->a, dst) == 0)
    goto out;

  if(lock_two(t->a, FM_READ, dst, FM_WRITE) < 0)
    goto out;

  sfd = open(t->a, O_RDONLY);
  if(sfd < 0)
    goto out_unlock;

  unlink(dst);
  dfd = open(dst, O_CREATE | O_WRONLY);
  if(dfd < 0)
    goto out_close_src;

  while(read(sfd, pair, 2) == 2){
    for(i = 0; i < pair[0]; i++){
      if(write(dfd, &pair[1], 1) != 1)
        goto out_close_both;
    }
  }

  rc = 0;

out_close_both:
  close(dfd);
out_close_src:
  close(sfd);
out_unlock:
  unlock_two(t->a, FM_READ, dst, FM_WRITE);
out:
  log_result("decompress", t->a, dst, rc);
  return rc;
}

static void
handle_task(struct task *t)
{
  int rc = -1;

  if(t->op == OP_READ)           rc = op_read(t);
  else if(t->op == OP_WRITE)     rc = op_write(t);
  else if(t->op == OP_COPY)      rc = op_copy(t);
  else if(t->op == OP_RENAME)    rc = op_rename(t);
  else if(t->op == OP_DELETE)    rc = op_delete(t);
  else if(t->op == OP_META)      rc = op_meta(t);
  else if(t->op == OP_COMPRESS)  rc = op_compress(t);
  else if(t->op == OP_DECOMPRESS) rc = op_decompress(t);

  if(rc < 0)
    printf("[%d] operation failed\n", getpid());
}

static void
usage(void)
{
  printf("usage:\n");
  printf("  fops read <file>\n");
  printf("  fops write <file> <text>\n");
  printf("  fops copy <src> <dst>\n");
  printf("  fops rename <old> <new>\n");
  printf("  fops delete <file>\n");
  printf("  fops meta <file>\n");
  printf("  fops compress <file>\n");
  printf("  fops decompress <file.rle>\n");
}


static int
build_task_from_argv(int argc, char *argv[], struct task *t)
{
  memset(t, 0, sizeof(*t));

  if(argc < 2)
    return -1;

  if(strcmp(argv[1], "read") == 0){
    if(argc != 3) return -1;
    t->op = OP_READ;
    copystr(t->a, argv[2], sizeof(t->a));
    return 0;
  }

  if(strcmp(argv[1], "write") == 0){
    int i;
    if(argc < 4) return -1;
    t->op = OP_WRITE;
    copystr(t->a, argv[2], sizeof(t->a));

    t->data[0] = 0;
    for(i = 3; i < argc; i++){
      if(strlen(t->data) + strlen(argv[i]) + 2 >= sizeof(t->data))
        break;
      if(i > 3)
        appendstr(t->data, " ", sizeof(t->data));
      appendstr(t->data, argv[i], sizeof(t->data));
    }
    return 0;
  }

  if(strcmp(argv[1], "copy") == 0){
    if(argc != 4) return -1;
    t->op = OP_COPY;
    copystr(t->a, argv[2], sizeof(t->a));
    copystr(t->b, argv[3], sizeof(t->b));
    return 0;
  }

  if(strcmp(argv[1], "rename") == 0){
    if(argc != 4) return -1;
    t->op = OP_RENAME;
    copystr(t->a, argv[2], sizeof(t->a));
    copystr(t->b, argv[3], sizeof(t->b));
    return 0;
  }

  if(strcmp(argv[1], "delete") == 0){
    if(argc != 3) return -1;
    t->op = OP_DELETE;
    copystr(t->a, argv[2], sizeof(t->a));
    return 0;
  }

  if(strcmp(argv[1], "meta") == 0){
    if(argc != 3) return -1;
    t->op = OP_META;
    copystr(t->a, argv[2], sizeof(t->a));
    return 0;
  }

  if(strcmp(argv[1], "compress") == 0){
    if(argc != 3) return -1;
    t->op = OP_COMPRESS;
    copystr(t->a, argv[2], sizeof(t->a));
    return 0;
  }

  if(strcmp(argv[1], "decompress") == 0){
    if(argc != 3) return -1;
    t->op = OP_DECOMPRESS;
    copystr(t->a, argv[2], sizeof(t->a));
    return 0;
  }

  return -1;
}

static void
worker(int rfd)
{
  struct task t;

  while(read(rfd, &t, sizeof(t)) == sizeof(t)){
    if(t.op == OP_STOP)
      break;
    handle_task(&t);
  }

  close(rfd);
  exit(0);
}

static void
producer_once(int q[NWORKERS][2], struct task *task)
{
  int i;
  struct task stop;

  if(write(q[0][1], task, sizeof(*task)) != sizeof(*task)){
    printf("queue write failed\n");
  }

  memset(&stop, 0, sizeof(stop));
  stop.op = OP_STOP;

  for(i = 0; i < NWORKERS; i++){
    write(q[i][1], &stop, sizeof(stop));
    close(q[i][1]);
  }

  while(wait(0) > 0)
    ;

  exit(0);
}

int
main(int argc, char *argv[])
{
  int i, j;
  int q[NWORKERS][2];
  struct task t;

  if(build_task_from_argv(argc, argv, &t) < 0){
    usage();
    exit(1);
  }

  for(i = 0; i < NWORKERS; i++){
    if(pipe(q[i]) < 0){
      fprintf(2, "pipe failed\n");
      exit(1);
    }
  }

  for(i = 0; i < NWORKERS; i++){
    if(fork() == 0){
      for(j = 0; j < NWORKERS; j++){
        close(q[j][1]);
        if(j != i)
          close(q[j][0]);
      }
      worker(q[i][0]);
    }
  }

  for(i = 0; i < NWORKERS; i++)
    close(q[i][0]);

  producer_once(q, &t);
  return 0;
}
