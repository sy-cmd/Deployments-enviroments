# Deployments-enviroments
Oracle Cloud Infrastructure with Terraform 
This guide will help you create and manage multiple isolated environments (dev, staging, production) on OCI using Terraform.

## Features 
+ Complete isolation - Each environment has separate VCNs, subnets, and state files
+ Automated PR environments - Create/destroy review environments with one command
+ Production security - Private subnets + bastion host for production
+ Cost tracking - Resource tagging by environment
+ Scalable - Modular design for easy expansion


## Prerequisites
Required Tools
+ OCI CLI installed and configured
+ Terraform >= 1.0
+ Git
+ SSH key pair generated

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
│   │   └── variables.tf
│   ├── staging/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── production/
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
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
### Workspace Management
Deploy Each Environment
+ Deploy Development:
```
cd ~/terraform-multi-env/environments/dev
oci session authenticate --region af-johannesburg-1 --profile sydney
terraform init
terraform plan
terraform apply

```
+ Deploy Staging
```
cd ~/terraform-multi-env/environments/staging
terraform init
terraform plan
terraform apply
```
+ Deploy Production:
```
cd ~/terraform-multi-env/environments/production
terraform init
terraform plan
terraform apply
```

### Create PR Environment with scripts 
where `42` is the attribute given by the user when running the scripts 
```
cd ~/terraform-multi-env
./scripts/create-pr-env.sh 42


# Review the plan the environment created 
cd environments/pr-42
terraform apply tfplan
```

#### Destroy PR Environment
```
cd ~/terraform-multi-env
./scripts/destroy-pr-env.sh 42
```