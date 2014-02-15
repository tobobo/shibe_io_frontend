HistoryRoute = Ember.Route.extend
  model: ->
    console.log 'history router'
    currentUserId = App.get('applicationController.currentUserId') or window.currentUserId
    if currentUserId?
      console.log 'current user id exists'
      @store.find 'transaction',
        userId: currentUserId
    else
      return null

  afterModel: (model) ->
    console.log 'model', model
    unless model?
      @replaceWith 'index'


`export default HistoryRoute`
