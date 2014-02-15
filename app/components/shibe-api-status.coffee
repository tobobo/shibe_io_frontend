ShibeApiStatus = Ember.Component.extend
  classNames: ['api-status']
  classNameBindings: ['align']
  align: 'left'
  checking: true
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
  alignLeft: (->
    if not @get('align')? or @get('align') == 'left'
      true
  ).property 'align'
  alignRight: Ember.computed.equal 'align', 'right'

`export default ShibeApiStatus`
