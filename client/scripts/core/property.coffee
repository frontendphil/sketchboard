class Property extends Observable

    constructor: (@id, @attr = {}) ->
        super

        @events.push "change"

        if @attr.ref?
            @dom = @attr.ref

        @set @attr.value

        @changed = no

    set: (value) ->
        if value is @value
            return

        @value = value

        @refreshDom value

    refreshDom: (value) ->
        if not @dom?
            return

        if @attr.multiline
            value = value.replace /\n/g, "<br />"

        @dom.html value

    get: ->
        @value

    getInput: ->
        switch @attr.type
            when "text"
                if @attr.multiline
                    return $ "<textarea id='" + @id + "' rows='6' />"

                return $ "<input type='text' id='" + @id + "' />"

    getEditor: ->
        group = $ "<div class='control-group'>" +
                    "<label class='control-label' for='" + @id + "'>" + @attr.name + "</label>" +
                    "<div class='controls'></div>" +
                  "</div>"

        @input = @getInput()
        @input.val @value

        (group.find ".controls").append @input

        return group

    discard: ->
        delete @input

    save: ->
        @set @input.val()
