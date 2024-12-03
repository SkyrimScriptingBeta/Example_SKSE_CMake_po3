cmake_minimum_required(VERSION 3.31.1)

project(SkseExampleUsingPowerof3 VERSION 0.0.1 LANGUAGES CXX)

include(add_skse_plugin)
include(add_papyrus_project)
include(add_skyrim_mod)

# find_package(CommonLibSSE CONFIG REQUIRED)

# add_library(my_1_5_97_skse_plugin SHARED plugin.cpp)
# target_link_libraries(my_1_5_97_skse_plugin PRIVATE CommonLibSSE::CommonLibSSE)
# target_precompile_headers(my_1_5_97_skse_plugin PRIVATE PCH.h)
# target_compile_features(my_1_5_97_skse_plugin PRIVATE cxx_std_23)

# add_skse_plugin(my_1_5_97_skse_plugin
# NAME "MyPlugin"
# VERSION "1.0.0"
# AUTHOR "Me"
# EMAIL "me@example.org"
# SOURCES plugin.cpp
# CXX_STANDARD 23
# PRECOMPILE_HEADERS foo.h
# SKIP_PLUGIN_DEFINITION
# NG
# )

# add_papyrus_project(my_papyrus_project
# PYRO_PATH "..."
# PPJ_FILE skyrimse.ppj
# )

# add_skyrim_mod(target_name
# MOD_NAME "..."
# SKSE_PLUGIN "target"
# SKSE_PLUGINS "target" "target"
# COPY_PATHS "..." "..."
# DATA_FOLDER "..."
# DATA_FOLDERS "..." "..."
# MODS_FOLDER "..."
# MODS_FOLDERS "..." "..."
# OUTPUT_FOLDER "..."
# OUTPUT_FOLDERS "..." "..."
# DELETE_BEFORE_COPY
# )
