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
