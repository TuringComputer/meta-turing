do_install_append() {
  # fix pkgconfig .pc file
  sed -i -e s#I${STAGING_DIR_HOST}#I#g ${D}${libdir}/pkgconfig/*.pc
}