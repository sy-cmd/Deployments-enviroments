output "instance_ids" {
  description = "Instance IDs"
  value       = oci_core_instance.main[*].id
}

output "public_ips" {
  description = "Public IPs"
  value       = oci_core_instance.main[*].public_ip
}

output "private_ips" {
  description = "Private IPs"
  value       = oci_core_instance.main[*].private_ip
}
