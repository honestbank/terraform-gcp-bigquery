output "bigquery_masked_dataset_id" {
  value = module.create_bigquery_dataset.masked_dataset_id
}

output "bigquery_main_dataset_id" {
  value = module.create_bigquery_dataset.main_dataset_id
}
