
browserTz = jstz.determine().name()

JamhubContainer = React.createClass
	render: -> React.createElement "div", className: "jamhubContainer",
		React.createElement JamStartDisplay, time: (this.state.jamStartTime - this.state.currentTime)
		React.createElement JamStartControl, change: this.handleJamStartChange, jamStartTime: this.state.jamStartTime
		React.createElement ThemeDisplay, theme: this.state.theme
		React.createElement ThemeControl, onThemeSubmit: this.handleThemeSubmit
	handleJamStartChange: (newJamStartTime) ->
		this.setState jamStartTime: newJamStartTime
	handleThemeSubmit: (theme) ->
		this.setState theme: theme
	getInitialState: ->
		theme: ""
		currentTime: Date.now()
		jamStartTime: Date.now()
	componentDidMount: ->
		setInterval(this.tick, 500)
	tick: ->
		this.setState({currentTime: Date.now()})
		#console.log this.state.currentTime

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
		console.log React.findDOMNode(this.refs.jamStartTime).value.trim()
		newStartTime = moment.tz React.findDOMNode(this.refs.jamStartTime).value.trim(), browserTz
		# newStartTime = React.findDOMNode(this.refs.jamStartTime).value.trim()
		this.props.change newStartTime.valueOf()

JamStartDisplay = React.createClass
	render: ->
		#d = moment(this.props.time).format("HH:mm:ss")
	
		d = moment.duration(this.props.time)
		# ("0000" + num).substr(-4,4)
		dString = d.hours() + ":" + d.minutes() + ":" + d.seconds() + ":" + d.milliseconds()
		React.createElement "div", null, dString

React.render React.createElement(JamhubContainer), document.getElementById("jamhub")
