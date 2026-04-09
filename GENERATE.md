# How to generate the margo-workload-management-api-client-rs code

We use the [rust generator](https://openapi-generator.tech/docs/generators/rust) with the `reqwest` library from
[openapi-generator.tech](https://openapi-generator.tech/) to generate this client. The generator does not perfectly
match all requirements, so we maintain two complementary mechanisms to persist post-generation adjustments:

- **Mustache templates** (`openapi_generator_templates/`) — override specific generator templates at generation time.
  Only files that deviate from the built-in defaults are stored here; the generator falls back to its built-in
  templates for everything else.
- **Patch files** (`patches/`) — apply targeted, file-specific changes after generation via `git apply`. Patches are
  applied in numeric order.

## Generate the code

Execute the following command from the repository root directory:

```bash
./generate.sh
```

This script runs code generation, formats the output, and applies all patches in one step.

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
