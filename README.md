# BUFS_ShuttleBus(학교가자)

**구현 사이트**
- [http://bufsbus.kr/](http://bufsbus.kr/)   
   
**실행방법**
1. 소스 파일 다운로드(또는 클론)
2. 도커(https://www.docker.com/get-started) 설치 및 실행
3. 쉘(cmd)에서 Dockerfile이 있는 경로로 이동 후 아래 명령어 차례대로 입력
4. docker build -t bufs .
5. docker run -it -p 80:80 -p 3306:3306 bufs
6. http://localhost 으로 접속
