var app, express;

express = require('express');

app = express();

console.log('one plus one is five');

console.log('booya');

module.exports = {
  run: function(callback) {
    return app.listen(app.get('port'), function() {
      return callback(app.get('port'));
    });
  },
  stop: function(callback) {
    return app.close(callback);
  }
};
