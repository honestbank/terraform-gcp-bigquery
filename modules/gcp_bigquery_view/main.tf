resource "google_bigquery_table" "view" {
  #checkov:skip=CKV_GCP_121:Deletion protection is not needed for views.
  #checkov:skip=CKV_GCP_80:Encryption at rest does not apply to views.
  dataset_id          = var.dataset_id
  table_id            = var.name
  deletion_protection = false
  description         = var.description

  view {
    query          = var.query
    use_legacy_sql = false
  }
}
