# DeploymentBundleRef

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**media_type** | Option<**String**> | MUST be application/vnd.margo.bundle.v1+tar+gzip; a gzip-compressed tar whose root contains one or more ApplicationDeployment YAML files. If there are zero deployments then bundle MUST be null (an empty archive MUST NOT be served). The archive MUST contain exactly the set of YAML files referenced by deployments.  | [optional]
**digest** | Option<**String**> | The digest of the bundle archive. MUST equal the digest computed over the exact sequence of bytes (per Exact Bytes Rule) in the bundle endpoint's HTTP 200 OK response body.  | [optional]
**size_bytes** | Option<**f64**> | Unsigned 64-bit advisory estimate of the decoded payload length in bytes for the bundle archive. Provided for bandwidth estimation and update planning. MUST NOT be used for integrity; digest verification remains mandatory.  | [optional]
**url** | Option<**String**> | Content-addressable retrieval endpoint of the form /api/v1/devices/{deviceId}/bundles/{digest} where {digest} equals bundle.digest.  | [optional]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


