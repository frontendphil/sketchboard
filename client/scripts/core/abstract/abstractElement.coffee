class AbstractElement extends Observable

    DOMEvents: ["mouseover", "mouseout", "click"]

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

    on: (name, clb) ->
        if name in @DOMEvents
            @el.on(name, clb)

            return

        super name, clb

    un: (name, clb) ->
        if name in @DOMEvents
            @el.un(name, clb)

    raise: ->
        name = arguments[0]
        args = ($ arguments).slice 1

        if name in @DOMEvents
            @el.raise name

            return

        super

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
                origin.raise e