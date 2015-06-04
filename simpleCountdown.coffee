# this function takes in milliseconds and spits out a properly formatted string

simpleCountdown = (milliseconds) ->
	days = (milliseconds / (1000 * 60 * 60 * 24))
	hours = (milliseconds / (1000 * 60 * 60)) % 24
	minutes = (milliseconds / (1000 * 60)) % 60
	seconds = (milliseconds / 1000) % 60
	return dString = Math.floor(days) + " days, " + Math.floor(hours) + " hours, " + Math.floor(minutes) + " minutes, " + Math.floor(seconds) + " seconds"
