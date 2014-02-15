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

  @resource 'acceptances',
    path: 'accept'
  , ->
    @resource 'acceptance',
      path: ':acceptanceCode'

  @resource 'history',
    path: 'history',
    templateName: 'history'

`export default Router`
