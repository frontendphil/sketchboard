class Label extends UIObject

    create: (attr) ->
        label = $ "<label />"

        label.html attr.text

        $.extend attr,
            renderTo: label

        super attr