resource "google_sql_database_instance" "db" {
  name                = "${var.common.prefix}-eisa-db-${var.common.environment}"
  region              = var.common.region
  database_version    = "POSTGRES_15"
  deletion_protection = false
  settings {
    tier              = "db-custom-2-7680"
    activation_policy = "ALWAYS"
    ip_configuration {
      ipv4_enabled = true
    }
    disk_type = "PD_SSD"
    disk_size = 10
  }
}

# Create a service account for cloud_sql_proxy
resource "google_service_account" "cloud_sql_proxy_sa" {
  account_id   = "cloud-sql-proxy-sa"
  display_name = "Service Account for Cloud SQL Proxy"
}

# Assign IAM roles to the service account for accessing the Cloud SQL instance
resource "google_project_iam_member" "cloud_sql_proxy" {
  project = var.common.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloud_sql_proxy_sa.email}"
}


resource "google_sql_database" "db" {
  name     = var.sql.database
  instance = google_sql_database_instance.db.name
}

resource "google_sql_user" "db" {
  name     = var.sql.user
  instance = google_sql_database_instance.db.name
  password = var.sql.password
}