class Form extends UIObject

    constructor: (@fields = []) ->
        super

        @events.push "save", "discard"

        @on "submit", =>
            @handleSubmit()

    handleSubmit: ->
        @save()

        return false

    create: ->
        form = $ "<form />"

        conf =
            renderTo: form,
            cls: "form-horizontal",
            items: field.getEditor() for field in @fields

        super conf

    save: ->
        field.save() for field in @fields

        @raise "save"

    discard: ->
        field.discard() for field in @fields

        @raise "discard"