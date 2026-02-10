#!/bin/bash

# Usage: ./create-pr-env.sh <pr-number>

if [ -z "$1" ]; then
  echo "Usage: $0 <pr-number>"
  exit 1
fi

PR_NUMBER=$1
ENV_NAME="pr-${PR_NUMBER}"
BASE_DIR="$(dirname "$0")/.."
PR_ENV_DIR="${BASE_DIR}/environments/${ENV_NAME}"

echo "Creating PR environment: ${ENV_NAME}"

# Create environment directory
mkdir -p "${PR_ENV_DIR}"

# Copy dev template
cp "${BASE_DIR}/environments/dev/main.tf" "${PR_ENV_DIR}/"
cp "${BASE_DIR}/environments/dev/variables.tf" "${PR_ENV_DIR}/"
cp "${BASE_DIR}/environments/dev/terraform.tfvars" "${PR_ENV_DIR}/"

# Update environment name
sed -i "s/environment = \"dev\"/environment = \"${ENV_NAME}\"/" "${PR_ENV_DIR}/main.tf"

# Update VCN CIDR to avoid conflicts (use PR number for uniqueness)
CIDR_BLOCK="10.$((100 + PR_NUMBER % 155)).0.0/16"
PUBLIC_CIDR="10.$((100 + PR_NUMBER % 155)).1.0/24"
PRIVATE_CIDR="10.$((100 + PR_NUMBER % 155)).2.0/24"

sed -i "s|vcn_cidr.*=.*\"10.0.0.0/16\"|vcn_cidr = \"${CIDR_BLOCK}\"|" "${PR_ENV_DIR}/main.tf"
sed -i "s|public_subnet_cidr.*=.*\"10.0.1.0/24\"|public_subnet_cidr = \"${PUBLIC_CIDR}\"|" "${PR_ENV_DIR}/main.tf"
sed -i "s|private_subnet_cidr.*=.*\"10.0.2.0/24\"|private_subnet_cidr = \"${PRIVATE_CIDR}\"|" "${PR_ENV_DIR}/main.tf"

# Initialize and apply
cd "${PR_ENV_DIR}"
echo "Initializing Terraform..."
terraform init

echo "Planning deployment..."
terraform plan -out=tfplan

echo ""
echo "Ready to deploy PR environment: ${ENV_NAME}"
echo "Run 'terraform apply tfplan' in ${PR_ENV_DIR} to create the environment"
echo ""
echo "To destroy later, run:"
echo "  cd ${PR_ENV_DIR} && terraform destroy"
