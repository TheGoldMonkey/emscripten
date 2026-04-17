#!MCVM cd ${mdir} && rm -rf build && rm -rf .cache && \
#!MCVM cmake -GNinja -S. -Bbuild --toolchain Emscripten.cmake --fresh \
#!MCVM && cmake --build build

include(${CMAKE_CURRENT_LIST_DIR}/../cmake/Modules/Platform/Emscripten.cmake)


# todo: move to cache in the project's folder, not in the toolchain file's folder
set(EMSCRIPTEN_CONFIG_PATH "${CMAKE_CURRENT_LIST_DIR}/.emscripten" CACHE STRING "")
set(EMSCRIPTEN_CONFIG_FLAG "--em-config ${EMSCRIPTEN_CONFIG_PATH}")
if(CMAKE_TOOLCHAIN_LOADED)
  return()
endif()
set(CMAKE_TOOLCHAIN_LOADED TRUE CACHE INTERNAL "Internal flag to ensure the toolchain is loaded only once.")

list(APPEND EM_CFLAGS
  --em-config ${EMSCRIPTEN_CONFIG_PATH}
  # -v  
  # -mextended-const
  # -mavx
  -fconstexpr-backtrace-limit=0

  -fwasm-exceptions
  -sWASM_LEGACY_EXCEPTIONS=0
  # -sWASM_EXCEPTIONS
  # -mexception-handling
  -mbulk-memory
  -pthread

  # -msimd128
  # -mavx2
  # -mrelaxed-simd
  -matomics

  -mreference-types

  -mmultivalue
  -mtail-call
  -msign-ext
  -mnontrapping-fptoint

  -gseparate-dwarf
  # -g
  # -gdwarf-5

  # -O0
  -gpubnames
  -sSUPPORT_LONGJMP=wasm
  # -fno-inline
  # -fno-omit-frame-pointer

  # -fexperimental-library
  # "-Xclang -mno-type-check"
  # -ffunction-sections
  # -fdata-sections
  # -frtti
  # -pipe
)
set(CMAKE_CXX_SCAN_FOR_MODULES 0)
# message("getting cflags")
# message("0:::::::::::::::::::::::::::::::::")
# message("${CMAKE_CXX_COMPILER} --cflags ${EM_CFLAGS}")
# message("1:::::::::::::::::::::::::::::::::")

# https://cmake.org/cmake/help/latest/command/separate_arguments.html#command:separate_arguments
execute_process(COMMAND "${CMAKE_CXX_COMPILER}" --cflags ${EM_CFLAGS} OUTPUT_VARIABLE EM_CFLAGS_OUT COMMAND_ECHO STDOUT)
message("2:::::::::::::::::::::::::::::::::")
message("${EM_CFLAGS_OUT}")
message("3:::::::::::::::::::::::::::::::::")
string(REPLACE "\n" "" EM_CFLAGS_OUT ${EM_CFLAGS_OUT})
# string(REPLACE " " ";" EM_CFLAGS_OUT ${EM_CFLAGS_OUT})


# string(REPLACE "-mllvm -disable-lsr" "" EM_CFLAGS_OUT ${EM_CFLAGS_OUT})
# string(REPLACE "-mllvm -disable-lsr" "" EM_CFLAGS_OUT ${EM_CFLAGS_OUT})


string(APPEND CMAKE_CXX_FLAGS " ${EM_CFLAGS_OUT} ${EMSCRIPTEN_CONFIG_FLAG} -sWASM_LEGACY_EXCEPTIONS=0 -sSUPPORT_LONGJMP=wasm")
string(APPEND CMAKE_C_FLAGS " ${EM_CFLAGS_OUT} ${EMSCRIPTEN_CONFIG_FLAG} -sWASM_LEGACY_EXCEPTIONS=0 -sSUPPORT_LONGJMP=wasm")
# string(APPEND CMAKE_DEPFILE_FLAGS_CXX "${EM_CFLAGS_OUT} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -sWASM_LEGACY_EXCEPTIONS=0")
# string(APPEND CMAKE_STATIC_LINKER_FLAGS "-sWASM_LEGACY_EXCEPTIONS=0")
# string(APPEND CMAKE_MODULE_LINKER_FLAGS "-sWASM_LEGACY_EXCEPTIONS=0")
string(APPEND CMAKE_SHARED_LINKER_FLAGS " -sWASM_LEGACY_EXCEPTIONS=0")

# 
# add_compile_options(
#   "SHELL:${EM_CFLAGS_OUT}"
#   --em-config ${EMSCRIPTEN_CONFIG_PATH}
# )
# add_link_options(
#   "SHELL:${EM_CFLAGS_OUT}"
#   --em-config ${EMSCRIPTEN_CONFIG_PATH}
#   -sWASM_LEGACY_EXCEPTIONS=0
# )
