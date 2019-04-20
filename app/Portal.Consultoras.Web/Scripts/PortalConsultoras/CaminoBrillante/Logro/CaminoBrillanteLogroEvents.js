var CaminoBrillanteLogroEvents = function () {
    var self = {};

    self.eventName = {
        onLogroLoaded: "onLogroLoaded",
        showMedalla: "showMedalla",
        hideMedalla: "hideMedalla",        
        onShowWarnings: "onShowWarnings",
    };

    registerEvent.call(self, self.eventName.onLogroLoaded);
    registerEvent.call(self, self.eventName.showMedalla);
    registerEvent.call(self, self.eventName.hideMedalla);
    registerEvent.call(self, self.eventName.onShowWarnings);

    return self;
};