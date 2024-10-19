locals {
  members = [
    "serviceAccount:${google_cloud_run_service.one_cloud_run_service.name}@${google_cloud_run_service.one_cloud_run_service.project}.iam.gserviceaccount.com",
  ]
}