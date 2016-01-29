{CompositeDisposable} = require 'atom'
{Server}              = require 'ws'

WSHandler             = require './ws-handler'

WS_PORT = 64292

module.exports = AtomicChrome =
  activate: (state) ->
    @wss = new Server({port: WS_PORT})

    @wss.on 'connection', (ws) ->
      new WSHandler(ws)
    @wss.on 'error', (err) ->
      console.error(err) unless err.code == 'EADDRINUSE'

  deactivate: ->
    @wss.close()
