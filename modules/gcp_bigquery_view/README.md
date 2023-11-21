This module is using for create BigQuery Materialized View (https://cloud.google.com/bigquery/docs/materialized-views-intro)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_table.view](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | The dataset ID to create the view in. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The field description. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A view name for the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_query"></a> [query](#input\_query) | The view query | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The `table_id` of the created resource |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The full link into the created resource |
<!-- END_TF_DOCS -->
