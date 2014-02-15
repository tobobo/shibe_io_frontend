`import Transaction from 'appkit/models/transaction'`

ShibeTransaction = Ember.Component.extend
  classNames: ['shibe-transaction']
  classNameBindings: ['isCredit:credit:debit', 'isPending:pending']
  personField: (->
    if @get('transaction.status') == Transaction.STATUS.DEPOSIT
      "Deposit"
    else if @get('isCredit')
      @get 'transaction.from'
    else
      @get 'transaction.to'
  ).property 'transaction.status', 'transaction.from'
  status: (->
    if @get('transaction.status') in [Transaction.STATUS.DEPOSIT, Transaction.STATUS.COMPLETE, Transaction.STATUS.WITHDRAWAL]
      @get('transaction.createdAt')
    else
      if @get('isCredit')
        if @get('transaction.confirmation') in [Transaction.CONFIRMATION.INSUFFICIENT_FUNDS, Transaction.CONFIRMATION.PENDING]
          "Pending"
        else if @get('transaction.confirmation') == Transaction.CONFIRMATION.ACCEPTED
          "Confirmed"
      else
        if @get('transaction.confirmation') == Transaction.CONFIRMATION.PENDING
          "Not yet confirmed. Resend confirmation?"
        if @get('transaction.confirmation') == Transaction.CONFIRMATION.INSUFFICIENT_FUNDS
          "Insufficient funds. Please deposit and re-confirm."
        else if @get('transaction.acceptance') == Transaction.ACCEPTANCE.PENDING
          "Pending acceptance"
        else
          @get('transaction.createdAt')

  ).property 'transaction.status', 'transaction.createdAt'
  isPending: (->
    console.log @get('transaction.status')
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

`export default ShibeTransaction`
