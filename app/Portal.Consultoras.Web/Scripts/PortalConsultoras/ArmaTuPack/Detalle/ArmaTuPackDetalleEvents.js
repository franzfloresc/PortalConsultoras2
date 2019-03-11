var ArmaTuPackDetalleEvents = function (){
    var self = {};
    
    self.eventName = {
        onGruposLoaded: "onGruposLoaded",
        onSelectedComponentsChanged: "onSelectedComponentsChanged"
    };

    registerEvent.call(self, self.eventName.onGruposLoaded);
    registerEvent.call(self, self.eventName.onSelectedComponentsChanged);

    return self;
};
