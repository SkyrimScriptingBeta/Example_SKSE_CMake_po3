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
# SKIP_NG_DETECTION
# )

# ----

# Parse a version string into its components
#
# This function is from CommonLibSSE-NG
# https://github.com/CharmedBaryon/CommonLibSSE-NG
# MIT License
function(skse_plugin_parse_version VERSION)
  string(REGEX MATCHALL "^([0-9]+)(\\.([0-9]+)(\\.([0-9]+)(\\.([0-9]+))?)?)?$" version_match "${VERSION}")
  unset(SKSE_PLUGIN_VERSION_MAJOR PARENT_SCOPE)
  unset(SKSE_PLUGIN_VERSION_MINOR PARENT_SCOPE)
  unset(SKSE_PLUGIN_VERSION_PATCH PARENT_SCOPE)
  unset(SKSE_PLUGIN_VERSION_TWEAK PARENT_SCOPE)

  if("${version_match} " STREQUAL " ")
    set(SKSE_PLUGIN_VERSION_MATCH FALSE PARENT_SCOPE)
    return()
  endif()

  set(SKSE_PLUGIN_VERSION_MATCH TRUE PARENT_SCOPE)
  set(SKSE_PLUGIN_VERSION_MAJOR "${CMAKE_MATCH_1}" PARENT_SCOPE)
  set(SKSE_PLUGIN_VERSION_MINOR "0" PARENT_SCOPE)
  set(SKSE_PLUGIN_VERSION_PATCH "0" PARENT_SCOPE)
  set(SKSE_PLUGIN_VERSION_TWEAK "0" PARENT_SCOPE)

  if(DEFINED CMAKE_MATCH_3)
    set(SKSE_PLUGIN_VERSION_MINOR "${CMAKE_MATCH_3}" PARENT_SCOPE)
  endif()

  if(DEFINED CMAKE_MATCH_5)
    set(SKSE_PLUGIN_VERSION_PATCH "${CMAKE_MATCH_5}" PARENT_SCOPE)
  endif()

  if(DEFINED CMAKE_MATCH_7)
    set(SKSE_PLUGIN_VERSION_TWEAK "${CMAKE_MATCH_7}" PARENT_SCOPE)
  endif()
endfunction()

# TODO: add usage docs here
function(add_skse_plugin TARGET)
  set(options SKIP_COMMONLIBSSE SKIP_PLUGIN_DEFINITION SKIP_NG_DETECTION SKIP_PRECOMPILE_HEADERS)
  set(oneValueArgs NAME VERSION AUTHOR EMAIL CXX_STANDARD)
  set(multiValueArgs SOURCES PRECOMPILE_HEADERS)
  cmake_parse_arguments(PARSE_ARGV 1 ADD_SKSE_PLUGIN "${options}" "${oneValueArgs}" "${multiValueArgs}")

  if(NOT ADD_SKSE_PLUGIN_NAME)
    set(ADD_SKSE_PLUGIN_NAME ${TARGET})
  endif()

  if(NOT ADD_SKSE_PLUGIN_VERSION)
    if(DEFINED PROJECT_VERSION)
      set(ADD_SKSE_PLUGIN_VERSION ${PROJECT_VERSION})
    else()
      set(ADD_SKSE_PLUGIN_VERSION "1.0.0")
    endif()
  endif()

  skse_plugin_parse_version(${ADD_SKSE_PLUGIN_VERSION})

  if(NOT SKSE_PLUGIN_VERSION_MATCH)
    message(FATAL_ERROR "Invalid add_skse_plugin version, expected format 'x.y.z', found '${ADD_SKSE_PLUGIN_VERSION}'")
  endif()

  if(NOT ADD_SKSE_PLUGIN_SOURCES)
    message(FATAL_ERROR "No sources provided for add_skse_plugin")
  endif()

  # Find CommonLibSSE, if not skipped
  if(NOT ADD_SKSE_PLUGIN_SKIP_COMMONLIBSSE)
    find_package(CommonLibSSE CONFIG REQUIRED)
  endif()

  # Create the plugin library
  if(NOT ADD_SKSE_PLUGIN_SKIP_NG_DETECTION AND COMMAND add_commonlibsse_plugin)
    message(DEBUG "Detected CommonLibSSE-NG")
    message(DEBUG [[
      add_commonlibsse_plugin(
        ${TARGET}
        NAME ${ADD_SKSE_PLUGIN_NAME}
        VERSION ${ADD_SKSE_PLUGIN_VERSION}
        AUTHOR ${ADD_SKSE_PLUGIN_AUTHOR}
        EMAIL ${ADD_SKSE_PLUGIN_EMAIL}
        SOURCES ${ADD_SKSE_PLUGIN_SOURCES}
        ${ADD_SKSE_PLUGIN_UNPARSED_ARGUMENTS}
      )
    ]])
    add_commonlibsse_plugin(
      ${TARGET}
      NAME ${ADD_SKSE_PLUGIN_NAME}
      VERSION ${ADD_SKSE_PLUGIN_VERSION}
      AUTHOR ${ADD_SKSE_PLUGIN_AUTHOR}
      EMAIL ${ADD_SKSE_PLUGIN_EMAIL}
      SOURCES ${ADD_SKSE_PLUGIN_SOURCES}
      ${ADD_SKSE_PLUGIN_UNPARSED_ARGUMENTS}
    )
  else()
    message(DEBUG "Using CommonLibSSE")
    add_library(${TARGET} SHARED ${ADD_SKSE_PLUGIN_SOURCES})
    target_link_libraries(${TARGET} PRIVATE CommonLibSSE::CommonLibSSE)

    # target_compile_features(${TARGET} PRIVATE cxx_std_23)
    # if(ADD_SKSE_PLUGIN_PRECOMPILE_HEADERS)
    # target_precompile_headers(${TARGET} PRIVATE ${ADD_SKSE_PLUGIN_PRECOMPILE_HEADERS})
    # endif()
  endif()
endfunction()