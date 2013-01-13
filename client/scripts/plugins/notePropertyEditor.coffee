class PropertyEditor extends UIObject

    constructor: (@owner, @facade) ->
        super

        @events.push "cancel", "save"

        @facade.getCanvas().on "note.added", =>
            @form.discard()

    create: ->
        conf =
            cls: "x-property-editor"
            items: [
                cls: "x-property-editor-body",
                items: [@getForm()]
            ]
            buttons: [
                    text: "Cancel",
                    click: =>
                        @form.discard()
                ,
                    text: "Save",
                    click: =>
                        @form.save()

                    default: true
            ]

        super conf

    save: ->
        @hide "fade"

        @raise "save"

    discard: ->
        @hide "fade"

        @raise "cancel"

    layout: ->
        @moveTo
            x: @owner.getWidth() + 30
            y: 0

    getForm: ->
        if @form
            return @form

        @form = new Form @owner.properties.all()

        @form.on "save", =>
            @save()

        @form.on "discard", =>
            @discard()

        return @form