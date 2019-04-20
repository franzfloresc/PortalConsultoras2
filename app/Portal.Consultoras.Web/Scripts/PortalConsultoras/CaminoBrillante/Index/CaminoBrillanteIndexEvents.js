var CaminoBrillanteIndexEvents = function () {
    var self = {};

    self.eventName = {
        onNivelesLoaded: "onNivelesLoaded",
        onClickNivel: "onClickNivel",
        onClickOfertas: "onClickOfertas",
        onResumenLogrosLoaded: "onResumenLogrosLoaded",
        onClickLogro: "onClickLogro",
        onShowWarnings: "onShowWarnings",
    };

    registerEvent.call(self, self.eventName.onNivelesLoaded);
    registerEvent.call(self, self.eventName.onClickNivel);
    registerEvent.call(self, self.eventName.onClickOfertas);
    registerEvent.call(self, self.eventName.onResumenLogrosLoaded);
    registerEvent.call(self, self.eventName.onClickLogro);
    registerEvent.call(self, self.eventName.onShowWarnings);

    return self;
};