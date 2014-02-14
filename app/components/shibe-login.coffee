`import Transaction from 'appkit/models/transaction'`

ShibeLoginComponent = Ember.Component.extend
  currentUserId: ((prop, value) ->
    if value != undefined
      App.set 'applicationController.currentUserId', value
      value
    else
      App.get('applicationController.currentUserId')
  ).property 'App.applicationController.currentUserId'

  loadingMessage: (->
    if @get('activationToken')?
      "Activating..."
    else if @get('transaction.confirmationCode')?
      "Confirming..."
    else if @get('transaction.acceptanceCode')?
      "Accepting..."
    else if @get('password')?
      "Logging in..."
    else
      "Submitting..."
  ).property 'activationToken', 'password', 'transaction.confirmationCode', 'transaction.acceptanceCode'

  buttonMessage: (->
    if @get('activationToken')?
      "Activate Account"
    else if @get('transaction.confirmationCode')?
      "Confirm"
    else if @get('transaction.acceptanceCode')?
      "Accept"
    else
      "Get Started"
  ).property 'activationToken', 'transaction.confirmationCode', 'transaction.acceptanceCode'

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
    @get('activationSent') or @get('accountActivated') or @get('loginSuccessful') or @get('currentUserId')? or @get('transactionConfirmed')? or @get('transactionAccepted')?
  ).property 'activationSent', 'accountActivated', 'loginSuccessful', 'currentUserId', 'transactionConfirmed'
  showPassword: ((prop, value) ->
    if value? then value
    else @get('activationToken')? or @get('transaction')?
  ).property 'activationToken', 'transaction'
  showAccountCheckbox: ((prop, value) ->
    if value? then value
    else not @get('activationToken')? and not @get('transaction')?
  ).property 'activationToken'
  didInsertElement: ->
    @send 'bindEvents'

  showPasswordDidChange: (->
    Ember.run.next =>
      @send 'bindEvents'
  ).observes 'showPassword'


  actions:
    bindEvents: ->
      @$('input').unbind 'keydown'
      @$('input:not(:checkbox)').bind 'keydown', (e) =>
        if e.keyCode == 13
          @send 'submit'      
    
      @$('input:checkbox').bind 'keydown', (e) =>
        if e.keyCode == 9 and not (e.metaKey or e.shiftKey)
          e.preventDefault()
          @$('input:checkbox').attr 'checked', true
          @set 'showPassword', true
          Ember.run.next =>
            @$('input[type=password]').focus()

    submit: ->
      if @get('activationToken')
        if @get('email')? and @get('password')?
          @set 'activationDetailsMissing', false
          @set 'loading', true
          $.ajax
            method: 'POST'
            url: @get('activateUrl')
            data: @getProperties('email', 'password', 'activationToken')
            dataType: 'json'
            xhrFields:
              withCredentials: true
            success: (data) =>
              @set 'currentUserId', data.user.id
              @set 'activationError', false
              @set 'userInactive', false
              @set 'accountActivated', true
            error: (error) =>
              @set 'activationError', true
              @set 'userInactive', false
            complete: =>
              @set 'loading', false
        else
          @set 'activationError', false
          @set 'activationDetailsMissing', true
          @set 'userInactive', false
      else if @get('transaction.confirmationCode')?
        if @get('email')? and @get('password')?
          console.log 'get email'
          @set 'loading', true
          @set 'transaction.userEmail', @get('email')
          @set 'transaction.userPassword', @get('password')
          @set 'transaction.confirmation', Transaction.CONFIRMATION.ACCEPTED
          @get('transaction').save()
            .then (transaction) =>
              @set 'confirmationDetailsMissing', false
              @set 'transactionConfirmed', true
              @set 'loading', false
              App.applicationController.send 'getIdFromCookie'
            , (error) =>
              @set 'confirmationDetailsMissing', false
              @set 'confirmationAuthError', true
              @set 'loading', false
        else
          @set 'confirmationDetailsMissing', true

      else if @get('transaction.acceptanceCode')?
        console.log 'get email'
        @set 'loading', true
        @set 'transaction.userEmail', @get('email')
        @set 'transaction.userPassword', @get('password')
        @set 'transaction.acceptance', Transaction.ACCEPTANCE.ACCEPTED
        console.log 'acceptance accepted', Transaction.ACCEPTANCE.ACCEPTED
        @get('transaction').save()
          .then (transaction) =>
            @set 'acceptanceDetailsMissing', false
            @set 'transactionAccepted', true
            @set 'loading', false
            App.applicationController.send 'getIdFromCookie'
          , (error) =>
            @set 'acceptanceDetailsMissing', false
            @set 'acceptanceAuthError', true
            @set 'loading', false
      else
        if @get('email')? and @get('password')?
          @set 'loading', true
          $.ajax
            method: 'POST'
            url: @get('loginUrl')
            data: @getProperties('email', 'password')
            dataType: 'json'
            xhrFields:
              withCredentials: true
            success: (data) =>
              @set 'loginSuccessful', true
              App.applicationController.send 'getIdFromCookie'
              @set 'loginError', false
              @set 'userInactive', false
            error: (error) =>
              @set 'loginError', true
              @set 'userInactive', false
            complete: =>
              @set 'loading', false
        else if @get('email')?
          @set 'loading', true
          $.ajax
            method: 'POST'
            url: @get('registerUrl')
            data: @getProperties('email')
            xhrFields:
              withCredentials: true
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
            complete: =>
              @set 'loading', false

`export default ShibeLoginComponent`
