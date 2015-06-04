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


JamControls = React.createClass
	render: -> React.createElement "div", className: "jamControls",
		React.createElement ThemeControl,
			onThemeSubmit: this.handleThemeSubmit
		React.createElement JamStartControl,
			change: this.props.jamStartChange
			jamStartTime: this.props.jamStartTime
	handleThemeSubmit: (theme) ->
		this.props.handleThemeSubmit theme
