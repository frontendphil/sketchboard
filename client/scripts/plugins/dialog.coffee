class Dialog extends UIObject

    constructor: (@facade, @attrs = {}) ->
        super @attrs

        canvas = @facade.getCanvas()

        @events.push "close"

        @on "show", =>
            canvas.mask()
            canvas.add @

            @moveTo "center"

        @on "close", =>
            canvas.unmask()

    create: (attr) ->
        $.extend attr,
            cls: "x-dialog-wrapper",
            items: [
                cls: "x-dialog",
                items: [
                    cls: "x-dialog-body",
                    items: [
                        new Label
                            text: attr.message
                    ]
                ],
                buttons: attr.buttons
            ]

        delete attr.buttons

        super attr

    close: ->
        @remove()

        @raise "close"