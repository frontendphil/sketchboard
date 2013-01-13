class Button extends UIObject

    constructor: (@attr = {}) ->
        super

        if @attr.click?
            @on "click", @attr.click

    create: ->
        button = $ "<button class='btn'>" + @attr.text + "</button>"

        conf =
            renderTo: button

        if @attr.default
            button.addClass "btn-primary"

        super conf