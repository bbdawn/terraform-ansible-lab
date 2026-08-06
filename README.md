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
    ├── terraform/                 # OpenStack VM 프로비저닝 + Ansible 자동 실행
    │   ├── main.tf                # VM 생성 + inventory.ini 자동 생성 + ansible-playbook 자동 실행
    │   ├── variables.tf
    │   ├── outputs.tf
    │   ├── deploy.sh               # terraform init/fmt/validate/plan/apply 자동 실행 스크립트
    │   └── terraform.tfvars       # (gitignore, 실제 값은 로컬에서 관리)
    ├── ansible/                   # DNS 설정 및 nginx 설치 + pool member별 페이지 배포
    │   ├── ansible.cfg
    │   ├── inventory.ini           # terraform이 자동 생성 (수동 편집 불필요)
    │   ├── install-nginx.yml
    │   ├── site.yml
    │   └── files/                  # pool member별로 배포할 index.html
    │       ├── vm1.html            # pool-member-1 전용 (Blue Server)
    │       └── vm2.html            # pool-member-2 전용 (Red Server)
    └── shell-script/               # deploy.sh 작성 실습
        └── deploy.sh
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

`terraform apply` 한 번으로 VM 생성 → Ansible inventory 자동 생성 → nginx 설치까지 이어지도록 구성합니다.

- `terraform/main.tf`
  - `pool-member-1`, `pool-member-2` VM 생성
  - `local_file` 리소스로 VM IP를 읽어서 `ansible/inventory.ini` 자동 생성
  - `null_resource` + `local-exec` provisioner로 `ansible-playbook install-nginx.yml` 자동 실행
- `ansible/install-nginx.yml`
  - nginx 설치 및 기동 이후, `vars.poolmember_pages`로 인벤토리 호스트명과 파일을 매핑해
    `pool-member-1` → `files/vm1.html`, `pool-member-2` → `files/vm2.html`을
    각 서버의 `/var/www/html/index.html`로 배포
  - 접속 시 `pool-member-1`은 파란색(Blue) 화면, `pool-member-2`는 빨간색(Red) 화면을 보여줘
    로드밸런서 pool member 동작을 눈으로 구분해서 확인할 수 있음

사용법
```bash
# 1. Terraform으로 VM 생성 + Ansible 자동 실행
cd 02-terraform-ansible-auto/terraform
terraform init
terraform apply

# (Ansible만 따로 다시 실행하고 싶을 때)
cd ../ansible
ansible-playbook -i inventory.ini install-nginx.yml

# 3. 결과 확인 (IP 조회 후 각 pool member 페이지 확인)
cd ../terraform
terraform output pool_member_ips
curl http://<pool-member-1_IP>/   # 🚀 VM1 Blue Server
curl http://<pool-member-2_IP>/   # 🔥 VM2 Red Server
```

### 트러블슈팅 기록
- **SSH 인증 실패 (`Permission denied`)**: Ubuntu 22.04 이미지는 `root` 직접 SSH 로그인이 막혀 있음.
  → `inventory.ini`의 `ansible_user`를 `root` → `ubuntu`로 변경하고, sudo 권한 상승을 위해 `ansible_become=true` 추가.
- **`private_key_file`이 적용 안 되던 문제**: `ansible.cfg`에서 `private_key_file` 옵션을 `[ssh_connection]` 섹션에 뒀더니 무시됨.
  → `[defaults]` 섹션으로 이동해야 정상 적용됨. 또한 `%(HOME)s` 보간이 동작하지 않아 `~/.ssh/<keypair>.pem` 형태로 변경.

## 환경
- OpenStack VM (Ubuntu 22.04)
- Terraform (OpenStack Provider)
- Ansible
