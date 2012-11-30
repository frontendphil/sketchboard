class Element

    constructor: (@attr = {}) ->
        @create()

    create: ->
        if(@attr.renderTo)
            @dom = $(@attr.renderTo)
        else
            @dom = jQuery('<div/>')

        @dom.addClass @attr.cls or ''

        @applyStyles(@dom, @attr.styles or {})

        for item in @attr.items or []
            if (item instanceof Element or item instanceof jQuery)
                @insert item
            else
                @insert new Element(item)

    draggable: (opts = {}) ->
        @dom.draggable
            stop: opts.stop
            start: opts.start
            drag: opts.drag

        @dom.css "position", "absolute"

    on: (name, clb) ->
        @dom.on name, clb

    un: (name, clb) ->
        @dom.unbind name, clb

    raise: (name) ->
        @dom.trigger name

    applyStyles: (element, styles) ->
        collectedStyle = []

        for key, value of styles
            collectedStyle.push key + ": " + value

            element.attr("style", collectedStyle.join ";")

    addClass: (cls) ->
        @dom.addClass cls

    insert: (el) ->
        if el.dom then @dom.append(el.dom) else @dom.append(el)

    moveTo: (coord) ->
        style =
            'left': coord.x + 'px'
            'top': coord.y + 'px'

        @dom.css style

    getWidth: ->
        @dom.outerWidth()

    getHeight: ->
        @dom.outerHeight()

    hide: ->
        @dom.hide()

    show: ->
        @dom.show()

    rotate: (deg) ->
        return

    isTarget: (element) ->
        @dom == element

    top: ->
        parseInt (@dom.css "top").replace "px", ""

    left: ->
        parseInt (@dom.css "left").replace "px", ""