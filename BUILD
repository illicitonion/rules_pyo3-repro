load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_rust//rust:defs.bzl", "rust_binary")
load("@rust_crate_index//:defs.bzl", "aliases", "all_crate_deps")

package(default_visibility = ["//visibility:public"])

[
    rust_binary(
        name = name,
        srcs = glob([
            "src/*.rs",
        ]),
        data = [
            "hello_world.py",
            "@rules_pyo3//pyo3:current_pyo3_toolchain",
        ],
        aliases = aliases(),
        proc_macro_deps = all_crate_deps(
            proc_macro = True,
        ),
        visibility = ["//visibility:public"],
        deps = all_crate_deps(),
        platform = platform,
    )
    for (name, platform) in [
        ("hello_world", None),
        ("hello_world_linux", "@zig_sdk//platform:linux_amd64"),
    ]
]

genrule(
    name = "list",
    toolchains = [
        "@rules_pyo3//pyo3:current_pyo3_toolchain",
    ],
    srcs = ["@rules_pyo3//pyo3:current_pyo3_toolchain"],
    cmd = "find . > $@",
    outs = ["list_of_files"],
)

platform_transition_filegroup(
    name = "list_linux",
    srcs = [":list"],
    target_platform = "@zig_sdk//platform:linux_amd64",
)
