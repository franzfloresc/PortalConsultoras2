var ArmaTuPackDetalleEvents = function (){
    var self = {};
    
    self.eventName = {
        onGruposLoaded: "onGruposLoaded",
        onGruposViewLoaded: "onGruposViewLoaded",
        onSelectedProductsChanged: "onSelectedProductsChanged"
    };

    registerEvent.call(self, self.eventName.onGruposLoaded);
    registerEvent.call(self, self.eventName.onGruposViewLoaded);
    registerEvent.call(self, self.eventName.onSelectedProductsChanged);

    return self;
};
