#!MCVM rm -rf build; cmake -S . -Bbuild -GNinja && cmake --build build
cmake_minimum_required(VERSION 3.30)
set(CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "ON")
set(CMAKE_C_COMPILER_WORKS 1 CACHE STRING "")
set(CMAKE_CXX_COMPILER_WORKS 1 CACHE STRING "")
set(EMSCRIPTEN_ROOT_PATH "/home/mcvm/dev/emscripten" CACHE STRING "Path to Emscripten root")
# set(CMAKE_CXX_COMPILER clang++ CACHE STRING "")
# set(CMAKE_C_COMPILER clang CACHE STRING "")
include(../cmake/Modules/Platform/Emscripten.cmake)


project(ts)


add_executable(ts main.cpp)
SET(EM_EXPORTED_RUNTIME_METHODS 
    # addOnPreRun
    # addOnInit
    # addOnPreMain
    # addOnExit
    # addOnPostRun
    # convertPCtoSourceLocation
    # WebGPU
    # JsValStore
    # JSEvents
    # fillMouseEventData
    # fillDeviceOrientationEventData
    # fillDeviceMotionEventData
    # fillOrientationChangeEventData
    # fillFullscreenChangeEventData
    # fillVisibilityChangeEventData
    # fillGamepadEventData
    ENV
    wasmMemory
    wasmExports
    stringToUTF8OnStack
    stackAlloc
    stackSave
    stackRestore
    # withStackSave
    # embindEmitTypes
    # flush_NO_FILESYSTEM
    # getCallstack
    # wasmExports
    # WasmOffsetConverter
    # WasmSourceMap
    # demangle
    # stackTrace
    # wasmTable
    run
    addOnPreRun
    addOnInit
    addOnPreMain
    addOnExit
    addOnPostRun
    addRunDependency
    removeRunDependency
    out
    err
    callMain
    abort
    wasmMemory
    wasmExports
    HEAPF32
    HEAPF64
    HEAP_DATA_VIEW
    HEAP8
    HEAPU8
    HEAP16
    HEAPU16
    HEAP32
    HEAPU32
    HEAP64
    HEAPU64
    writeStackCookie
    checkStackCookie
    writeI53ToI64
    writeI53ToI64Clamped
    writeI53ToI64Signaling
    writeI53ToU64Clamped
    writeI53ToU64Signaling
    readI53FromI64
    readI53FromU64
    convertI32PairToI53
    convertI32PairToI53Checked
    convertU32PairToI53
    INT53_MAX
    INT53_MIN
    bigintToI53Checked
    stackSave
    stackRestore
    stackAlloc
    getTempRet0
    setTempRet0
    ptrToString
    zeroMemory
    getHeapMax
    abortOnCannotGrowMemory
    growMemory
    ENV
    ERRNO_CODES
    strError
    inetPton4
    inetNtop4
    inetPton6
    inetNtop6
    readSockaddr
    writeSockaddr
    DNS
    Protocols
    Sockets
    timers
    warnOnce
    emscriptenLog
    readEmAsmArgsArray
    readEmAsmArgs
    jstoi_q
    jstoi_s
    getExecutableName
    listenOnce
    autoResumeAudioContext
    getDynCaller
    dynCall
    callUserCallback
    asmjsMangle
    asyncLoad
    alignMemory
    mmapAlloc
    # HandleAllocator
    # getNativeTypeSize
    # wasmTable
    # noExitRuntime
    # STACK_SIZE
    # STACK_ALIGN
    # POINTER_SIZE
    # ASSERTIONS
    # getCFunc
    # ccall
    # cwrap
    # uleb128Encode
    # sigToWasmTypes
    # generateFuncType
    # convertJsFunctionToWasm
    # freeTableIndexes
    # functionsInTableMap
    # getEmptyTableSlot
    # updateTableMap
    # getFunctionAddress
    # addFunction
    # removeFunction
    # reallyNegative
    # unSign
    # strLen
    # reSign
    # formatString
    # setValue
    # getValue
    # PATH
    # PATH_FS
    # UTF8Decoder
    # UTF8ArrayToString
    # UTF8ToString
    # stringToUTF8Array
    # stringToUTF8
    # lengthBytesUTF8
    # intArrayFromString
    # intArrayToString
    # AsciiToString
    # stringToAscii
    # UTF16Decoder
    # UTF16ToString
    # stringToUTF16
    # lengthBytesUTF16
    # UTF32ToString
    # stringToUTF32
    # lengthBytesUTF32
    # stringToNewUTF8
    # stringToUTF8OnStack
    # writeArrayToMemory
    # JSEvents
    # registerKeyEventCallback
    # specialHTMLTargets
    # maybeCStringToJsString
    # findEventTarget
    # findCanvasEventTarget
    # getBoundingClientRect
    # fillMouseEventData
    # registerMouseEventCallback
    # registerWheelEventCallback
    # registerUiEventCallback
    # registerFocusEventCallback
    # fillDeviceOrientationEventData
    # registerDeviceOrientationEventCallback
    # fillDeviceMotionEventData
    # registerDeviceMotionEventCallback
    # screenOrientation
    # fillOrientationChangeEventData
    # registerOrientationChangeEventCallback
    # fillFullscreenChangeEventData
    # registerFullscreenChangeEventCallback
    # JSEvents_requestFullscreen
    # JSEvents_resizeCanvasForFullscreen
    # registerRestoreOldStyle
    # hideEverythingExceptGivenElement
    # restoreHiddenElements
    # setLetterbox
    # currentFullscreenStrategy
    # restoreOldWindowedStyle
    # softFullscreenResizeWebGLRenderTarget
    # doRequestFullscreen
    # fillPointerlockChangeEventData
    # registerPointerlockChangeEventCallback
    # registerPointerlockErrorEventCallback
    # requestPointerLock
    # fillVisibilityChangeEventData
    # registerVisibilityChangeEventCallback
    # registerTouchEventCallback
    # fillGamepadEventData
    # registerGamepadEventCallback
    # registerBeforeUnloadEventCallback
    # fillBatteryEventData
    # battery
    # registerBatteryEventCallback
    # setCanvasElementSize
    # getCanvasElementSize
    # jsStackTrace
    # getCallstack
    # UNWIND_CACHE
    # convertPCtoSourceLocation
    # getEnvStrings
    # checkWasiClock
    # doReadv
    # doWritev
    # wasiRightsToMuslOFlags
    # wasiOFlagsToMuslOFlags
    # initRandomFill
    # # randomFill
    # # safeSetTimeout
    # # setImmediateWrapped
    # # safeRequestAnimationFrame
    # # clearImmediateWrapped
    # # polyfillSetImmediate
    # # registerPostMainLoop
    # # registerPreMainLoop
    # # promiseMap
    # # getPromise
    # # makePromise
    # # idsToPromises
    # # makePromiseCallback
    # # uncaughtExceptionCount
    # # exceptionLast
    # # exceptionCaught
    # # ExceptionInfo
    # # findMatchingCatch
    # # MONTH_DAYS_REGULAR
    # # MONTH_DAYS_LEAP
    # # MONTH_DAYS_REGULAR_CUMULATIVE
    # # MONTH_DAYS_LEAP_CUMULATIVE
    # # isLeapYear
    # # ydayFromDate
    # # arraySum
    # # addDays
    # # SYSCALLS
    # # getSocketFromFD
    # # getSocketAddress
    # # preloadPlugins
    # # FS_createPreloadedFile
    # # FS_modeStringToFlags
    # # FS_getMode
    # # FS_stdin_getChar_buffer
    # # FS_stdin_getChar
    # # FS_unlink
    # # FS_createPath
    # # FS_createDevice
    # # FS_readFile
    # # FS
    # # FS_createDataFile
    # # FS_mkdirTree
    # # FS_createLazyFile
    # # MEMFS
    # # TTY
    # # PIPEFS
    # # SOCKFS
    # # _setNetworkCallback
    # # ALLOC_NORMAL
    # # ALLOC_STACK
    # # allocate
    # # writeStringToMemory
    # # writeAsciiToMemory
    # # allocateUTF8
    # # allocateUTF8OnStack
    # # setErrNo
    # # demangle
    # # stackTrace
    # # print
    # # printErr
    # # InternalError
    # # BindingError
    # # throwInternalError
    # # throwBindingError
    # # registeredTypes
    # # awaitingDependencies
    # # typeDependencies
    # # tupleRegistrations
    # # structRegistrations
    # # sharedRegisterType
    # # whenDependentTypesAreResolved
    # # embind_charCodes
    # # embind_init_charCodes
    # # readLatin1String
    # # getTypeName
    # # getFunctionName
    # # getFunctionArgsName
    # # heap32VectorToArray
    # # requireRegisteredType
    # # usesDestructorStack
    # # createJsInvokerSignature
    # # checkArgCount
    # # getRequiredArgCount
    # # createJsInvoker
    # # UnboundTypeError
    # # PureVirtualError
    # # GenericWireTypeSize
    # # InvokerFunctions
    # # EmValType
    # # EmValOptionalType
    # # throwUnboundTypeError
    # # ensureOverloadTable
    # # exposePublicSymbol
    # # replacePublicSymbol
    # # extendError
    # # createNamedFunction
    # # embindRepr
    # # registeredInstances
    # # getBasestPointer
    # # registerInheritedInstance
    # # unregisterInheritedInstance
    # # getInheritedInstance
    # # getInheritedInstanceCount
    # # getLiveInheritedInstances
    # # registeredPointers
    # # registerType
    # # integerReadValueFromPointer
    # # enumReadValueFromPointer
    # # floatReadValueFromPointer
    # # readPointer
    # # runDestructors
    # # newFunc
    # # craftInvokerFunction
    # # embind__requireFunction
    # # genericPointerToWireType
    # # constNoSmartPtrRawPointerToWireType
    # # nonConstNoSmartPtrRawPointerToWireType
    # # init_RegisteredPointer
    # # RegisteredPointer
    # # RegisteredPointer_fromWireType
    # # runDestructor
    # # releaseClassHandle
    # # finalizationRegistry
    # # detachFinalizer_deps
    # # detachFinalizer
    # # attachFinalizer
    # # makeClassHandle
    # # init_ClassHandle
    # # ClassHandle
    # # throwInstanceAlreadyDeleted
    # # deletionQueue
    # # flushPendingDeletes
    # # delayFunction
    # # setDelayFunction
    # # RegisteredClass
    # # shallowCopyInternalPointer
    # # downcastPointer
    # # upcastPointer
    # # validateThis
    # # char_0
    # # char_9
    # # makeLegalFunctionName
    # # emval_freelist
    # # emval_handles
    # # emval_symbols
    # # init_emval
    # # count_emval_handles
    # # getStringOrSymbol
    # # Emval
    # # emval_get_global
    # # emval_returnValue
    # # emval_lookupTypes
    # # emval_methodCallers
    # # emval_addMethodCaller
    # # reflectConstruct
    # 
)
STRING(REPLACE ";" "\",\"" EM_EXPORTED_RUNTIME_METHODS "${EM_EXPORTED_RUNTIME_METHODS}")
set(EM_EXPORTED_RUNTIME_METHODS "[\"${EM_EXPORTED_RUNTIME_METHODS}\"]")
target_compile_options(ts PRIVATE
  -fwasm-exceptions
  -sEXCEPTION_STACK_TRACES
)
target_link_options(ts PRIVATE
  --emit-tsd emscripten.ts
  --color-diagnostics
  # -sEXPORT_ALL=1
  # -sINCLUDE_FULL_LIBRARY=1
  -sERROR_ON_UNDEFINED_SYMBOLS=0
  -sMODULARIZE=1
  -sEXPORT_ES6=1
  -sNO_POLYFILL
  -sENVIRONMENT=web,worker,node
  -sWASM_BIGINT
  # -sEMBIND_AOT
  # -sMINIMAL_RUNTIME
  -lembind
  # -sLINKABLE
  # -sEXPORT_EXCEPTION_HANDLING_HELPERS
  # -sMAIN_MODULE=1
  "-sEXPORTED_RUNTIME_METHODS=${EM_EXPORTED_RUNTIME_METHODS}"

)