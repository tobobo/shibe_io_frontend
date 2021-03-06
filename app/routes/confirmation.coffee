`import Transaction from 'appkit/models/transaction'`
`import TransactionTokenRoute from 'appkit/routes/transaction_token'`

console.log 'ttr', TransactionTokenRoute

ConfirmationRoute = TransactionTokenRoute.extend

  transactionIsValid: (transaction) ->
    parseInt(transaction.get('confirmation')) == parseInt(Transaction.CONFIRMATION.PENDING)

`export default ConfirmationRoute`
