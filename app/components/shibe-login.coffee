ShibeLoginComponent = Ember.Component.extend
  loginUrl: (->
    Ember.get('App.applicationController.apiHost') + '/users/login'
  ).property 'App.applicationController.apiHost'
  registerUrl: (->
    Ember.get('App.applicationController.apiHost') + '/users/new'
  ).property 'App.applicationController.apiHost'
  activateUrl: (->
    Ember.get('App.applicationController.apiHost') + '/users/activate'
  ).property 'App.applicationController.apiHost'
  hideForm: (->
    @get('activationSent') or @get('accountActivated') or @get('loginSuccessful')
  ).property 'activationSent', 'accountActivated', 'loginSuccessful'
  actions:
    submit: ->
      if @get('activationToken')
        if @get('email') and @get('password')
          @set 'activationDetailsMissing', false
          $.ajax
            method: 'POST'
            url: @get('activateUrl')
            data: @getProperties('email', 'password', 'activationToken')
            success: (data) =>
              @set 'activationError', false
              @set 'userInactive', false
              @set 'accountActivated', true
            error: (error) =>
              @set 'activationError', true
              @set 'userInactive', false
        else
          @set 'activationError', false
          @set 'activationDetailsMissing', true
          @set 'userInactive', false
      else
        if @get('email') and @get('password')
          $.ajax
            method: 'POST'
            url: @get('loginUrl')
            data: @getProperties('email', 'password')
            success: (data) =>
              @set 'loginSuccessful', true
              @set 'loginError', false
              @set 'userInactive', false
            error: (error) =>
              @set 'loginError', true
              @set 'userInactive', false
        else if @get('email')
          $.ajax
            method: 'POST'
            url: @get('registerUrl')
            data: @getProperties('email')
            success: (data) =>
              @set 'noPassword', false
              @set 'userInactive', false
              @set 'activationSent', true
            error: (error) =>
              response = JSON.parse error.responseText
              if response.user.active
                @set 'noPassword', true
              else
                @set 'userInactive', true

`export default ShibeLoginComponent`
