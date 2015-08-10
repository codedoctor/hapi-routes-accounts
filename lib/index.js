
/*
@author Martin Wawrusch (martin@wawrusch.com)
 */

(function() {
  var Hoek, _, i18n, routesAccount, routesUsersMeAccount;

  _ = require('underscore');

  Hoek = require('hoek');

  i18n = require('./i18n');

  routesAccount = require('./routes-account');

  routesUsersMeAccount = require('./routes-users-me-account');


  /*
  Main entry point for the plugin
  
  @param [Server] server the HAPI plugin
  @param [Object] options the plugin options
  @option options [String|Array] defaultFeatures a string or array of strings indicating the default features for each newly created account.
  @option options [Number] maxOwnedAccountsPerUser The maximum number of accounts a user can create (defaults to 1)
  @param [Function] cb the callback invoked after completion
  
  Please note that the routesBaseName is only included to make the life easier while doing the config of your HAPI server.
   */

  module.exports.register = function(server, options, cb) {
    var defaults;
    if (options == null) {
      options = {};
    }
    defaults = {
      defaultFeatures: [],
      maxOwnedAccountsPerUser: 1
    };
    options = Hoek.applyToDefaults(defaults, options);
    if (_.isString(options.defaultFeatures)) {
      options.defaultFeatures = [options.defaultFeatures];
    }
    routesAccount(server, options);
    routesUsersMeAccount(server, options);
    server.expose('i18n', i18n);
    return cb();
  };


  /*
  @nodoc
   */

  module.exports.register.attributes = {
    pkg: require('../package.json')
  };

}).call(this);

//# sourceMappingURL=index.js.map
