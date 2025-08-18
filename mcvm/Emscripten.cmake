#!MCVM cd ${mdir} && cmake -GNinja -S. -Bbuild -DCMAKE_TOOLCHAIN_FILE=Emscripten.cmake --fresh \
#!MCVM && cmake --build build

include(${CMAKE_CURRENT_LIST_DIR}/../cmake/Modules/Platform/Emscripten.cmake)


set(EMSCRIPTEN_CONFIG_FLAG "--em-config ${CMAKE_SOURCE_DIR}/.emscripten")
if(CMAKE_TOOLCHAIN_LOADED)
  return()
endif()
set(CMAKE_TOOLCHAIN_LOADED TRUE CACHE INTERNAL "Internal flag to ensure the toolchain is loaded only once.")

list(APPEND EM_CFLAGS
    --em-config ${CMAKE_SOURCE_DIR}/.emscripten
    -v  
    # -mextended-const
    # -mavx
    -fconstexpr-backtrace-limit=0

    -fwasm-exceptions
    -sWASM_LEGACY_EXCEPTIONS=0
    # -sWASM_EXCEPTIONS
    # -mexception-handling
    -mbulk-memory
    -pthread

    -msimd128
    -mavx2
    -mrelaxed-simd
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
    # -fno-inline
    # -fno-omit-frame-pointer

    # -fexperimental-library
    # "-Xclang -mno-type-check"
    # -ffunction-sections
    # -fdata-sections
    # -frtti
    # -pipe
)
# set(CMAKE_CXX_SCAN_FOR_MODULES 0)
message("getting cflags")
message("0:::::::::::::::::::::::::::::::::")
message("${CMAKE_CXX_COMPILER} --cflags ${EM_CFLAGS}")
message("1:::::::::::::::::::::::::::::::::")
execute_process(COMMAND "${CMAKE_CXX_COMPILER}" --cflags ${EM_CFLAGS} OUTPUT_VARIABLE EM_CFLAGS_OUT COMMAND_ECHO STDOUT)
message("2:::::::::::::::::::::::::::::::::")
message("${EM_CFLAGS_OUT}")
message("3:::::::::::::::::::::::::::::::::")
string(REPLACE "\n" "" EM_CFLAGS_OUT ${EM_CFLAGS_OUT})
# string(REPLACE "-mllvm -disable-lsr" "" EM_CFLAGS ${EM_CFLAGS})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EM_CFLAGS_OUT} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EM_CFLAGS_OUT} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
# set(CMAKE_DEPFILE_FLAGS_CXX "${CMAKE_DEPFILE_FLAGS_CXX} ${EM_CFLAGS_OUT} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
# set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
# set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --em-config ${CMAKE_SOURCE_DIR}/.emscripten")


