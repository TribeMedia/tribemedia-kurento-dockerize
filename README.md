# TribeMedia Kurento Docker image

This builds Kurento Media Server from source code tagged 6.0.0.  The intent is to follow up with
a Node.js controller app that can configure and restart Kurento based on parameters passed in that
would change kurento.conf.json.

## Current behavior
Currently, this set of files, ensures the following:

* Correct configuration of the TURN server execution based on queried external and internal IP addresses.
* Correct configuration of WebRTC endpoint Kurento Configuration based on the external IP of the embedded CoTurn server.

### Node.js
A Node.js script in the "/transform" directory uses Mustache for Node.js to generate the appropriate WebRtcEndpoint.conf.ini file and copy it to the "/etc/kurento/modules/kurento" directory where the server process will pick it up upon execution.

### Update: 7/29
In this version, there is support for extending the behavior of this base image by copying files into the "/docker-entrypoint-init-kurento.d" directory.  If the file extension is ".sh", the shell script is run.  If the file is ".js", Node.js is run against it.  Be sure to copy a "package.json" file into the directory, so dependencies can be included.

Also, this version introduces a VOLUME--/var/lib/kurento/data--that would be used to store recorded Kurento sessions and provide a place for persistent data (like the local database files used by the Node.js app to come).