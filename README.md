# 부산외대 학교가자
   
### 사이트 주소: [http://bufsbus.kr/](http://bufsbus.kr/)

### 사이트 정보

- 부산외대에 들리는 셔틀 버스, 마을 버스, 시내 버스 정보를 확인할 수 있는 사이트


### Node.js 리팩토링 버전

- https://github.com/sanchoco/bufsbus-docker



### 소개 및 효과

- 학교와 관련된 버스 정보를 확인하려면 종이로 된 시간표를 카메라로 찍어두고 보거나 학교 사이트에 접속해서 봐야 하는 불편함이 있었음.
- 셔틀버스, 마을버스, 시내버스에 대한 정보를 통합하여 제공하고 몇 분 뒤 도착하는지 편리하게 볼 수 있도록 제작.
- 2020년 10월부터 서비스를 운영하고 있으며 하루 평균 700명 ~ 800명 이용
- '유용하다', '정말 잘 쓰고 있다' 와 같은 긍정적인 피드백이 많았으며 주기적으로 시간표 업데이트 중

### 기능
- 셔틀버스, 마을버스, 시내버스에 대한 정보 제공
- 학교 셔틀 버스 각 정류장 별 도착 시간 안내
- 금정3번 마을 버스 도착 시간 안내
- 301번 시내 버스 학교 도착 시간 안내


### 구현 환경 및 프로그램
- 서버 및 환경:  Docker, Ubuntu, OpenJDK
- 프론트엔드: HTML, CSS, JSP, Bootstrap
- 백엔드: Java, MariaDB, ,REST API, Apache Tomcat

### 구현 화면
![bufs1](https://user-images.githubusercontent.com/58046372/104699552-4583c680-5756-11eb-9eb6-fdce8dc4be1a.png)
![bufs2](https://user-images.githubusercontent.com/58046372/104699555-461c5d00-5756-11eb-9609-557d4316efe2.png)

### 홍보
<img width="816" alt="스크린샷 2021-06-24 오전 1 19 16" src="https://user-images.githubusercontent.com/58046372/123133003-47cb1900-d48a-11eb-94b9-8815aeb24099.png">

**프로젝트 소개 페이지**
- https://www.notion.so/7481f4094a8e41a6ae36a550ebdf2bfb

### 인프라
![image](https://user-images.githubusercontent.com/58046372/131765554-34af6e9a-a348-4483-8c35-b20be3c84855.png)


### 어려웠던 점
- DB와 처음 연동해보는 프로젝트라 Java와 MySQL을 사용하려고 JDBC를 사용하였는데 잘 되지 않아 며칠간 해멨지만 여러 시도 끝에 해결.
- 개발 환경과 라즈베리파이(arm)의 아키텍쳐가 달라 배포할 때 어려움이 있었습니다. 도커파일로 배포를 하여도 문제가 있었는데 자바와 같이 아키텍쳐별로 다른 프로그램을 설치해서 그랬었고 공통적으로 명령어를 통해 설치하도록 수정하여 해결
- 서비스를 운영하던 중 어느순간 도커 빌드가 되지 않았는데 외부에서 받는 프로그램 중 최신 버전으로 받게 했던게 문제. 이전 버전의 경로에 종속되어 경로를 포함하는 돌아가는 프로그램들이 있었고 같은 버전을 받도록 수정하여 해결.
- 시내버스 정보를 가져올 때 공공 API를 사용하고 있었는데 외부 API가 멈춰 계속 리퀘스트가 쌓이고 메모리 사용량이 올라가면서 서버가 멈추는 상황이 발생. timeout을 걸어 해결.
