terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.63.1"
    }
  }
}

resource "google_bigquery_table" "google_bigquery_table" {
  # checkov:skip=CKV_GCP_80:Big Lake Table does not support CSEK. The normal practice is to use the key in GCS bucket.
  dataset_id          = var.dataset_id
  deletion_protection = var.deletion_protection
  description         = var.description
  table_id            = var.name

  # Terraform will detect changes to this property made by BigQuery, but we'll ignore them using the `lifecycle` block.
  schema = var.schema

  external_data_configuration {
    autodetect    = var.autodetect
    connection_id = var.connection_id
    source_format = var.source_format
    source_uris   = var.source_uris

    # Use the exact same schema here. This one won't be changed by BigQuery, however Terraform will still detect the changes you make on purpose to this field.
    schema = var.schema

    hive_partitioning_options {
      mode              = var.hive_partitioning_mode
      source_uri_prefix = var.hive_source_uri_prefix
    }
  }

  lifecycle {

    # See https://github.com/hashicorp/terraform-provider-google/issues/10919
    ignore_changes = [
      # BigQuery will return the effective schema, which contains differences (e.g. the partition column(s) is added to
      # it). Recreation of the table should only be based on `external_data_configuration.schema`, which is only stored
      # in the Terraform state, not BigQuery. This field contains exactly the input schema and can be used for diffs.
      schema,
    ]
  }
}
