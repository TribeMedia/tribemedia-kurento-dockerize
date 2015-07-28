var Mustache = require('mustache');
var fs = require('fs');

fs.readFile(__dirname + '/WebRtcEndpoint.tmpl', function(err, data) {
  var output = Mustache.render(data.toString(), {EXTERNAL_IP:process.env.EXTERNAL_IP});
  fs.writeFile('/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini', output, function(err) {
  });
});