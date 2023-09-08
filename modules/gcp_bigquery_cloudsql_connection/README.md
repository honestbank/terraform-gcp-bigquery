<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >=4.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >=4.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_bigquery_connection.connection](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_bigquery_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | ID of the BigQuery connection | `string` | n/a | yes |
| <a name="input_database_instance_id"></a> [database\_instance\_id](#input\_database\_instance\_id) | ID of the CloudSQL INSTANCE. Note: not the database inside the instance, but the instance. Note: it has to be formatted as project:zone:database\_id | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database inside the CloudSQL instance, NOT the instance name / ID. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of the BigQuery connection | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | GCP location, e.g. asia-southeast2 | `string` | `"asia-southeast2"` | no |
| <a name="input_sql_user_credentials"></a> [sql\_user\_credentials](#input\_sql\_user\_credentials) | Credentials of the SQL User in the database inside the instance - Note: The user must exist prior to building this component. | <pre>object({<br>    user_name : string<br>    password : string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_connection_link"></a> [bigquery\_connection\_link](#output\_bigquery\_connection\_link) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_id"></a> [id](#output\_id) | The reference ID of the created resource |
<!-- END_TF_DOCS -->
