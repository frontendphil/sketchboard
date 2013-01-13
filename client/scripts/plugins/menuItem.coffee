class MenuItem extends UIObject

    constructor: (attrs = {}) ->
        attrs.cls = attrs.cls or "x-menu-item"

        super attrs

    create: (attrs) ->
        i = $ "<i/>",
            class: "icon-" + attrs.icon

        $.extend attrs,
            title: attrs.hint,
            items: [i]

        super attrs

        if attrs["click"]
            @on "click", attrs["click"]


