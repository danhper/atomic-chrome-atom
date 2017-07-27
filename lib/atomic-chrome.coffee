{Server} = require 'ws'
WSHandler = null # defer require till necessary
WS_PORT = 64292

module.exports = AtomicChrome =
  activate: (state) ->
    @wss = new Server({port: WS_PORT})

    @wss.on 'connection', (ws) ->
      WSHandler ?= require './ws-handler'
      new WSHandler(ws)
    @wss.on 'error', (err) ->
      console.error(err) unless err.code == 'EADDRINUSE'

  deactivate: ->
    @wss.close()

  config:
    defaultExtension:
      type: 'string'
      default: '.md'
