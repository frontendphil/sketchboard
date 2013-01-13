class NoteMenu extends UIObject

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
            note = new Note @facade,
                thumbnail: true,
                color: color,
                style:
                    "margin-left": index + spacing + "px"

            note.on "click", =>
                @addNote(color)

            notes.push note

        return notes

    addNote: (color) ->
        note = new Note @facade,
            color: color
            heading: "New Note"
            content: "Your notes go here."

        canvas = @facade.getCanvas()

        canvas.add note

        note.moveTo
            x: canvas.getWidth() / 2 - note.getWidth() / 2
            y: canvas.getHeight() / 2 - note.getHeight() / 2