cmake_minimum_required(VERSION 3.16)

project(Qt6MultiPlatformDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(MSVC)
    add_compile_options("/utf-8")
endif()

find_package(Qt6 REQUIRED COMPONENTS Quick )

qt_standard_project_setup(REQUIRES 6.8)

#设置安卓最低sdk版本和编译目标版本
if(ANDROID)
    set(CMAKE_ANDROID_API 28)
    set(CMAKE_ANDROID_TARGET_SDK 34)
    set(CMAKE_ANDROID_SDK 34)
endif()

#递归添加android文件夹中的所有文件（为了方便在IDE中查看文件）
if(ANDROID)
file(GLOB_RECURSE ANDROID_FILES "${CMAKE_SOURCE_DIR}/android/*")
add_custom_target(android SOURCES ${ANDROID_FILES})
endif()
#设置工程输出目录
set(PROJECT_BUILD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/projectbuilddir)
set(OUTPUT_BIN_DIR ${PROJECT_BUILD_DIR}/bin)

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

qt_add_qml_module(${PROJECT_NAME}
    URI multiPlatformDemo
    VERSION 1.0
    QML_FILES
    Main.qml
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_BIN_DIR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE

)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
