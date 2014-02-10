ApplicationController = Ember.ObjectController.extend
  apiHost: window.ENV.SHIBE_API_URL
  checkingApi: true
  init: ->
    App.set 'applicationController', @
  apiIsUp: ((prop, value) ->
    if value? then value
    else
      $.ajax
        url: @get('apiHost')
        success: (data) =>
          if data?
            @set 'apiIsUp', true
          @set 'checkingApi', false
        error: (error) =>
          if error?
            @set 'apiIsUp', false
          @set 'checkingApi', false
      false
  ).property()

  currentUserId: ((prop, value) ->
    if value? then return value
    else
      cookie = $.cookie('shibe')
      if cookie
        cookie.match(/"([^"]*)"/)[1]
  ).property()

`export default ApplicationController`
