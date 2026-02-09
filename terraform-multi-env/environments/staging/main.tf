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

  environment          = "staging"
  compartment_id       = var.compartment_id
  vcn_cidr             = "10.1.0.0/16"
  public_subnet_cidr   = "10.1.1.0/24"
  private_subnet_cidr  = "10.1.2.0/24"
}

module "compute" {
  source = "../../modules/compute"

  environment         = "staging"
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = module.network.public_subnet_id
  instance_shape      = var.instance_shape
  instance_count      = 1
  image_id            = var.image_id
  ssh_public_key      = var.ssh_public_key
  assign_public_ip    = true
}

output "staging_public_ips" {
  description = "Staging environment public IPs"
  value       = module.compute.public_ips
}

output "staging_private_ips" {
  description = "Staging environment private IPs"
  value       = module.compute.private_ips
}
