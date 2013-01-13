class Mask extends UIObject

    constructor: (@attrs = {}) ->
        @attrs.cls = @attrs.cls or "x-mask"

        super @attrs