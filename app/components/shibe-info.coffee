ShibeInfoComponent = Ember.Component.extend
  classNames: ['shibe-info']
  actions:
    logout: ->
      console.log 'shibe info logout'
      Ember.get('App.applicationController').send('logout')

`export default ShibeInfoComponent`
