시스템 프로그래밍 수업 과제
* linking이 왜 필요한지 생각해보면서 "라이브러리 생성 및 배포"를 해보자!
---
# 기능 구현 목록
## 1. coordinate 구조체가 담긴 배열 생성 
* firstCoor, secondCoor 배열의 각 원소에는 geoinfo 타입의 위도와 경도로 구성된 coordinate 구조체가 있음
## 2. input.txt 파일 읽기
* 파일 내용을 firstCoor, secondCoor에 저장
    * 위도 및 경도의 dms, direction 초기화 완료
## 3. dms 변수를 파싱하여 각 geoinfo의 degree, minute, second, totalSec 초기화
* firstCoor, secondCoor 배열 각 원소의 위도, 경도에 대해 각각 해줘야 함
## 4. distance second 구하기
* 매개변수 : firstCoor, secondCoor
* totalSec이 각 x1, y1과 x2, y2가 되며, 두 가지 거리 구하는 방식에 적용해 distance 구하기
### 1) Euclidean
### 2) Manhattan
---
### 사용법
1. git clone을 한다
2. man.c와 euc.c를 라이브러리로 생성
gcc -shared -o libman man.c
gcc -shared -o libeuc euc.c
3. 컴파일
gcc -o proc main.c fillGeoInfo.c libman.so libeuc.so
4. 실행
./proc input.txt man
