IndexRoute = Ember.Route.extend
  beforeModel: ->
    if window.currentUserId?
      @replaceWith 'history'
      
`export default IndexRoute`
