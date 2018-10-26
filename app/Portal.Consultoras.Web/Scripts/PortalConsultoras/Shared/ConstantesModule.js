
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
        RevistaDigital: "RDLista",
        Ganadoras: "MGLista"
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
        MasGanadoras: "007",
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
        RD: "RD",
        HV: "HV",
        GND: "GN",
        LAN: "LAN",
        MG: "MG"
    }

    var _urlObtenerEstrategia = {
        OfertaParaTi: "/Estrategia/OPTObtenerProductos",
        OfertasParaMi: "/Estrategia/RDObtenerProductos",
        Lanzamiento: "/Estrategia/LANObtenerProductos",
        GuiaDeNegocioDigitalizada: "/Estrategia/GNDObtenerProductos",
        HerrameintasVenta: "/Estrategia/HVObtenerProductos"
    }

    var _origenPedidoWeb = {
        //OfertaDelDiaDesktopHomeBanner: "1191",
        //OfertaDelDiaDesktopPedidoBanner: "1291",
        //OfertaDelDiaDesktopGeneralBanner: "1991",
        DesktopHomeOfertaDeliaBannerSuperior: "1010306",
        DesktopPedidoOfertaDelDiaBannerSuperior: "1020306",
        DesktopOtrasOfertaDelDiaBannerSuperior: "1090306",

        DesktopContenedorGanadorasCarrusel: "1081401",
        DesktopContenedorGanadorasFicha: "1081402",
        DesktopLandingGanadorasGanadorasCarrusel: "1111401",
        DesktopLandingGanadorasGanadorasFicha: "1111402",
        MobileContenedorGanadorasCarrusel: "1081401",
        MobileContenedorGanadorasFicha: "1081402",
        MobileLandingGanadorasGanadorasCarrusel: "1111401",
        MobileLandingGanadorasGanadorasFicha: "1111402"
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
