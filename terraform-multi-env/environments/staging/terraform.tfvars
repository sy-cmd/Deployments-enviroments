# variables.tfvars.example
# Placeholder values - Replace with your actual values before use

region              = "your-region-here"
compartment_id      = "ocid1.tenancy.oc1..aaaaaaaa..."
availability_domain = "YpPz:YOUR-REGION-1-AD-1"
instance_shape      = "VM.Standard.E3.Flex"
image_id            = "ocid1.image.oc1.your-region-1.aaaaaaa..."
ssh_public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB84PDs61yUckVtxzXdnf0sWW/QAL3VH+NI/F/amba0q user@email.com"
shape_ocpus         = 1
shape_memory        = 6
vcn_cidr_block      = "10.0.0.0/16"
subnet_cidr_block   = "10.0.1.0/24"
instance_name       = "your-instance-name"
instance_count      = 1