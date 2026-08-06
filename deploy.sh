#!/bin/bash

set -e

echo "===== terraform init provider 초기화 ====="
terraform init

echo "===== terraform fmt 코드 정렬 ====="
terraform fmt

echo "===== terraform validate 문법 검증 ====="
terraform validate

echo "===== terraform plan 변경사항 미리 보기 ====="
terraform plan

echo "===== terraform apply 확인없이 바로 적용 ====="
terraform apply -auto-approve