IndexController = Ember.ObjectController.extend
  actions:
    goToHistory: ->
      Ember.get('App.applicationController').send 'getIdFromCookie'
      Ember.run.next =>
        @transitionToRoute 'history'

`export default IndexController`
