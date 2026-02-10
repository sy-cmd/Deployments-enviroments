#!/bin/bash
echo "=== ENVIRONMENT STATUS ==="
for env in dev staging production; do
  echo ""
  echo "--- $env ---"
  cd ~/terraform-multi-env/environments/$env
  terraform output 2>/dev/null || echo "Not deployed"
done
