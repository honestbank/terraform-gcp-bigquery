terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.13.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

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
  default     = ""
  description = "Database name for bigquery cloudsql connection, keep in mind one database per connection"
}

variable "user_name" {
  default     = "github-terratest@test-terraform-project-01.iam.gserviceaccount.com"
  description = "username for cloudsql"
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
  default     = "CLOUD_IAM_SERVICE_ACCOUNT"
  description = "choose between CLOUD_IAM_SERVICE_ACCOUNT or CLOUD_IAM_USER or BUILD_IN"
}

variable "gcp_region" {
  default     = "asia-southeast2"
  description = "Default region for gcp project"
}
resource "random_id" "random_id" {
  byte_length = 8
}

// create a google service account to become dataset owner
resource "google_service_account" "owner" {
  account_id   = "datasetowner${random_id.random_id.hex}"
  display_name = "dataset_owner"
}

// creating the BigQuery dataset at Jakarta
module "create_bigquery_dataset" {
  source = "../../modules/gcp_bigquery_dataset"
  // name of the dataset, this will have run number as suffix but the friendly name will be exactly what we set
  name = "dataset"
  // description describe the dataset
  description = "dataset's description"
  // location of the resource which here is Jakarta
  location = "asia-southeast2"
  // email of the owner of the account, can be either user or service account
  owner_email = google_service_account.owner.email
  // indicate the Google project that this resource will be created in
  google_project = var.google_project
}

// create a google service account to become dataset viewer
resource "google_service_account" "viewer" {
  account_id   = "dsv-${random_id.random_id.hex}"
  display_name = "dataset_viewer"
}

// attach viewer service account to the dataset
module "attach_viewer_to_dataset" {
  source = "../../modules/gcp_bigquery_dataset_iam_policy"

  // created customer managed key from the dataset
  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id
  // created dataset id that this will attach itself to
  dataset_id = module.create_bigquery_dataset.id
  // service account email in the format user:name@email.com for Google account, and serviceAccount:name@project.iam.gserviceaccount.com for a service account
  member = "serviceAccount:${google_service_account.viewer.email}"
  // the role we that this user will be allowed to do
  role = "roles/bigquery.dataViewer"
}

// create a google service account to become dataset editor
resource "google_service_account" "editor" {
  account_id   = "dse-${random_id.random_id.hex}"
  display_name = "dataset_editor"
}

resource "random_id" "instance_suffix" {
  byte_length = 4
}

resource "random_id" "random_string" {
  byte_length = 12
}

module "sql_database_instance" {
  source = "../../modules/terraform-gcp-sql/modules/google_sql_database_instance"

  name = "sql-rr-bigquery-test-${random_id.instance_suffix.hex}"

  # depends_on = [module.google_service_networking_connection_private_vpc_connection]


  settings_backup_configuration_binary_log_enabled = var.settings_backup_configuration_binary_log_enabled
  settings_backup_configuration_enabled            = var.settings_backup_configuration_enabled

  # Requirements for using the Cloud SQL Auth proxy
  # https://cloud.google.com/sql/docs/mysql/sql-proxy#requirements

  settings_ip_configuration_ipv4_enabled = true
  # settings_ip_configuration_private_network = module.google_compute_network_private_network.id

  #checkov:skip=CKV_GCP_6:Ensure all Cloud SQL database instance requires all incoming connections to use SSL"
  settings_ip_configuration_require_ssl = false

  settings_availability_type = var.settings_availability_type

  settings_tier       = var.settings_tier
  deletion_protection = false

  enable_read_replica                                 = true
  read_replica_settings_ip_configuration_ipv4_enabled = true
  read_replica_settings_tier                          = var.settings_tier
}

module "sql_database" {
  source = "../../modules/terraform-gcp-sql/modules/google_sql_database"

  depends_on = [
    module.sql_user
  ]

  instance_name = module.sql_database_instance.instance_name
  name          = var.database_name
}

module "sql_user" {
  source = "../../modules/terraform-gcp-sql/modules/google_sql_user"

  # depends_on = [
  #   module.google_sql_database_instance
  # ]

  instance_name = module.sql_database_instance.instance_name
  name          = var.user_name
  password      = random_id.random_string.hex
  host          = "%"
  type          = var.user_type
}

module "connection" {
  source = "../../modules/gcp_bigquery_cloudsql_connection"
  providers = {
    google-beta = google-beta
  }
  depends_on           = [module.sql_user]
  connection_id        = "bigquery-connection-random_id.instance_suffix.hex-for-test"
  description          = "we're h@k3rs"
  database_instance_id = module.sql_database_instance.read_replica_connection_name
  database_name        = var.database_name
  sql_user_credentials = {
    user_name : var.user_name
    password : random_id.random_string.hex
  }
}
