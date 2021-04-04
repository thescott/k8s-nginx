#!/usr/bin/env bash

set -x 
set -e
clusterID="$(terraform output subnetwork_name)"
# Set your compute zone to match what your terraform is creating
gcloud config set compute/zone us-central1-a

# Authenticate to your newly created cluster 
gcloud container clusters get-credentials $clusterID

# Apply the following because this CI example is set up for the deployment only
# This yaml creates a service
kubectl apply -f hello-world-nginx-svc.yaml

# This yaml creates your ingress 
kubectl apply -f hello-world-nginx-ingree.yaml

# Create a loadbalancer 
kubectl apply -f lb-hello-world-nginx-svc.yaml

