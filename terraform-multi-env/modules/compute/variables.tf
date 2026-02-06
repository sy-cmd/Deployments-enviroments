variable "environment" {
  description = "Environment name"
  type        = string
}

variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for instance"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "image_id" {
  description = "OS image OCID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "assign_public_ip" {
  description = "Assign public IP"
  type        = bool
  default     = true
}variable "environment" {
  description = "Environment name"
  type        = string
}

variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for instance"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "image_id" {
  description = "OS image OCID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "assign_public_ip" {
  description = "Assign public IP"
  type        = bool
  default     = true
}
