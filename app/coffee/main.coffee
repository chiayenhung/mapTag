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

getLocation = ->
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition showPosition

showPosition = (position) ->
	initialize(position.coords.latitude, position.coords.longitude)()

getLocation()
