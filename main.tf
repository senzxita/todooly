terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file("cloud-school-project-311310-12c94d32df5d.json")
  project = "cloud-school-project-311310"
  region = "us-central1"
  zone   = "us-central1-a"

}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_cloud_run_service" "SCA-service" {
  name = "SCA-service" 
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/app"
      }
    }
  }
  traffic {
    percent = 100
    latest_revision = true
  }

  depends_on = [google_project_service.run]
  }

 

resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.SCA-service.name
  location = google_cloud_run_service.SCA-service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "url" {
  value = "${google_cloud_run_service.SCA-service.status[0].url}"
}

resource "google_compute_network" "private_network" {
  provider = google-beta
  name = "private-network"
}

resource "google_compute_global_address" "private_ip" {
  provider = google-beta

  name          = "private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}


resource "google_sql_database_instance" "todooly-mysql" {
  provider = google-beta

  name             = "todooly"
  database_version = "mysql:5.7"
  region           = "us-central1"
  
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "n1-standard-1"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.id
    }
  }
}






