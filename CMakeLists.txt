cmake_minimum_required(VERSION 3.22)

project(Playground CXX)

set(CMAKE_CXX_STANDARD 20)

add_subdirectory(thirdparty/googletest-release-1.11.0)

set(SOURCES main.cpp)

add_executable(playground ${SOURCES} )
target_link_libraries(playground gtest gtest_main)