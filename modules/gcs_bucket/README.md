# GCS Bucket Terraform Module

This module provisions a secure, configurable Google Cloud Storage bucket.

## Usage

```hcl
module "bucket" {
  source = "../../modules/gcs_bucket"

  name                        = "my-sample-bucket"
  location                    = "US"
  storage_class               = "STANDARD"
  versioning                  = true
  uniform_bucket_level_access = true
  force_destroy               = true
  lifecycle_rules = [
    {
      action_type = "Delete"
      age         = 30
    }
  ]
  retention_period_days = 90
  logging = {
    log_bucket        = "logging-bucket"
    log_object_prefix = "gcs/"
  }
  labels = {
    env = "dev"
  }
}
```

## Required IAM
Ensure the identity running Terraform has:
- `roles/storage.admin`
- `roles/logging.admin` (if enabling logging)