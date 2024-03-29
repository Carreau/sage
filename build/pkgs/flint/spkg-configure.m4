SAGE_SPKG_CONFIGURE([flint], [
    SAGE_SPKG_DEPCHECK([mpfr], [
        AC_CHECK_HEADER(flint/flint.h, [dnl
          dnl gr_get_fexpr appears in Flint 3.0
          AC_SEARCH_LIBS([gr_get_fexpr], [flint], [dnl
            dnl Flint 3.1 is too new
            AC_MSG_CHECKING([whether FLINT version is >= 3.1.0])
            AC_COMPILE_IFELSE([dnl
              AC_LANG_PROGRAM([[#include <flint/flint.h>
                                #if __FLINT_RELEASE >= 30100
                                # error "FLINT 3.1 is too new"
                                #endif
                              ]])
            ], [dnl
              AC_MSG_RESULT([no])
            ], [dnl
              AC_MSG_RESULT([yes; too new])
              sage_spkg_install_flint=yes
            ])
          ], [sage_spkg_install_flint=yes])
        ], [sage_spkg_install_flint=yes])
    ])
], [], [], [dnl
     if test x$sage_spkg_install_flint = xyes; then
        AC_SUBST(SAGE_FLINT_PREFIX, ['$SAGE_LOCAL'])
     else
        AC_SUBST(SAGE_FLINT_PREFIX, [''])
     fi
])
