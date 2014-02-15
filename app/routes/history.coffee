HistoryRoute = Ember.Route.extend
  model: ->
    currentUserId = App.get('applicationController.currentUserId') or window.currentUserId
    if currentUserId?
      @store.find 'transaction',
        userId: currentUserId
      .then (transactions) =>
        console.log 'transactions?', transactions
        new Ember.RSVP.Promise (resolve, reject) =>
          resolve transactions
      , (error) =>
        @replaceWith 'index'
        Ember.set('App.applicationController.currentUserId', null)
    else
      return null

  afterModel: (model) ->
    unless model?
      @replaceWith 'index'


`export default HistoryRoute`
