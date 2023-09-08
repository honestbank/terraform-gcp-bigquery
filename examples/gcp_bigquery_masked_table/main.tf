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

resource "random_id" "random_id" {
  byte_length = 4
}

// create a google service account to become dataset owner
resource "google_service_account" "owner" {
  account_id   = "datasetowner${random_id.random_id.hex}"
  display_name = "dataset_owner"
}
resource "random_id" "dataset_suffix" {
  byte_length = 10
}
// creating the BigQuery dataset at Jakarta
module "bigquery_dataset" {
  source = "../../modules/gcp_bigquery_masked_dataset"
  // name of the dataset, this will have run number as suffix but the friendly name will be exactly what we set
  name = "dataset_${random_id.dataset_suffix.hex}"
  // description describe the dataset
  description = "dataset's description"
  // location of the resource which here is Jakarta
  location = "asia-southeast2"
  // email of the owner of the account, can be either user or service account
  owner_email = google_service_account.owner.email
  // indicate the Google project that this resource will be created in
  google_project = var.google_project
}

resource "time_sleep" "sleep_before_creating_tables" {
  create_duration  = "10s"
  destroy_duration = "0s"
}

// creating the BigQuery table
module "bigquery_masked_table" {
  source = "../../modules/gcp_bigquery_masked_table"
  // dataset id that this table will be created in
  table_dataset_id = module.bigquery_dataset.main_dataset_id
  view_dataset_id  = module.bigquery_dataset.masked_dataset_id
  // name of this table, the table name will be name with run number, but the friendly name will be the same with what we set here
  name = "service__table_name_1"
  // description of the table
  description = "table descriptions"
  // protect terraform from deleting the resource, set to false in this example because the test will need to be able to destroy it
  deletion_protection = false
  // customer managed key that dataset is created
  customer_managed_key_id = module.bigquery_dataset.dataset_customer_managed_key_id
  schema = [
    { name : "name", type : "STRING", pii : true, mode : "NULLABLE" },
    { name : "id", type : "STRING", pii : false, mode : "NULLABLE" }
  ]
  depends_on = [
    time_sleep.sleep_before_creating_tables
  ]
}
