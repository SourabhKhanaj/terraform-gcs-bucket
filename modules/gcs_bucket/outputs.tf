output "bucket_name" {
  description = "The name of the GCS bucket"
  value       = google_storage_bucket.this.name
}

output "bucket_url" {
  description = "The GCS bucket self-link"
  value       = google_storage_bucket.this.self_link
}