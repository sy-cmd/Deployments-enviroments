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
variable "bucket_name" { type = string }
