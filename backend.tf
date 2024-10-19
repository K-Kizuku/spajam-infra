resource "google_storage_bucket" "terraform-state-store" {
  name     = "${var.common.prefix}-tfbacket-bucket-${var.common.environment}"
  location = var.storage.location

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
    }
  }
}
