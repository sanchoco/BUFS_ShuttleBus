# BUFS_ShuttleBus(학교가자) - 진행 중

**구현 사이트**
- [http://bufsbus.kr/](http://bufsbus.kr/)   
   
**실행방법**
1. 소스 파일 다운로드(또는 클론)
2. 도커(https://www.docker.com/get-started) 설치 및 실행
3. 쉘(cmd)에서 Dockerfile이 있는 경로로 이동 후 아래 명령어 차례대로 입력
4. docker build -t bufs .
5. docker run -it -p 80:80 -p 3306:3306 bufs
6. http://localhost 으로 접속
   
**mysql 접속 및 확인**
- MYSQL GUI 툴(heidiSQL, MYSQL Workbench 등)로 접속 가능
- 호스트: 127.0.0.1 포트: 3306
- 사용자: readOnly 비밀번호: 1234   
   
**현재시간 이후 가장 가까운 버스 시간 조회**
```sql
use goSchool;
select arrive, curtime() as now, DATE_FORMAT(TIMEDIFF(arrive, curtime()), '%k') as hour, DATE_FORMAT(TIMEDIFF(arrive, curtime()), '%i') as minute from shuttle_bufs where id in (select id from shuttle_bufs where curtime() <= arrive order by arrive asc) limit 1;
```

**프로젝트 페이지**   
[https://www.notion.so/7481f4094a8e41a6ae36a550ebdf2bfb](https://www.notion.so/7481f4094a8e41a6ae36a550ebdf2bfb)