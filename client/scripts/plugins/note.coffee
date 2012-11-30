class Note extends UIObject

    COLORS: ["yellow", "pink", "orange", "green", "blue", "white"]
    DEFAULT_COLOR: "yellow"

    constructor: (@facade, @attr = {}) ->
        super

        @initEvents()

    initEvents: ->
        if not @attr.thumbnail
            @draggable
                start: =>
                    @dragging = true
                    @overlay.hide()
                stop: =>
                    @dragging = false

                    @update()
                    @overlay.move()
                    @overlay.show()

            @on "mouseover", =>
                @showMenu()

            @facade.getCanvas().on "mouseup", =>
                @handleMouseUp()

            @on "mouseup", =>
                @handleMouseUp()

            @on "mousedown", =>
                @handleMouseDown()

    handleMouseDown: ->
        @clicking = yes

        window.setTimeout =>
            @clicking = no
        , 200

    handleMouseUp: ->
        if @clicking
            @handleClick

    handleClick: ->
        console.log "click"

    move: ->
        @moveTo
            x: @position.x + 100
            y: @position.y + 100

    create: ->
        head = $ "<h1/>"
        head.html @attr.heading

        text = $ "<p/>"
        text.html @attr.content

        super @getConf head, text

    getConf: (head, text) ->
        conf =
            cls: "x-note-wrap" + (if @attr.thumbnail then " x-note-thumb" else "")
            style: @attr.style or {}
            items: [
                cls: "x-note"
                style:
                    width: if @attr.width > 0 then @attr.width + "px" else ""
                    height: if @attr.height > 0 then @attr.height + "px" else ""
                items: [
                    cls: "x-note-body " + @getColor()
                    items: [head, text]
                ]
            ]

    getColor: ->
        color = (@attr.color or "").toLowerCase()
        color = if color in @COLORS then color else @DEFAULT_COLOR

        return "x-note-color-" + color

    showInfo: ->
        return

    rotate: (deg) ->
        @el.rotate deg

    showMenu: ->
        if @dragging
            return

        if not @overlay
            @overlay = new Overlay @facade, @,
                padding: 40
                menu:
                    items: [
                        icon: "edit",
                        click: =>
                            @showInfo
                    ]


        @overlay.show()

