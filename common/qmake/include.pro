include( findsources.pro.inc )
include( breakpad.pro.inc )
include( debug.pro.inc )
#win32:include( manifest.pro.inc )
include( QtOverride.pro.inc )

linux*:CONFIG += link_pkgconfig

CONFIG( service ) {
    CONFIG += plugin
    TARGET = $$TARGET.service
}

CONFIG( extension ) {
    CONFIG += plugin
    TARGET = $$TARGET.extension
}

CONFIG( core ):LIBS += -lcore
CONFIG( ws ) {
    LIBS += -lws
    QT += xml network
}
CONFIG( types ):LIBS += -ltypes
CONFIG( unicorn ):LIBS += -lunicorn
CONFIG( moose ):LIBS += -lmoose
CONFIG( radio ):LIBS += -lradio
CONFIG( scrobble ):LIBS += -lscrobble

CONFIG( qtestlib ) {
    DESTDIR = $$DESTDIR/tests
}

CONFIG( taglib ) {
    linux*: PKGCONFIG += taglib
    else: LIBS += -L$$COMMON_LIBS_DIR/taglib/taglib -ltag
}

CONFIG( mad ) {
    linux*: PKGCONFIG += mad
    else: LIBS += -L$$COMMON_LIBS_DIR/libmad -lmad
}


defineTest( generateVersionHeader ) {
	DEFINE = $${LITERAL_HASH}define

	win32 {
		# Windows is different for some reason :( *cries*
	    system( echo '$$DEFINE VERSION "$$VERSION"' > version.h )
	    system( echo '$$DEFINE PRODUCT_NAME "$$TARGET"' >> version.h )
	}
	else {
	    system( echo \\'$$DEFINE VERSION \\\"$$VERSION\\\"\\' > version.h )
	    system( echo \\'$$DEFINE PRODUCT_NAME \\\"$$TARGET\\\"\\' >> version.h )
	}
}


# you also need to QMAKE_EXTRA_INCLUDES += Makefile.dmg sadly
defineReplace( generateInstallerMakefile ) {
	macx*:!macx-xcode:release:contains( TEMPLATE, app ) {
		system( $$ROOT_DIR/common/dist/mac/Makefile.dmg.pl $$DESTDIR $$VERSION $$QMAKE_LIBDIR_QT $$LIBS > Makefile.dmg )
		return( Makefile.dmg )
	}
}
