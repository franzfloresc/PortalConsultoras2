var OpcionesEvents = function () {
    var self = {};

    self.eventName = {
        onEstrategiaLoaded: "onEstrategiaLoaded",
        onOptionSelected: "onOptionSelected",
        onComponentSelected: "onComponentSelected"
    };

    registerEvent.call(self, self.eventName.onEstrategiaLoaded);
    registerEvent.call(self, self.eventName.onOptionSelected);
    registerEvent.call(self, self.eventName.onComponentSelected);

    return self;
};
