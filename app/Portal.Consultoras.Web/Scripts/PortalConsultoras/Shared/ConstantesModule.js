
var ConstantesModule = (function () {
  
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

    var _constantesPalanca = {
        OfertaParaTi: "001",
        PackNuevas: "002",
        OfertaWeb: "003",
        Lanzamiento: "005",
        OfertasParaMi: "007",
        PackAltoDesembolso: "008",
        RevistaDigital: "101",
        LosMasVendidos: "020",
        IncentivosProgramaNuevas: "021",
        OfertaDelDia: "009",
        GuiaDeNegocioDigitalizada: "010",
        Incentivos: "022",
        ShowRoom: "030",
        HerramientasVenta: "011",
        ProgramaNuevasRegalo: "044",
        ParticipaProgramaNuevas: "1",
        NotParticipaProgramaNuevas: "0"
    }

    var _tipoEstrategia = {
        rd: "rd",
        hv: "hv",
        gn: "gn",
        lan: "lan"
    }

    return {
        CodigosPalanca: _codigosPalanca,
        KeysLocalStorage: _keysLocalStorage,
        CodigoVariedad: _codigoVariedad,
        ConstantesPalanca: _constantesPalanca,
        TipoEstrategia: _tipoEstrategia
    }
    
})();
