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

`export default Transaction`
