output "bigquery_dataset_id" {
  value = module.bigquery_dataset.id
}

output "bigquery_dataset_link" {
  value = module.bigquery_dataset.self_link
}

output "bigquery_table_1_id" {
  value = module.bigquery_table_1.id
}

output "bigquery_table_2_id" {
  value = module.bigquery_table_2.id
}

output "bigquery_table_1_link" {
  value = module.bigquery_table_1.self_link
}

output "bigquery_table_2_link" {
  value = module.bigquery_table_2.self_link
}
