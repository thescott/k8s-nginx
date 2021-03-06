# Configure the Google Cloud provider
provider "google" {
  project     = var.project_id
  region      = var.region
}
# I want to use the default network 
data "google_compute_network" "default" {
  name = "default-us-central1"
}

# Use this data source to access the configuration of the Google Cloud provider 
data "google_client_config" "current" {
}

# Provides access to available Google Kubernetes Engine versions in a zone or region for a given project.
data "google_container_engine_versions" "default" {
  location = var.location
}

# Create cluster with 3 nodes
resource "google_container_cluster" "default" {
  name               = var.name
  location           = var.location
  initial_node_count = 3
  min_master_version = data.google_container_engine_versions.default.latest_master_version

  provisioner "local-exec" {
    when    = destroy
    command = "sleep 90"
  }
}
# Terraform will output this data once everything has been created


output "cluster_name" {
  value = google_container_cluster.default.name
}

output "cluster_region" {
  value = var.region
}



