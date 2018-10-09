
var ConstantesModule = (function () {
  
    var _codigosPalanca = {
        OfertaParaTi: "OfertaParaTi",
        PackNuevas: "PackNuevas", // Oferta Nueva Esika
        OfertaWeb: "OfertaWeb",
        Lanzamiento: "LoNuevoNuevo",
        OfertasParaMi: "OfertasParaMi",
        PackAltoDesembolso: "PackAltoDesembolso",
        RevistaDigital: "RevistaDigital", // No tiene referecia con BD, es un grupo de estrategias
        LosMasVendidos: "LosMasVendidos",
        IncentivosProgramaNuevas: "IncentivosProgramaNuevas",
        OfertaDelDia: "SoloHoy",
        GuiaDeNegocioDigitalizada: "GuiadeNegocio",
        Incentivos: "Incentivos",
        ShowRoom: "Especiales",
        HerramientasVenta: "Demostradores",
        ProgramaNuevasRegalo: "ProgramaNuevasRegalo",
        ParticipaProgramaNuevas: "ParticipaProgramaNuevas",
        NotParticipaProgramaNuevas: "NotParticipaProgramaNuevas",
        Ganadoras : "Ganadoras"
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

    var _urlObtenerEstrategia = {
        OfertaParaTi: "/Estrategia/OPTObtenerProductos",
        OfertasParaMi: "/Estrategia/RDObtenerProductos",
        Lanzamiento: "/Estrategia/RDObtenerProductosLan",
        GuiaDeNegocioDigitalizada: "/Estrategia/GNDObtenerProductos",
        HerrameintasVenta: "/Estrategia/HVObtenerProductos"
    }

    var _origenPedidoWeb = {
        OfertaDelDiaDesktopHomeBanner: "1191",
        OfertaDelDiaDesktopPedidoBanner: "1291",
        OfertaDelDiaDesktopGeneralBanner: "1991",

        MasGanadorasDesktopContenedorCarrusel: "1081401",
        MasGanadorasDesktopContenedorCarruselFicha: "1081402",
        MasGanadorasMobileContenedorCarruselFicha: "2081402",
        MasGanadorasDesktopLanding: "1111401",
        MasGanadorasDesktopLandingFicha: "1111402",
        MasGanadorasMobileLandingFicha: "2111402"
    }
    
    return {
        CodigosPalanca: _codigosPalanca,
        KeysLocalStorage: _keysLocalStorage, 
        CodigoVariedad: _codigoVariedad,
        ConstantesPalanca: _constantesPalanca,
        TipoEstrategia: _tipoEstrategia,
        UrlObtenerEstrategia: _urlObtenerEstrategia,
        OrigenPedidoWeb: _origenPedidoWeb
    }
    
})();
