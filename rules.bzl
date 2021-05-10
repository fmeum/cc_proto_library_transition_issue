_COPT_BUILD_SETTING = "//command_line_option:copt"

def _set_foobar_copt(settings, attr):
    return {_COPT_BUILD_SETTING: ["-DFOOBAR"]}

set_foobar_copt = transition(
    implementation = _set_foobar_copt,
    inputs = [],
    outputs = [_COPT_BUILD_SETTING],
)

def _apply_transition_impl(ctx):
    pass

apply_transition = rule(
        implementation = _apply_transition_impl,
        attrs = {
            "native_target": attr.label(
                cfg = set_foobar_copt,
            ),
            "_allowlist_function_transition": attr.label(
                default = "@bazel_tools//tools/whitelists/function_transition_whitelist",
            ),
        },
    )


def _exec_with_library_dep_impl(ctx):
    ctx.actions.write(ctx.outputs.out, "")

exec_with_library_dep = rule(
    _exec_with_library_dep_impl,
    attrs = {
        "library": attr.label(
            mandatory = True,
            cfg = "exec",
        ),
        "out": attr.output(
            mandatory = True,
        ),
    },
)
