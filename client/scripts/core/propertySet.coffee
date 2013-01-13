class PropertySet

    constructor: (properties = []) ->
        @properties = {}

        for property in properties
            @properties[property.id] = property

    add: (property) ->
        @properties[property.id] = property

    set: (id, value) ->
        @properties[id].set value

    get: (id) ->
        @properties[id].get()

    all: ->
        value for key, value of @properties