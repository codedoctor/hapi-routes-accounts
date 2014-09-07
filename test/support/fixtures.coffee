

module.exports = 
  accountId: '01234567890123456789000b'
  creditCardId: '01234567890123456789000c'
  userId:'01234567890123456789000a'

  account1:
    owningUserId: '01234567890123456789000a'
    name: 'Account 1'

  account2:
    owningUserId: '01234567890123456789000b'
    name: 'Account 2'

  account3:
    owningUserId: '01234567890123456789000a'
    name: 'Account 3'


  creditCard1: {}


  credentialsAnonymous:
    id: "13a88c31413019245de27da7"
    username: 'Martin Wawrusch'
    scope: ['user-anonymous-access']

  credentialsBearer:
    id: "13a88c31413019245de27da7"
    username: 'Martin Wawrusch'
    scope: ['user-bearer-access']

  credentialsBearerWithAccountId:
    id: "13a88c31413019245de27da7"
    username: 'Martin Wawrusch'
    accountId: '13a88c31413019245de27da0'
    scope: ['user-bearer-access']
