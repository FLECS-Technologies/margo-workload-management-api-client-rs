#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker run --rm \
    -v "${SCRIPT_DIR}:/local" \
    --user "$(id -u):$(id -g)" \
    openapitools/openapi-generator-cli:v7.20.0 generate \
    -i /local/workload-management-api-1.0.0.yaml \
    --additional-properties=packageName=margo-workload-management-api-client-rs,library=reqwest,preferUnsignedInt=true,supportMiddleware=true,packageVersion=1.0.0 \
    -g rust \
    -t /local/openapi_generator_templates \
    -o /local

cargo +nightly fmt -- --config format_code_in_doc_comments=true

for patch in "${SCRIPT_DIR}"/patches/*.patch; do
    echo "Applying ${patch}..."
    git -C "${SCRIPT_DIR}" apply "${patch}"
done
