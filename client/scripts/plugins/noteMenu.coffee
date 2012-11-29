class NoteMenu extends AbstractElement

    constructor: (@facade, @attr = {}) ->
        super

    create: ->
        help = $ "<span/>"
        help.html "Notes are here"

        super @getConf help

        @addThumbs()

    addThumbs: ->
        notes = @getNoteThumbnails()

        position =
            x: 0
            y: 0

        padding = 30

        for note, index in notes
            @add note

    getConf: (help) ->
        conf =
            cls: "x-note-menu",
            items: [
                cls: "x-note-menu-help",
                items: [help]
            ]

    getNoteThumbnails: ->
        colors = Note.prototype.COLORS
        spacing = 120

        notes = []

        $.each colors, (index, color) =>
            notes.push new Note @facade,
                thumbnail: true,
                color: color,
                style:
                    "margin-left": index + spacing + "px"

        return notes