# Deployments-enviroments
Oracle Cloud Infrastructure with Terraform 
This guide will help you create and manage multiple isolated environments (dev, staging, production) on OCI using Terraform.

## Prerequisites
Required Tools

 OCI CLI installed and configured
 Terraform >= 1.0
 Git
 SSH key pair generated

OCI Setup
```
# Verify OCI authentication 
oci session authenticate --region af-johannesburg-1 --profile DEFAULT

# Verify Terraform is installed
terraform --version
```

## Structure 
```
terraform-multi-env/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── production/
│       ├── main.tf
│       ├── terraform.tfvars
│       └── backend.tf
├── modules/
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── security/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── scripts/
│   ├── create-pr-env.sh
│   ├── destroy-pr-env.sh
│   └── validate-env.sh
└── README.md
```