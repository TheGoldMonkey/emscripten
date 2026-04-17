#!MCVM python ${file}
import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
# import json
# import types
if __name__ == "__main__":
    # import ..tools.system_libs
    # from ..tools import system_libs
    from tools import system_libs, cmdline

    from tools import settings
    from tools.cmdline import OFormat

    options = cmdline.EmccOptions()

    # settings.settings.LINK_AS_CXX = True
    # res = system_libs.get_libs_to_link(options)

    # print(res)
    lcxx = system_libs.libcxx(
        eh_mode='wasm',
        is_mt=True,
        is_ww=True,
        is_debug=False,
    )
    lcxx.build_dir = ''
    print(lcxx.get_cflags())
    print(lcxx.src_dir)
    print(lcxx.src_glob)
    print(lcxx.get_files())


