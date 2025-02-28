#!MCVM python ${file} /home/mcvm/dev/clang-p2996
#!/usr/bin/env python3
# Copyright 2019 The Emscripten Authors.  All rights reserved.
# Emscripten is available under two separate licenses, the MIT license and the
# University of Illinois/NCSA Open Source License.  Both these licenses can be
# found in the LICENSE file.

import os
import sys
import shutil

script_dir = os.path.abspath(os.path.dirname(__file__))
emscripten_root = os.path.dirname(os.path.dirname(script_dir))
default_llvm_dir = os.path.join(os.path.dirname(emscripten_root), 'llvm-project')
local_root = os.path.join(script_dir, 'libc', 'llvm')
local_src = os.path.join(local_root, 'src')
local_inc = os.path.join(local_root, 'include')
local_shared = os.path.join(local_root, 'shared')
local_hdr = os.path.join(local_root, 'hdr')

preserve_files = ('readme.txt', 'symbols')
excludes = ('CMakeLists.txt',)


def clean_dir(dirname):
  for f in os.listdir(dirname):
    if f in preserve_files:
      continue
    full = os.path.join(dirname, f)
    if os.path.isdir(full):
      shutil.rmtree(full)
    else:
      os.remove(full)


def copy_tree(upstream_dir, local_dir):
  for f in os.listdir(upstream_dir):
    full = os.path.join(upstream_dir, f)
    if os.path.isdir(full):
      shutil.copytree(full, os.path.join(local_dir, f))
    elif f not in excludes:
      shutil.copy2(full, os.path.join(local_dir, f))


def main():
  if len(sys.argv) > 1:
    llvm_dir = os.path.abspath(sys.argv[1])
  else:
    llvm_dir = default_llvm_dir
  libc_dir = os.path.join(llvm_dir, 'libc')
  upstream_src = os.path.join(libc_dir, 'src')
  upstream_inc = os.path.join(libc_dir, 'include')
  upstream_shared = os.path.join(libc_dir, 'shared')
  upstream_hdr = os.path.join(libc_dir, 'hdr')
  assert os.path.exists(upstream_inc)
  assert os.path.exists(upstream_src)
  assert os.path.exists(upstream_hdr)
  assert os.path.exists(upstream_shared)

  # Remove old version
  clean_dir(local_src)
  clean_dir(local_inc)
  clean_dir(local_shared)
  clean_dir(local_hdr)

  copy_tree(upstream_src, local_src)
  copy_tree(upstream_inc, local_inc)
  copy_tree(upstream_shared, local_shared)
  copy_tree(upstream_hdr, local_hdr)


if __name__ == '__main__':
  main()
