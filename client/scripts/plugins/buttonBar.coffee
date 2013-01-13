class ButtonBar extends UIObject

    constructor: (@buttons = []) ->
        super

    create: ->
        conf =
            cls: "x-button-bar",
            items: [
                cls: "x-button-wrapper"
                items: (new Button config for config in @buttons)
            ]

        super conf

