#!/bin/bash

set -e

export EXTERNAL_IP=$(curl -s http://whatismyip.akamai.com/)
export LOCAL_IP=$(/sbin/ifconfig eth0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}')

echo $EXTERNAL_IP
echo $LOCAL_IP

cd /transform
npm install
EXTERNAL_IP=$EXTERNAL_IP LOCAL_IP=$LOCAL_IP node goturn.js
EXTERNAL_IP=$EXTERNAL_IP node go.js

# mkdir -p "$KURENTO_DATA"
# cd /docker-entrypoint-init-kurento.d
# npm install

# echo
# for f in /docker-entrypoint-init-kurento.d/*; do
# 	case "$f" in
# 		*.sh)  echo "$0: running $f"; . "$f" ;;
# 		*.js) echo "$0: running $f"; node "$f" && echo ;;
# 		*)     echo "$0: ignoring $f" ;;
# 	esac
# 	echo
# done

exec "$@"