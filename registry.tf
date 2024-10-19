# Artifact Registry Repository
resource "google_artifact_registry_repository" "repository" {
  location      = var.common.region
  repository_id = "${var.common.prefix}-docker-${var.common.environment}"
  format        = "DOCKER"
}

# Artifact Registry IAM Binding (Grant pull permissions)
resource "google_artifact_registry_repository_iam_member" "artifact_registry" {
  repository = "${var.common.prefix}-docker-${var.common.environment}"
  role       = "roles/artifactregistry.reader"
  for_each   = toset(local.members)
  member     = each.value
}