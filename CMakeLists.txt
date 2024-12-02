cmake_minimum_required(VERSION 3.31.1)

project(Example VERSION 0.0.1 LANGUAGES CXX)

find_package(CommonLibSSE CONFIG REQUIRED)

add_library(my_1_5_97_skse_plugin SHARED plugin.cpp)
target_link_libraries(my_1_5_97_skse_plugin PRIVATE CommonLibSSE::CommonLibSSE)
target_precompile_headers(my_1_5_97_skse_plugin PRIVATE PCH.h)
target_compile_features(my_1_5_97_skse_plugin PRIVATE cxx_std_23)
