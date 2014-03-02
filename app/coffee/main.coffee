something = () ->
  console.log "main.coffee"

$('a').click (event) ->
  event.preventDefault()
  something()
