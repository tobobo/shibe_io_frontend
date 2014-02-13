Router = Ember.Router.extend
  location: 'history'

Router.map ->
  @resource 'activations',
    path: 'activate'
  , ->
    @resource 'activation',
      path: ':activationToken'

  @resource 'confirmations',
    path: 'confirm'
  , ->
    @resource 'confirmation',
      path: ':confirmationCode'

`export default Router`
