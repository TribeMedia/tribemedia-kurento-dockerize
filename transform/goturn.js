var Mustache = require('mustache');
var fs = require('fs');

fs.readFile(__dirname + '/turnserver.tmpl', function(err, data) {
  var output = Mustache.render(data.toString(), {EXTERNAL_IP:process.env.EXTERNAL_IP});
  fs.writeFile('/etc/turnserver.conf', output, function(err) {
  });
});