class Overlay extends UIObject

    constructor: (@facade, @slave, attrs = {}) ->
        width = @slave.getWidth() + (attrs.padding or 0)
        height = @slave.getHeight() + (attrs.padding or 0)

        super width, height

        @padding = attrs.padding

        @layout()

        @initEvents attrs
        @initMenu attrs.menu

    initMenu: (conf) ->
        @add new Menu conf

    initEvents: (attrs) ->
        @on "mouseout", =>
            @hide()

        @slave.on "move", =>
            @move attrs.padding

        # proyying disabled as overlay is actually shown behind_ the element
        # @proxy @slave, "click", "mousedown", "mouseup"

    layout: ->
        @move()

        # TODO: somewhat handle rotation of slave element

    move: ->
        position = @slave.getPosition()

        @moveTo
            x: position.x - @padding / 2
            y: position.y - @padding / 2

    create: (width, height) ->
        super
            cls: "x-overlay"
            styles:
                height: height + "px"
                width: width + "px"

        canvas = @facade.getCanvas()
        canvas.add @

        @hide()