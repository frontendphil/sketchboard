class PropertyEditor extends UIObject

    constructor: (@owner, @properties) ->
        super

    create: ->
        conf =
            cls: "x-property-editor"

        super conf
