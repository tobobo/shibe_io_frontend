Router = Ember.Router.extend
  location: 'history'

Router.map ->
  @resource 'activations',
    path: 'activate'
  , ->
    @resource 'activation',
      path: ':activationToken'

`export default Router`
