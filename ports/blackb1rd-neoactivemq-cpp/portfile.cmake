vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO blackb1rd/neoactivemq-cpp
    REF "v${VERSION}"
    SHA512 c016cfbf98ac77595c177aff036fa0fd06b68633ddd3f62d2ac70b340cd26b2a23cb0d82e6e2d47aae5fae26786e6cf5b7b8959cd37f223c8c0211c53cf4b3cf
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        ssl AMQCPP_USE_SSL
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" AMQCPP_SHARED_LIB)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DAMQCPP_BUILD_EXAMPLES=OFF
        -DAMQCPP_BUILD_TESTS=OFF
        -DAMQCPP_SHARED_LIB=${AMQCPP_SHARED_LIB}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/neoactivemq-cpp)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
