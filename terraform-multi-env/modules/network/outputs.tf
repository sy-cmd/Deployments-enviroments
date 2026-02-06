output "vcn_id" {
  description = "VCN ID"
  value       = oci_core_vcn.main.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = oci_core_subnet.private.id
}

output "vcn_cidr" {
  description = "VCN CIDR block"
  value       = oci_core_vcn.main.cidr_block
}
