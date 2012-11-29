class Canvas extends AbstractElement

    constructor: ->
        super
            renderTo: '.canvas'
            cls: "x-canvas-background"

        facade = new Facade
        facade.registerEntryPoint("getCanvas", => @)

        note = new Note facade,
            heading: "New Note",
            content: "My first note"

        note.moveTo
            x: 300,
            y: 300

        @add note

        noteMenu = new NoteMenu facade
        @add noteMenu

