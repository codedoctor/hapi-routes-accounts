_ = require 'underscore'
databaseCleaner = require './database-cleaner'
Hapi = require "hapi"
hapiUserStoreMultiTenant = require 'hapi-user-store-multi-tenant'
hapiStoreAccounts = require 'hapi-store-accounts'
index = require '../../lib/index'
mongoose = require 'mongoose'

fixtures = require './fixtures'

testMongoDbUrl = 'mongodb://localhost/codedoctor-test'
testPort = 5675
testHost = "localhost"
loggingEnabled = false



module.exports = loadServer = (cb) ->
  server = new Hapi.Server testPort,testHost,{}

  pluginConf = [
      plugin: hapiUserStoreMultiTenant
    ,
      plugin: hapiStoreAccounts
    ,
      plugin: index
      options:
        defaultFeatures: ['feature-1']
  ]

  mongoose.disconnect()
  mongoose.connect testMongoDbUrl, (err) ->
    return cb err if err
    databaseCleaner loggingEnabled, (err) ->
      return cb err if err

      server.pack.register pluginConf, (err) ->

        plugin = server.pack.plugins['hapi-store-accounts']
        plugin.rebuildIndexes (err) ->
          cb err,server,plugin


