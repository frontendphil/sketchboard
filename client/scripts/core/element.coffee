class Element

    constructor: (@attr = {}) ->
        this.create()

    create: ->
        if(@attr.renderTo)
            @dom = $(@attr.renderTo)
        else
            @dom = jQuery('<div/>', class: @attr.cls or '')

        this.applyStyles(@dom, @attr.styles or {})

        for item in @attr.items or []
            do(item) ->
                if (item instanceof Element or item instanceof jQuery)
                    this.insert(item)
                else 
                    this.insert(new Element(item))

    applyStyles: (element, styles) ->
        collectedStyle = []

        for key, value of styles
            collectedStyle.push key + ": " + value

        element.writeAttribute("style", collectedStyle.join ";")

    addClass: (cls) ->
        @dom.addClassName cls

    insert: (el) ->
        if el.dom then @dom.insert(el.dom) else @dom.insert(el)

    moveTo: (coord) ->
        style =
            'margin-left': coord.x + 'px'
            'margin-top': coord.y + 'px'

        @dom.css style