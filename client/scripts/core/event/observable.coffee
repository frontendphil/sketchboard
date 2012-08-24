class Observable
    constructor: ->
        @listeners = {};

    observe: (name, callback) ->
        if(!name in @listeners)
            @listeners[name] = []

        @listeners[name].push callback

    fire: (name) ->
        args = arguments.slice 1
        that = this

        callback.apply that, args for callback in @listeners[name] if @listeners[name]

    removeListener: (name, callback) ->
        @listeners[name].pop callback if @listeners[name]