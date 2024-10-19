# Cloud Storage Bucket
resource "google_storage_bucket" "bucket" {
  name     = "${var.common.prefix}-storage-bucket-${var.common.environment}"
  location = var.storage.location
  cors {
    origin          = ["http://localhost:3000", "https://localhost:5173", var.common.domain]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}


# Google Cloud Storage IAM Binding (Allow access to the bucket)
resource "google_storage_bucket_iam_member" "bucket_admin" {
  bucket   = "${var.common.prefix}-storage-bucket-${var.common.environment}"
  role     = "roles/storage.objectAdmin"
  for_each = toset(local.members)
  member   = each.value
}

resource "google_project_iam_member" "service_account_token_creator" {
  project  = var.common.project
  role     = "roles/iam.serviceAccountTokenCreator"
  for_each = toset(local.members)
  member   = each.value
}