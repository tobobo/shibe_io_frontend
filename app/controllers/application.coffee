ApplicationController = Ember.ObjectController.extend
  apiHost: 'http://api-v1.shibe.io'
  checkingApi: true
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

console.log 'howdy there'

`export default ApplicationController`
