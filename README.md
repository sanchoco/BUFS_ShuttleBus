# BUFS_ShuttleBus(학교가자)


실행방법
1. 소스 파일 다운로드(또는 클론)
2. 도커(https://www.docker.com/get-started) 설치 및 실행
3. 쉘(cmd)에서 Dockerfile이 있는 경로로 이동 후 아래 명령어 차례대로 입력
4. docker build -t bufs .
5. docker run -it -p 8080:8080 -p 3306:3306 bufs
6. http://localhost:8080 으로 접속
   
mysql 접속 및 확인
- mysql gui 툴(heidi sql)로 접속 가능
- 호스트: 127.0.0.1 포트: 3306
- 사용자: readOnly 비밀번호: 1234   
   
현재시간 이후 가장 가까운 버스 시간 조회   
```sql
select arrive   
from shuttle_bufs   
where id in   
(select id   
from shuttle_bufs   
where now() < arrive   
order by arrive asc)   
limit 1   
```
