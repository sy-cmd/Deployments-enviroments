resource "oci_core_instance" "main" {
  count               = var.instance_count
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = "${var.environment}-instance-${count.index + 1}"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "${var.environment}-vnic-${count.index + 1}"
    assign_public_ip = var.assign_public_ip
    hostname_label   = "${var.environment}instance${count.index + 1}"
  }

  source_details {
    source_type             = "image"
    source_id               = var.image_id
    boot_volume_size_in_gbs = 50
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
      environment = var.environment
    }))
  }

  preserve_boot_volume = false

  timeouts {
    create = "60m"
  }
}
