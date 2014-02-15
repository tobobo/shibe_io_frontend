`import Transaction from 'appkit/models/transaction'`

ShibeTransaction = Ember.Component.extend
  classNames: ['shibe-transaction']
  personField: (->
    console.log @get('transaction.to')
    console.log 'transaction status', @get('transaction.status')
    if @get('transaction.status') == Transaction.STATUS.DEPOSIT
      "Deposit"
    else if @get('isCredit')
      @get 'transaction.from'
    else
      @get 'transaction.to'
  ).property 'transaction.status', 'transaction.from'
  status: (->
    console.log 'getting status'
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
  isCredit: (->
    @get('transaction.receiverId') == @get('currentUser.id')
  ).property 'transaction.receiverId', 'currentUser.id'
  symbol: (->
    if @get('isCredit') then '+'
    else '-'
  ).property 'isCredit'

`export default ShibeTransaction`
