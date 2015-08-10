_ = require 'underscore'

module.exports = (x) ->
    x = JSON.parse(JSON.stringify(x))
    delete x.__v
    x

