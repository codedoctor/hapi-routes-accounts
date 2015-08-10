(function() {
  var Boom, Hoek, _, async, bson, helperObjToRest, i18n, validationSchemas;

  _ = require('underscore');

  Boom = require('boom');

  Hoek = require("hoek");

  bson = require('bson');

  async = require('async');

  helperObjToRest = require('./helper-obj-to-rest');

  i18n = require('./i18n');

  validationSchemas = require('./validation-schemas');


  /*
  fnCreateObjectId = ->
    (new ObjectID()).toString()
  
  fnToObjectId = (objIdAsString) ->
    try
      return (new ObjectID(objIdAsString)).toString()
    catch
      return null
   */

  module.exports = function(plugin, options) {
    var hapiStoreAccounts, hapiUserStoreMultiTenant, methodsRoles, methodsUsers;
    if (options == null) {
      options = {};
    }
    hapiUserStoreMultiTenant = function() {
      return plugin.plugins['hapi-user-store-multi-tenant'];
    };
    Hoek.assert(hapiUserStoreMultiTenant(), i18n.couldNotFindHapiUserStoreMultiTenantPlugin);
    hapiStoreAccounts = function() {
      return plugin.plugins['hapi-store-accounts'];
    };
    Hoek.assert(hapiStoreAccounts(), i18n.couldNotFindHapiStoreAccountsPlugin);
    methodsRoles = function() {
      return hapiUserStoreMultiTenant().methods.roles;
    };
    methodsUsers = function() {
      return hapiUserStoreMultiTenant().methods.users;
    };
    Hoek.assert(methodsRoles(), i18n.couldNotFindMethodsRoles);
    return Hoek.assert(methodsUsers(), i18n.couldNotFindMethodsUsers);
  };

}).call(this);

//# sourceMappingURL=routes-account.js.map
