#
# Install libjpeg from source
#

if (NOT libjpeg_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)

# Need dos2unix because libjpeg source has dos lines that break under unix.
external_source (dos2unix
    6.0.2
    dos2unix-6.0.2.tar.gz
    http://downloads.sourceforge.net/project/dos2unix/dos2unix/6.0.2)

message ("Installing ${dos2unix_NAME} into FlyEM build area: ${FLYEM_BUILD_DIR} ...")
ExternalProject_Add(${dos2unix_NAME}
    PREFIX            ${FLYEM_BUILD_DIR}
    URL               ${dos2unix_URL}
    UPDATE_COMMAND    ""
    PATCH_COMMAND     ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND     make prefix=${FLYEM_BUILD_DIR}
    BUILD_IN_SOURCE   1
    INSTALL_COMMAND   make prefix=${FLYEM_BUILD_DIR} install
)

external_source (libjpeg
    6b
    jpegsr6.zip
    http://downloads.sourceforge.net/project/libjpeg/libjpeg/6b)

message ("Installing ${libjpeg_NAME} into FlyEM build area: ${FLYEM_BUILD_DIR} ...")
ExternalProject_Add(${libjpeg_NAME}
    DEPENDS           ${dos2unix_NAME}
    PREFIX            ${FLYEM_BUILD_DIR}
    URL               ${libjpeg_URL}
    UPDATE_COMMAND    ${CMAKE_COMMAND} -E make_directory ${FLYEM_BUILD_DIR}/man/man1
    PATCH_COMMAND     ${FLYEM_BUILD_DIR}/bin/dos2unix ${libjpeg_SRC_DIR}/configure
    CONFIGURE_COMMAND ./configure --prefix=${FLYEM_BUILD_DIR} --enable-shared
    BUILD_COMMAND     make LIBTOOL=libtool
    BUILD_IN_SOURCE   1
    TEST_COMMAND      make check
    INSTALL_COMMAND   make LIBTOOL=libtool install
)

endif (NOT libjpeg_NAME)