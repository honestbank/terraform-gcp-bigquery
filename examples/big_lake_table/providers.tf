variable "google_project" {
  type        = string
  description = "Project that dataset will be created"
}

provider "google" {
  project = var.google_project
}
