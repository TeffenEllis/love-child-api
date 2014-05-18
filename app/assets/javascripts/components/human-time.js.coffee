REFRESH_DELAY = 1000

LC.Components.HumanTime = React.createClass
  displayName: "humantime"

  getInitialState: ->
    {relativeTime: @humanize(@props.datetime)}

  componentDidMount: ->
    @interval = setInterval(@refresh, REFRESH_DELAY)

  componentWillUnmount: ->
    clearInterval @interval

  humanize: (datetime) ->
    moment(datetime).fromNow()

  refresh: ->
    @setState relativeTime: @humanize(@props.datetime)

  render: ->
    R.time {className: "human-time", dateTime: @props.datetime, title: @props.datetime},
      @state.relativeTime

