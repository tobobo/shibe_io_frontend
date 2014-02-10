ApplicationController = Ember.ObjectController.extend
  apiHost: window.ENV.SHIBE_API_URL
  logoutUrl: (->
    @get('apiHost') + '/users/logout'
  ).property 'apiHost'
  checkingApi: true
  init: ->
    App.set 'applicationController', @
  apiIsUp: ((prop, value) ->
    if value? then value
    else
      $.ajax
        method: 'get'
        xhrFields:
          withCredentials: true
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
        matches =cookie.match(/"([^"]*)"/)
        if matches
          matches[1]
  ).property()

  actions:
    logout: ->
      $.ajax
        method: 'delete'
        url: @get 'logoutUrl'
        xhrFields:
          withCredentials: true
        success: =>
          window.location.href = window.location.host
          window.location.reload()


`export default ApplicationController`
