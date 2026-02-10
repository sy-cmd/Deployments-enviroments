provider "oci" {
  auth                = "SecurityToken"
  config_file_profile = "sydney"
  region              = var.region
}

module "network" {
  source = "../../modules/network"

  #  line to pass the authenticated provider
  providers = {
    oci = oci
  }
  environment          = "dev"
  compartment_id       = var.compartment_id
  vcn_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
}

module "compute" {
  source = "../../modules/compute"

  # line to pass the authenticated provider
  providers = {
    oci = oci
  }

  environment         = "dev"
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  subnet_id           = module.network.public_subnet_id
  instance_shape      = var.instance_shape
  instance_count      = 1
  image_id            = var.image_id
  ssh_public_key      = var.ssh_public_key
  assign_public_ip    = true
  #VM.Standard.A1.Flex
  shape_ocpus         = var.shape_ocpus
  shape_memory        = var.shape_memory
}

output "dev_public_ips" {
  description = "Dev environment public IPs"
  value       = module.compute.public_ips
}

output "dev_private_ips" {
  description = "Dev environment private IPs"
  value       = module.compute.private_ips
}
