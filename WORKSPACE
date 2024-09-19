load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "bc283cdfcd526a52c3201279cda4bc298652efa898b10b4db0837dc51652756f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
    ],
)

http_archive(
    name = "rules_cc",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.10/rules_cc-0.0.10.tar.gz"],
    sha256 = "65b67b81c6da378f136cc7e7e14ee08d5b9375973427eceb8c773a4f69fa7e49",
    strip_prefix = "rules_cc-0.0.10",
)

http_archive(
    name = "rules_rust",
    integrity = "sha256-MZscNcESBO9WsdlKVJ9rnTUygTt3jwLXCe9oyDcDbPE=",
    urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.50.1/rules_rust-v0.50.1.tar.gz"],
)

http_archive(
    name = "rules_pyo3",
    integrity = "sha256-ObyBGmMiWQb9WYBnWX1RyXNssALyplEVD5iLbWLDOO4=",
    urls = ["https://github.com/abrisco/rules_pyo3/releases/download/0.0.6/rules_pyo3-v0.0.6.tar.gz"],
)

http_archive(
    name = "rules_python",
    sha256 = "be04b635c7be4604be1ef20542e9870af3c49778ce841ee2d92fcb42f9d9516a",
    strip_prefix = "rules_python-0.35.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.35.0/rules_python-0.35.0.tar.gz",
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")

py_repositories()

# This is actually ignored, the bzlmod one is used instead.
python_register_toolchains(
    name = "py_toolchains",
    python_version = "3.9",
)

load("//:setup_rust.bzl", "rust_setup")

rust_setup("//:Cargo.Bazel.lock")

load("@rust_crate_index//:defs.bzl", "crate_repositories")

crate_repositories()
