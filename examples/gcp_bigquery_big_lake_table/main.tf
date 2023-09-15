terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.63.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.2"
    }
  }
}

resource "random_id" "random_id" {
  byte_length = 4
}

locals {
  CONST_GOOGLE_REGION_JAKARTA          = "asia-southeast2"
  CONST_BIGQUERY_SOURCE_FORMAT_CSV     = "CSV"
  CONST_BIGQUERY_SOURCE_FORMAT_PARQUET = "PARQUET"
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

module "big_lake_connection" {
  source        = "../../modules/gcp_bigquery_big_lake_connection"
  connection_id = "big_lake_connection_${random_id.random_id.hex}"
  location      = local.CONST_GOOGLE_REGION_JAKARTA
}

// creating the BigQuery Big Lake table
module "big_lake_table" {
  #checkov:skip=CKV_GCP_121:Deletion protection is not needed for test resources.
  source = "../../modules/gcp_bigquery_big_lake_table"

  // Let the table detect schema automatically
  autodetect = true
  // Connection id to Big Lake table
  connection_id = module.big_lake_connection.id
  // dataset id that this table will be created in
  dataset_id = module.bigquery_dataset.id
  // protect terraform from deleting the resource, set to false in this example because the test will need to be able to destroy it
  deletion_protection = false
  // description of the table
  description = "table descriptions"

  hive_partitioning_mode = "AUTO"
  hive_source_uri_prefix = "gs://${google_storage_bucket.big_lake_data_source.name}/parquet/"
  // name of this table, the table name will be name with run number, but the friendly name will be the same with what we set here
  name = "big_lake_table"
  // Format of source NEWLINE_DELIMITED_JSON, AVRO, PARQUET
  source_format = local.CONST_BIGQUERY_SOURCE_FORMAT_PARQUET
  // source uri that let Big Lake table read the external data from GCS
  source_uris = ["gs://${google_storage_bucket.big_lake_data_source.name}/${google_storage_bucket_object.dummy_parquet_file.name}"]


  dataset_kms_key_name = module.bigquery_dataset.customer_managed_key_id

  depends_on = [
    google_storage_bucket_object.dummy_parquet_file,
    google_storage_bucket_iam_member.big_lake_connection_gcs_binding
  ]
}

module "partitioned_csv_big_lake_table" {
  #checkov:skip=CKV_GCP_121:Deletion protection is not needed for test resources.
  source = "../../modules/gcp_bigquery_big_lake_table"

  autodetect          = false
  connection_id       = module.big_lake_connection.id
  dataset_id          = module.bigquery_dataset.id
  deletion_protection = false
  description         = "A partitioned CSV table"

  hive_partitioning_mode = "CUSTOM"
  hive_source_uri_prefix = "gs://${google_storage_bucket.big_lake_data_source.name}/csv/{year:INTEGER}/{month:INTEGER}/{day:INTEGER}"
  name                   = "partitioned_csv_big_lake_table"
  schema = jsonencode([
    { name : "column1", type : "STRING", mode : "NULLABLE" },
    { name : "column2", type : "STRING", mode : "NULLABLE" },
  ])
  source_format = local.CONST_BIGQUERY_SOURCE_FORMAT_CSV
  source_uris   = ["gs://${google_storage_bucket.big_lake_data_source.name}/csv/*.csv"]
  csv_options = {
    skip_leading_rows = 1
    field_delimiter   = "|"
  }


  dataset_kms_key_name = module.bigquery_dataset.customer_managed_key_id

  depends_on = [
    google_storage_bucket_object.dummy_csv_file,
    google_storage_bucket_iam_member.big_lake_connection_gcs_binding
  ]
}

resource "google_storage_bucket" "big_lake_data_source" {
  #checkov:skip=CKV_GCP_114:This is an ephemeral example not meant for real-world usage.
  #checkov:skip=CKV_GCP_29:This is an ephemeral example not meant for real-world usage.
  #checkov:skip=CKV_GCP_62:This is an ephemeral example not meant for real-world usage.
  #checkov:skip=CKV_GCP_78:This is an ephemeral example not meant for real-world usage.

  location = local.CONST_GOOGLE_REGION_JAKARTA
  name     = "big_lake_data_source-${random_id.big_lake_data_source_random_id.hex}"
}

resource "random_id" "big_lake_data_source_random_id" {
  byte_length = 4
}

resource "google_storage_bucket_iam_member" "big_lake_connection_gcs_binding" {
  bucket = google_storage_bucket.big_lake_data_source.id
  member = "serviceAccount:${module.big_lake_connection.service_account_id}"
  role   = "roles/storage.objectUser"
}

locals {
  file_extensions = {
    AVRO                   = "avro",
    CSV                    = "csv",
    NEWLINE_DELIMITED_JSON = "json",
    PARQUET                = "parquet",
  }
}

resource "google_storage_bucket_object" "dummy_parquet_file" {
  bucket       = google_storage_bucket.big_lake_data_source.id
  name         = "lang=en/test.${local.file_extensions[var.external_data_source_format]}"
  source       = "./test.${local.file_extensions[var.external_data_source_format]}"
  content_type = "text/plain"
}

resource "google_storage_bucket_object" "dummy_csv_file" {
  bucket       = google_storage_bucket.big_lake_data_source.id
  name         = "csv/year=2023/month=12/day=18/test.csv"
  content      = <<-EOT
  header1|header2
  hello|world
  EOT
  content_type = "text/plain"
}
