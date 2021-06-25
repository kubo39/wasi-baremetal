extern (C):
nothrow:
@nogc:

import ldc.attributes;

alias __wasi_fd_t = int;
alias __wasi_filesize_t = ulong;
alias __wasi_size_t = size_t;

struct __wasi_ciovec_t
{
    const(ubyte)* buf;
    __wasi_size_t buf_len;
}
static assert(__wasi_ciovec_t.sizeof == 8);
static assert(__wasi_ciovec_t.alignof == 4);
static assert(__wasi_ciovec_t.buf.offsetof == 0);
static assert(__wasi_ciovec_t.buf_len.offsetof == 4);

@llvmAttr("wasm-import-module", "wasi_snapshot_preview1")
@llvmAttr("wasm-import-name", "fd_allocate")
extern int __imported_wasi_snapshot_preview1_fd_allocate(int arg0, long arg1, long arg2);

ushort __wasi_fd_allocate(__wasi_fd_t fd, __wasi_filesize_t offset, __wasi_filesize_t len)
{
    int ret = __imported_wasi_snapshot_preview1_fd_allocate(cast(int) fd, cast(long) offset, cast(long) len);
    return cast(ushort) ret;
}

@llvmAttr("wasm-import-module", "wasi_snapshot_preview1")
@llvmAttr("wasm-import-name","fd_close")
extern int __imported_wasi_snapshot_preview1_fd_close(int arg0);

ushort __wasi_fd_close(__wasi_fd_t fd)
{
    int ret = __imported_wasi_snapshot_preview1_fd_close(cast(int) fd);
    return cast(ushort) ret;
}

@llvmAttr("wasm-import-module", "wasi_snapshot_preview1")
@llvmAttr("wasm-import-name", "fd_write")
extern int __imported_wasi_snapshot_preview1_fd_write(int arg0, int arg1, int arg2, int arg3);

ushort __wasi_fd_write(__wasi_fd_t fd, const(__wasi_ciovec_t)* iovs, size_t iovs_len, __wasi_size_t* retptr0)
{
    int ret = __imported_wasi_snapshot_preview1_fd_write(cast(int) fd, cast(int) iovs, cast(int) iovs_len, cast(int) retptr0);
    return cast(ushort) ret;
}

void _start()
{
    const(ubyte)* s = cast(const(ubyte)*) "Hello!\n".ptr;
    __wasi_fd_t fd = 1;
    __wasi_fd_allocate(fd, 0, 7);
    __wasi_ciovec_t iovs = { s, 7 };
    __wasi_size_t ret;
    __wasi_fd_write(fd, &iovs, 1, &ret);
    __wasi_fd_close(fd);
}
