#!/bin/bash

set -e

EXTERNAL_IP=$(curl -s http://whatismyip.akamai.com/)
LOCAL_IP=$(/sbin/ifconfig eth0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}')

cd /transform
npm install
node goturn.js
node go.js

mkdir -p "$KURENTO_DATA"

echo
for f in /docker-entrypoint-init-kurento.d/*; do
	case "$f" in
		*.sh)  echo "$0: running $f"; . "$f" ;;
		*.js) echo "$0: running $f"; npm install; node < "$f" && echo ;;
		*)     echo "$0: ignoring $f" ;;
	esac
	echo
done