provider "google" {
  project = var.project_id
  region = var.region
}

resource "google_cloud_run_service" "app" {
  name = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent = 100
    latest_revision = true
  }
}

resource "google_cloud_run_member" "public" {
  service = google_cloud_run_service.app.name
  location = var.region
  role = "roles/run.invoker"
  member = "allUsers"
}
