`import Transaction from 'appkit/models/transaction'`

ShibeTransaction = Ember.Component.extend
  classNames: ['shibe-transaction']
  classNameBindings: ['isCredit:credit:debit', 'isPending:pending']
  didInsertElement: ->
    @send 'assignScrolliness'
  personField: (->
    if @get('transaction.status') == Transaction.STATUS.DEPOSIT
      "deposit"
    else if @get('isCredit')
      @get 'transaction.from'
    else
      if @get('transaction.receiverAddress')?
        @get 'receiverAddress'
      else
        @get 'transaction.to'
  ).property 'transaction.status', 'transaction.from', 'transaction.to', 'transaction.receiverAddress'
  subject: (->

  ).property 'transaction.subject', 'transaction.receiverAddress'
  status: (->
    if @get('transaction.status') in [Transaction.STATUS.DEPOSIT, Transaction.STATUS.COMPLETE, Transaction.STATUS.WITHDRAWAL]
      @get('transaction.createdAt')
    else
      if @get('isCredit')
        if @get('transaction.confirmation') in [Transaction.CONFIRMATION.INSUFFICIENT_FUNDS, Transaction.CONFIRMATION.PENDING]
          "pending"
        else if @get('transaction.confirmation') == Transaction.CONFIRMATION.ACCEPTED
          "confirmed"
      else
        if @get('transaction.confirmation') == Transaction.CONFIRMATION.PENDING
          "not yet confirmed. resend confirmation?"
        if @get('transaction.confirmation') == Transaction.CONFIRMATION.INSUFFICIENT_FUNDS
          "insufficient funds. please deposit and re-confirm."
        else if @get('transaction.acceptance') == Transaction.ACCEPTANCE.PENDING
          "pending acceptance"
        else
          @get('transaction.createdAt')

  ).property 'transaction.status', 'transaction.createdAt'
  isPending: (->
    @get('transaction.status') not in [Transaction.STATUS.COMPLETE, Transaction.STATUS.DEPOSIT]
  ).property 'transaction.status'
  isCredit: (->
    @get('transaction.receiverId') == @get('currentUser.id')
  ).property 'transaction.receiverId', 'currentUser.id'
  arrow: (->
    if @get('isCredit')
      '◢'
    else
      '◤'
  ).property 'isCredit'
  sign: (->
    if @get('isCredit') then '+'
    else '-'
  ).property 'isCredit'

  actions:
    assignScrolliness: ->
      scrollinessAssignment = =>
        @get('scrollElements').forEach (element) ->
          if element.outerWidth() < element[0].scrollWidth
            element.addClass('scroll-active')
          else
            element.removeClass('scroll-active')
      scrollElements = []
      @$('.scroll-content').each ->
        scrollElements.push $(this)
      @set 'scrollElements', scrollElements
      scrollinessAssignment()
      $(window).bind 'resize', scrollinessAssignment

`export default ShibeTransaction`
