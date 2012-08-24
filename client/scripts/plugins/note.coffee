class Note extends Observable
    
    COLORS: ["yellow", "pink", "orange", "green", "blue", "white"]
    DEFAULT_COLOR: "yellow"

    constructor: (@facade, @attr = {}) ->
        supper @attr

        @.create()

    moveTo: (coord) ->
        @el.moveTo coord

    create: ->
        head = jQuery("<h1/>")
        head.html(@attr.heading)

        text = jQuery("<p/>")
        text.html(@attr.content)

        @el = new Element @getConf()

        @facade.getCanvas().add @

    getConf: ->
        conf = 
            cls: "x-note-wrap"
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

