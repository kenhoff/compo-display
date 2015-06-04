
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
		this.interval = setInterval(this.tick, 50)
	componentWillUnmount: ->
		clearInterval this.interval
	tick: ->
		this.setState({currentTime: Date.now()})
		#console.log this.state.currentTime

JamControls = React.createClass
	render: -> React.createElement "div", className: "jamControls",
		React.createElement ThemeControl,
			onThemeSubmit: this.handleThemeSubmit
		React.createElement JamStartControl,
			change: this.props.jamStartChange
			jamStartTime: this.props.jamStartTime
	handleThemeSubmit: (theme) ->
		this.props.handleThemeSubmit theme

ThemeDisplay = React.createClass
	render: -> React.createElement "div", className: "themeDisplay", "The theme is: ", this.props.theme

ThemeControl = React.createClass
	render: ->
		React.createElement("input", {className: "themeControl", ref: "themeText", onChange: this.handleSubmit})
	handleSubmit: (e) ->
		e.preventDefault()
		theme = React.findDOMNode(this.refs.themeText).value.trim()
		this.props.onThemeSubmit theme # calls the onthemesubmit function on the parent

JamStartControl = React.createClass
	componentDidMount: ->
		jamStartTime = moment(this.props.jamStartTime).format("YYYY-MM-DDTHH:mm")
		React.findDOMNode(this.refs.jamStartTime).value = jamStartTime
		# 2014-01-02T11:42
	render: -> React.createElement "input", {className: "jamStartControl", ref: "jamStartTime", onChange: this.change, type: "datetime-local"}, "jam start time"
	change: ->
		# console.log React.findDOMNode(this.refs.jamStartTime).value.trim()
		newStartTime = moment.tz React.findDOMNode(this.refs.jamStartTime).value.trim(), browserTz
		# newStartTime = React.findDOMNode(this.refs.jamStartTime).value.trim()
		this.props.change newStartTime.valueOf()

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
