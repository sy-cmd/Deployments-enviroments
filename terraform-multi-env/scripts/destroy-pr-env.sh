#!/bin/bash

# Usage: ./destroy-pr-env.sh <pr-number>

if [ -z "$1" ]; then
  echo "Usage: $0 <pr-number>"
  exit 1
fi

PR_NUMBER=$1
ENV_NAME="pr-${PR_NUMBER}"
BASE_DIR="$(dirname "$0")/.."
PR_ENV_DIR="${BASE_DIR}/environments/${ENV_NAME}"

if [ ! -d "${PR_ENV_DIR}" ]; then
  echo "PR environment ${ENV_NAME} does not exist"
  exit 1
fi

echo "Destroying PR environment: ${ENV_NAME}"
cd "${PR_ENV_DIR}"

# Refresh auth token
oci session authenticate --region af-johannesburg-1 --profile sydney

# Destroy
terraform destroy -auto-approve

# Clean up directory
cd "${BASE_DIR}"
rm -rf "${PR_ENV_DIR}"

echo "PR environment ${ENV_NAME} destroyed"
