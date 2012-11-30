class UIObject extends Observable

    DOMEvents: ["mouseover", "mouseout", "click", "mousedown", "mouseup", "mousemove"]

    constructor: ->
        super

        @events.push "move", "add", "remove", "show", "hide", "render"

        @create.apply @, arguments

    create: (conf) ->
        @el = new Element conf
        @position =
            x: 0
            y: 0

        @raise "render", @

    draggable: (opts) ->
        @el.draggable opts

    on: (name, clb) ->
        if name in @DOMEvents
            @el.on(name, clb)

            return

        super

    un: (name, clb) ->
        if name in @DOMEvents
            @el.un(name, clb)

    raise: ->
        name = arguments[0]
        args = ($ arguments).slice 1

        if name in @DOMEvents
            @el.raise.apply @el, [name].concat args

            return

        super

    update: ->
        @position =
            x: @el.left()
            y: @el.top()

    add: (child) ->
        @el.insert child.el

        @raise "add", @

    remove: ->
        @el.remove()

        @raise "remove", @

    getWidth: ->
        @el.getWidth()

    getHeight: ->
        @el.getHeight()

    moveTo: (coord) ->
        @el.moveTo coord

        @position = coord

        @raise "move", @, coord

    getPosition: ->
        @position

    show: ->
        @el.show()

        @raise "show", @

    hide: ->
        @el.hide()

        @raise "hide", @

    proxy: ->
        origin = arguments[0]
        events = ($ arguments).slice 1

        for e in events
            @on e, ->
                args = $ arguments

                origin.raise.apply origin, [e].concat args