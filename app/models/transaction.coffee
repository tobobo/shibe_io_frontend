Transaction = DS.Model.extend
  amount: DS.attr 'number'
  createdAt: DS.attr 'date'
  receiverId: DS.attr 'string'
  subject: DS.attr 'string'
  from: DS.attr 'string'
  to: DS.attr 'string'
  status: DS.attr 'number'
  acceptance: DS.attr 'number'
  confirmation: DS.attr 'number'
  confirmationCode: DS.attr 'string'
  userEmail: DS.attr 'string'
  userPassword: DS.attr 'string'

constants =
  STATUS: ['PENDING', 'ANNOUNCED', 'DEPOSIT']
  CONFIRMATION: ['PENDING', 'ACCEPTED']
  ACCEPTANCE: ['PENDING', 'ACCEPTED']

for c, a of constants
  Transaction[c] = {}
  for i, v of a
    Transaction[c][i] = v
    Transaction[c][v] = i 

`export default Transaction`