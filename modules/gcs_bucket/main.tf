resource "google_storage_bucket" "this" {
  name                        = var.name
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = "enforced"

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type = lifecycle_rule.value.action_type
      }
      condition {
        age = lifecycle_rule.value.age
      }
    }
  }

  retention_policy {
    is_locked        = false
    retention_period = max(var.retention_period_days, 90) * 86400
  }

  logging {
    log_bucket        = var.logging.log_bucket
    log_object_prefix = var.logging.log_object_prefix
  }

  labels = var.labels
}