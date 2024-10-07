load("@rules_pyo3//pyo3:repositories.bzl", "register_pyo3_toolchains", "rules_pyo3_dependencies")
load("@rules_pyo3//pyo3:repositories_transitive.bzl", "rules_pyo3_transitive_deps")
load("@rules_rust//crate_universe:defs.bzl", "crate", "crates_repository")
load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")
load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")

def rust_setup(lockfile):
    """
    Sets up the rust toolchain and rust dependencies for the current workspace.

    Args:
        lockfile: The path to the Cargo.lock file to use. Due to
            https://github.com/bazelbuild/rules_rust/issues/2125 this must be different between
            different workspaces, so a value is passed in.
    """

    RUST_VERSION = "1.81.0"

    rust_register_toolchains(
        edition = "2021",
        versions = [RUST_VERSION],
        extra_target_triples = [
            "x86_64-unknown-linux-gnu",
            "x86_64-apple-darwin",
            "aarch64-apple-darwin",
            "aarch64-unknown-linux-gnu",
        ],
    )

    # When you add or change dependencies, run `z rust update-deps`.
    rules_rust_dependencies()
    crate_universe_dependencies()

    rules_pyo3_dependencies()
    register_pyo3_toolchains()
    rules_pyo3_transitive_deps()

    crates_repository(
        name = "rust_crate_index",
        isolated = False,
        cargo_lockfile = "@//:Cargo.lock",
        lockfile = lockfile,
        manifests = [
            "@//:Cargo.toml",
        ],
        rust_version = RUST_VERSION,
        annotations = {
            "pyo3-build-config": [
                crate.annotation(
                    build_script_data = [
                        "@system_python_for_pyo3//:pyo3-config-file.txt",
                    ],
                    build_script_env = {
                        "PYO3_CONFIG_FILE": "$(execpath @system_python_for_pyo3//:pyo3-config-file.txt)",
                    },
                ),
            ],
            "pyo3-ffi": [
                crate.annotation(
                    build_script_data = [
                        "@rules_pyo3//pyo3:current_pyo3_toolchain",
                    ],
                    build_script_env = {
                        "PYO3_CROSS": "$(PYO3_CROSS)",
                        "PYO3_CROSS_LIB_DIR": "$(PYO3_CROSS_LIB_DIR)",
                        "PYO3_CROSS_PYTHON_IMPLEMENTATION": "$(PYO3_CROSS_PYTHON_IMPLEMENTATION)",
                        "PYO3_CROSS_PYTHON_VERSION": "$(PYO3_CROSS_PYTHON_VERSION)",
                        "PYO3_NO_PYTHON": "$(PYO3_NO_PYTHON)",
                        "PYO3_PYTHON": "$(PYO3_PYTHON)",
                    },
                    build_script_toolchains = [
                        "@rules_pyo3//pyo3:current_pyo3_toolchain",
                    ],
                ),
            ],
        },
    )
