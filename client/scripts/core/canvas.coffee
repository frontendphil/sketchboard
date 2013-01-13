class Canvas extends UIObject

    constructor: ->
        super
            renderTo: '.canvas'
            cls: "x-canvas-background"

        facade = new Facade
        facade.registerEntryPoint("getCanvas", => @)

        note = new Note facade,
            heading: "New Note",
            content: "My first note"

        note.rotate 15

        note.moveTo
            x: 300,
            y: 300

        @add note

        noteMenu = new NoteMenu facade
        @add noteMenu

        @events.push "note.added"

    add: ->
        super

        @raise "note.added"