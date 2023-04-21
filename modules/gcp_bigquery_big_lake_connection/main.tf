# ######################################################################
# Creates a BigQuery connection to support BigLake table
# ######################################################################

resource "google_bigquery_connection" "big_lake_connection" {
  connection_id = var.connection_id
  description   = var.description
  friendly_name = var.connection_id
  location      = var.location
  provider      = google

  cloud_resource {}
}
