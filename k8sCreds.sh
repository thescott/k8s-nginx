#!/usr/bin/env bash

set -x 
set -e
clusterID="$(terraform output subnetwork_name)"
# Set your compute zone to match what your terraform is creating
gcloud config set compute/zone us-central1-a

# Authenticate to your newly created cluster 
gcloud container clusters get-credentials $clusterID

# Copy Kubernetes terraform file to here so you can continue
cp k8s-setup/k8s.tf .

# Moving tf init to here 
terraform init


# Apply the copied .tf file
terraform apply -auto-approve
