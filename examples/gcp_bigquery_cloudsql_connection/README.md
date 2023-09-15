# Google BigQuery CloudSQL Connection Example

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.13.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.16.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bigquery_dataset"></a> [bigquery\_dataset](#module\_bigquery\_dataset) | ../../modules/gcp_bigquery_dataset | n/a |
| <a name="module_connection"></a> [connection](#module\_connection) | ../../modules/gcp_bigquery_cloudsql_connection | n/a |
| <a name="module_dataset_owner_access"></a> [dataset\_owner\_access](#module\_dataset\_owner\_access) | ../../modules/gcp_bigquery_dataset_iam_policy | n/a |
| <a name="module_dataset_viewer_access"></a> [dataset\_viewer\_access](#module\_dataset\_viewer\_access) | ../../modules/gcp_bigquery_dataset_iam_policy | n/a |
| <a name="module_sql_database"></a> [sql\_database](#module\_sql\_database) | ../../modules/terraform-gcp-sql/modules/google_sql_database | n/a |
| <a name="module_sql_database_instance"></a> [sql\_database\_instance](#module\_sql\_database\_instance) | ../../modules/terraform-gcp-sql/modules/google_sql_database_instance | n/a |
| <a name="module_sql_user"></a> [sql\_user](#module\_sql\_user) | ../../modules/terraform-gcp-sql/modules/google_sql_user | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.instance_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_instance_id"></a> [database\_instance\_id](#input\_database\_instance\_id) | Database name for bigquery cloudsql connection, keep in mind one database per connection | `string` | `""` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Database name for bigquery cloudsql connection, keep in mind one database per connection | `string` | `"superhackers"` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Default region for gcp project | `string` | `"asia-southeast2"` | no |
| <a name="input_google_credentials"></a> [google\_credentials](#input\_google\_credentials) | JSON GCP IAM credentials that have GCP Owner and BigQuery Admin Role granted | `string` | n/a | yes |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | Project where Bigquery resources will be created | `string` | n/a | yes |
| <a name="input_settings_availability_type"></a> [settings\_availability\_type](#input\_settings\_availability\_type) | select between zonal, regional | `string` | `"ZONAL"` | no |
| <a name="input_settings_backup_configuration_binary_log_enabled"></a> [settings\_backup\_configuration\_binary\_log\_enabled](#input\_settings\_backup\_configuration\_binary\_log\_enabled) | backup log enablement cloudsql | `bool` | `true` | no |
| <a name="input_settings_backup_configuration_enabled"></a> [settings\_backup\_configuration\_enabled](#input\_settings\_backup\_configuration\_enabled) | Database backup enable | `bool` | `true` | no |
| <a name="input_settings_tier"></a> [settings\_tier](#input\_settings\_tier) | instance type fo the cloudsql | `string` | `"db-f1-micro"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | CloudSQL database username | `string` | `"cloudsql_connection_example_user"` | no |
| <a name="input_user_type"></a> [user\_type](#input\_user\_type) | choose between CLOUD\_IAM\_SERVICE\_ACCOUNT or CLOUD\_IAM\_USER or BUILD\_IN | `string` | `"BUILT_IN"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_connection_link"></a> [bigquery\_connection\_link](#output\_bigquery\_connection\_link) | The name of bigquery to read replica connection |
| <a name="output_bigquery_dataset_id"></a> [bigquery\_dataset\_id](#output\_bigquery\_dataset\_id) | n/a |
| <a name="output_bigquery_dataset_link"></a> [bigquery\_dataset\_link](#output\_bigquery\_dataset\_link) | n/a |
| <a name="output_random_string"></a> [random\_string](#output\_random\_string) | Random string |
| <a name="output_sql_database_instance_master_connection_name"></a> [sql\_database\_instance\_master\_connection\_name](#output\_sql\_database\_instance\_master\_connection\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_sql_database_instance_master_first_ip_address"></a> [sql\_database\_instance\_master\_first\_ip\_address](#output\_sql\_database\_instance\_master\_first\_ip\_address) | The IPv4 address assigned. |
| <a name="output_sql_database_instance_master_instance_name"></a> [sql\_database\_instance\_master\_instance\_name](#output\_sql\_database\_instance\_master\_instance\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_sql_database_instance_master_private_ip_address"></a> [sql\_database\_instance\_master\_private\_ip\_address](#output\_sql\_database\_instance\_master\_private\_ip\_address) | The first private (`PRIVATE`) IPv4 address assigned. |
| <a name="output_sql_database_instance_master_public_ip_address"></a> [sql\_database\_instance\_master\_public\_ip\_address](#output\_sql\_database\_instance\_master\_public\_ip\_address) | The first public (`PRIMARY`) IPv4 address assigned. |
| <a name="output_sql_database_instance_master_self_link"></a> [sql\_database\_instance\_master\_self\_link](#output\_sql\_database\_instance\_master\_self\_link) | The URI of the created resource. |
| <a name="output_sql_database_instance_master_service_account_email_address"></a> [sql\_database\_instance\_master\_service\_account\_email\_address](#output\_sql\_database\_instance\_master\_service\_account\_email\_address) | The service account email address assigned to the instance. |
| <a name="output_sql_database_instance_read_replica_connection_name"></a> [sql\_database\_instance\_read\_replica\_connection\_name](#output\_sql\_database\_instance\_read\_replica\_connection\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_sql_database_instance_read_replica_first_ip_address"></a> [sql\_database\_instance\_read\_replica\_first\_ip\_address](#output\_sql\_database\_instance\_read\_replica\_first\_ip\_address) | The IPv4 address assigned. |
| <a name="output_sql_database_instance_read_replica_instance_name"></a> [sql\_database\_instance\_read\_replica\_instance\_name](#output\_sql\_database\_instance\_read\_replica\_instance\_name) | The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy. |
| <a name="output_sql_database_instance_read_replica_self_link"></a> [sql\_database\_instance\_read\_replica\_self\_link](#output\_sql\_database\_instance\_read\_replica\_self\_link) | The URI of the created resource. |
| <a name="output_sql_database_instance_read_replicbigquery_connection_linka_service_account_email_address"></a> [sql\_database\_instance\_read\_replicbigquery\_connection\_linka\_service\_account\_email\_address](#output\_sql\_database\_instance\_read\_replicbigquery\_connection\_linka\_service\_account\_email\_address) | The service account email address assigned to the instance. |
| <a name="output_sql_database_master_id"></a> [sql\_database\_master\_id](#output\_sql\_database\_master\_id) | an identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}} |
| <a name="output_sql_database_master_self_link"></a> [sql\_database\_master\_self\_link](#output\_sql\_database\_master\_self\_link) | The URI of the created resource. |
| <a name="output_sql_user_name"></a> [sql\_user\_name](#output\_sql\_user\_name) | The name of the user. |
| <a name="output_sql_user_password"></a> [sql\_user\_password](#output\_sql\_user\_password) | The password for the user |
| <a name="output_sql_user_type"></a> [sql\_user\_type](#output\_sql\_user\_type) | The user type |
<!-- END_TF_DOCS -->
