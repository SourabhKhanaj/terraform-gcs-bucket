variable "name" {
  description = "Unique name of the bucket (must comply with GCS naming rules)"
  type        = string
  validation {
    condition     = length(var.name) <= 63 && length(var.name) >= 3 && can(regex("^[a-z0-9._-]+$", var.name))
    error_message = "Bucket name must be 3-63 characters, lowercase, and only include letters, numbers, dashes, underscores, and dots."
  }
}

variable "location" {
  description = "Location of the bucket (e.g. US, EU, ASIA)"
  type        = string
}

variable "storage_class" {
  description = "Storage class of the bucket"
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "storage_class must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = false
}

variable "uniform_bucket_level_access" {
  description = "Enable uniform bucket-level access"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for bucket objects"
  type = list(object({
    action_type = string
    age         = number
  }))
  default = []
}

variable "retention_period_days" {
  description = "Retention period in days (minimum 90)"
  type        = number
  default     = 90
}

variable "logging" {
  description = "Logging configuration"
  type = object({
    log_bucket        = string
    log_object_prefix = string
  })
  default = {
    log_bucket        = ""
    log_object_prefix = ""
  }
}

variable "force_destroy" {
  description = "Force destroy bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Key-value pairs of labels to assign to the bucket"
  type        = map(string)
  default     = {}
}