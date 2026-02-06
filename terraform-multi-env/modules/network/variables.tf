variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
}

variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "vcn_cidr" {
  description = "VCN CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
}