#!/bin/bash

set -e

echo "===== terraform fmt ====="
terraform fmt

echo "===== terraform validate ====="
terraform validate

echo "===== terraform plan ====="
terraform plan

echo "===== terraform apply ====="
terraform apply -auto-approve

echo "===== Complete! ====="
