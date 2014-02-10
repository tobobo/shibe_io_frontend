ShibeLoginComponent = Ember.Component.extend
  loginUrl: (->
    Ember.get('App.applicationController.apiHost') + '/users/login'
  ).property 'App.applicationController.apiHost'
  registerUrl: (->
    Ember.get('App.applicationController.apiHost') + '/users/new'
  ).property 'App.applicationController.apiHost'
  hideForm: (->
    @get('activationSent')
  ).property 'activationSent'
  actions:
    submit: ->
      if @get('password')
      else
        $.ajax
          method: 'POST'
          url: @get('registerUrl')
          data: @getProperties('email', 'password')
          success: (data) =>
            @set 'noPassword', false
            @set 'userInactive', false
            @set 'activationSent', true
            console.log data
          error: (error) =>
            response = JSON.parse error.responseText
            if response.user.active
              @set 'noPassword', true
            else
              @set 'userInactive', true

`export default ShibeLoginComponent`
