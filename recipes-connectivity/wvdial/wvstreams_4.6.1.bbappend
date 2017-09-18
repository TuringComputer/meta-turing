# Turing Computer: this come from pyro branch

DEPENDS_append_libc-musl = " argp-standalone libexecinfo"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://gcc-6.patch \
           file://argp.patch \
           file://0001-Check-for-limits.h-during-configure.patch \
           file://0002-wvtask-Dont-use-ucontext-on-non-glibc-systems.patch \
           file://0003-wvtask-Check-for-HAVE_LIBC_STACK_END-only-on-glibc-s.patch \
           file://0004-wvcrash-Replace-use-of-basename-API.patch \
           file://0005-check-for-libexecinfo-during-configure.patch \
           file://0001-build-fix-parallel-make.patch \
           file://0002-wvrules.mk-Use-_DEFAULT_SOURCE.patch \
           "

# Turing Computer: this removes package from blacklist and fix runtime crashes
PNBLACKLIST[wvstreams] = ""
TARGET_CFLAGS_append = " -O0"
TARGET_CXXFLAGS_append = " -O0"