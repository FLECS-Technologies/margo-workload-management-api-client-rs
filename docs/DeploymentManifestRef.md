# DeploymentManifestRef

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**deployment_id** | **String** | The unique UUID from the ApplicationDeployment's metadata.annotations.id.  | 
**digest** | **String** | The digest of the individual ApplicationDeployment YAML file. MUST equal the digest computed over the exact sequence of bytes (per Exact Bytes Rule) in that deployment endpoint's HTTP 200 OK response body.  | 
**size_bytes** | Option<**f64**> | Unsigned 64-bit advisory estimate of the decoded payload length in bytes for the deployment YAML. Provided for planning or progress display. MUST NOT be used for integrity; digest verification remains mandatory.  | [optional]
**url** | **String** | Content-addressable endpoint of the form /api/v1/devices/{deviceId}/deployments/{deploymentId}/{digest}. The {digest} MUST equal deployments[].digest; the referenced resource is immutable  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


