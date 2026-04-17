#!MCVM cd ${mdir} && rm -rf build && rm -rf .cache && \
#!MCVM cmake -GNinja -S. -Bbuild --toolchain Emscripten.cmake --fresh \
#!MCVM && cmake --build build

cmake_minimum_required(VERSION 3.30)
project(mcvm_emscripten)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS "src/*.cpp")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)



# string(REPLACE " " ";" EM_CFLAGS ${EM_CFLAGS})


# add_executable(mcvm_emscripten_web)
add_library(mcvm_emscripten)
target_sources(mcvm_emscripten PUBLIC ${SOURCES})
# set(CMAKE_EXECUTABLE_SUFFIX ".js")

# message(${EM_CFLAGS})


add_executable(mcvm_emscripten_node)
add_executable(mcvm_emscripten_web)
target_compile_features(mcvm_emscripten PUBLIC cxx_std_26)

target_compile_options(
    mcvm_emscripten PUBLIC
    -freflection
    -freflection-latest
    -fexpansion-statements
    -fparameter-reflection
    -fentity-proxy-reflection

    # -fsanitize=address
    # -fsanitize=undefined
    # -flto=thin

    # -ftemplate-backtrace-limit=0

    # -ftime-trace
    # -ftime-trace-verbose

    # -fmodules
    # -fbuiltin-module-map
    # -fimplicit-module-maps

    -Wall
    -Wextra
    -Werror
    -Wno-error=user-defined-warnings

    # -Wno-error=user-defined-warnings
    -Wno-reorder-init-list
    -Wno-return-type-c-linkage
    -Wno-unused-variable
    -Wno-c23-extensions
    -Wno-format-security
    -Wno-string-compare
    -Wno-unused-local-typedef
    -Wno-unused-but-set-variable
    -Wno-unused-function
    -Wno-missing-designated-field-initializers
    -Wno-unused-value
    -Wno-missing-field-initializers
    -Wno-missing-braces
    -Wno-unused-lambda-capture

    # -Wno-error=sign-compare
    -Wno-sign-compare
    -Wno-unused-parameter
    -fcolor-diagnostics
)

target_link_options(
    mcvm_emscripten PUBLIC
    -sWASM_LEGACY_EXCEPTIONS=0
)

target_link_libraries(
    mcvm_emscripten_node
    mcvm_emscripten
)

target_link_libraries(
    mcvm_emscripten_web
    mcvm_emscripten
)

target_compile_options(
    mcvm_emscripten_node PUBLIC
)

target_link_options(
    mcvm_emscripten_node PUBLIC
    # -sENVIRONMENT=node
)
set_target_properties(mcvm_emscripten_node PROPERTIES SUFFIX ".js")
set_target_properties(mcvm_emscripten_web PROPERTIES SUFFIX ".html")
