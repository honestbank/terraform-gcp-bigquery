output "table_id" {
  description = "The `table_id` of the created BigQuery Table"
  value       = module.table_main.id
}

output "view_id" {
  description = "The `view_id` of the created BigQuery View"
  value       = module.view_masked.id
}
