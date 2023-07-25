#!/bin/bash

compose_files="-f compose/networks.yml -f compose/volumes.yml -f compose/services.yml"

# docker-compose up 실행
if [ "$1" = "up" ]; then
  docker-compose $compose_files up -d
  docker-compose $compose_files ps
# docker-compose down 실행
elif [ "$1" = "down" ]; then
  docker-compose $compose_files down --volumes
  docker-compose $compose_files ps
# docker-compose down 실행 후 docker-compose up 실행
elif [ "$1" = "rerun" ]; then
  docker-compose $compose_files down --volumes
  docker-compose $compose_files up -d
  docker-compose $compose_files ps
else
  # 알 수 없는 인자일 경우 메시지 출력
  echo "\033[31m유효하지 않은 인자입니다. 'up', 'down', 'rerun' 중 하나를 입력해주세요.\033[0m"
  echo "up: 컨테이너를 백그라운드로 실행합니다."
  echo "down: 실행 중인 컨테이너를 중지하고 볼륨을 삭제합니다."
  echo "rerun: 실행 중인 컨테이너를 중지하고 볼륨을 삭제한 뒤 다시 실행합니다."
fi