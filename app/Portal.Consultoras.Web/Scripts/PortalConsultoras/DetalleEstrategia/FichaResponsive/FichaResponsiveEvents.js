var FichaResponsiveEvents = function (){
    var self = {};
    
    self.eventName = {
        onFichaResponsiveLoaded: "onFichaResponsiveLoaded"
    };

    registerEvent.call(self, self.eventName.onFichaResponsiveLoaded);

    return self;
};
