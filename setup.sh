#! /bin/bash

# this will create a terraform.tfvars file to be used with cloud shell
cat > terraform.tfvars <<EOF
region          = "us-central1"
zone            = "us-central1-a"
location        = "us-central1-a"
project_id      = "$GOOGLE_CLOUD_PROJECT"
name            = "ci-example"
EOF

terraform init
