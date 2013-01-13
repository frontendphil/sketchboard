class Element

    BROWSER_PREFIXES = ["-moz-", "-webkit-", "-ms-", "-o-", ""]

    constructor: (@attr = {}) ->
        @create()

    create: ->
        if(@attr.renderTo)
            @dom = $(@attr.renderTo)
        else
            @dom = jQuery('<div/>')

        @dom.addClass @attr.cls or ''

        if @attr.buttons?
            @attr.items = @attr.items or []
            @attr.items.push new ButtonBar @attr.buttons

        if @attr.renderHidden
            $.extend @attr.styles,
                display: "none"


        @applyStyles(@dom, @attr.styles)

        if @attr.title
            @dom.attr "title", @attr.title

        for item in @attr.items or []
            if (item instanceof Element or item instanceof jQuery)
                @insert item
            else if item instanceof UIObject
                @insert item.el
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
        if not styles
            return

        collectedStyle = []

        for key, value of styles
            collectedStyle.push key + ": " + value

        element.attr "style", collectedStyle.join ";"

    addClass: (cls) ->
        @dom.addClass cls

    insert: (el) ->
        if el.dom then @dom.append(el.dom) else @dom.append(el)

    moveTo: (coord) ->
        if coord is "center"
            @dom.position
                my: "center",
                at: "center",
                of: @dom.parent()

            return

        style =
            'left': coord.x + 'px'
            'top': coord.y + 'px'

        @dom.css style

    getWidth: ->
        @dom.outerWidth()

    getHeight: ->
        @dom.outerHeight()

    hide: (effect) ->
        @dom.hide(effect)

    show: (effect) ->
        @dom.show(effect)

    visible: ->
        @dom.is(":visible")

    remove: ->
        @dom.remove()

    getCrossBrowserProperty: (name, value) ->
        property = {}

        $.each BROWSER_PREFIXES, ->
            property[@ + name] = value

        return property

    rotate: (deg, duration=0) ->
        if duration
            start = @rotation || 0
            end = deg

            frameLength = (1 / 25) * 1000

            delta = end - start
            stepSize = delta / (frameLength * duration)

            animFn = =>
                if delta > 0 && start >= end || delta < 0 && end >= start
                    window.clearInterval animFn

                    return

                start += stepSize

                @dom.css @getCrossBrowserProperty "transform", "rotate(" + start + "deg)"

            window.setInterval animFn, frameLength

            @rotation = deg

            return

        @rotation = deg

        @dom.css @getCrossBrowserProperty "transform", "rotate(" + deg + "deg)"

    isTarget: (element) ->
        @dom == element

    top: ->
        parseInt (@dom.css "top").replace "px", ""

    left: ->
        parseInt (@dom.css "left").replace "px", ""