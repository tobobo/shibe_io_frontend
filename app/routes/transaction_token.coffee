TransactionTokenRoute = Ember.Route.extend
  model: (params) ->
    console.log 'modeling'
    console.log 'params', params
    realParams = {}
    for p in ['confirmationCode', 'acceptanceCode']
      realParams[p] = params[p]
    @store.find 'transaction', realParams
    .then (transactions) =>
      new Ember.RSVP.Promise (resolve, reject) =>
        transaction = transactions.get('firstObject')
        console.log 'transaction is', transaction
        transaction.set 'confirmationCode', params.confirmationCode if transaction? and params.confirmationCode?
        transaction.set 'acceptanceCode', params.acceptanceCode if transaction? and params.acceptanceCode?
        resolve transaction

  afterModel: (model) ->
    if model? and @transactionIsValid model
      @controllerFor('application').set 'currentUserId', null
    else
      @replaceWith 'index'

`export default TransactionTokenRoute`
