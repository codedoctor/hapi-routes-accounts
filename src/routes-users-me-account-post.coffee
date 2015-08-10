_ = require 'underscore'
Boom = require 'boom'
Hoek = require "hoek"
bson = require 'bson'
#ObjectID = bson.ObjectID
async = require 'async'
Joi = require 'joi'

helperObjToRestCreditCard = require './helper-obj-to-rest-credit-card'
helperObjToRestAccount = require './helper-obj-to-rest-account'

i18n = require './i18n'
validationSchemas = require './validation-schemas'

###
fnCreateObjectId = ->
  (new ObjectID()).toString()

fnToObjectId = (objIdAsString) ->
  try
    return (new ObjectID(objIdAsString)).toString()
  catch
    return null
###

module.exports = (plugin,options = {}) ->
  #Hoek.assert options.routesBaseName,i18n.optionsRoutesBaseNameRequired
  #Hoek.assert options.tags && _.isArray(options.tags),i18n.optionsTagsRequiredAndArray

  #hapiUserStoreMultiTenant = -> plugin.plugins['hapi-user-store-multi-tenant']
  #Hoek.assert hapiUserStoreMultiTenant(),i18n.couldNotFindHapiUserStoreMultiTenantPlugin

  hapiStoreAccounts = -> plugin.plugins['hapi-store-accounts']
  Hoek.assert hapiStoreAccounts(),i18n.couldNotFindHapiStoreAccountsPlugin

  methodAccounts = -> hapiStoreAccounts().accounts
  #methodsRoles = -> hapiUserStoreMultiTenant().methods.roles
  #methodsUsers = -> hapiUserStoreMultiTenant().methods.users

  Hoek.assert methodAccounts(),i18n.couldNotFindMethodsAccounts
  #Hoek.assert methodsRoles(),i18n.couldNotFindMethodsRoles
  #Hoek.assert methodsUsers(),i18n.couldNotFindMethodsUsers

  ###
  Creates a new account. In this version each user can create one account only.
  ###
  plugin.route
    path: "/users/me/accounts"
    method: "POST"
    config:
      description: i18n.descriptionUsersMeAccountsPost
      tags: options.routeTagsPublic
      validate:
        payload: Joi.object().keys(
                                  name : Joi.string()
                                  sitename: Joi.string()
                                  contactPhone: Joi.string()
                                  contactEmail: Joi.string()
                                  stripeCustomerId: validationSchemas.stripeCustomerId
                                  defaultCreditCardId: validationSchemas.creditCardId

                                  ).options({allowUnknown: true,stripUnknown:true})
    handler: (request, reply) ->
      id = request.auth?.credentials?.id
      return reply Boom.unauthorized(i18n.errorAuthenticationRequired) unless id

      methodAccounts().countAllForOwner id,null,(err,totalAccountCountForOwner) ->
        return reply err if err

        exceedsLimit = options.maxOwnedAccountsPerUser <= totalAccountCountForOwner

        return reply Boom.badRequest("#{i18n.accountExceededLimitOf} #{options.maxOwnedAccountsPerUser}") if exceedsLimit

        request.payload.name = "#{request.auth.credentials.username} #{i18n.accountPostfix}" unless request.payload.name
        request.payload.owningUserId = id
        request.payload.features = options.defaultFeatures

        methodAccounts().create request.payload,null, (err,accountResult) ->
          return reply err if err
          reply( helperObjToRestAccount(accountResult)).code(201)



