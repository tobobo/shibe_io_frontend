Router = Ember.Router.extend
  location: 'history'

Router.map ->
  @resource 'activations',
    path: 'activate'
  , ->
    @resource 'activation',
      path: ':activation_id'

`export default Router`
