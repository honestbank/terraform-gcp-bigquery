This module is using for attach IAM into the BigQuery dataset

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.62.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset_iam_member.google_bigquery_dataset_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset_iam_member) | resource |
| [google_kms_crypto_key_iam_member.google_kms_crypto_key_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_managed_key_id"></a> [customer\_managed\_key\_id](#input\_customer\_managed\_key\_id) | The crypto key ID, in the form {project\_id}/{location\_name}/{key\_ring\_name}/{crypto\_key\_name} or {location\_name}/{key\_ring\_name}/{crypto\_key\_name}. In the second form, the provider's project setting will be used as a fallback. | `string` | n/a | yes |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | The dataset ID. | `string` | n/a | yes |
| <a name="input_member"></a> [member](#input\_member) | Identities that will be granted the privilege in role. If this is a Google account use user:name@email.com, if this is a service account use serviceAccount:name@project.iam.gserviceaccount.com | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The role that should be applied. Only one google\_bigquery\_dataset\_iam\_binding can be used per role. Note that custom roles must be of the format [projects\|organizations]/{parent-name}/roles/{role-name}. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
