ShibeApiStatus = Ember.Component.extend
  classNames: ['api-status']
  checking: true;
  up: ((prop, value) ->
    if value? then value
    else
      $.ajax
        method: 'get'
        xhrFields:
          withCredentials: true
        url: @get('apiHost')
        success: (data) =>
          if data?
            @set 'up', true
          @set 'checking', false
        error: (error) =>
          if error?
            @set 'up', false
          @set 'checking', false
      false
  ).property()

`export default ShibeApiStatus`
