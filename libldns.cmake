include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

if (NOT libldns_NAME)

external_git_repo (libldns
    master
    https://github.com/NLnetLabs/ldns)


ExternalProject_Add(${libldns_NAME}
    PREFIX          ${BUILDEM_DIR}
    GIT_REPOSITORY  ${libldns_URL}
    GIT_TAG         ${libldns_TAG}
    UPDATE_COMMAND  ""
    BUILD_IN_SOURCE 1
    TEST_COMMAND    ""
    PATCH_COMMAND   libtoolize -c --install && autoreconf --install 
    CONFIGURE_COMMAND ${BUILDEM_ENV_STR} ${libldns_SRC_DIR}/configure
        --enable-static
        --disable-shared
        --prefix=${BUILDEM_DIR}
        --disable-dependency-tracking
        --disable-ldns-config
        --disable-sha2
        --disable-gost
        --disable-ecdsa
        --disable-dane
        --enable-draft-rrtypes
        --without-pyldnsx
    INSTALL_COMMAND ${BUILDEM_ENV_STRING} make install 
    BUILD_COMMAND   ${BUILDEM_ENV_STRING} make 
)

endif()
