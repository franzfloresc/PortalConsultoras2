
var ConstantesModule = (function() {
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
        SR: "ShowRoom",
        DuoPerfecto: "DuoPerfecto" //HD-3473 EINCA
    }

    var _keysLocalStorage = {
        GuiaDeNegocio: "GNDLista",
        HerramientasVenta: "HVLista",
        Lanzamiento: "LANLista",
        RevistaDigital: "RDLista",
        Ganadoras: "MGLista",
        //INI HD-3908
        PackNuevas: "PNLista",
        DuoPerfecto: "DPLista",
        //FIN HD-3908
        EstrategiaTemporal: 'EstrategiaTemporal',
        DescripcionProductoCatalogo: function (codigoCampania, codigoCuv) {
            var key = 'producto-catalogo-descripcion-' + codigoCampania + '-' + codigoCuv;
            return key;
        }
    }

    var _codigoVariedad = {
        IndividualVariable: "2001",
        ComuestaFija: "2002",
        CompuestaVariable: "2003"
    }

    // es homologo a DB TipoEstrategia, campo Codigo
    // es homologo a constantes.TipoEstrategiaCodigo
    // agregar a CodigoOrigenPedidoWeb diccionarioTipoEstrategiaPalanca
    // antiguo var _constantesPalanca = {
    var _codigoTipoEstrategia = {
        OfertaParaTi: "001",
        PackNuevas: "002",
        OfertaWeb: "003",
        ArmaTuPack: "004",
        Lanzamiento: "005",
        OfertasParaMi: "007",
        PackAltoDesembolso: "008",
        OfertaDelDia: "009",
        GuiaDeNegocioDigitalizada: "010",
        HerramientasVenta: "011",
        LosMasVendidos: "020",
        IncentivosProgramaNuevas: "021",
        Incentivos: "022",
        ShowRoom: "030",

        RevistaDigital: "101", // No tiene referencia con BD, caso particular de OfertasParaMi 007
        MasGanadoras: "201", // No tiene referecia con BD, caso particular de OfertasParaMi 007

        ProgramaNuevasRegalo: "044",
        ParticipaProgramaNuevas: "1",
        NotParticipaProgramaNuevas: "0",
        DuoPerfecto: "034" //HD-3473 EINCA
    }

    var _tipoPersonalizacion = {
        Catalogo: "CAT",
    };

    var _tipoPersonalizacionTexto = {
        Catalogo: "Catalogo",
    };

    var _diccionarioTipoEstrategia = [
        { codigo: _codigoTipoEstrategia.OfertaParaTi, texto: _codigoTipoEstrategiaTexto.OfertaParaTi },
        { codigo: _codigoTipoEstrategia.PackNuevas, texto: _codigoTipoEstrategiaTexto.PackNuevas },
        { codigo: _codigoTipoEstrategia.OfertaWeb, texto: _codigoTipoEstrategiaTexto.OfertaWeb },
        { codigo: _codigoTipoEstrategia.Lanzamiento, texto: _codigoTipoEstrategiaTexto.Lanzamiento },
        { codigo: _codigoTipoEstrategia.OfertasParaMi, texto: _codigoTipoEstrategiaTexto.OfertasParaMi },
        { codigo: _codigoTipoEstrategia.PackAltoDesembolso, texto: _codigoTipoEstrategiaTexto.PackAltoDesembolso },
        { codigo: _codigoTipoEstrategia.OfertaDelDia, texto: _codigoTipoEstrategiaTexto.OfertaDelDia },
        { codigo: _codigoTipoEstrategia.GuiaDeNegocioDigitalizada,texto: _codigoTipoEstrategiaTexto.GuiaDeNegocioDigitalizada },
        { codigo: _codigoTipoEstrategia.GuiaDeNegocioDigitalizada, texto: _codigoTipoEstrategiaTexto.GuiaNegocio },
        { codigo: _codigoTipoEstrategia.HerramientasVenta, texto: _codigoTipoEstrategiaTexto.HerramientasVenta },
        { codigo: _codigoTipoEstrategia.ShowRoom, texto: _codigoTipoEstrategiaTexto.ShowRoom },
        { codigo: _codigoTipoEstrategia.RevistaDigital, texto: _codigoTipoEstrategiaTexto.RevistaDigital },
        { codigo: _codigoTipoEstrategia.MasGanadoras, texto: _codigoTipoEstrategiaTexto.Ganadoras },
        { codigo: _tipoPersonalizacion.Catalogo, texto: _tipoPersonalizacionTexto.Catalogo }
    ];

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
        ATP: "ATP",
        DP: "DP",
        //INI HD-3908
        PN: "PN"
        //FIN HD-3908
    };

    var _urlObtenerEstrategia = {
        OfertaParaTi: "/Estrategia/OPTObtenerProductos",
        OfertasParaMi: "/Estrategia/RDObtenerProductos",
        Lanzamiento: "/Estrategia/LANObtenerProductos",
        GuiaDeNegocioDigitalizada: "/Estrategia/GNDObtenerProductos",
        HerrameintasVenta: "/Estrategia/HVObtenerProductos",
        MasGanadoras: "/Estrategia/MGObtenerProductos"
    };

    // en AnalyticsPortal.js tambiar actualizar los valores


    var _origenPedidoWeb = {
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
    };

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
        //obtenerEstrategiaFicha: '/Estrategia/ObtenerOfertaFicha'
    }

    var _urlPedido = {
        cargarDetallePedido: '/Pedido/CargarDetallePedido',
        ejecutarServicioProl: '/Pedido/EjecutarServicioPROL',
        updatePostulanteMensaje: '/Pedido/UpdatePostulanteMensaje'
    };

    var _getTipoPersonalizacionByTipoEstrategia = function(codigoTipoEstrategia) {

        var valor = _TipoEstrategiaTipoPersonalizacion.find(function(element) {
            return element.TipoEstrategia == codigoTipoEstrategia;
        });

        if (valor == undefined) {
            return "";
        }

        valor.TipoPersonalizacion || valor.Nombre || "";
    };

    var _mensajeAgregarPedido = {
        normal: '¡Listo! Agregaste con éxito a tu pedido.',
        reservado: '¡Listo! Agregaste con éxito a tu pedido reservado.'
    };

    var _mensajeModificarPedido = {
        normal: '¡Listo! Tu pedido ha sido modificado',
        reservado: '¡Listo! Tu pedido reservado ha sido modificado'
    };

    var _tiempo = {
        ToolTip: 2500
    };

    var _tipoSeccion = {
        Video: "01",
        Texto: "02"
    };

    var _tipoVentaIncremental = {
        CrossSelling: "CrossSell",
        Sugerido: "Suggested",
        UpSelling: "UpSelling"
    }

    return {
        CodigoPalanca: _codigoPalanca,
        TipoEstrategia: _codigoTipoEstrategia,
        TipoEstrategiaTexto: _codigoTipoEstrategiaTexto,
        KeysLocalStorage: _keysLocalStorage,
        CodigoVariedad: _codigoVariedad,
        OrigenPedidoWeb: _origenPedidoWeb,
        ConfiguracionOferta: _configuracionOferta,
        TipoAccionNavegar: _tipoAccionNavegar,
        EditarItemPedido: _editarItemPedido,
        UrlObtenerEstrategia: _urlObtenerEstrategia,
        UrlDetalleEstrategia: _urlDetalleEstrategia,
        UrlPedido: _urlPedido,
        DiccionarioTipoEstrategia: _diccionarioTipoEstrategia,
        GetTipoPersonalizacionByTipoEstrategia: _getTipoPersonalizacionByTipoEstrategia,
        MensajeAgregarPedido: _mensajeAgregarPedido,
        MensajeModificarPedido: _mensajeModificarPedido,
        Tiempo: _tiempo,
        TipoSeccion: _tipoSeccion,
        TipoVentaIncremental: _tipoVentaIncremental,
        TipoPersonalizacion: _tipoPersonalizacion,
        TipoPersonalizacionTexto: _tipoPersonalizacionTexto
    }
})();
