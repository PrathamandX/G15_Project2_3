## Multithreaded File Management System on xv6  
### (Producer-Consumer Based Concurrent File Operations)

This project implements a **concurrent file management system** on the **xv6 operating system** for Operating Systems Lab (Project 2.3).  
It demonstrates core OS concepts such as producer-consumer task distribution, synchronization, kernel/user interaction, and safe file operations under concurrency.

Although xv6 does not provide a full pthread-style user thread library, the project uses multiple worker processes (`fork`) to simulate concurrent workers.  
The producer accepts file-operation requests, sends tasks through a pipe, and consumers execute them with kernel-level file locks.

---

## Project Goals

- Build a file management system on xv6
- Support concurrent file operations safely
- Implement producer-consumer style task handling
- Add synchronization for shared file access
- Include robust error handling and operation logging
- Demonstrate compression and decompression in xv6

---

## Core Design

### 1) Producer-Consumer Workflow
- **Producer:** main `fmops` process parses command-line request and queues task
- **Consumers:** worker processes created using `fork()`
- **Queue/Communication:** pipes between producer and workers

### 2) Kernel-Level Synchronization
Two custom syscalls were added:
- `fmlock(path, mode)` – acquire file lock
- `fmunlock(path, mode)` – release file lock

Locking behavior:
- Multiple readers can access a file together
- Only one writer can write at a time
- Writers are blocked if readers are active
- No concurrent access while writer lock is held

---

## Features Implemented

The system includes all required nine features:

1. **Concurrent file reading** (shared read locks)  
2. **Exclusive file writing** (write locks)  
3. **Safe file deletion**  
4. **File renaming** (`link + unlink` in xv6)  
5. **File copying** (source read lock + destination write lock)  
6. **File metadata display** (type, inode, links, size)  
7. **Robust error handling**  
8. **Operation logging** in `fmops.log`  
9. **Compression and decompression** using simple RLE

---

## Command Usage

Run from xv6 shell:

```sh
fmops read <file>
fmops write <file> <text>
fmops copy <src> <dst>
fmops rename <old> <new>
fmops delete <file>
fmops meta <file>
fmops compress <file>
fmops decompress <file.rle>
```

Example log format:

```text
tick=123 pid=5 op=copy a=src1 b=dst1 rc=0
```

---

## Build & Run

From xv6 root directory:

```sh
make clean
make qemu
```

Inside xv6 shell (sample setup):

```sh
echo hello_world > a
echo operating_systems_lab > b
echo aaaaabbbbcccccc > comp
```

Then run operations such as:

```sh
fmops read a
fmops write a new_content
fmops copy a c
fmops rename c d
fmops meta d
fmops compress comp
fmops decompress comp.rle
fmops delete d
cat fmops.log
```

---

## Codebase Changes

### New Files
- `kernel/fmlock.c` – file lock manager in kernel
- `user/fm.c` – user-space file management tool

### Modified Files
- `kernel/defs.h`
- `kernel/main.c`
- `kernel/syscall.h`
- `kernel/syscall.c`
- `kernel/sysfile.c`
- `user/user.h`
- `user/usys.pl`
- `Makefile`

---

## Testing Summary

The implementation was tested for:
- repeated concurrent reads
- serialized writes without corruption
- safe delete/rename/copy behavior
- metadata correctness
- graceful failures for invalid operations
- complete operation logging (success + failure)
- compression/decompression round-trip correctness

All nine required functionalities were implemented and validated in the project report test sequence.

---

## Limitations

- Uses **process-based concurrency** (`fork`) instead of true user-level threads
- Rename is implemented as `link + unlink` (no native xv6 `rename`)
- Metadata fields are limited to xv6 `stat` support
- Compression uses simple RLE (not general-purpose compression like gzip)
- Lock fairness is basic; heavy read traffic may delay writers

---

## Learning Outcomes

This project provides practical experience in:
- extending xv6 with custom system calls
- reader-writer style synchronization in kernel space
- safe concurrent file access patterns
- producer-consumer design in OS-level programming
- building reliable systems with logging and error handling

---

## Team

- Prathamesh Vispute
- Pranjul
- Prathyush P
- Punit
- Poka Sireesha
- Prabir Soren
