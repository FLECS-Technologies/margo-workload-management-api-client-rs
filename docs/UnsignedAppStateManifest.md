# UnsignedAppStateManifest

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**manifest_version** | **f64** | Monotonically increasing unsigned 64-bit integer in the inclusive range [1, 2^64-1]. Prevents rollback attacks. The first manifest MUST use 1.  | 
**bundle** | Option<[**models::DeploymentBundleRef**](DeploymentBundleRef.md)> |  | 
**deployments** | [**Vec<models::DeploymentManifestRef>**](DeploymentManifestRef.md) | A list of deployment object references for the device. The reference contains some meta info and reference to the url where the deployment is available. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


