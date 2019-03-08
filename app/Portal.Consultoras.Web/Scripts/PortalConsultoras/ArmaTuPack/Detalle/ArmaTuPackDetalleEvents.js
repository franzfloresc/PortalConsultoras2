var ArmaTuPackDetalleEvents = function (){
    var self = {};
    
    self.eventName = {
        onGruposLoaded: "onGruposLoaded",
        onSelectedProductsChanged: "onSelectedProductsChanged"
    };

    registerEvent.call(self, self.eventName.onGruposLoaded);
    registerEvent.call(self, self.eventName.onSelectedProductsChanged);

    return self;
};
