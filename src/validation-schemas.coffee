Joi = require "joi"
i18n = require "./i18n"

validateId = Joi.string().length(24)

module.exports = 
  creditCardId : validateId.description(i18n.descriptionCreditCardId).example(i18n.exampleObjectId)
  stripeCustomerId : Joi.string().description(i18n.descriptionStripeCustomerId)
