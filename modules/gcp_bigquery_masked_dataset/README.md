## Requirements
This creates 2 datasets, one for raw data tables and another one for masked views.

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.2 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.32.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.google_bigquery_main_dataset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_dataset.google_bigquery_masked_dataset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_kms_crypto_key.google_kms_crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.google_kms_crypto_key_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.google_kms_key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/3.1.2/docs/resources/id) | resource |
| [time_sleep.time_sleep](https://registry.terraform.io/providers/hashicorp/time/0.7.2/docs/resources/sleep) | resource |
| [google_bigquery_default_service_account.google_bigquery_default_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/bigquery_default_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A user-friendly description of the dataset | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | GCP project name that this dataset will be creating in. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The geographic location where the dataset should reside. See official docs. <br>There are two types of locations, regional or multi-regional. A regional location is a specific geographic place, such as Tokyo, and a multi-regional location is a large geographic area, such as the United States, that contains at least two geographic places. <br>The default value is multi-regional location US. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A descriptive name for the dataset | `string` | n/a | yes |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | An email address of a user to grant access to. For example bigquery@bigquery-prod-343507.iam.gserviceaccount.com | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataset_customer_managed_key_id"></a> [dataset\_customer\_managed\_key\_id](#output\_dataset\_customer\_managed\_key\_id) | The reference ID of the created customer managed key |
| <a name="output_main_dataset_id"></a> [main\_dataset\_id](#output\_main\_dataset\_id) | The reference ID of the main dataset |
| <a name="output_main_dataset_self_link"></a> [main\_dataset\_self\_link](#output\_main\_dataset\_self\_link) | The full link into the main dataset |
| <a name="output_masked_dataset_id"></a> [masked\_dataset\_id](#output\_masked\_dataset\_id) | The reference ID of the masked dataset |
| <a name="output_masked_dataset_self_link"></a> [masked\_dataset\_self\_link](#output\_masked\_dataset\_self\_link) | The full link into the masked dataset |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.2 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.google_bigquery_main_dataset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_dataset.google_bigquery_masked_dataset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_kms_crypto_key.main_dataset_kms_crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key.masked_dataset_kms_crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.main_dataset_kms_crypto_key_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_crypto_key_iam_member.masked_dataset_kms_crypto_key_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.google_kms_key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_bigquery_default_service_account.google_bigquery_default_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/bigquery_default_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A user-friendly description of the dataset | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | GCP project name that this dataset will be creating in. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The geographic location where the dataset should reside. See official docs. <br>There are two types of locations, regional or multi-regional. A regional location is a specific geographic place, such as Tokyo, and a multi-regional location is a large geographic area, such as the United States, that contains at least two geographic places. <br>The default value is multi-regional location US. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A descriptive name for the dataset | `string` | n/a | yes |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | An email address of a user to grant access to. For example bigquery@bigquery-prod-343507.iam.gserviceaccount.com | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataset_customer_managed_key_id"></a> [dataset\_customer\_managed\_key\_id](#output\_dataset\_customer\_managed\_key\_id) | The reference ID of the created customer managed key |
| <a name="output_main_dataset_id"></a> [main\_dataset\_id](#output\_main\_dataset\_id) | The `dataset_id` of the main dataset |
| <a name="output_main_dataset_self_link"></a> [main\_dataset\_self\_link](#output\_main\_dataset\_self\_link) | The full link into the main dataset |
| <a name="output_masked_dataset_customer_managed_key_id"></a> [masked\_dataset\_customer\_managed\_key\_id](#output\_masked\_dataset\_customer\_managed\_key\_id) | The reference ID of the created customer managed key |
| <a name="output_masked_dataset_id"></a> [masked\_dataset\_id](#output\_masked\_dataset\_id) | The `dataset_id` of the masked dataset |
| <a name="output_masked_dataset_self_link"></a> [masked\_dataset\_self\_link](#output\_masked\_dataset\_self\_link) | The full link into the masked dataset |
<!-- END_TF_DOCS -->
