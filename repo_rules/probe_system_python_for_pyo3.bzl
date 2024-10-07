_PROBE_SCRIPT = """# Allow the script to run on Python 2, so that nicer error can be printed later.
from __future__ import print_function

import os.path
import platform
import struct
import sys
from sysconfig import get_config_var, get_platform

version="{}.{}".format(sys.version_info[0], sys.version_info[1])

print("implementation={}".format(platform.python_implementation()))
print("version={}".format(version))
print("shared=true")
print("abi3=true")
print("lib_dir={}".format(get_config_var("LIBDIR")))
print("build_flags=")
print("suppress_build_script_link_lines=false")
"""

def _probe_system_python_for_pyo3_impl(rctx):
    rctx.file("BUILD.bazel", """exports_files(["pyo3-config-file.txt"])""")

    exec_result = rctx.execute(["python3", "-c", _PROBE_SCRIPT])
    if exec_result.return_code != 0:
        fail("Failed to probe system python: {}".format(exec_result.stderr))

    rctx.file("pyo3-config-file.txt", exec_result.stdout)

probe_system_python_for_pyo3 = repository_rule(
    implementation = _probe_system_python_for_pyo3_impl,
)
