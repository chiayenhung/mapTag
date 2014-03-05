initialize = (latitude, longitude) ->
	->
		mapOptions =
			zoom: 15
			center: new google.maps.LatLng(latitude, longitude)

		map = new google.maps.Map document.getElementById('map-canvas'), mapOptions

getLocation = ->
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition showPosition

showPosition = (position) ->
	initialize(position.coords.latitude, position.coords.longitude)()

getLocation()