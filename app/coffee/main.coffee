map = {}


initialize = (latitude, longitude) ->
	->
		mapOptions =
			zoom: 8
			center: new google.maps.LatLng(latitude, longitude)

		map = new google.maps.Map document.getElementById('map-canvas'), mapOptions

# google.maps.event.addDomListener window, 'load', initialize(-34.397, 150.644)

getLocation = ->
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition showPosition

showPosition = (position) ->
	google.maps.event.addDomListener window, 'load', initialize(position.coords.latitude, position.coords.longitude)

getLocation()