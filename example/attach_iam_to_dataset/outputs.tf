output "bigquery_dataset_id" {
  value = module.create_bigquery_dataset.id
}

output "bigquery_dataset_link" {
  value = module.create_bigquery_dataset.self_link
}
