# \DefaultApi

All URIs are relative to *https://wfm.margo.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**api_v1_clients_client_id_bundles_digest_get**](DefaultApi.md#api_v1_clients_client_id_bundles_digest_get) | **GET** /api/v1/clients/{clientId}/bundles/{digest} | Retrieve bundle information for a specific device and digest
[**api_v1_clients_client_id_capabilities_post**](DefaultApi.md#api_v1_clients_client_id_capabilities_post) | **POST** /api/v1/clients/{clientId}/capabilities | Report device capabilities
[**api_v1_clients_client_id_capabilities_put**](DefaultApi.md#api_v1_clients_client_id_capabilities_put) | **PUT** /api/v1/clients/{clientId}/capabilities | Update device capabilities (Update)
[**api_v1_clients_client_id_deployment_deployment_id_status_post**](DefaultApi.md#api_v1_clients_client_id_deployment_deployment_id_status_post) | **POST** /api/v1/clients/{clientId}/deployment/{deploymentId}/status | Report deployment status
[**api_v1_clients_client_id_deployments_deployment_id_digest_get**](DefaultApi.md#api_v1_clients_client_id_deployments_deployment_id_digest_get) | **GET** /api/v1/clients/{clientId}/deployments/{deploymentId}/{digest} | Retrieve an individual ApplicationDeployment YAML file
[**api_v1_clients_client_id_deployments_get**](DefaultApi.md#api_v1_clients_client_id_deployments_get) | **GET** /api/v1/clients/{clientId}/deployments | Retrieve the complete desired state for all workloads assigned to a device
[**api_v1_onboarding_certificate_get**](DefaultApi.md#api_v1_onboarding_certificate_get) | **GET** /api/v1/onboarding/certificate | Download Root CA certificate
[**api_v1_onboarding_post**](DefaultApi.md#api_v1_onboarding_post) | **POST** /api/v1/onboarding | Complete onboarding with client certificate



## api_v1_clients_client_id_bundles_digest_get

> std::path::PathBuf api_v1_clients_client_id_bundles_digest_get(client_id, digest, if_none_match)
Retrieve bundle information for a specific device and digest

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**client_id** | **String** | Unique identifier of the device-client | [required] |
**digest** | **String** | Content-addressable digest of the bundle archive. MUST conform to the 'digest' attribute in the Digest Specification and MUST equal the digest computed over the exact sequence of bytes (per Exact Bytes Rule) in the HTTP 200 OK response body. If the server cannot produce content whose digest matches this value it MUST return 404 Not Found. | [required] |
**if_none_match** | Option<**String**> | Quoted ETag (same as digest) previously returned for this bundle. |  |

### Return type

[**std::path::PathBuf**](std::path::PathBuf.md)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/gzip

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_clients_client_id_capabilities_post

> api_v1_clients_client_id_capabilities_post(client_id, device_capabilities_manifest)
Report device capabilities

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**client_id** | **String** |  | [required] |
**device_capabilities_manifest** | [**DeviceCapabilitiesManifest**](DeviceCapabilitiesManifest.md) |  | [required] |

### Return type

 (empty response body)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_clients_client_id_capabilities_put

> api_v1_clients_client_id_capabilities_put(client_id, device_capabilities_manifest)
Update device capabilities (Update)

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**client_id** | **String** |  | [required] |
**device_capabilities_manifest** | [**DeviceCapabilitiesManifest**](DeviceCapabilitiesManifest.md) |  | [required] |

### Return type

 (empty response body)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_clients_client_id_deployment_deployment_id_status_post

> api_v1_clients_client_id_deployment_deployment_id_status_post(client_id, deployment_id, deployment_status_manifest)
Report deployment status

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**client_id** | **String** |  | [required] |
**deployment_id** | **String** |  | [required] |
**deployment_status_manifest** | [**DeploymentStatusManifest**](DeploymentStatusManifest.md) |  | [required] |

### Return type

 (empty response body)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_clients_client_id_deployments_deployment_id_digest_get

> String api_v1_clients_client_id_deployments_deployment_id_digest_get(client_id, deployment_id, digest, if_none_match, accept_encoding)
Retrieve an individual ApplicationDeployment YAML file

This endpoint is used by the client to fetch the YAML for a single ApplicationDeployment after it has processed a new State Manifest and identified a small number of new or updated deployments. This allows for highly efficient, incremental updates without needing to download the full bundle. To make individual workload retrievals race-free and cache-friendly, this endpoint is content-addressable: the digest of the expected YAML is part of the URL. This guarantees immutability of the fetched resource and prevents a time-of-check / time-of-use race where a deployment changes between manifest retrieval and content fetch. 

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**client_id** | **String** | Unique identifier of the Edge Compute Device | [required] |
**deployment_id** | **String** | UUID of the ApplicationDeployment (metadata.annotations.id) | [required] |
**digest** | **String** | Content-addressable digest of the ApplicationDeployment YAML file. MUST conform to the Digest Specification and MUST equal the digest computed over the exact sequence of bytes (per Exact Bytes Rule) in the HTTP 200 OK response body. If the server cannot produce content whose digest matches this value it MUST return 404 Not Found.  | [required] |
**if_none_match** | Option<**String**> | Optional ETag for caching. The ETag is returned to the client from the /deployments endpoint, it is the digest of the state manifest.  |  |
**accept_encoding** | Option<**String**> | Indicates supported compression formats (e.g., gzip, br) |  |

### Return type

**String**

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/yaml

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_clients_client_id_deployments_get

> models::UnsignedAppStateManifest api_v1_clients_client_id_deployments_get(client_id, if_none_match, accept)
Retrieve the complete desired state for all workloads assigned to a device

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**client_id** | **String** | The unique identifier of the Edge Compute Device making the request | [required] |
**if_none_match** | Option<**String**> | ETag value of the last successfully synced manifest. The ETag is returned to the client from the /deployments endpoint, it is the digest of the state manifest.  |  |
**accept** | Option<**String**> | Indicates which manifest formats the client supports. Supported values: application/vnd.margo.manifest.v1+json.  |  |

### Return type

[**models::UnsignedAppStateManifest**](UnsignedAppStateManifest.md)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/vnd.margo.manifest.v1+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_onboarding_certificate_get

> models::ApiV1OnboardingCertificateGet200Response api_v1_onboarding_certificate_get()
Download Root CA certificate

### Parameters

This endpoint does not need any parameter.

### Return type

[**models::ApiV1OnboardingCertificateGet200Response**](_api_v1_onboarding_certificate_get_200_response.md)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


## api_v1_onboarding_post

> models::ApiV1OnboardingPost201Response api_v1_onboarding_post(api_v1_onboarding_post_request)
Complete onboarding with client certificate

### Parameters


Name | Type | Description  | Required | Notes
------------- | ------------- | ------------- | ------------- | -------------
**api_v1_onboarding_post_request** | [**ApiV1OnboardingPostRequest**](ApiV1OnboardingPostRequest.md) |  | [required] |

### Return type

[**models::ApiV1OnboardingPost201Response**](_api_v1_onboarding_post_201_response.md)

### Authorization

[PayloadSignature](../README.md#PayloadSignature)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

