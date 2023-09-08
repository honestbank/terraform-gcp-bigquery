output "bigquery_main_dataset_id" {
  value = module.bigquery_dataset.main_dataset_id
}
output "bigquery_masked_dataset_id" {
  value = module.bigquery_dataset.masked_dataset_id
}

output "bigquery_table_id" {
  value = module.bigquery_masked_table.table_id
}

output "bigquery_view_id" {
  value = module.bigquery_masked_table.view_id
}
