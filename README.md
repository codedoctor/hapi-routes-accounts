[![Build Status](https://travis-ci.org/codedoctor/hapi-routes-accounts.svg?branch=master)](https://travis-ci.org/codedoctor/hapi-routes-accounts)
[![Coverage Status](https://img.shields.io/coveralls/codedoctor/hapi-routes-accounts.svg)](https://coveralls.io/r/codedoctor/hapi-routes-accounts)
[![NPM Version](http://img.shields.io/npm/v/hapi-routes-accounts.svg)](https://www.npmjs.org/package//hapi-routes-accounts)
[![Dependency Status](https://gemnasium.com/codedoctor/hapi-routes-accounts.svg)](https://gemnasium.com/codedoctor/hapi-routes-accounts)
[![NPM Downloads](http://img.shields.io/npm/dm/hapi-routes-accounts.svg)](https://www.npmjs.org/package/hapi-routes-accounts)
[![Issues](http://img.shields.io/github/issues/codedoctor/hapi-routes-accounts.svg)](https://github.com/codedoctor/hapi-routes-accounts/issues)
[![HAPI 8.0](http://img.shields.io/badge/hapi-8.0-blue.svg)](http://hapijs.com)
[![API Documentation](http://img.shields.io/badge/API-Documentation-ff69b4.svg)](http://coffeedoc.info/github/codedoctor/hapi-routes-accounts)

(C) 2014 Martin Wawrusch

Provides HAPI based account management endpoints.

## POST /users/me/accounts

Creates a new account. The account is owned by the user who posts this (taken from the id field from the credentials.) The default options limit to one per user, but this can be overridden.




## more later
get /users/me/accounts/active --> Retrieves the currently active account for the user
post /users/me/account/active
get /users/me/accounts

get /accounts/:accountId
patch /accounts/:accountId
delete /accounts/:accountId

post /accounts/:accountId/credit-cards/stripe-card-token
get /accounts/:accountId/credit-cards
delete /accounts/:accountId/credit-cards/:creditCardId
get /accounts/:accountId/default-credit-card

Later
post /accounts/:accountId/users/invite






## Dependencies

* HAPI >= 6.5.0

## Plugins that must be loaded into your hapi server:

* hapi-store-accounts

## See also

* [hapi-auth-bearer-mw](https://github.com/codedoctor/hapi-auth-bearer-mw)
* [hapi-loggly](https://github.com/codedoctor/hapi-loggly)
* [hapi-mandrill](https://github.com/codedoctor/hapi-mandrill)
* [hapi-mongoose-db-connector](https://github.com/codedoctor/hapi-mongoose-db-connector)
* [hapi-oauth-store-multi-tenant](https://github.com/codedoctor/hapi-oauth-store-multi-tenant)
* [hapi-routes-authorization-and-session-management](https://github.com/codedoctor/hapi-routes-authorization-and-session-management)
* [hapi-routes-oauth-management](https://github.com/codedoctor/hapi-routes-oauth-management)
* [hapi-routes-accounts](https://github.com/codedoctor/hapi-routes-accounts)
* [hapi-routes-status](https://github.com/codedoctor/hapi-routes-status)
* [hapi-routes-users-authorizations](https://github.com/codedoctor/hapi-routes-users-authorizations)
* [hapi-routes-users](https://github.com/codedoctor/hapi-routes-users)
* [hapi-user-store-multi-tenant](https://github.com/codedoctor/hapi-user-store-multi-tenant)

and additionally

* [api-pagination](https://github.com/codedoctor/api-pagination)
* [mongoose-oauth-store-multi-tenant](https://github.com/codedoctor/mongoose-oauth-store-multi-tenant)
* [mongoose-rest-helper](https://github.com/codedoctor/mongoose-rest-helper)
* [mongoose-user-store-multi-tenant](https://github.com/codedoctor/mongoose-user-store-multi-tenant)

## Contributing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the package.json, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Martin Wawrusch 


