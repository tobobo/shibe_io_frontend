`import Transaction from 'appkit/models/transaction'`
`import TransactionTokenRoute from 'appkit/routes/transaction_token'`

console.log 'ttr', TransactionTokenRoute

AcceptanceRoute = TransactionTokenRoute.extend

  transactionIsValid: (transaction) ->
    parseInt(transaction.get('acceptance')) == parseInt(Transaction.ACCEPTANCE.PENDING)

`export default AcceptanceRoute`
