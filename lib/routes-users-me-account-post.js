(function() {
  var Boom, Hoek, Joi, _, async, bson, helperObjToRestAccount, helperObjToRestCreditCard, i18n, validationSchemas;

  _ = require('underscore');

  Boom = require('boom');

  Hoek = require("hoek");

  bson = require('bson');

  async = require('async');

  Joi = require('joi');

  helperObjToRestCreditCard = require('./helper-obj-to-rest-credit-card');

  helperObjToRestAccount = require('./helper-obj-to-rest-account');

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
    var hapiStoreAccounts, methodAccounts;
    if (options == null) {
      options = {};
    }
    hapiStoreAccounts = function() {
      return plugin.plugins['hapi-store-accounts'];
    };
    Hoek.assert(hapiStoreAccounts(), i18n.couldNotFindHapiStoreAccountsPlugin);
    methodAccounts = function() {
      return hapiStoreAccounts().accounts;
    };
    Hoek.assert(methodAccounts(), i18n.couldNotFindMethodsAccounts);

    /*
    Creates a new account. In this version each user can create one account only.
     */
    return plugin.route({
      path: "/users/me/accounts",
      method: "POST",
      config: {
        description: i18n.descriptionUsersMeAccountsPost,
        tags: options.routeTagsPublic,
        validate: {
          payload: Joi.object().keys({
            name: Joi.string(),
            sitename: Joi.string(),
            contactPhone: Joi.string(),
            contactEmail: Joi.string(),
            stripeCustomerId: validationSchemas.stripeCustomerId,
            defaultCreditCardId: validationSchemas.creditCardId
          }).options({
            allowUnknown: true,
            stripUnknown: true
          })
        }
      },
      handler: function(request, reply) {
        var id, ref, ref1;
        id = (ref = request.auth) != null ? (ref1 = ref.credentials) != null ? ref1.id : void 0 : void 0;
        if (!id) {
          return reply(Boom.unauthorized(i18n.errorAuthenticationRequired));
        }
        return methodAccounts().countAllForOwner(id, null, function(err, totalAccountCountForOwner) {
          var exceedsLimit;
          if (err) {
            return reply(err);
          }
          exceedsLimit = options.maxOwnedAccountsPerUser <= totalAccountCountForOwner;
          if (exceedsLimit) {
            return reply(Boom.badRequest(i18n.accountExceededLimitOf + " " + options.maxOwnedAccountsPerUser));
          }
          if (!request.payload.name) {
            request.payload.name = request.auth.credentials.username + " " + i18n.accountPostfix;
          }
          request.payload.owningUserId = id;
          request.payload.features = options.defaultFeatures;
          return methodAccounts().create(request.payload, null, function(err, accountResult) {
            if (err) {
              return reply(err);
            }
            return reply(helperObjToRestAccount(accountResult)).code(201);
          });
        });
      }
    });
  };

}).call(this);

//# sourceMappingURL=routes-users-me-account-post.js.map
