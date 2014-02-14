QrCodeComponent = Ember.Component.extend
  tagName: 'div'
  classNames: ['qr-code']
  qrCode: null
  contentDidChange: (->
    unless @get('qrCode')?
      @set 'qrCode', new QRCode(@$().get(0))
    console.log @get('qrCode')
    @get('qrCode').makeCode @get('content')
    return
  ).observes('content').on 'didInsertElement'

`export default QrCodeComponent`
