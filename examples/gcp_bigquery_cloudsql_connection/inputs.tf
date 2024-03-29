variable "settings_tier" {
  default     = "db-f1-micro"
  description = "instance type fo the cloudsql"
}

variable "settings_backup_configuration_binary_log_enabled" {
  default     = true
  description = "backup log enablement cloudsql"
}

variable "settings_availability_type" {
  default     = "ZONAL"
  description = "select between zonal, regional"
}

variable "database_name" {
  default     = "cloudsql_conn_example_db"
  description = "Database name for bigquery cloudsql connection, keep in mind one database per connection"
}

variable "user_name" {
  default     = "cloudsql_connection_example_user"
  description = "CloudSQL database username"
}

variable "database_instance_id" {
  default     = ""
  description = "Database name for bigquery cloudsql connection, keep in mind one database per connection"
}

variable "settings_backup_configuration_enabled" {
  default     = true
  description = "Database backup enable"
}

variable "user_type" {
  default     = "BUILT_IN"
  description = "choose between CLOUD_IAM_SERVICE_ACCOUNT or CLOUD_IAM_USER or BUILD_IN"
}

variable "gcp_region" {
  default     = "asia-southeast2"
  description = "Default region for gcp project"
}
