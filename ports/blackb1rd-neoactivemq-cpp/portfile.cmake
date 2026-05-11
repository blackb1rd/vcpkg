vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO blackb1rd/neoactivemq-cpp
    REF "v${VERSION}"
    SHA512 cd5c7b8d335f46a909750898a3fe5ba4dba9f5d8f866c0deb77be398e5f103ff228388f7b8f15f12f0e8827bc402ff1af10da683639a623d505f06e44f6bf23f
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
