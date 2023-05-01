terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.63.1"
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

// creating the BigQuery dataset at Jakarta
module "bigquery_dataset" {
  source = "../../modules/gcp_bigquery_dataset"

  // name of the dataset, this will have run number as suffix but the friendly name will be exactly what we set
  name = "dataset_${random_id.random_id.hex}"
  // description describe the dataset
  description = "dataset's description"
  // location of the resource which here is Jakarta
  location = "asia-southeast2"
  // email of the owner of the account, can be either user or service account
  owner_email = google_service_account.owner.email
  // indicate the Google project that this resource will be created in
  google_project = var.google_project
}

// creating the BigQuery Big Lake table
module "big_lake_table" {
  source = "../../modules/gcp_bigquery_big_lake_table"

  // Let the table detect schema automatically
  autodetect = true
  // Connection id to Big Lake table
  connection_id = "projects/storage-44a30d2d/locations/asia-southeast2/connections/big_lake_connection"
  // dataset id that this table will be created in
  dataset_id = "big_lake_poc"
  // protect terraform from deleting the resource, set to false in this example because the test will need to be able to destroy it
  deletion_protection = false
  // description of the table
  description = "table descriptions"
  // Hive partition mode for detect file pattern
  hive_partitioning_mode = "AUTO"
  // dataset id
  hive_source_uri_prefix = "gs://kafka-connector-dev_06d1a6cf/topics/data.online-etl.brankas.transformed_transactions"
  // name of this table, the table name will be name with run number, but the friendly name will be the same with what we set here
  name = "big_lake_table"
  // Format of source NEWLINE_DELIMITED_JSON, AVRO, PARQUET
  source_format = "NEWLINE_DELIMITED_JSON"
  // source uri that let Big Lake table read the external data from GCS
  source_uris = ["gs://kafka-connector-dev_06d1a6cf/topics/data.online-etl.brankas.transformed_transactions*"]
}
