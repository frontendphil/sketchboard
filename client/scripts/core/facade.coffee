class Facade

    registerEntryPoint: (name, callback) ->
        @[name] = callback