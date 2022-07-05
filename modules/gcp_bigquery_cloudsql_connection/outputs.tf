output "bigquery_connection_link" {
  description = "The connection name of the instance to be used in connection strings. For example, when connecting with Cloud SQL Proxy."
  value       = google_bigquery_connection.connection.id
}

output "id" {
  description = "The reference ID of the created resource"
  value       = google_bigquery_connection.connection.connection_id
}
