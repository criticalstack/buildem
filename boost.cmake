#
# Install boost libraries from source
#

if (NOT boost_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)

include (python)
include (zlib)

include_directories (${FLYEM_BUILD_DIR}/include)

external_source (boost
    1_51_0
    boost_1_51_0.tar.gz
    http://downloads.sourceforge.net/project/boost/boost/1.51.0)

message ("Installing ${boost_NAME} into FlyEM build area: ${FLYEM_BUILD_DIR} ...")
ExternalProject_Add(${boost_NAME}
    DEPENDS ${python_NAME} ${zlib_NAME}
    PREFIX ${FLYEM_BUILD_DIR}
    URL ${boost_URL}
    UPDATE_COMMAND ""
    PATCH_COMMAND ""
    CONFIGURE_COMMAND ./bootstrap.sh 
        --with-python=${PYTHON_EXE} 
        --prefix=${FLYEM_BUILD_DIR}
        LDFLAGS=-L${FLYEM_BUILD_DIR}/lib
        CPPFLAGS=-I${FLYEM_BUILD_DIR}/include
    BUILD_COMMAND ./b2 
        -sNO_BZIP2=1 
        -sZLIB_INCLUDE=${FLYEM_BUILD_DIR}/include 
        -sZLIB_SOURCE=${zlib_SRC_DIR} install
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND ""
)

endif (NOT boost_NAME)
