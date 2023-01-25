jQuery(document).on 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create "ClientChannel", 
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Connected to ClientChannel')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Disconnected from ClientChannel')
    
  received: (data) ->
    if document.getElementById("user_" + data['user_id'])
      document.getElementById("user_" + data['user_id']).remove()
      $('#users-online').append data['user']
    else
      # Called when there's incoming data on the websocket for this channel
      console.log('Received message: ' + data['user'])
      $('#users-online').append data['user']