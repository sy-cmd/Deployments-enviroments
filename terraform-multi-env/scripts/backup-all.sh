#!/bin/bash
set -e

ENVIRONMENT=${1:-dev}
BACKUP_DIR="${HOME}/oci-backups/${ENVIRONMENT}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "=== BACKUP STARTED ==="
echo "Environment: ${ENVIRONMENT}"
echo "Timestamp: ${TIMESTAMP}"

mkdir -p "${BACKUP_DIR}/${TIMESTAMP}"

# 1. Terraform state
cd /home/sydney/Workstation/Terraform/Projects/Deployments-enviroments/terraform-multi-env/environments/dev
terraform output -json > "${BACKUP_DIR}/${TIMESTAMP}/outputs.json"

# 2. Instance boot volumes
INSTANCE_IDS=$(terraform output -json | jq -r '.instance_ids.value[]? // empty')
for ID in $INSTANCE_IDS; do
  BOOT_VOL=$(oci compute boot-volume-attachment list \
    --instance-id "$ID" \
    --auth security_token \
    --query 'data[0]."boot-volume-id"' \
    --raw-output)
  
  oci bv boot-volume-backup create \
    --boot-volume-id "$BOOT_VOL" \
    --display-name "${ENVIRONMENT}-backup-${TIMESTAMP}" \
    --auth security_token
done

# 3. Database backup (if exists)
DB_ID=$(terraform output -json | jq -r '.database_id.value? // empty')
if [ -n "$DB_ID" ]; then
  oci db autonomous-database create-backup \
    --autonomous-database-id "$DB_ID" \
    --display-name "${ENVIRONMENT}-db-backup-${TIMESTAMP}" \
    --auth security_token
fi

echo "✓ Backup complete: ${BACKUP_DIR}/${TIMESTAMP}"
