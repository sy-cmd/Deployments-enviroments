output "load_balancer_ip" {
  value = oci_load_balancer_load_balancer.main.ip_address_details
}
