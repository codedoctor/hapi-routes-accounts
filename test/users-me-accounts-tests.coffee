assert = require 'assert'
should = require 'should'

fixtures = require './support/fixtures'
loadServer = require './support/load-server'
shouldHttp = require './support/should-http'

describe 'no entities in db', ->
  server = null

  describe 'with server setup', ->
    beforeEach (cb) ->
      loadServer (err,serverResult) ->
        return cb err if err
        server = serverResult
        cb null

    describe 'POST /users/me/accounts', ->
      describe 'with NO credentials', ->
        it 'should return a 401', (cb) ->
          shouldHttp.post server, "/users/me/accounts", {},null,401, (err,response) ->
            return cb err if err
            cb null
      describe 'with VALID credentials', ->
        it 'should return a 201', (cb) ->
          shouldHttp.post server, "/users/me/accounts", {},fixtures.credentialsBearer,201, (err,response) ->
            return cb err if err
            
            #console.log JSON.stringify(response.result)

            should.exist response.result

            response.result = JSON.parse(JSON.stringify(response.result))

            response.result.should.have.property 'createdAt'
            response.result.should.have.property 'updatedAt'
            response.result.should.have.property 'name',"#{fixtures.credentialsBearer.username} Account"
            response.result.should.have.property 'owningUserId', fixtures.credentialsBearer.id
            response.result.should.have.property 'accountStatus', 'active'
            response.result.should.have.property 'features'
            response.result.features.should.have.lengthOf 1
            response.result.features[0].should.equal 'feature-1'

            cb null

        it 'should return a 400 if more than one account is created for the same user', (cb) ->
          shouldHttp.post server, "/users/me/accounts", {},fixtures.credentialsBearer,201, (err,response) ->
            return cb err if err

            shouldHttp.post server, "/users/me/accounts", {},fixtures.credentialsBearer,400, (err,response) ->
              cb null
