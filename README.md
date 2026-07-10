# terraform-ansible-lab
Terraform으로 OpenStack VM을 프로비저닝하고 Ansible로 서버 환경을 자동 구성하는 IaC 실습 저장소입니다.

단계별로 폴더를 나눠서 진행합니다.

## 구성

```
terraform-ansible-lab/
├── 01-terraform-ansible-basic/    # 기본 실습: VM 생성 + DNS 설정 + nginx 설치
│   ├── terraform/                 # OpenStack VM 프로비저닝
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars       # (gitignore, 실제 값은 로컬에서 관리)
│   └── ansible/                   # nginx 설치 및 설정
│       ├── inventory.ini
│       ├── site.yml
│       ├── install-nginx.yml
│       └── roles/
│           ├── tasks/main.yml
│           ├── templates/nginx.conf.j2
│           └── handlers/main.yml
│
└── 02-terraform-ansible-auto/     # 고도화 실습 (진행 중)
    ├── terraform/
    └── ansible/
```

## 01-terraform-ansible-basic
Terraform으로 VM을 생성하고 Ansible로 DNS 설정 및 nginx 설치까지 진행하는 기본 실습입니다.

사용법
```bash
# 1. Terraform으로 VM 프로비저닝
cd 01-terraform-ansible-basic/terraform
terraform init
terraform apply

# 2. Ansible로 서버 구성
cd ../ansible
ansible-playbook -i inventory.ini site.yml
```

## 02-terraform-ansible-auto
01을 기반으로 자동화 수준을 높이는 고도화 실습입니다. (작업 중)

## 환경
- OpenStack VM (Ubuntu 22.04)
- Terraform (OpenStack Provider)
- Ansible
