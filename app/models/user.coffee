User = DS.Model.extend
  email: DS.attr 'string'
  createdAt: DS.attr 'date'
  balance: DS.attr 'number'
  depositAddress: DS.attr 'string'


`export default User`
