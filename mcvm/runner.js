#!MCVM node --experimental-wasm-exnref ${file} --force-colors=true
// import { createRequire } from 'module';
// const require = createRequire(import.meta.url);

// @ts-types="./build/scpp.d.ts"
import * as scpp from "./build/mcvm_emscripten_node.js";
// const scpp = require("./build/mcvm_emscripten_node.js");
const argv = [
  "./build/mcvm_emscripten_node.wasm",
  // "--help"
]; // arg0 is node, arg1 is script name
for (let i = 2; i < process.argv.length; i++) {
  argv.push(process.argv[i]);
};
console.log(argv);
const argc = argv.length;

const PTR_SIZE = 4;
(async () => {
  // console.log(scpp)
  // const module = await scpp.default();
  // console.log(scpp.default._main)
  // const sp = module.stackSave();
  // try {
  //   const arg_arr_ptr = module.stackAlloc(PTR_SIZE * argc) >> 2;

  //   for (let i = 0; i < argc; i++) {
  //     const arg = argv[i];
  //     const arg_ptr = module.stringToUTF8OnStack(arg);
  //     module.HEAP32[arg_arr_ptr + i] = arg_ptr;
  //   }
  //   module._main(argc, arg_arr_ptr << 2);
  // } catch (e) {
  //   console.error(e);
  // } finally { module.stackRestore(sp); }

})();
