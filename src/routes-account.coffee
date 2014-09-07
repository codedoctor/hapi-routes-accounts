_ = require 'underscore'
Boom = require 'boom'
Hoek = require "hoek"
bson = require 'bson'
#ObjectID = bson.ObjectID
async = require 'async'

helperObjToRest = require './helper-obj-to-rest'
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

  hapiUserStoreMultiTenant = -> plugin.plugins['hapi-user-store-multi-tenant']
  Hoek.assert hapiUserStoreMultiTenant(),i18n.couldNotFindHapiUserStoreMultiTenantPlugin

  hapiStoreAccounts = -> plugin.plugins['hapi-store-accounts']
  Hoek.assert hapiStoreAccounts(),i18n.couldNotFindHapiStoreAccountsPlugin

  methodsRoles = -> hapiUserStoreMultiTenant().methods.roles
  methodsUsers = -> hapiUserStoreMultiTenant().methods.users

  Hoek.assert methodsRoles(),i18n.couldNotFindMethodsRoles
  Hoek.assert methodsUsers(),i18n.couldNotFindMethodsUsers

