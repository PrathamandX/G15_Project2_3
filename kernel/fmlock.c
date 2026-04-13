#include "types.h"
#include "param.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"

#define FM_MAX_LOCKS 32
#define FM_NAME_MAX  64
#define FM_READ      0
#define FM_WRITE     1

struct fmentry {
  int used;
  char name[FM_NAME_MAX];
  int readers;
  int writer;
};

struct {
  struct spinlock lock;
  struct fmentry e[FM_MAX_LOCKS];
} fmtable;

static struct fmentry*
fm_find(char *name)
{
  int i;
  for(i = 0; i < FM_MAX_LOCKS; i++){
    if(fmtable.e[i].used && strncmp(fmtable.e[i].name, name, FM_NAME_MAX) == 0)
      return &fmtable.e[i];
  }
  return 0;
}

static struct fmentry*
fm_get_or_alloc(char *name)
{
  struct fmentry *freee = 0;
  int i;

  for(i = 0; i < FM_MAX_LOCKS; i++){
    if(fmtable.e[i].used && strncmp(fmtable.e[i].name, name, FM_NAME_MAX) == 0)
      return &fmtable.e[i];
    if(!fmtable.e[i].used && freee == 0)
      freee = &fmtable.e[i];
  }

  if(freee){
    freee->used = 1;
    freee->readers = 0;
    freee->writer = 0;
    safestrcpy(freee->name, name, FM_NAME_MAX);
  }

  return freee;
}

void
fmlockinit(void)
{
  initlock(&fmtable.lock, "fmtable");
}

int
fm_acquire(char *name, int mode)
{
  struct fmentry *e;

  acquire(&fmtable.lock);
  for(;;){
    e = fm_get_or_alloc(name);
    if(e == 0){
      release(&fmtable.lock);
      return -1;
    }

    if(mode == FM_READ){
      if(e->writer == 0){
        e->readers++;
        release(&fmtable.lock);
        return 0;
      }
    } else {
      if(e->writer == 0 && e->readers == 0){
        e->writer = 1;
        release(&fmtable.lock);
        return 0;
      }
    }

    sleep(e, &fmtable.lock);
  }
}

int
fm_release(char *name, int mode)
{
  struct fmentry *e;
  void *chan;

  acquire(&fmtable.lock);
  e = fm_find(name);
  if(e == 0){
    release(&fmtable.lock);
    return -1;
  }

  if(mode == FM_READ){
    if(e->readers <= 0){
      release(&fmtable.lock);
      return -1;
    }
    e->readers--;
  } else {
    if(e->writer == 0){
      release(&fmtable.lock);
      return -1;
    }
    e->writer = 0;
  }

  chan = e;
  if(e->readers == 0 && e->writer == 0){
    e->used = 0;
    e->name[0] = 0;
  }

  wakeup(chan);
  release(&fmtable.lock);
  return 0;
}
