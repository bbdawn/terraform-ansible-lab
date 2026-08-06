#  Terraform Files

## variables.tf
- 사용할 변수를 선언한다.
  --> image_id, flavor_id, network_name, key_pair 등을 선언
## main.tf
- 리소스를 정의한다.
- variables.tf에서 선언한 변수를 사용하여 인프라를 구성한다.
- --> GPU VM생성
## terraform.tfvars
- 변수의 실제 값을 정의한다.
- --> 실제 image_id, flavor_id, network_name 값 입력
## outputs.tf
- 생성된 리소스의 정보를 출력한다.
- 다른 Terraform 설정이나 스크립트(Ansible 등)에서 사용할 값을 정의한다.
- --> gpu_ip, qdrant_ip 출력