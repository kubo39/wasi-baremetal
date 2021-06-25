import ldc.attributes;

extern (C):
nothrow:
@nogc:
@system:

alias __wasi_fd_t = int;
alias __wasi_size_t = size_t;
alias __wasi_errno_t = ushort;
alias __wasi_exitcode_t = uint;

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
@llvmAttr("wasm-import-name", "fd_write")
extern int __imported_wasi_snapshot_preview1_fd_write(int arg0, int arg1, int arg2, int arg3) @trusted;

__wasi_errno_t __wasi_fd_write(__wasi_fd_t fd, const(__wasi_ciovec_t)* iovs, size_t iovs_len, __wasi_size_t* retptr0) @trusted
{
    int ret = __imported_wasi_snapshot_preview1_fd_write(cast(int) fd, cast(int) iovs, cast(int) iovs_len, cast(int) retptr0);
    return cast(ushort) ret;
}

@llvmAttr("noreturn")
@llvmAttr("wasm-import-module", "wasi_snapshot_preview1")
@llvmAttr("wasm-import-name", "proc_exit")
extern void __imported_wasi_snapshot_preview1_proc_exit(int arg0) @trusted;

@llvmAttr("noreturn")
void __wasi_proc_exit(__wasi_exitcode_t rval) @trusted
{
    __imported_wasi_snapshot_preview1_proc_exit(cast(int) rval);
}

void _start() @trusted
{
    const(ubyte)* s = cast(const(ubyte)*) "Hello, World!\n".ptr;
    int fd = 1;
    __wasi_ciovec_t iovs = { s, 14 };
    __wasi_size_t retp;
    int r = __wasi_fd_write(fd, &iovs, 1, &retp);
    if (r != 0)
        __wasi_proc_exit(r);
}
