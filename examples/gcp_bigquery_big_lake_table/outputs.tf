output "bigquery_dataset_id" {
  value = module.bigquery_dataset.id
}

output "bigquery_dataset_link" {
  value = module.bigquery_dataset.self_link
}

output "big_lake_table_id" {
  value = module.big_lake_table.id
}

output "big_lake_table_link" {
  value = module.big_lake_table.self_link
}


output "partitioned_csv_big_lake_table_id" {
  value = module.partitioned_csv_big_lake_table.id
}
