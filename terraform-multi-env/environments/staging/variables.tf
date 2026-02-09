variable "region" {
  description = "OCI region"
  type        = string
}

variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "image_id" {
  description = "OS image OCID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "shape_ocpus" {
  description = "Number of OCPUs for instance shape configuration"
  type        = number
  default     = 1
}
variable "shape_memory" {
  description = "Memory in GB for instance shape configuration"
  type        = number
  default     = 6
}