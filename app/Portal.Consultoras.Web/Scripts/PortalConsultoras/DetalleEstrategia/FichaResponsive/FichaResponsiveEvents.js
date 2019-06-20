var FichaResponsiveEvents = function (){
    var self = {};
    
    self.eventName = {
        onFichaResponsiveLoaded: "onFichaResponsiveLoaded",
        onCarruselDisplay: "onCarruselDisplay"
    };

    registerEvent.call(self, self.eventName.onFichaResponsiveLoaded);
    registerEvent.call(self, self.eventName.onCarruselDisplay);

    return self;
};
