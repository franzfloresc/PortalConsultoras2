var CaminoBrillanteOfertaEvents = function () {
    var self = {};

    self.eventName = {
        onSelectedTabChanged: "onSelectedTabChanged",
        onKitsLoaded: "onKitsLoaded",
        onSelectedKitChanged: "onSelectedKitChanged",
        onDemostradorLoaded: "onDemostradorLoaded",
        onSelectedDemostradorChanged: "onSelectedDemostradorChanged",
        onShowWarnings: "onShowWarnings",
    };

    registerEvent.call(self, self.eventName.onSelectedTabChanged);
    registerEvent.call(self, self.eventName.onKitsLoaded);
    registerEvent.call(self, self.eventName.onSelectedKitChanged);
    registerEvent.call(self, self.eventName.onDemostradorLoaded);
    registerEvent.call(self, self.eventName.onSelectedDemostradorChanged);
    registerEvent.call(self, self.eventName.onShowWarnings);

    return self;
};