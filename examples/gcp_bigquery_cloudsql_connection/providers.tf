variable "google_project" {
  type        = string
  description = "Project where Bigquery resources will be created"
}

variable "google_credentials" {
  type        = string
  description = "JSON GCP IAM credentials that have GCP Owner and BigQuery Admin Role granted"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.13.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.16.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.2"
    }
  }
}

provider "google" {
  credentials = var.google_credentials
  project     = var.google_project
  region      = var.gcp_region
}

provider "google-beta" {
  credentials = var.google_credentials
  project     = var.google_project
  region      = var.gcp_region
}
