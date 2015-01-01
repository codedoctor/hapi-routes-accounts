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
  server = new Hapi.Server()
  server.connection
            port: testPort
            host: testHost

  pluginConf = [
      register: hapiUserStoreMultiTenant
    ,
      register: hapiStoreAccounts
    ,
      register: index
      options:
        defaultFeatures: ['feature-1']
  ]

  mongoose.disconnect()
  mongoose.connect testMongoDbUrl, (err) ->
    return cb err if err
    databaseCleaner loggingEnabled, (err) ->
      return cb err if err

      server.register pluginConf, (err) ->

        plugin = server.plugins['hapi-store-accounts']
        plugin.rebuildIndexes (err) ->
          cb err,server,plugin


