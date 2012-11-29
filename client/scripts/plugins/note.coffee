class Note extends AbstractElement

    COLORS: ["yellow", "pink", "orange", "green", "blue", "white"]
    DEFAULT_COLOR: "yellow"

    constructor: (@facade, @attr = {}) ->
        super

        @initEvents()

    initEvents: ->
        if not @attr.thumbnail
            @on "click", =>
                @move()

            @on "mouseover", =>
                @showMenu()

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

    showMenu: ->
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

