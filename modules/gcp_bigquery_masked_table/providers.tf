terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.13.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.2"
    }
  }
}
