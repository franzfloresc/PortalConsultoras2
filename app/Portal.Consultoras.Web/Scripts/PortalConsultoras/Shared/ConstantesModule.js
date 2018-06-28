var ConstantesModule = (function() {
  
    var _codigosPalanca = {
        OfertaParaTi: "OfertaParaTi",
        PackNuevas: "PackNuevas", // Oferta Nueva Esika
        OfertaWeb: "OfertaWeb",
        Lanzamiento: "Lanzamiento",
        OfertasParaMi: "OfertasParaMi",
        PackAltoDesembolso: "PackAltoDesembolso",
        RevistaDigital: "RevistaDigital", // No tiene referecia con BD, es un grupo de estrategias
        LosMasVendidos: "LosMasVendidos",
        IncentivosProgramaNuevas: "IncentivosProgramaNuevas",
        OfertaDelDia: "OfertaDelDia",
        GuiaDeNegocioDigitalizada: "GuiaDeNegocioDigitalizada",
        Incentivos: "Incentivos",
        ShowRoom: "ShowRoom",
        HerramientasVenta: "HerramientasVenta",
        ProgramaNuevasRegalo: "ProgramaNuevasRegalo",
        ParticipaProgramaNuevas: "ParticipaProgramaNuevas",
        NotParticipaProgramaNuevas: "NotParticipaProgramaNuevas"
    }
    
    var _keysLocalStorage = {
        GuiaDeNegocio: "GNDLista",
        HerramientasVenta: "HVLista",
        Lanzamiento: "LANLista",
        RevistaDigital: "RDLista"
    }
    
    var _codigoVariedad = {
        IndividualVariable: "2001",
        ComuestaFija: "2002",
        CompuestaVariable: "2003"
    }
    
    return {
        CodigosPalanca: _codigosPalanca,
        KeysLocalStorage: _keysLocalStorage,
        CodigoVariedad: _codigoVariedad
    }
    
})();
