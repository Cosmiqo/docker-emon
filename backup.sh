#!/bin/bash 

if [[ "$#" -ne 1 ]]; then
  echo "USAGE: ./backup.sh CONTAINER NAME"
  exit 1
fi

docker run --rm --volumes-from "$1" -v $(pwd):/backup busybox tar cvf /backup/backup.tar /var/lib/mysql/emoncms \
  /var/lib/phpfiwa /var/lib/phpfina /var/lib/phptimeseries /var/lib/timestore
