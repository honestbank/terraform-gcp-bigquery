## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_table_main"></a> [table\_main](#module\_table\_main) | ../gcp_bigquery_table | n/a |
| <a name="module_view_masked"></a> [view\_masked](#module\_view\_masked) | ../gcp_bigquery_materialized_view | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_managed_key_id"></a> [customer\_managed\_key\_id](#input\_customer\_managed\_key\_id) | Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table. The BigQuery Service Account associated with your project requires access to this encryption key. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to prevent Terraform from destroying the instance. | `bool` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A table name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_schema"></a> [schema](#input\_schema) | n/a | `list(object({ name : string, type : string, pii : bool, mode : string }))` | n/a | yes |
| <a name="input_table_dataset_id"></a> [table\_dataset\_id](#input\_table\_dataset\_id) | ID of the dataset on which the tables should be created | `string` | n/a | yes |
| <a name="input_view_dataset_id"></a> [view\_dataset\_id](#input\_view\_dataset\_id) | ID of the dataset on which view should be created | `string` | n/a | yes |

## Outputs

No outputs.