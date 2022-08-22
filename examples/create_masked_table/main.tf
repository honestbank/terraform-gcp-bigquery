module "masked_dataset" {
  source         = "../../modules/gcp_bigquery_masking_dataset"
  description    = "description of the dataset"
  google_project = "project"
  location       = "asia-southeast2"
  name           = "dataset_name"
  owner_email    = "email"
}

module "create_masked_table" {
  source = "../../modules/gcp_bigquery_masked_table"
  customer_managed_key_id = module.masked_dataset.dataset_customer_managed_key_id
  deletion_protection = true
  description = "table description"
  name = "table name"
  table_dataset_id = module.masked_dataset.main_dataset_id
  view_dataset_id = module.masked_dataset.masked_dataset_id
  schema = [{name: "test", "type": "STRING", mode: "NULLABLE", pii: true}]
}
