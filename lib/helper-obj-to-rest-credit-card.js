(function() {
  var _;

  _ = require('underscore');

  module.exports = function(x) {
    x = JSON.parse(JSON.stringify(x));
    delete x.__v;
    return x;
  };

}).call(this);

//# sourceMappingURL=helper-obj-to-rest-credit-card.js.map
