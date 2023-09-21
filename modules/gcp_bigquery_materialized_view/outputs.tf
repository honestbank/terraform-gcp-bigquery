output "self_link" {
  description = "The full link into the created resource"
  value       = google_bigquery_table.materialized_view.self_link
}

output "id" {
  description = "The `table_id` of the created resource"
  value       = google_bigquery_table.materialized_view.table_id
}
