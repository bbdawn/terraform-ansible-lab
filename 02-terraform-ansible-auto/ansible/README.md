[//]: # (README > ansible)

$ ansible -i inventory.ini pool_members -m ping

(1) terraform apply
(2) OpenStack VM 생성
(3) Terraform이 IP 확인
(4) inventory.ini 자동 생성
(5) Ansible Playbook(install-nginx.yml) 실행
(6) nginx 설치 완료
(7) files/vm1.html, files/vm2.html을 각각 pool-member-1, pool-member-2의
    /var/www/html/index.html로 배포

## files/

pool member별로 배포할 index.html을 모아둔 디렉토리.

| 파일 | 대상 호스트 | 내용 |
|------|------------|------|
| `vm1.html` | pool-member-1 | 🚀 VM1 Blue Server |
| `vm2.html` | pool-member-2 | 🔥 VM2 Red Server |

`install-nginx.yml`의 `vars.poolmember_pages`에서 인벤토리 호스트명과 파일명을 매핑하고,
`copy` 태스크가 `inventory_hostname` 기준으로 알맞은 파일을 골라 배포한다.





















