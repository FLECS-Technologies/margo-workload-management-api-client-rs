This project was generated executing 
```bash
docker run --rm -v $(pwd):/local --user $(id -u):$(id -g) openapitools/openapi-generator-cli:v7.20.0 generate -i /local/workload-management-api-1.0.0.yaml --additional-properties=packageName=margo-workload-management-api-client-rs,library=reqwest,preferUnsignedInt=true,supportMiddleware=true,packageVersion=1.0.0 -g rust -o /local
cargo fmt -- --config format_code_in_doc_comments=true
```
from the repository root.