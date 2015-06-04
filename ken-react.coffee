
browserTz = jstz.determine().name()

JamhubContainer = React.createClass
	render: -> React.createElement "div", className: "jamhubContainer",
		React.createElement JamStartDisplay, time: (this.state.jamStartTime - this.state.currentTime)
		if (this.state.jamStartTime - this.state.currentTime) < 0
			React.createElement ThemeDisplay, theme: this.state.theme
		React.createElement JamControls,
			handleThemeSubmit: this.handleThemeSubmit
			jamStartChange: this.handleJamStartChange
			jamStartTime: this.state.jamStartTime
		# React.createElement ThemeControl, onThemeSubmit: this.handleThemeSubmit
	handleJamStartChange: (newJamStartTime) ->
		this.setState jamStartTime: newJamStartTime
	handleThemeSubmit: (theme) ->
		this.setState theme: theme
	getInitialState: ->
		theme: ""
		currentTime: Date.now()
		jamStartTime: Date.now() + 10000
	componentDidMount: ->
		this.interval = setInterval(this.tick, 500)
	componentWillUnmount: ->
		clearInterval this.interval
	tick: ->
		this.setState({currentTime: Date.now()})
		#console.log this.state.currentTime


ThemeDisplay = React.createClass
	render: -> React.createElement "div", className: "themeDisplay", "The theme is: ", this.props.theme

JamStartDisplay = React.createClass
	render: ->
		# this.props.time is milliseconds until jam start
		d = this.props.time
		# ("0000" + num).substr(-4,4)

		days = (d / (1000 * 60 * 60 * 24))
		hours = (d / (1000 * 60 * 60)) % 24
		minutes = (d / (1000 * 60)) % 60
		seconds = (d / 1000) % 60

		dString = Math.floor(days) + " days, " + Math.floor(hours) + " hours, " + Math.floor(minutes) + " minutes, " + Math.floor(seconds) + " seconds"
		# dString = this.props.time
		if d > 0
			React.createElement "div", null, dString
		else
			React.createElement "div", null, "Time's up!"

React.render React.createElement(JamhubContainer), document.getElementById("jamhub")
