class Canvas extends Observable

    constructor: ->
        super

        @el = new Element({
            renderTo: '.canvas'
        })

        that = @

        facade = new Facade
        facade.registerEntryPoint("getCanvas", () -> that)

    setUp: ->
        @el.addClass "x-canvas-background"

    add: (child) ->
        @el.insert child.el
