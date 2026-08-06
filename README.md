#  Terraform Files
## variables.tf
- 사용할 변수를 선언한다.
--> image_id, flavor_id, network_name, key_pair 등을 선언
## main.tf
- 리소스를 정의한다. 
- variables.tf에서 선언한 변수를 사용하여 인프라를 구성한다.
- --> GPU VM, Qdrant VM 생성
## terraform.tfvars
- 변수의 실제 값을 정의한다.
- --> 실제 image_id, flavor_id, network_name 값 입력
## outputs.tf
- 생성된 리소스의 정보를 출력한다. 
- 다른 Terraform 설정이나 스크립트(Ansible 등)에서 사용할 값을 정의한다. 
- --> gpu_ip, qdrant_ip 출력

variables.tf
│
▼
terraform.tfvars
│
▼
main.tf
│
terraform apply
│
▼
OpenStack에 리소스 생성
│
▼
outputs.tf
│
▼
terraform output



# Terraform 명령어


$ terraform init
$ terraform fmt
$ terraform validate
$ terraform validate
$ terraform plan
$ terraform apply


## init 
- 초기화
- terraform init

## format
- terraform 코드의 들여쓰기와 정렬 맞춰줌
- terraform fmt 

## validate
- Terraform 설정 파일이 올바른지 검사. 실제 OpenStack 리소스 존재 여부는 검사하지 않는다. 
- terraform validate

## plan
- 현재 상태(State)와 설정파일을 비교하여 어떤 변경이 발생할지 미리 확인한다. 실제 리소스는 생성되지 않는다. 
- terraform plan

## apply
- 변경 사항 적용. 실행 계획에 따라 OpenStack에 실제 리소스를 생성/수정/삭제한다. 
- terraform apply

## output
- Terraform이 관리하는 리소스 출력값(Output)을 조회
- IP 확인 : vm 생성한 뒤에 GPU VM의 IP 확인 

### pool member 1 IP 확인
terraform output gpu_ip

### pool member 2 IP 확인
terraform output qdrant_ip

## terraform output은 어디서 가져오는 걸까?
## OpenStack에 다시 API를 호출하는 것이 아니라, Terrform State(terraform.tfstate)에 저장된 값을 읽어서 보여준다. 

terraform apply
│
▼
OpenStack에 VM 생성
│
▼
terraform.tfstate에 생성 정보 저장
│
▼
terraform output