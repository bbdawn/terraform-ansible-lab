# Shell Script를 이용한 Terraform 자동 실행

## deploy.sh 생성

```bash
touch deploy.sh
```

또는

```bash
vi deploy.sh
```

## deploy.sh 작성

```bash
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
```

## 실행 권한 부여

```bash
chmod +x deploy.sh
```

## Shell Script 실행

```bash
./deploy.sh
```

## 실행 과정

Shell Script를 실행하면 아래 순서대로 Terraform 명령어가 자동으로 수행된다.

1. `terraform fmt`
    - Terraform 코드의 형식을 자동으로 정렬한다.

2. `terraform validate`
    - Terraform 구성 파일의 문법과 설정을 검증한다.

3. `terraform plan`
    - 실제 적용 전에 변경될 리소스를 미리 확인한다.

4. `terraform apply -auto-approve`
    - 확인 과정 없이 인프라를 자동으로 생성 및 변경한다.

## set -e 옵션

```bash
set -e
```

`set -e` 옵션은 명령어 실행 중 하나라도 오류가 발생하면 즉시 스크립트를 종료한다.

예를 들어 `terraform validate`에서 오류가 발생하면 `terraform plan`과 `terraform apply`는 실행되지 않아 잘못된 구성이 적용되는 것을 방지할 수 있다.