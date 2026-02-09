terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

provider "oci" {
  auth                = "SecurityToken"
  config_file_profile = "sydney"
  region              = var.region
}

module "network" {
  source = "../../modules/network"

  environment          = "production"
  compartment_id       = var.compartment_id
  vcn_cidr             = "10.2.0.0/16"
  public_subnet_cidr   = "10.2.1.0/24"
  private_subnet_cidr  = "10.2.2.0/24"
}

module "compute" {
  source = "../../modules/compute"

  environment         = "production"
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = module.network.private_subnet_id  # Production in private subnet
  instance_shape      = var.instance_shape
  instance_count      = 2  # Production has 2 instances
  image_id            = var.image_id
  ssh_public_key      = var.ssh_public_key
  assign_public_ip    = false  # No public IP for production
}

# Bastion host for production access
module "bastion" {
  source = "../../modules/compute"

  environment         = "production-"
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = module.network.public_subnet_id
  instance_shape      = var.instance_shape
  instance_count      = 1
  image_id            = var.image_id
  ssh_public_key      = var.ssh_public_key
  assign_public_ip    = true
  shape_ocpus         = var.shape_ocpus
  shape_memory        = var.shape_memory
}

output "production_private_ips" {
  description = "Production environment private IPs"
  value       = module.compute.private_ips
}

output "bastion_public_ip" {
  description = "Bastion host public IP"
  value       = module.bastion.public_ips
}
