terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

variable "environment" { type = string }
variable "compartment_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "backend_ips" { type = list(string) }
