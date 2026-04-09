# How to generate the margo-workload-management-api-client-rs code

We use the [rust generator](https://openapi-generator.tech/docs/generators/rust) with the `reqwest` library from
[openapi-generator.tech](https://openapi-generator.tech/) to generate this client. The generator does not perfectly
match all requirements, so we maintain two complementary mechanisms to persist post-generation adjustments:

- **Mustache templates** (`openapi_generator_templates/`) — override specific generator templates at generation time.
  Only files that deviate from the built-in defaults are stored here; the generator falls back to its built-in
  templates for everything else.
- **Patch files** (`patches/`) — apply targeted, file-specific changes after generation via `git apply`. Patches are
  applied in numeric order.

## API spec source

The OpenAPI spec is maintained in the
[margo/specification](https://github.com/margo/specification/blob/pre-draft/system-design/specification/margo-management-interface/workload-management-api-1.0.0.yaml)
repository. It is **not** committed here — `generate.sh` fetches it directly from GitHub at generation time.

The exact spec version used for the currently committed code is recorded in `API_SPEC_VERSION`.

## Generate the code

```bash
./generate.sh [REF]
```

`REF` can be a branch name, tag, or full commit SHA from the `margo/specification` repository.
Defaults to `pre-draft` if omitted.

Examples:
```bash
./generate.sh                      # use pre-draft branch
./generate.sh main                 # use main branch
./generate.sh v1.2.0               # use a tag
./generate.sh a1b2c3d4e5f6...      # use a specific commit SHA
```

The script:
1. Resolves the ref to a full commit SHA via the GitHub API
2. Fetches the spec directly from GitHub raw content (no local copy)
3. Runs code generation, formats the output with `cargo +nightly fmt`, and applies all patches
4. Writes `API_SPEC_VERSION` with the resolved SHA and (if a named ref was used) the ref name

## Automated updates

A nightly GitHub Actions workflow (`.github/workflows/update-api-client.yml`) runs at 02:00 UTC and:
- Resolves the `pre-draft` branch to its current commit SHA
- Skips if the SHA matches `API_SPEC_VERSION` (no change in the spec repo)
- Regenerates and opens a PR only if the generated code in `src/` actually changed

The workflow can also be triggered manually via `workflow_dispatch` with a custom `ref` input. Manual runs
skip the code-change check and always open a PR (unless the SHA and ref are both already up to date).

## Make necessary manual adjustments

### Template changes

If a change applies systematically to all generated files of a certain type, modify the relevant mustache template in
`openapi_generator_templates/`. To extract additional templates from the generator image for reference or modification,
run:

```bash
docker run --rm -v ${PWD}/openapi_generator_templates:/out --user $(id -u):$(id -g) \
    openapitools/openapi-generator-cli:v7.20.0 author template -g rust -o /out
```

Keep only the files you actually modify — delete the rest so the generator uses its built-in versions for everything
else.

### Patch changes

If a change is specific to a single file or endpoint, add it as a patch file:

1. Make the change manually in the generated source
2. Run `git diff src/path/to/file.rs > patches/N-short-description.patch` (increment `N`)
3. Commit the patch file

Patches in `patches/` are applied in filename order by `generate.sh`.
