var ConstantesModule = (function () {
  
    var _codigosPalanca = {
        InicioRD: "INICIORD",
        Inicio: "INICIO",
        OfertasParaTi: "OPT",
        RevistaDigitalIntriga: "RDI",
        RevistaDigital: "RD",
        RevistaDigitalReducida: "RDR",
        RevistaDigitalSuscripcion: "RDS",
        Lanzamiento: "LAN",
        ValidacionMontoMaximo: "MMAX",
        OfertaFinalTradicional: "OFT",
        OfertaFinalCrossSelling: "OFC",
        OfertaFinalRegaloSorpresa: "OFR",
        OfertaFinalCrossSellingGanaMas: "OFCGM",
        ShowRoom: "SR",
        OfertaDelDia: "ODD",
        Informacion: "INFO",
        Descargables: "DES-NAV",
        GuiaDeNegocioDigitalizada: "GND",
        HerramientasVenta: "HV",
        PagoEnLinea: "PAYONLINE"
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
