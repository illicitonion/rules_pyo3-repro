load("@rules_rust//rust:defs.bzl", "rust_binary")
load("@rust_crate_index//:defs.bzl", "aliases", "all_crate_deps")

package(default_visibility = ["//visibility:public"])

rust_binary(
    name = "hello_world",
    srcs = glob([
        "src/*.rs",
    ]),
    data = [
        "hello_world.py",
        # Uncommenting this will make sure the toolchain is actually present for the link action and cause linking to succeed.
        # This is a bug in rules_rust (or possibly how rules_pyo3 recommends people set up annotations).
        #"@rules_pyo3//pyo3:current_pyo3_toolchain",
    ],
    aliases = aliases(),
    proc_macro_deps = all_crate_deps(
        proc_macro = True,
    ),
    visibility = ["//visibility:public"],
    deps = all_crate_deps(),
)

genrule(
    name = "list",
    toolchains = [
        "@rules_pyo3//pyo3:current_pyo3_toolchain",
    ],
    srcs = ["@rules_pyo3//pyo3:current_pyo3_toolchain"],
    cmd = "find . > $@",
    outs = ["list_of_files"],
)
