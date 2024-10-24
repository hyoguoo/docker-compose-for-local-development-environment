# 로컬 개발 환경 세팅

`Docker Compose`를 이용해 로컬에서 개발을 위한 환경 세팅 자동화 스크립트를 제공합니다.

### 디렉토리 구성

```
compose                 # docker-compose.yml 파일과 환경 변수 파일 디렉토리
  ├── .env
  ├── network.yml
  ├── services.yml
  └── volumes.yml
init                    # 초기화 스크립트 디렉토리
  ├── mysql
  │   ├── 01-schema.sql
  │   ├── 02-ddl.sql
  │   └── 03-dml.sql
  └── ...
compose.sh              # docker-compose 실행 스크립트
```

### 지원하는 서비스

|    서비스    |  컨테이너 이름  |  포트   |
|:---------:|:---------:|:-----:|
|   MySQL   |   mysql   | 3306  |
|   Redis   |   redis   | 6379  |
| Memcached | memcached | 11211 |
| Zookeeper | zookeeper | 2181  |
|   Kafka   |   kafka   | 9092  |

#### MySQL Init Script

`init/mysql` 디렉토리에 `01-schema.sql`, `02-ddl.sql`, `03-dml.sql` 파일을 작성하면 로컬 개발 환경 세팅 시 자동으로 실행됩니다.

- `01-schema.sql`: 스키마 생성을 위한 쿼리 작성
- `02-ddl.sql`: 테이블 생성을 위한 DDL 쿼리 작성
- `03-dml.sql`: seed 데이터 생성을 위한 DML 쿼리 작성

** 테이블 변경이나 데이터 변경 시 `sh compose.sh down` 후 `sh compose.sh up`을 실행해야 변경사항이 반영됩니다.(=`sh compose.sh rerun`)

#### Kafka Init Topic

`compose` 디렉토리에 `.env` 파일의 `KAFKA_TOPICS` 환경 변수에 topic 이름을 추가하면 로컬 개발 환경 세팅 시 자동으로 topic을 생성합니다.

```shell
KAFKA_TOPICS=topic1,topic2,topic3
```

### 실행

- up: 컨테이너를 백그라운드로 실행합니다.

```shell
sh compose.sh up
```

- down: 실행 중인 컨테이너를 중지하고 볼륨을 삭제합니다.

```shell
sh compose.sh down
```

- rerun: 실행 중인 컨테이너를 중지하고 볼륨을 삭제한 뒤 다시 실행합니다.

```shell
sh compose.sh rerun
```

정상 실행 시 다음과 같은 메시지가 출력됩니다.

```
❯ sh compose.sh rerun
[+] Running 9/9
 ✔ Container zookeeper      Removed                                                                                                                                                                                                                                                                                                                                   0.5s 
 ✔ Container kafka          Removed                                                                                                                                                                                                                                                                                                                                   1.0s 
 ✔ Container mysql          Removed                                                                                                                                                                                                                                                                                                                                   1.3s 
 ✔ Container redis          Removed                                                                                                                                                                                                                                                                                                                                   0.1s 
 ✔ Container memcached      Removed                                                                                                                                                                                                                                                                                                                                   1.1s 
 ✔ Volume redis_conf        Removed                             __                                                                                                                                                                                                                                                                                                      0.0s 
 ✔ Volume redis_data        Removed                                                                                                                                                                                                                                                                                                                                   0.0s 
 ✔ Volume mysql_data        Removed                                                                                                                                                                                                                                                                                                                                   0.0s 
 ✔ Network compose_dev_net  Removed                                                                                                                                                                                                                                                                                                                                   0.1s 
[+] Running 9/9
 ✔ Network compose_dev_net  Created                                                                                                                                                                                                                                                                                                                                   0.0s 
 ✔ Volume "redis_data"      Created                                                                                                                                                                                                                                                                                                                                   0.0s 
 ✔ Volume "redis_conf"      Created                                                                                                                                                                                                                                                                                                                                   0.0s 
 ✔ Volume "mysql_data"      Created                                                                                                                                                                                                                                                                                                                                   0.0s 
 ✔ Container mysql          Started                                                                                                                                                                                                                                                                                                                                   0.2s 
 ✔ Container kafka          Started                                                                                                                                                                                                                                                                                                                                   0.2s 
 ✔ Container memcached      Started                                                                                                                                                                                                                                                                                                                                   0.2s 
 ✔ Container zookeeper      Started                                                                                                                                                                                                                                                                                                                                   0.2s 
 ✔ Container redis          Started                                                                                                                                                                                                                                                                                                                                   0.2s 
NAME        IMAGE                     COMMAND                  SERVICE     CREATED                  STATUS                                     PORTS
kafka       bitnami/kafka:3.3.2       "/opt/bitnami/script…"   kafka       Less than a second ago   Up Less than a second                      0.0.0.0:9092->9092/tcp
memcached   memcached:1.6.18          "docker-entrypoint.s…"   memcached   Less than a second ago   Up Less than a second                      0.0.0.0:11211->11211/tcp
mysql       mysql:8.0.33              "docker-entrypoint.s…"   mysql       Less than a second ago   Up Less than a second (health: starting)   0.0.0.0:3306->3306/tcp, 33060/tcp
redis       redis:7.0.11              "docker-entrypoint.s…"   redis       Less than a second ago   Up Less than a second                      0.0.0.0:6379->6379/tcp
zookeeper   bitnami/zookeeper:3.8.4   "/opt/bitnami/script…"   zookeeper   Less than a second ago   Up Less than a second                      2888/tcp, 3888/tcp, 0.0.0.0:2181->2181/tcp, 8080/tcp
```

### 컨테이너 접속

```shell
docker exec -it [컨테이너 이름] bash
```
