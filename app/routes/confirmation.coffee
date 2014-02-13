`import Transaction from 'appkit/models/transaction'`

ConfirmationRoute = Ember.Route.extend
  model: (params) ->
    console.log 'modeling'
    @store.find 'transaction', params
    .then (transactions) =>
      new Ember.RSVP.Promise (resolve, reject) =>
        transaction = transactions.get('firstObject')
        console.log 'transaction is', transaction
        transaction.set 'confirmationCode', params.confirmationCode if transaction?
        resolve transaction

  afterModel: (model) ->
    if model? and parseInt(model.get('confirmation')) == parseInt(Transaction.CONFIRMATION.PENDING)
      @controllerFor('application').set 'currentUserId', null
    else
      @replaceWith 'index'
`export default ConfirmationRoute`
