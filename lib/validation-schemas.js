(function() {
  var Joi, creditCardId, i18n, stripeCustomerId, validateId;

  Joi = require("joi");

  i18n = require("./i18n");

  validateId = Joi.string().length(24);

  creditCardId = validateId.description(i18n.descriptionCreditCardId).example(i18n.exampleObjectId);

  stripeCustomerId = Joi.string().description(i18n.descriptionStripeCustomerId);

  module.exports = {
    creditCardId: creditCardId,
    stripeCustomerId: stripeCustomerId,
    payloadUsersMeAccountsPost: Joi.object().keys({
      name: Joi.string(),
      sitename: Joi.string(),
      contactPhone: Joi.string(),
      contactEmail: Joi.string(),
      stripeCustomerId: stripeCustomerId,
      defaultCreditCardId: creditCardId
    }).options({
      allowUnknown: true,
      stripUnknown: true
    })
  };

}).call(this);

//# sourceMappingURL=validation-schemas.js.map
