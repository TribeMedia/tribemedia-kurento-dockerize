# TribeMedia Kurento Docker image

This builds Kurento Media Server from source code tagged 6.0.0.  The intent is to follow up with
a Node.js controller app that can configure and restart Kurento based on parameters passed in that
would change kurento.conf.json.

## Problem
The current problem is that this image must be built in Docker with the "--privileged" flag due to the
use of "Fuse" in the development artifacts.
