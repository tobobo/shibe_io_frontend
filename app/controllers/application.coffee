ApplicationController = Ember.ObjectController.extend
  apiHost: window.ENV.SHIBE_API_URL
  currentUserId: null
  currentUserLoading: false
  currentUser: ((prop, value) ->
    @set 'currentUserLoading', true
    if value? then value
    else
      if @get('currentUserId')
        @store.find 'user', @get('currentUserId')
        .then (user) =>
          @set 'currentUser', user
          @set 'currentUserLoading', false
        , (error) =>
          console.log 'user error', error
          @set 'currentUserId', null
          @set 'currentUserLoading', false
      null
  ).property 'currentUserId'
  logoutUrl: (->
    @get('apiHost') + '/users/logout'
  ).property 'apiHost'
  checkingApi: true
  init: ->
    App.set 'applicationController', @
    @send 'getIdFromCookie'
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

  currentUserIdDidChange: (->
    console.log 'user id changed', @get('currentUserId')
    unless @get('currentUserId')?
      @send 'removeIdCookie'
  ).observes 'currentUserId'


  cookieName: 'shibe'

  actions:
    getIdFromCookie: ->
      console.log 'getting cookie'
      cookie = $.cookie @get('cookieName')
      if cookie
        console.log cookie
        matches =cookie.match(/"([^"]*)"/)
        if matches? and matches.length > 1
          console.log 'matches'
          id = matches[1]
          console.log 'id', id
          if id
            @set 'currentUserId', id
            console.log 'aftersetting', @get('currentUserId')

    removeIdCookie: ->
      $.cookie @get('cookieName'), null

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
