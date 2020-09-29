# BUFS_ShuttleBus(학교가자)


실행방법
1. 도커(https://www.docker.com/get-started) 설치 및 실행
2. 소스 파일들 다운로드(혹은 클론)
3. 쉘(cmd)에서 Dockerfile이 있는 경로로 이동 후 아래 명령어 차례대로 입력
4. docker build -t bufs .
5. docker run -it -p 8080:8080 bufs
6. http://localhost:8080 으로 접속
