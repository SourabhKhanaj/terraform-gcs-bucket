provider "google" {
  project = "rabobank-assessment"
  region  = "us-central1"
}

module "bucket" {
  source = "../../modules/gcs_bucket"

  name     = "rabobank-bkt"
  location = "US"

  storage_class                = "STANDARD"
  versioning                  = true
  force_destroy               = true
  uniform_bucket_level_access = true

  lifecycle_rules = [
    {
      action_type = "Delete"
      age         = 30
    }
  ]

  retention_period_days = 100
  logging = {
    log_bucket        = "logging-bucket"
    log_object_prefix = "tf-bucket/"
  }

  labels = {
    environment = "dev"
    team        = "cloud"
  }
}