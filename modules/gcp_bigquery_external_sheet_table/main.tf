locals {
  # BigQuery reads a Google Sheet over the Drive connector. It accepts the plain spreadsheet URL, without a `#gid`
  # fragment. Use `var.range` to select a tab, because a `#gid` fragment in the URI is ignored.
  source_uri = "https://docs.google.com/spreadsheets/d/${var.spreadsheet_id}"
}

resource "google_bigquery_table" "google_bigquery_table" {
  # checkov:skip=CKV_GCP_80:A Google Sheets external table stores no data in BigQuery, so it cannot hold a CSEK key.
  #                          The sheet itself stays under Google Drive encryption.
  dataset_id          = var.dataset_id
  deletion_protection = var.deletion_protection
  description         = var.description
  table_id            = var.name

  external_data_configuration {
    autodetect    = var.autodetect
    source_format = "GOOGLE_SHEETS"
    source_uris   = [local.source_uri]

    # An external table without a `connection_id` must carry its schema here, not in the top-level `schema` field.
    # See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table
    schema = var.schema == "" ? null : var.schema

    # A KPI sheet often carries trailing comment columns and part-filled rows. These two inputs stop a single bad
    # cell from failing every query.
    ignore_unknown_values = var.ignore_unknown_values
    max_bad_records       = var.max_bad_records

    google_sheets_options {
      range             = var.range
      skip_leading_rows = var.skip_leading_rows
    }
  }

  lifecycle {
    # BigQuery returns the effective schema, which differs from the input schema. Ignore it, exactly as the Big Lake
    # table module does. See https://github.com/hashicorp/terraform-provider-google/issues/10919
    ignore_changes = [
      schema,
    ]
  }
}
