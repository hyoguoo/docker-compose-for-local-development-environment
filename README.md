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
services                # 서비스별 Dockerfile 디렉토리
  ├── svc_memcached
  │   ├── Dockerfile
  │   └── ...
  └── ...
compose.sh              # docker-compose 실행 스크립트
```

### 지원하는 서비스

|    서비스    |  컨테이너 이름  |  포트   |
|:---------:|:---------:|:-----:|
|   MySQL   |   mysql   | 3306  |
|   Redis   |   redis   | 6379  |
| Memcached | memcached | 11211 |

#### MySQL Init Script

`init/mysql` 디렉토리에 `01-schema.sql`, `02-ddl.sql`, `03-dml.sql` 파일을 작성하면 로컬 개발 환경 세팅 시 자동으로 실행됩니다.

- `01-schema.sql`: 스키마 생성을 위한 쿼리 작성
- `02-ddl.sql`: 테이블 생성을 위한 DDL 쿼리 작성
- `03-dml.sql`: seed 데이터 생성을 위한 DML 쿼리 작성

** 테이블 변경이나 데이터 변경 시 `sh compose.sh down` 후 `sh compose.sh up`을 실행해야 변경사항이 반영됩니다.(=`sh compose.sh rerun`)

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
 ✔ Network compose_dev_net     Created 
 ✔ Volume "redis_data"         Created 
 ✔ Volume "redis_conf"         Created 
 ✔ Volume "mysql_data_master"  Created 
 ✔ Volume "mysql_data_slave"   Created 
 ✔ Container mysql_master      Healthy 
 ✔ Container redis             Started 
 ✔ Container mysql_slave       Healthy 
 ✔ Container memcached         Started 
NAME                IMAGE               COMMAND                  SERVICE             CREATED             STATUS                    PORTS
memcached           memcached:1.6.18    "docker-entrypoint.s…"   memcached           22 seconds ago      Up Less than a second     0.0.0.0:11211->11211/tcp
mysql_master        mysql:8.0.33        "docker-entrypoint.s…"   mysql-master        22 seconds ago      Up 21 seconds (healthy)   0.0.0.0:3306->3306/tcp, 33060/tcp
mysql_slave         mysql:8.0.33        "docker-entrypoint.s…"   mysql-slave         22 seconds ago      Up 10 seconds (healthy)   33060/tcp, 0.0.0.0:3307->3306/tcp
redis               redis:7.0.11        "docker-entrypoint.s…"   redis               22 seconds ago      Up 21 seconds             0.0.0.0:6379->6379/tcp
```

### 컨테이너 접속

```shell
docker exec -it [컨테이너 이름] bash
```
