FILESEXTRAPATHS_prepend := "${THISDIR}/php-5.6.23/:"

# Adding patch to fix lpthread link error
SRC_URI += "file://0001-Add-lpthread-to-link.patch"

# Adding apache2 to PACKAGECONFIG
PACKAGECONFIG ??= "mysql sqlite3 imap apache2 \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}"

