# Cloud Run Service
resource "google_cloud_run_service" "one_cloud_run_service" {
  name     = "${var.common.prefix}-one-${var.common.environment}"
  location = var.common.region

  template {
    spec {
      containers {
        image = "${var.common.region}-docker.pkg.dev/${var.common.project}/${var.common.prefix}-docker-${var.common.environment}/${var.cloud_run.name}:latest"
        resources {
          limits = {
            cpu    = var.cloud_run.cpu
            memory = var.cloud_run.memory
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_cloud_run_service_iam_member.invoker]
}



resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.common.prefix}-cloud-run-neg"
  region                = var.common.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_service.one_cloud_run_service.name
  }
}

# Cloud Run IAM Binding (Allow all users to invoke the service)
resource "google_cloud_run_service_iam_member" "invoker" {
  location = var.common.region
  project  = var.common.project
  service  = var.cloud_run.name

  role   = "roles/run.invoker"
  member = "allUsers"
}

resource "google_service_account" "cloudrun_service_account-one" {
  account_id   = "${var.common.prefix}-one-${var.common.environment}"
  display_name = "Cloud Run Service Account"
}




