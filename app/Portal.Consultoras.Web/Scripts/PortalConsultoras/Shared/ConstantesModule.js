﻿
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
        Ganadoras: "Ganadoras"
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
        MG: "MG",
        SR: "SR"
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
        MobileContenedorGanadorasCarrusel: "2081401",
        MobileContenedorGanadorasFicha: "2081402",
        MobileLandingGanadorasGanadorasCarrusel: "2111401",
        MobileLandingGanadorasGanadorasFicha: "2111402"
    }

    var _origenPedidoWebEstructura = {
        Dispositivo: {
            Desktop: '1',
            Mobile: '2'
        },
        Pagina: {
            LandingHerramientasVenta: '00',
            Home: '01',
            Pedido: '02',
            LandingLiquidacion: '03',
            Buscador: '04',
            LandingShowroom: '05',
            LandingGnd: '06',
            LandingOfertasParaTi: '07',
            Contenedor: '08',
            Otras: '09',
            LandingBuscador: '10',
            LandingGanadoras: '11'
        },
        Palanca: {
            OfertasParaTi: '00',
            Showroom: '01',
            Lanzamientos: '02',
            OfertaDelDia: '03',
            OfertaFinal: '04',
            GND: '05',
            Liquidacion: '06',
            ProductoSugerido: '07',
            HerramientasVenta: '08',
            Banners: '09',
            Digitado: '10',
            CatalogoLbel: '11',
            CatalogoEsika: '12',
            CatalogoCyzone: '13',
            Ganadoras: '14'
        },
        Seccion: {
            Carrusel: '01',
            Ficha: '02',
            Banner: '03',
            DesplegableBuscador: '04',
            CarruselVerMas: '05',
            BannerSuperior: '06',
            SubCampania: '07'
        }
    }

    return {
        CodigosPalanca: _codigosPalanca,
        KeysLocalStorage: _keysLocalStorage,
        CodigoVariedad: _codigoVariedad,
        ConstantesPalanca: _constantesPalanca,
        TipoEstrategia: _tipoEstrategia,
        UrlObtenerEstrategia: _urlObtenerEstrategia,
        OrigenPedidoWeb: _origenPedidoWeb,
        OrigenPedidoWebEstructura: _origenPedidoWebEstructura
    }

})();
