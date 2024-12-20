cmake_minimum_required(VERSION 3.31.1)

project(ExampleCMakePo3 VERSION 0.0.1 LANGUAGES CXX)

find_package(CommonLibSSE CONFIG REQUIRED)

add_library(${PROJECT_NAME} SHARED plugin.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE CommonLibSSE::CommonLibSSE)
target_precompile_headers(${PROJECT_NAME} PRIVATE PCH.h)
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_23)
