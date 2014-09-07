_ = require 'underscore'

module.exports = 
  account: (x) ->
    x = JSON.parse(JSON.stringify(x))
    delete x.__v
    x

  creditCard: (x) ->
    x = JSON.parse(JSON.stringify(x))
    delete x.__v
    x

