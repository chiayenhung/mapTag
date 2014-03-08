initialize = (latitude, longitude) ->
	->
		latLng = new google.maps.LatLng(latitude, longitude)
		mapOptions =
			zoom: 15
			center: latLng

		map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
		marker = new google.maps.Marker
			position: latLng
			map: map
		infowindow = new google.maps.InfoWindow
			content: JST['InfoWindow']()
		google.maps.event.addListener marker, 'click', ->
			infowindow.open map, marker

  google.maps.event.addListener map, 'rightclick', (event) ->
    marker1 = new google.maps.Marker
      position: event.latLng
      map: map
    newInfoWindow = _.clone infowindow
    google.maps.event.addListener marker1, 'click', ->
      newInfoWindow.open map, marker1
      eventsBinding newInfoWindow

getLocation = ->
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition showPosition

showPosition = (position) ->
	initialize(position.coords.latitude, position.coords.longitude)()

eventsBinding = (infowindow) ->
    google.maps.event.addListener infowindow, 'domready', () ->
        $('.save_marker').off "click"
        $('.save_marker').on "click", (event) ->
            console.log 'save'
        $('.add_memo').off "click"
        $('.add_memo').on "click", (event) ->
            console.log "add_memo"
        $('.add_photo').off "click"
        $('.add_photo').on "click", (event) ->
            console.log "add_photo"
        $('.delete_location').off "click"
        $('.delete_location').on "click", (event) ->
            console.log "delete_location"


getLocation()
