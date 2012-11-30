class Observable

    constructor: ->
        @listeners = {};
        @events = []

    on: (name, callback) ->
        if name not in @events
            return

        if name not in @listeners
            @listeners[name] = []

        @listeners[name].push callback

    raise: (name) ->
        args = ($ arguments).slice 1

        callback.apply @, args for callback in @listeners[name] if @listeners[name]

    un: (name, callback) ->
        @listeners[name].pop callback if @listeners[name]