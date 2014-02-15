IndexController = Ember.ObjectController.extend
  actions:
    goToHistory: ->
      @transitionToRoute 'history'

`export default IndexController`
