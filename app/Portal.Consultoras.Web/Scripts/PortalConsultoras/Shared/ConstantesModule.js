﻿
var ConstantesModule = (function () {
    // antiguo var _codigosPalanca = {
    var _codigoTipoEstrategiaTexto = {
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
        Ganadoras: "Ganadoras",
        LiquidacionWeb: "OfertasLiquidacion",
        GuiaNegocio: "GuiaNegocio",
        SR: "ShowRoom"
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

    // es homologo a DB TipoEstrategia, campo Codigo
    // es homologo a constantes.TipoEstrategiaCodigo
    // antiguo var _constantesPalanca = {
    var _codigoTipoEstrategia = {
        OfertaParaTi: "001",
        PackNuevas: "002",
        OfertaWeb: "003",
        ArmaTuPack: "004",
        Lanzamiento: "005",
        OfertasParaMi: "007",
        MasGanadoras: "007", // No tiene referecia con BD, caso particular de OfertasParaMi 007
        PackAltoDesembolso: "008",
        OfertaDelDia: "009",
        GuiaDeNegocioDigitalizada: "010",
        HerramientasVenta: "011",
        LosMasVendidos: "020",
        IncentivosProgramaNuevas: "021",
        Incentivos: "022",
        ShowRoom: "030",

        RevistaDigital: "101", // No tiene referecia con BD, caso particular de OfertasParaMi 007

        ProgramaNuevasRegalo: "044",
        ParticipaProgramaNuevas: "1",
        NotParticipaProgramaNuevas: "0"
    }

    var _configuracionOferta = {
        Web: 1701,
        Liquidacion: 1702,
        CrossSelling: 1703,
        Nueva: 1704,
        Flexipago: 1705,
        Accesorizate: 1706,
        ShowRoom: 1707,
    }

    // es homologo a DB ConfiguracionPais, campo Codigo
    // es homologo a constantes.ConfiguracionPais
    // antiguo var _tipoEstrategia = {
    var _codigoPalanca = {
        RD: "RD",
        HV: "HV",
        GND: "GND",
        LAN: "LAN",
        MG: "MG",
        SR: "SR",
        ATP: "ATP"
    }


    /// los que no tienen TipoPersonalizacion se pone texto
    var _TipoEstrategiaTipoPersonalizacion = [
        { TipoEstrategia: "001", TipoPersonalizacion: "OPT", Nombre: "" },
        { TipoEstrategia: "002", TipoPersonalizacion: "", Nombre: "PackNueva" },
        { TipoEstrategia: "003", TipoPersonalizacion: "" },
        { TipoEstrategia: "004", TipoPersonalizacion: "ATP" },
        { TipoEstrategia: "005", TipoPersonalizacion: "LAN" },
        { TipoEstrategia: "006", TipoPersonalizacion: "" },
        { TipoEstrategia: "007", TipoPersonalizacion: "OPM" },
        { TipoEstrategia: "008", TipoPersonalizacion: "PAD" },
        { TipoEstrategia: "009", TipoPersonalizacion: "ODD" },
        { TipoEstrategia: "010", TipoPersonalizacion: "GND" },
        { TipoEstrategia: "011", TipoPersonalizacion: "HV" },
        { TipoEstrategia: "020", TipoPersonalizacion: "", Nombre: "MasVendidos" },
        { TipoEstrategia: "021", TipoPersonalizacion: "", Nombre: "ProgramaNuevas" },
        { TipoEstrategia: "022", TipoPersonalizacion: "", Nombre: "Incentivos" },
        { TipoEstrategia: "030", TipoPersonalizacion: "SR" },
        { TipoEstrategia: "101", TipoPersonalizacion: "", Nombre: "RevistaDigital" },
        { TipoEstrategia: "201", TipoPersonalizacion: "", Nombre: "MasGanadoras" }
    ];

    var _urlObtenerEstrategia = {
        OfertaParaTi: "/Estrategia/OPTObtenerProductos",
        OfertasParaMi: "/Estrategia/RDObtenerProductos",
        Lanzamiento: "/Estrategia/LANObtenerProductos",
        GuiaDeNegocioDigitalizada: "/Estrategia/GNDObtenerProductos",
        HerrameintasVenta: "/Estrategia/HVObtenerProductos",
        MasGanadoras: "/Estrategia/MGObtenerProductos"
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
        MobileLandingGanadorasGanadorasFicha: "2111402",

        DesktopBuscadorGanadorasDesplegable: "1041404",
        MobileBuscadorGanadorasDesplegable: "2041404",
        DesktopBuscadorGanadorasFicha: "1041402",
        MobileBuscadorGanadorasFicha: "2041402",
        DesktopBuscadorGanadorasCarrusel: "1101401",
        MobileBuscadorGanadorasCarrusel: "2101401",
        DesktopLandingBuscadorGanadorasFicha: "1101402",
        MobileLandingBuscadorGanadorasFicha: "2101402"
    }
    var _codigoUbigeoPortal = {
        GuionPedidoGuionFichaResumida: "--02--00",
        GuionContenedorArmaTuPackGuion: "--0816--"
}

    // en AnaluticsPortal.js tambiar actualizar los valores
    var _origenPedidoWebEstructura = {
        Dimension: 7,
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

    var _tipoAccionNavegar = {
        BreadCrumbs: 1,
        Volver: 2
    };

    var _editarItemPedido = {
        Activo: 1,
        Inactivo: 2
    };

    var _urlDetalleEstrategia = {
        obtenerComponentes: '/DetalleEstrategia/ObtenerComponentes',
        obtenerComponenteDetalle: '/DetalleEstrategia/ObtenerComponenteDetalle',
        obtenerModelo: '/DetalleEstrategia/ObtenerModelo',
        obtenerPedidoWebSetDetalle: '/Pedido/ObtenerPedidoWebSetDetalle'
    }

    var _urlPedido = {
        cargarDetallePedido: '/Pedido/CargarDetallePedido',
        ejecutarServicioProl: '/Pedido/EjecutarServicioPROL',
        updatePostulanteMensaje: '/Pedido/UpdatePostulanteMensaje'
    }

    var _getTipoPersonalizacionByTipoEstrategia = function (codigoTipoEstrategia) {

        var valor = _TipoEstrategiaTipoPersonalizacion.find(function (element) {
            return element.TipoEstrategia == codigoTipoEstrategia;
        });

        if (valor == undefined) {
            return "";
        }

        valor.TipoPersonalizacion || valor.Nombre || "";
    };

    return {
        CodigoPalanca: _codigoPalanca,
        TipoEstrategia: _codigoTipoEstrategia,
        TipoEstrategiaTexto: _codigoTipoEstrategiaTexto,
        KeysLocalStorage: _keysLocalStorage,
        CodigoVariedad: _codigoVariedad,
        OrigenPedidoWeb: _origenPedidoWeb,
        OrigenPedidoWebEstructura: _origenPedidoWebEstructura,
        ConfiguracionOferta: _configuracionOferta,
        TipoAccionNavegar: _tipoAccionNavegar,
        EditarItemPedido: _editarItemPedido,
        UrlObtenerEstrategia: _urlObtenerEstrategia,
        UrlDetalleEstrategia: _urlDetalleEstrategia,
        UrlPedido: _urlPedido,
        GetTipoPersonalizacionByTipoEstrategia: _getTipoPersonalizacionByTipoEstrategia,
        CodigoUbigeoPortal: _codigoUbigeoPortal
    }
})();
