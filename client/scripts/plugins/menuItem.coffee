class MenuItem extends UIObject

    constructor: (attrs = {}) ->
        attrs.cls = attrs.cls or "x-menu-item"

        super attrs

    create: (attrs) ->
        i = $ "<i/>",
            class: "icon-" + attrs.icon

        attrs.items = [i]

        super attrs


