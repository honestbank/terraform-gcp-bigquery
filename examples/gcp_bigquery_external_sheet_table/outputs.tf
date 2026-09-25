output "bigquery_dataset_id" {
  value = module.bigquery_dataset.id
}

output "bigquery_dataset_link" {
  value = module.bigquery_dataset.self_link
}

output "bigquery_external_sheet_table_id" {
  value = module.bigquery_external_sheet_table.id
}

output "bigquery_external_sheet_table_link" {
  value = module.bigquery_external_sheet_table.self_link
}
