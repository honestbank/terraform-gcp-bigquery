output "bigquery_dataset_id" {
  value = module.bigquery_dataset.id
}

output "bigquery_dataset_link" {
  value = module.bigquery_dataset.self_link
}

output "bigquery_table_id" {
  value = module.bigquery_table.id
}

output "bigquery_table_link" {
  value = module.bigquery_table.self_link
}

output "bigquery_view_id" {
  value = module.bigquery_view.id
}

output "bigquery_view_link" {
  value = module.bigquery_view.self_link
}
