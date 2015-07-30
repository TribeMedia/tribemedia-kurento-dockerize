#!/bin/bash

set -e

export EXTERNAL_IP=$(curl -4 icanhazip.com)

echo $EXTERNAL_IP

cd /transform
npm install
EXTERNAL_IP=$EXTERNAL_IP node goturn.js
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