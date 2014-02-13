ApplicationAdapter = DS.RESTAdapter.extend
  host: window.ENV.SHIBE_API_URL
  ajaxOptions: (url, type, hash) ->
    hash = hash || {}
    hash.xhrFields = hash.xhrFields || {}
    console.log 'hash', hash
    hash.xhrFields.withCredentials = true
    console.log 'hash', hash
    @_super.call @, url, type, hash

`export default ApplicationAdapter`
