ApplicationController = Ember.ObjectController.extend
  apiHost: window.ENV.SHIBE_API_URL
  currentUserId: null
  currentUserLoading: false
  statusIsRightAligned: (->
    console.log 'curent route', @get('currentRoute')
    @get('currentRouteName') == 'history'
  ).property 'currentRouteName'
  statusAlignment: (->
    if @get 'statusIsRightAligned'
      'right'
  ).property 'statusIsRightAligned'
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
          @set 'currentUserId', null
          @set 'currentUserLoading', false
      id: @get('currentUserId')
      isLoading: true
  ).property 'currentUserId'

  logoutUrl: (->
    @get('apiHost') + '/users/logout'
  ).property 'apiHost'

  init: ->
    App.set 'applicationController', @
    @send 'getIdFromCookie'

  currentUserIdDidChange: (->
    unless @get('currentUserId')?
      @send 'removeIdCookie'
  ).observes 'currentUserId'

  actions:
    getIdFromCookie: ->
      @set 'currentUserId', window.getIdFromCookie()

    removeIdCookie: ->
      window.removeIdCookie()

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
