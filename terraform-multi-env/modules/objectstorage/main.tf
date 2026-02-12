data "oci_objectstorage_namespace" "main" {
  compartment_id = var.compartment_id
}

resource "oci_objectstorage_bucket" "main" {
  compartment_id = var.compartment_id
  namespace      = data.oci_objectstorage_namespace.main.namespace
  name           = "${var.environment}-${var.bucket_name}"
  access_type    = "NoPublicAccess"
  versioning     = "Enabled"
  storage_tier   = "Standard"
}

resource "oci_objectstorage_object_lifecycle_policy" "main" {
  namespace = data.oci_objectstorage_namespace.main.namespace
  bucket    = oci_objectstorage_bucket.main.name

  rules {
    action      = "ARCHIVE"
    is_enabled  = true
    name        = "archive-old-files"
    time_amount = 90
    time_unit   = "DAYS"
    target      = "objects"
  }

  rules {
    action      = "DELETE"
    is_enabled  = true
    name        = "delete-very-old-files"
    time_amount = 365
    time_unit   = "DAYS"
    target      = "objects"
  }
}
