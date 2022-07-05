terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.13.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

resource "random_id" "random_id" {
  byte_length = 4
}

// create a google service account to become dataset owner
resource "google_service_account" "owner" {
  account_id   = "datasetowner${random_id.random_id.hex}"
  display_name = "dataset_owner"
}

// creating the BigQuery dataset at Jakarta
module "create_bigquery_dataset" {
  source = "../../modules/gcp_bigquery_dataset"
  // name of the dataset, this will have run number as suffix but the friendly name will be exactly what we set
  name = "dataset_${random_id.random_id.hex}"
  // description describe the dataset
  description = "dataset's description"
  // location of the resource which here is Jakarta
  location = "asia-southeast2"
  // email of the owner of the account, can be either user or service account
  owner_email = google_service_account.owner.email
  // indicate the Google project that this resource will be created in
  google_project = var.google_project
}

// creating the BigQuery table
module "create_bigquery_table_1" {
  source = "../../modules/gcp_bigquery_table"
  // dataset id that this table will be created in
  dataset_id = module.create_bigquery_dataset.id
  // name of this table, the table name will be name with run number, but the friendly name will be the same with what we set here
  name = "service__table_name_1"
  // description of the table
  description = "table descriptions"
  // protect terraform from deleting the resource, set to false in this example because the test will need to be able to destroy it
  deletion_protection = false
  // customer managed key that dataset is created
  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id
}

// creating the BigQuery table with Schema
module "create_bigquery_table_2" {
  source = "../../modules/gcp_bigquery_table"
  // dataset id that this table will be created in
  dataset_id = module.create_bigquery_dataset.id
  // name of this table, the table name will be name with run number, but the friendly name will be the same with what we set here
  name = "service__table_name_2"
  // description of the table
  description = "table descriptions"
  // protect terraform from deleting the resource, set to false in this example because the test will need to be able to destroy it
  deletion_protection = false
  // schema for the table
  schema = <<EOF
[
  {
    "mode": "NULLABLE",
    "name": "F9_DW002_UPD_TMS",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "P9_DW002_FI",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "P9_DW002_CRN",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_TTL",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_NAME",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_NEW_ID_IND",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_NEW_ID",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "F9_DW002_DOB",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_GENDR",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_NATL",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_MARR_STAT",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_EMAIL_ADDR",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_HP",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_REVW_CDE",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CIF_NO",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CUST_IND",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_STAT",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORP_DIST",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORP_SUB_DIST",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_ADDR_1",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_ADDR_2",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_ADDR_3",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_ADDR_4",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_CNTRY",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_ST_CDE",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_TEL",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_TOWN",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_CORSP_ZIP",
    "type": "INTEGER"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_FLWUP_PGM_IND",
    "type": "BOOLEAN"
  },
  {
    "mode": "NULLABLE",
    "name": "FX_DW002_POB",
    "type": "STRING"
  }
]
EOF
  // customer managed key that dataset is created
  customer_managed_key_id = module.create_bigquery_dataset.customer_managed_key_id

  materialized_view = [{
    query = "SELECT * FROM service__table_name_1"
  }]
}
