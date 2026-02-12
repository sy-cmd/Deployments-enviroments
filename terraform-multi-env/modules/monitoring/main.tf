resource "oci_ons_notification_topic" "alerts" {
  compartment_id = var.compartment_id
  name           = "${var.environment}-alerts"
}

resource "oci_ons_subscription" "email" {
  compartment_id = var.compartment_id
  topic_id       = oci_ons_notification_topic.alerts.id
  protocol       = "EMAIL"
  endpoint       = var.alert_email
}

resource "oci_monitoring_alarm" "cpu_high" {
  count                = length(var.instance_ids)
  compartment_id       = var.compartment_id
  destinations         = [oci_ons_notification_topic.alerts.id]
  display_name         = "${var.environment}-cpu-high-${count.index}"
  is_enabled           = true
  metric_compartment_id = var.compartment_id
  namespace            = "oci_computeagent"
  query                = "CpuUtilization[1m]{resourceId = \"${var.instance_ids[count.index]}\"}.mean() > 80"
  severity             = "CRITICAL"
  body                 = "CPU above 80%"
  repeat_notification_duration = "PT2H"
}

resource "oci_monitoring_alarm" "memory_high" {
  count                = length(var.instance_ids)
  compartment_id       = var.compartment_id
  destinations         = [oci_ons_notification_topic.alerts.id]
  display_name         = "${var.environment}-memory-high-${count.index}"
  is_enabled           = true
  metric_compartment_id = var.compartment_id
  namespace            = "oci_computeagent"
  query                = "MemoryUtilization[1m]{resourceId = \"${var.instance_ids[count.index]}\"}.mean() > 85"
  severity             = "WARNING"
  body                 = "Memory above 85%"
  repeat_notification_duration = "PT2H"
}

resource "oci_monitoring_alarm" "instance_down" {
  count                = length(var.instance_ids)
  compartment_id       = var.compartment_id
  destinations         = [oci_ons_notification_topic.alerts.id]
  display_name         = "${var.environment}-instance-down-${count.index}"
  is_enabled           = true
  metric_compartment_id = var.compartment_id
  namespace            = "oci_compute_infrastructure_health"
  query                = "instance_status[1m]{resourceId = \"${var.instance_ids[count.index]}\"}.mean() < 1"
  severity             = "CRITICAL"
  body                 = "Instance is down!"
  repeat_notification_duration = "PT30M"
}
