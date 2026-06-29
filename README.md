# openstack-gpu-provisioner
Terraform으로 OpenStack VM을 프로비저닝하고 Ansible로 GPU 환경을 자동 구성하는 IaC 프로젝트입니다.

## 배경
OpenStack GPU 인스턴스 운영 시 nvidia-driver, dcgm-exporter, qemu-guest-agent 설치를
매번 수동으로 진행하던 과정을 Ansible Role 기반으로 자동화했습니다.
Idempotency를 보장하여 몇 번을 실행해도 동일한 결과를 보장합니다.

## 구성
```
openstack-gpu-provisioner/
├── terraform/                        # OpenStack VM 프로비저닝
│   └── main.tf
├── inventory/
│   └── hosts.ini                     # control / target 노드 등록
├── group_vars/
│   └── all.yml                       # driver_version, dcgm_version 등 변수
├── roles/
│   ├── nvidia/
│   │   └── tasks/main.yml            # nvidia-driver 설치
│   ├── dcgm/
│   │   └── tasks/main.yml            # dcgm-exporter 설치 + systemd 등록
│   └── qemu/
│       └── tasks/main.yml            # qemu-guest-agent 설치
└── site.yml                          # 전체 실행 플레이북
```


## 주요 구현
- Role 구조 분리 : nvidia / dcgm / qemu 역할별로 독립 관리
- 변수화 : driver 버전, exporter 포트 등을 group_vars/all.yml로 분리
- Handler 활용 : driver 설치 완료 후 자동 재시작 처리
- Idempotency 보장 : 중복 실행 시 동일한 결과 유지

## 환경
- OpenStack VM (Ubuntu 22.04)
- Ansible
- Terraform (OpenStack Provider)
- GPU: NVIDIA (A100 / H100 / B300)

사용법

1. Terraform으로 VM 프로비저닝
$ cd terraform
$ terraform init
$ terraform apply


2. Ansible로 GPU 환경 구성
$ ansible-playbook -i inventory/hosts.ini site.yml

버전 변수는 group_vars/all.yml에서 수정하세요.



