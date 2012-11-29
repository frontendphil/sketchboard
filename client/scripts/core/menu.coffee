class Menu extends AbstractElement

    constructor: (@attrs = {}) ->
        @processItems @attrs.items

        delete attrs.items

        @attrs.cls = @attrs.cls or "x-menu"

        super

        @afterRender()

    afterRender: ->
        for item in @items
            @add item

    processItems: (items = []) ->
        @items = []

        for conf in items
            @items.push new MenuItem conf