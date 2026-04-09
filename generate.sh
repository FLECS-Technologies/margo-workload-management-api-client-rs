#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SPEC_REPO="margo/specification"
SPEC_FILE_PATH="system-design/specification/margo-management-interface/workload-management-api-1.0.0.yaml"
REF="${1:-pre-draft}"

# Resolve ref to full commit SHA via GitHub API
echo "Resolving ref '${REF}' in ${SPEC_REPO}..."
API_RESPONSE=$(curl -sf "https://api.github.com/repos/${SPEC_REPO}/commits/${REF}")
COMMIT_SHA=$(echo "${API_RESPONSE}" | jq -r '.sha')
if [ -z "${COMMIT_SHA}" ] || [ "${COMMIT_SHA}" = "null" ]; then
    echo "Error: failed to resolve ref '${REF}' to a commit SHA" >&2
    exit 1
fi
echo "Resolved to commit: ${COMMIT_SHA}"

SPEC_RAW_URL="https://raw.githubusercontent.com/${SPEC_REPO}/${COMMIT_SHA}/${SPEC_FILE_PATH}"
SPEC_BLOB_URL="https://github.com/${SPEC_REPO}/blob/${COMMIT_SHA}/${SPEC_FILE_PATH}"

# Generate code (openapi-generator fetches the spec directly from the URL)
docker run --rm \
    -v "${SCRIPT_DIR}:/local" \
    --user "$(id -u):$(id -g)" \
    openapitools/openapi-generator-cli:v7.20.0 generate \
    -i "${SPEC_RAW_URL}" \
    --additional-properties=packageName=margo-workload-management-api-client-rs,library=reqwest,preferUnsignedInt=true,supportMiddleware=true,packageVersion=1.0.0 \
    -g rust \
    -t /local/openapi_generator_templates \
    -o /local

cargo +nightly fmt -- --config format_code_in_doc_comments=true

for patch in "${SCRIPT_DIR}"/patches/*.patch; do
    echo "Applying ${patch}..."
    git -C "${SCRIPT_DIR}" apply "${patch}"
done

# Write tracking file
{
    echo "COMMIT_SHA=${COMMIT_SHA}"
    echo "COMMIT_URL=${SPEC_BLOB_URL}"
    if ! [[ "${REF}" =~ ^[0-9a-f]{40}$ ]]; then
        echo "REF=${REF}"
        echo "REF_URL=https://github.com/${SPEC_REPO}/blob/${REF}/${SPEC_FILE_PATH}"
    fi
} > "${SCRIPT_DIR}/API_SPEC_VERSION"

echo "Done. API spec version written to API_SPEC_VERSION."
