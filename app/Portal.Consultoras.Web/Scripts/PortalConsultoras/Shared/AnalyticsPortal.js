﻿
if (!jQuery) { throw new Error("AnalyticsPortal.js requires jQuery"); }

+function ($) {
    "use strict";
}(window.jQuery);

var AnalyticsPortalModule = (function () {
    var _evento = {
        virtualEvent: "virtualEvent",
        virtualRemoveEvent: "removeFromCart",
        socialEvent: "socialEvent",
        addToCart: "addToCart",
        productImpression: "productImpression",
        productClick: "productClick",
        productDetails: "productDetails",
        promotionView: "promotionView",
        promotionClick: "promotionClick",
        productCheckout: "productCheckout"
    };

    var _texto = {
        excepcion: "Excepción en AnalyticsPortal.js > ",
        estandar: "Estándar",
        fichaProducto: "Ficha de Producto",
        iniciarVideo: "Iniciar Video",
        migajaPan: "Breadcrumb",
        // Ini - Analytics Buscador Miguel
        notavaliable: "(not available)",
        // Fin - Analytics Buscador Miguel
        // Ini - Analytics Ofertas (Miguel)
        contenedor: "Contenedor",
        contenedorHome: "Contenedor - Inicio",
        contenedorDetalle: "Contenedor - Detalle de Producto",
        contenedorDetalleSets: "Contenedor - Detalle de Producto - Ver más Sets",
        contenedorRevisar: "Contenedor - Revisar",
        contenedorMasGanadoras: "Más Ganadoras",
        contenedorfichaProducto: "Contenedor - Ficha de producto",
        CarritoCompras: "Carrito de compras",
        siguiente: "Ver siguiente",
        anterior: "Ver anterior",
        duoPerfecto: "Dúo Perfecto",
        palancaLasMasGandoras: "Más Ganadoras",
        armaTuDuoPerfecto: 'Arma tu Dúo Perfecto - Dúo Perfecto'

        // Fin - Analytics Ofertas (Miguel)
    };

    // Inicio - Analytics Home 1 (Miguel)
    var _codigoSeccion = {
        LAN: "LAN",
        HV: "HV",
        RD: "RD",
        SR: "SR",
        ODD: "ODD",
        GND: "GND",
        MG: "MG",
        Ficha: "FICHA",
        DP: "DP"
    };
    // Fin - Analytics Home 1 (Miguel)

    var _constantes = {
        // Ini - Analytics Buscador Miguel
        isTest: false, //Desactivar
        currencyCodes: [
            { "CountryCode": "BO", "Code": "BOB" },
            { "CountryCode": "CL", "Code": "CLP" },
            { "CountryCode": "CO", "Code": "COP" },
            { "CountryCode": "CR", "Code": "CRC" },
            { "CountryCode": "DO", "Code": "DOP" },
            { "CountryCode": "EC", "Code": "ECS" },
            { "CountryCode": "GT", "Code": "GTQ" },
            { "CountryCode": "MX", "Code": "MXN" },
            { "CountryCode": "PA", "Code": "USD" },
            { "CountryCode": "PE", "Code": "PEN" },
            { "CountryCode": "PR", "Code": "USD" },
            { "CountryCode": "SV", "Code": "SVC" }
        ],
        seccionesPalanca: [
            { "CodigoSeccion": "ODD", "Palanca": "Oferta Del Día" },
            { "CodigoSeccion": "SR", "Palanca": "Showroom" },
            { "CodigoSeccion": "DP", "Palanca": "Dúo Perfecto" }
        ],
        origenpedidoWeb: [
            { "CodigoPalanca": "00", "Palanca": "Ofertas Para Ti" },
            { "CodigoPalanca": "01", "Palanca": "Showroom" },
            { "CodigoPalanca": "02", "Palanca": "Lanzamientos" },
            { "CodigoPalanca": "03", "Palanca": "Oferta Del Día" },
            { "CodigoPalanca": "04", "Palanca": "Oferta Final" },
            { "CodigoPalanca": "05", "Palanca": "GND" },
            { "CodigoPalanca": "06", "Palanca": "Liquidación" },
            { "CodigoPalanca": "07", "Palanca": "Producto Sugerido" },
            { "CodigoPalanca": "08", "Palanca": "Herramientas de Venta" },
            { "CodigoPalanca": "09", "Palanca": "Banners" },
            { "CodigoPalanca": "10", "Palanca": "Digitado" },
            { "CodigoPalanca": "11", "Palanca": "Catalogo Lbel" },
            { "CodigoPalanca": "12", "Palanca": "Catalogo Esika" },
            { "CodigoPalanca": "13", "Palanca": "Catalogo Cyzone" },
            { "CodigoPalanca": "14", "Palanca": "Más Ganadoras" },
            { "CodigoPalanca": "15", "Palanca": "" },
            { "CodigoPalanca": "16", "Palanca": "Dúo Perfecto" },
            { "CodigoPalanca": "17", "Palanca": "Pack de Nuevas" },
        ],
        origenpedidoWebHome: [
            { "Codigo": "010306", "Descripcion": "Banner Header" },
            { "Codigo": "010601", "Descripcion": "Liquidaciones Web" },
            { "Codigo": "010001", "Descripcion": "Club GANA+" }
        ],
        origenpedidoWebEstrategia: [
            { "Codigo": "1020001", "Descripcion": "Desktop Pedido Ofertas Para Ti Carrusel" },
            { "Codigo": "2020001", "Descripcion": "Mobile Pedido Ofertas Para Ti Carrusel" }
        ],
        paginas: [
            { "CodigoPagina": "00", "Pagina": "Landing Herramientas de Venta" },
            { "CodigoPagina": "01", "Pagina": "Home" },
            { "CodigoPagina": "02", "Pagina": "Pedido" },
            { "CodigoPagina": "03", "Pagina": "Landing Liquidación" },
            { "CodigoPagina": "04", "Pagina": "Buscador" },
            { "CodigoPagina": "05", "Pagina": "Landing Showroom" },
            { "CodigoPagina": "06", "Pagina": "Landing GND" },
            { "CodigoPagina": "07", "Pagina": "Landing Ofertas Para Ti" },
            { "CodigoPagina": "08", "Pagina": "Contenedor" },
            { "CodigoPagina": "09", "Pagina": "Otras" },
            { "CodigoPagina": "10", "Pagina": "Landing Buscador" },
            { "CodigoPagina": "11", "Pagina": "Landing Ganadoras" },
            { "CodigoPagina": "12", "Pagina": "" },
            { "CodigoPagina": "13", "Pagina": "" },
            { "CodigoPagina": "14", "Pagina": "Landing Dúo Perfecto" },
            { "CodigoPagina": "15", "Pagina": "Landing Pack de Nuevas" }
        ],
        secciones: [
            { "CodigoSeccion": "01", "Seccion": "Carrusel" },
            { "CodigoSeccion": "02", "Seccion": "Ficha" },
            { "CodigoSeccion": "03", "Seccion": "Banner" },
            { "CodigoSeccion": "04", "Seccion": "Desplegable Buscador" },
            { "CodigoSeccion": "05", "Seccion": "Carrusel Ver Más" },
            { "CodigoSeccion": "06", "Seccion": "Banner Superior" },
            { "CodigoSeccion": "07", "Seccion": "Sub Campaña" }
        ],
        codigoPais: function () {
            return !(typeof variablesPortal === 'undefined') ? variablesPortal.PaisISO : "";
        },
        // Fin - Analytics Buscador Miguel
        // Ini - Analytics Ofertas
        campania: "Campaña ",
        IdBannerGanadorasVerMas: "000123",
        IdBannerArmaTuPack: "000124",
        // Fin - Analytics Ofertas
        IdBennerDuoPerfecto: "347301"
    };

    var _origenPedidoWebEstructura = {
        Dispositivo: [
            { "Codigo": "1", "TextoList": "" },
            { "Codigo": "2", "TextoList": "" }
        ],
        Pagina: [
            { "Codigo": "00", "TextoList": "" },
            { "Codigo": "01", "TextoList": "Home" },
            { "Codigo": "02", "TextoList": "Carrito de Compras" },
            { "Codigo": "03", "TextoList": "" },
            { "Codigo": "04", "TextoList": "Showroom" },
            { "Codigo": "05", "TextoList": "" },
            { "Codigo": "06", "TextoList": "" },
            { "Codigo": "07", "TextoList": "" },
            { "Codigo": "08", "TextoList": "Inicio" },
            { "Codigo": "09", "TextoList": "Otras Paginas" },
            { "Codigo": "10", "TextoList": "" },
            { "Codigo": "11", "TextoList": "" }
        ],
        Palanca: [
            { "Codigo": "00", "CodigoPalanca": "RD", "TextoList": "Ofertas Para Ti" },
            { "Codigo": "01", "CodigoPalanca": "SR", "TextoList": "Showroom" },
            { "Codigo": "02", "CodigoPalanca": "LAN", "TextoList": "Lanzamientos" },
            { "Codigo": "03", "CodigoPalanca": "ODD", "TextoList": "Oferta del Día" },
            { "Codigo": "04", "CodigoPalanca": "OF", "TextoList": "" },
            { "Codigo": "05", "CodigoPalanca": "GND", "TextoList": "GND" },
            { "Codigo": "06", "CodigoPalanca": "", "TextoList": "Liquidaciones Web" },
            { "Codigo": "07", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "08", "CodigoPalanca": "HV", "TextoList": "Herramientas de Venta" },
            { "Codigo": "09", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "10", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "11", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "12", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "13", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "14", "CodigoPalanca": "MG", "TextoList": "Más Ganadoras" },
            { "Codigo": "15", "CodigoPalanca": "", "TextoList": "" },
            { "Codigo": "16", "CodigoPalanca": "DP", "TextoList": "Dúo Perfecto" },
            { "Codigo": "17", "CodigoPalanca": "PN", "TextoList": "Pack de Nuevas" }
        ],
        Seccion: [
            { "Codigo": "01", "TextoList": "" },
            { "Codigo": "02", "TextoList": "Detalle de Producto" },
            { "Codigo": "03", "TextoList": "" },
            { "Codigo": "04", "TextoList": "" },
            { "Codigo": "05", "TextoList": "Detalle de Producto - Ver más sets" },
            { "Codigo": "06", "TextoList": "" },
            { "Codigo": "07", "TextoList": "" }
        ]
    }

    var _urlPaginas = [
        { Codigo: "00", UrlController: "RevistaDigital" },
        { Codigo: "01", UrlController: "ShowRoom" },
        { Codigo: "02", UrlController: "" },
        { Codigo: "03", UrlController: "" },
        { Codigo: "04", UrlController: "" },
        { Codigo: "05", UrlController: "GuiaNegocio" },
        { Codigo: "06", UrlController: "OfertaLiquidacion" },
        { Codigo: "07", UrlController: "" },
        { Codigo: "08", UrlController: "HerramientasVenta" },
        { Codigo: "09", UrlController: "" },
        { Codigo: "10", UrlController: "" },
        { Codigo: "11", UrlController: "" },
        { Codigo: "12", UrlController: "" },
        { Codigo: "13", UrlController: "" },
        { Codigo: "14", UrlController: "MasGanadoras" },
        { Codigo: "15", UrlController: "" },
        { Codigo: "16", UrlController: "" },
        { Codigo: "17", UrlController: "" }
    ]

    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Metodos Iniciales
    ////////////////////////////////////////////////////////////////////////////////////////
    var _getIdPalancaSegunCodigo = function (codigo) {
        var total = _origenPedidoWebEstructura.Palanca.length;
        for (var i = 0; i < total; i++) {
            var item = _origenPedidoWebEstructura.Palanca[i];
            if (item.CodigoPalanca == codigo) {
                return item.Codigo;
            }
        }

        return "";
    };

    var _getEstructuraOrigenPedidoWeb = function (origen, url) {
        var origenEstructura = {};

        if (typeof origen === "object") {
            origenEstructura = origen || {};
        }
        else {
            origenEstructura.OrigenPedidoWeb = origen || "";
        }

        origenEstructura.OrigenPedidoWeb = (origenEstructura.OrigenPedidoWeb || "").toString().trim();
        origenEstructura.CodigoPalanca = (origenEstructura.CodigoPalanca || "").toString().trim();

        if (origenEstructura.OrigenPedidoWeb.length < ConstantesModule.OrigenPedidoWebEstructura.Dimension) {
            origenEstructura.OrigenPedidoWeb = "";
        }

        var codigoOrigenPedido = origenEstructura.OrigenPedidoWeb;

        origenEstructura.Pagina = (origenEstructura.Pagina || codigoOrigenPedido.substring(1, 3)).toString().trim();
        origenEstructura.Palanca = (origenEstructura.Palanca || codigoOrigenPedido.substring(3, 5)).toString().trim();
        origenEstructura.Seccion = (origenEstructura.Seccion || codigoOrigenPedido.substring(5, 7)).toString().trim();

        if (origenEstructura.Palanca == "" && url != "") {
            origenEstructura.Palanca = _getCodigoPalancaSegunUrl(url);
        }

        if (origenEstructura.Palanca == "" && origenEstructura.CodigoPalanca != "") {
            origenEstructura.Palanca = _getIdPalancaSegunCodigo(origenEstructura.CodigoPalanca);
        }

        if (origenEstructura.Pagina == "" && url != "") {
            switch (window.controllerName) {
                case "ofertas": origenEstructura.Pagina = ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor; break;
            }
        }

        return origenEstructura;
    }

    var _getTextoContenedorSegunOrigen = function (origenEstructura) {

        origenEstructura.CodigoPalanca = origenEstructura.CodigoPalanca || "";
        var contendor = origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.Contenedor
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingBuscador
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingGanadoras
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingGnd
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingHerramientasVenta
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingLiquidacion
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingOfertasParaTi
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingDuoPerfecto
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingPackNuevas
            || origenEstructura.Pagina == ConstantesModule.OrigenPedidoWebEstructura.Pagina.LandingShowroom
            || origenEstructura.Seccion == ConstantesModule.OrigenPedidoWebEstructura.Seccion.Ficha
            || origenEstructura.Seccion == ConstantesModule.OrigenPedidoWebEstructura.Seccion.CarruselVerMas
            || origenEstructura.CodigoPalanca != "";

        if (contendor) {
            return _texto.contenedor;
        }

        return "";
    }

    var _getTextoPaginaSegunOrigen = function (origenEstructura) {

        var obj = _origenPedidoWebEstructura.Pagina.find(function (element) {
            return element.Codigo == origenEstructura.Pagina;
        });

        if (obj == undefined) {
            return "";
        }

        return obj.TextoList || "";
    }

    var _getTextoPalancaSegunOrigen = function (origenEstructura) {

        var obj = _origenPedidoWebEstructura.Palanca.find(function (element) {
            return element.Codigo == origenEstructura.Palanca;
        });

        if (obj == undefined && origenEstructura.CodigoPalanca != "") {
            var obj = _origenPedidoWebEstructura.Palanca.find(function (element) {
                return element.CodigoPalanca == origenEstructura.CodigoPalanca;
            });
        }

        if (obj == undefined) {
            return "";
        }

        return obj.TextoList || "";
    }

    var _getTextoSeccionSegunOrigen = function (origenEstructura) {

        var obj = _origenPedidoWebEstructura.Seccion.find(function (element) {
            return element.Codigo == origenEstructura.Seccion;
        });

        if (obj == undefined) {
            return "";
        }

        return obj.TextoList || "";
    }

    var _getCodigoPalancaSegunUrl = function (url) {

        url = url || "";
        var partes = url.split('/');
        var controlador = "";
        $.each(partes, function (index, campo) {
            campo = campo.toLocaleLowerCase();
            if (controlador == "" && campo != "" && campo != "mobile") {
                controlador = campo;
            }
        });

        var controller = controlador || window.controllerName || "";
        controller = controller.toLocaleLowerCase();

        var seccion = _urlPaginas.find(function (element) {
            return element.UrlController.toLocaleLowerCase() == controller;
        });

        if (seccion == undefined) {
            return "";
        }

        return seccion.Codigo || "";
    }

    var _getParametroListSegunOrigen = function (origenEstructura, url, estoyEnLaFicha) {

        origenEstructura = _getEstructuraOrigenPedidoWeb(origenEstructura, url);

        if (estoyEnLaFicha === true) {
            origenEstructura.Seccion = ConstantesModule.OrigenPedidoWebEstructura.Seccion.CarruselVerMas;
        }

        var contendor = _getTextoContenedorSegunOrigen(origenEstructura);
        var pagina = "";

        if (origenEstructura.Seccion == ConstantesModule.OrigenPedidoWebEstructura.Seccion.CarruselVerMas) {
            pagina = _getTextoSeccionSegunOrigen(origenEstructura);
        }
        else {
            pagina = _getTextoPaginaSegunOrigen(origenEstructura);
        }

        var palanca = _getTextoPalancaSegunOrigen(origenEstructura);

        var separador = " - ";
        var texto = contendor;

        texto += texto != ""
            ? ((pagina != "" ? separador : "") + pagina)
            : pagina;

        texto += texto != ""
            ? ((palanca != "" ? separador : "") + palanca)
            : palanca;

        return texto;
    }

    var marcarIniciarPlayVideo = function (producto) {
        try {
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": _texto.fichaProducto,
                "action": _texto.iniciarVideo,
                "label": producto
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    //var _marcarProductImpresionSegunLista = function (data) {
    //    try {
    //        if (_constantes.isTest)
    //            alert("Marcación product impression.");

    //        var parametroList = _getParametroListSegunOrigen(data.Origen);

    //        var lista = data.lista;
    //        var cantidadMostrar = lista.length == 1 ? 1 : data.CantidadMostrar;
    //        var impressions = [];
    //        $.each(lista, function (index) {
    //            if (index < cantidadMostrar) {
    //                var item = lista[index];
    //                var impression = {
    //                    'name': item.DescripcionCompleta,
    //                    'id': item.CUV2,
    //                    'price': item.PrecioVenta,
    //                    'brand': item.DescripcionMarca,
    //                    'category': _texto.notavaliable,
    //                    'variant': _texto.estandar,
    //                    'list': parametroList,
    //                    'position': (item.Position == undefined ? index : item.Position) + 1
    //                };

    //                impressions.push(impression);
    //            }
    //        });

    //        _marcarImpresionSetProductos(impressions);

    //        if (data.Direccion != undefined) {

    //            var paramlabel = "Flecha Anterior";
    //            if (data.Direccion == CarruselVariable.Direccion.next) {
    //                paramlabel = "Flecha Siguiente";
    //            }

    //            dataLayer.push({
    //                'event': _evento.virtualEvent,
    //                'category': parametroList,
    //                'action': "Flecha de Productos",
    //                'label': paramlabel
    //            });
    //        }

    //    } catch (e) {
    //        console.log("marcarProductImpresionSegunLista" + _texto.excepcion + e);
    //    }

    //}

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Metodos Iniciales
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Add To Cart
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcaAnadirCarritoBuscador = function (model, origen, campoBuscar) {
        try {
            var desplegable = "";
            if ($.isNumeric(campoBuscar) && campoBuscar.length == 5)
                desplegable = " por CUV";
            var palanca;
            if (model.CodigoTipoEstrategia === "0") palanca = model.DescripcionEstrategia;
            else palanca = _obtenerNombrePalanca(model.CodigoTipoEstrategia);

            if (model.MaterialGanancia || model.Palanca == 'Ganadoras') palanca = _texto.palancaLasMasGandoras;

            var lista = "Buscador - " + palanca + " - " + origen + desplegable;
            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': lista },
                        'products': [{
                            'name': model.DescripcionCompleta,
                            'id': model.CUV,
                            'price': parseFloat(model.Precio).toFixed(2).toString(),
                            'brand': _getMarca(model.MarcaId),
                            'category': _texto.notavaliable,
                            'variant': campoBuscar,
                            'quantity': model.Cantidad
                        }]
                    }
                }
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaAnadirCarritoRecomendaciones = function (divPadre, valueJSON) {
        try {
            var model = JSON.parse($(divPadre).find(valueJSON).val());
            var cantidad = $(divPadre).find("[data-input='cantidad']").val();
            var agregado = $(divPadre).find(".etiqueta_buscador_producto");
            model.Cantidad = cantidad;

            var lista = "Pedido - Ofertas Relacionadas";
            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': lista },
                        'products': [{
                            'name': model.DescripcionCompleta,
                            'id': model.CUV,
                            'price': parseFloat(model.Precio).toFixed(2).toString(),
                            'brand': _getMarca(model.MarcaId),
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': model.Cantidad
                        }]
                    }
                }
            });
        } catch (e) {
            console.error(e);
        }
    }
    var marcaAnadirCarritoHome = function (event, codigoOrigen, data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic añadir al carrito.");

            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigen);
            var producto = data;

            list = "Home" + " - " + palanca;

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': producto.DescripcionCompleta,
                            'price': producto.PrecioVenta,
                            'brand': producto.DescripcionMarca,
                            'id': producto.CUV2,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': producto.Cantidad
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    var marcaAnadirCarritoHomeBanner = function (event, codigoOrigen, data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic añadir al carrito.");

            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigen);
            var producto = data;

            list = "Home - Oferta del Día";

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': producto.DescripcionCompleta,
                            'price': producto.PrecioVenta,
                            'brand': producto.DescripcionMarca,
                            'id': producto.CUV2,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': producto.Cantidad
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }
    
    var marcaAnadirCarritoLiquidacion = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic añadir al carrito.");


            list = "Home" + " - " + "Liquidaciones Web";

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': data.descripcionProd,
                            'price': data.PrecioUnidad,
                            'brand': data.descripcionMarca,
                            'id': data.CUV,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': data.Cantidad
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }


    var marcaAnadirCarrito = function (event, codigoOrigen, data) {

        try {
            if (_constantes.isTest)
                alert("Marcación clic añadir al carrito.");

            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigen);
            var contenedor = AnalyticsPortalModule.GetContenedorByOrigenPedido(event, codigoOrigen);

            var codigoPalanca = codigoOrigen.toString().substring(3, 5);
            var seccion = _constantes.origenpedidoWeb.find(function (element) {
                return element.CodigoPalanca === codigoPalanca;
            });

            var esCarrusel = false;
            if (!(event == null)) {
                var elementCarrusel = $(event.target || event).parents("[data-item]");
                esCarrusel = elementCarrusel.hasClass("slick-slide");
            }

            var producto = data;
            var list = "";
            //Si es carrusel de la ficha
            if (esCarrusel && seccion.CodigoPalanca !== _constantes.origenpedidoWeb[parseInt(codigoPalanca)].CodigoPalanca)
                list = contenedor + " - " + _constantes.campania + producto.CampaniaID;
            else if (seccion.CodigoPalanca === _constantes.origenpedidoWeb[parseInt(codigoPalanca)].CodigoPalanca)
                list = contenedor + " - " + palanca;
            else
                list = contenedor + " - " + palanca + " - " + _constantes.campania + producto.CampaniaID;

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': producto.DescripcionCompleta,
                            'price': producto.PrecioVenta,
                            'brand': producto.DescripcionMarca,
                            'id': producto.CUV2,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': producto.Cantidad
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }
    
    function clickAddCartFicha(event, codigoOrigenPedido, estrategia) {
        try {

            var producto = estrategia;

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': 'Ficha de Producto – Las Más Ganadoras' },
                        'products': [{
                            'name': producto.DescripcionCompleta,
                            'price': producto.PrecioVenta,
                            'brand': producto.DescripcionMarca,
                            'id': producto.CUV2,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': producto.Cantidad
                        }]
                    }
                }
            });

        } catch (e) {

        }
    }

    function marcarAddCarArmaTuPack(codigoubigeoportal, estrategia) {
        try {

            var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(codigoubigeoportal) + ""; //using new function

            var products = [];
            $.each(estrategia, function (index) {
                var item = estrategia[index];
                var product = {
                    "name": item.NombreComercial,
                    "price": item.PrecioCatalogo,
                    "brand": item.DescripcionMarca,
                    "id": item.Cuv,
                    category: _texto.notavaliable,
                    variant: item.NombreBulk,
                    quantity: item.Cantidad
                };
                products.push(product);
            });

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'add': {
                        'actionField': { 'list': textoCategory },
                        'products': products
                    }
                }
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Add To Cart
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Product Impression
    ////////////////////////////////////////////////////////////////////////////////////////

    var autoMapperEstrategia = function (lista, cantidadMostrar, parametroList) {

        lista = lista || [];
        cantidadMostrar = cantidadMostrar || 0;
        parametroList = parametroList || "";

        var impressions = [];

        $.each(lista, function (index, item) {
            if (index < cantidadMostrar) {
                var impression = {
                    'name': item.DescripcionCompleta,
                    'id': item.CUV2 || item.CUV,
                    'price': item.PrecioVenta || item.PrecioString,
                    'brand': item.DescripcionMarca || _getMarca(item.MarcaId || item.MarcaID),
                    'category': _texto.notavaliable,
                    'variant': _texto.estandar,
                    'list': parametroList,
                    'position': (item.Position == undefined ? index : item.Position) + 1
                };

                impressions.push(impression);
            }
        });

        return impressions;
    };

    //Impresiones por productos en el carrusel
    var _marcarImpresionSetProductos = function (arrayItems) {

        try {

            var tipoMoneda = _getCurrencyCodes();
            dataLayer.push({
                'event': _evento.productImpression,
                'ecommerce': {
                    'currencyCode': tipoMoneda,
                    'impressions': arrayItems
                }
            });

            return true;
        } catch (e) {
            console.log("_marcar Impresion Set Productos - " + _texto.excepcion + e);
        }

        return false;
    }

    var marcaGenericaLista = function (seccion, data, pos) {
        try {
            console.log('marca Generica Lista- ini', seccion, data, pos);

            _marcarProductImpresionSegunLista(data);

        } catch (e) {
            console.log('marca Generica Lista - ' + _texto.excepcion, e);
        }

    }

    var _marcarProductImpresionSegunLista = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación product impression.");

            data = data || {};

            var parametroList = _getParametroListSegunOrigen(data.Origen);

            var lista = data.lista || [];
            var cantidadMostrar = (lista.length == 1 ? 1 : data.CantidadMostrar) || 0;
            var impressions = autoMapperEstrategia(lista, cantidadMostrar, parametroList);

            //$.each(lista, function (index) {
            //    if (index < cantidadMostrar) {
            //        var item = lista[index];
            //        var impression = {
            //            'name': item.DescripcionCompleta,
            //            'id': item.CUV2,
            //            'price': item.PrecioVenta,
            //            'brand': item.DescripcionMarca,
            //            'category': _texto.notavaliable,
            //            'variant': _texto.estandar,
            //            'list': parametroList,
            //            'position': (item.Position == undefined ? index : item.Position) + 1
            //        };
            //        impressions.push(impression);
            //    }
            //});

            var seMarco = _marcarImpresionSetProductos(impressions);

            if (data.Direccion != undefined) {

                var paramlabel = "Flecha Anterior";
                if (data.Direccion == CarruselVariable.Direccion.next) {
                    paramlabel = "Flecha Siguiente";
                }

                dataLayer.push({
                    'event': _evento.virtualEvent,
                    'category': parametroList,
                    'action': "Flecha de Productos",
                    'label': paramlabel
                });
            }

            if (!(lista.length == 0
                || cantidadMostrar <= 0
                || impressions.length == 0
                || !seMarco)) {
                return true;
            }

        } catch (e) {
            console.log("marcarProductImpresionSegunLista" + _texto.excepcion + e);
        }

        return false;

    }

    var marcaProductImpressionRecomendaciones = function (data, isMobile) {
        try {

            data = data || {};
            var cantidadMostrar = (isMobile ? 1 : (data.Total >= 3) ? 3 : data.Total) || 0;

            var lista = data.Productos || [];

            var impressions = autoMapperEstrategia(lista, cantidadMostrar, 'Pedido - Ofertas Relacionadas');

            var seMarco = _marcarImpresionSetProductos(impressions);

            if (!(lista.length == 0
                || cantidadMostrar <= 0
                || impressions.length == 0
                || !seMarco)) {
                return true;
            }

            //$.each(lista, function (index) {
            //    if (index == cantidadMostrar)
            //        return false;
            //    var item = lista[index];
            //    var impression = {
            //        'name': item.DescripcionCompleta,
            //        'id': item.CUV,
            //        'price': parseFloat(item.Precio).toFixed(2).toString(),
            //        'brand': _getMarca(item.MarcaId),
            //        'category': _texto.notavaliable,
            //        'variant': _texto.estandar,
            //        'list': 'Pedido - Ofertas Relacionadas',
            //        'position': index + 1
            //    };
            //    impressions.push(impression);
            //});

            //dataLayer.push({
            //    'event': _evento.productImpression,
            //    'ecommerce': {
            //        'currencyCode': _getCurrencyCodes(),
            //        'impressions': impressions
            //    }
            //});


        } catch (e) {
            console.log(_texto.excepcion + e);
        }

        return false;
    }

    var marcaProductImpressionViewRecomendaciones = function (data, index) {
        try {

            var listaProductos = data.Productos || [];
            index = index >= 0 ? index : -1;
            var lista = [];
            if (listaProductos.length > index && index >= 0) {
                var item = listaProductos[index];
                lista.push(item);
            }

            var impressions = autoMapperEstrategia(lista, 1, 'Pedido - Ofertas Relacionadas');

            var seMarco = _marcarImpresionSetProductos(impressions);


            if (!(lista.length == 0
                || impressions.length == 0
                || !seMarco)) {
                return true;
            }

            //var impressions = [];
            //var item = lista[index];
            //var impression = {
            //    'name': item.DescripcionCompleta,
            //    'id': item.CUV,
            //    'price': parseFloat(item.Precio).toFixed(2).toString(),
            //    'brand': _getMarca(item.MarcaId),
            //    'category': _texto.notavaliable,
            //    'variant': _texto.estandar,
            //    'list': 'Pedido - Ofertas Relacionadas',
            //    'position': index + 1
            //};
            //impressions.push(impression);

            //dataLayer.push({
            //    'event': _evento.productImpression,
            //    'ecommerce': {
            //        'currencyCode': _getCurrencyCodes(),
            //        'impressions': impressions
            //    }
            //});


        } catch (e) {
            console.log(_texto.excepcion + e);
        }

        return false;
    }

    //var marcaProductImpressionViewRecomendacionesMobile = function (data, index) {
    //    try {
    //        var lista = data.Productos;
    //        var impressions = [];
    //        index = index + 1;
    //        var item = lista[index];
    //        var impression = {
    //            'name': item.DescripcionCompleta,
    //            'id': item.CUV,
    //            'price': parseFloat(item.Precio).toFixed(2).toString(),
    //            'brand': _getMarca(item.MarcaId),
    //            'category': _texto.notavaliable,
    //            'variant': _texto.estandar,
    //            'list': 'Pedido - Ofertas Relacionadas',
    //            'position': index + 1
    //        };
    //        impressions.push(impression);
    //        dataLayer.push({
    //            'event': _evento.productImpression,
    //            'ecommerce': {
    //                'currencyCode': _getCurrencyCodes(),
    //                'impressions': impressions
    //            }
    //        });
    //    } catch (e) {
    //        console.log(_texto.excepcion + e);
    //    }
    //}

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Product Impression
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Product Click
    ////////////////////////////////////////////////////////////////////////////////////////


    var marcaVerDetalleProducto = function (element, codigoOrigenPedido, url) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic ver detalle producto.");

            var estoyEnLaFicha = isFicha();

            var list = _getParametroListSegunOrigen(codigoOrigenPedido, url, estoyEnLaFicha);

            var item = $(element).parents("[data-item-cuv]").find("div [data-estrategia]").data("estrategia")
                || $(element).parents("[data-item-cuv]").find("div[data-estrategia]").data("estrategia")
                || {};

            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'click': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': item.DescripcionCompleta,
                            'id': item.CUV2,
                            'price': item.PrecioVenta,
                            'brand': item.DescripcionMarca,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'position': item.Posicion
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaDetalleProductoBienvenida = function (element, codigoOrigenPedido) {
        try {

            var item = element;

            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'click': {
                        'actionField': { 'list': 'Home - GANA+' },
                        'products': [{
                            'name': item.DescripcionCompleta,
                            'id': item.CUV2,
                            'price': item.PrecioVenta,
                            'brand': item.DescripcionMarca,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'position': item.Posicion
                        }]
                    }
                }
            });


        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }

    var marcaFichaDetalleRecomendado = function (strData, position) {

        var jsonData = jQuery.parseJSON(strData);

        var _localEvent = _evento.productClick;
        var _currencyCode = _getCurrencyCodes();
        var _productName = jsonData.Descripcion;
        var _id = jsonData.CUV;
        var _price = jsonData.Precio;
        var _brand = _getMarca(jsonData.MarcaId);
        var _category = _texto.notavaliable;
        var _variant = _texto.estandar;
        var _position = position.toString();
        var _list = "Pedido - Ofertas Relacionadas";

        try {
            dataLayer.push({
                "event": _localEvent,
                "ecommerce": {
                    "currencyCode": _currencyCode,
                    "click": {
                        "actionField": {
                            "list": _list
                        },
                        "products": [{
                            "name": _productName,
                            "id": _id,
                            "price": _price,
                            "brand": _brand,
                            "category": _category,
                            "variant": _variant,
                            "position": _position
                        }]
                    }
                },
                'eventCallback': function () {
                    //console.log('msg');
                }
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcaEligeloClickArmaTuPack = function (origenPedido, estrategia) {

        var item = estrategia;

        try {
            if (origenPedido !== "") {

                if (origenPedido === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPack) {
                    var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(origenPedido) + ""; //using new function
                    dataLayer.push({
                        'event': _evento.productClick,
                        'ecommerce': {
                            'currencyCode': _getCurrencyCodes(),
                            'click': {
                                'actionField': { 'list': textoCategory },
                                'products': [{
                                    'name': item.DescripcionCompleta,
                                    'id': item.CUV2,
                                    'price': item.Precio2,
                                    'brand': item.DescripcionMarca,
                                    'category': _texto.notavaliable,
                                    'variant': _texto.estandar,
                                    'position': item.Posicion
                                }]
                            }
                        }
                    });
                }
            }

        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Product Click
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Product Details
    ////////////////////////////////////////////////////////////////////////////////////////
    var marcaVisualizarDetalleProducto = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic visualizar detalle producto.");

            var products = [];

            var item = data;
            var product = {
                "id": item.CUV2,
                "name": item.DescripcionCompleta,
                "price": item.PrecioVenta,
                "brand": item.DescripcionMarca,
                "category": _texto.notavaliable,
                "variant": _texto.estandar
            };
            products.push(product);


            dataLayer.push({
                'event': _evento.productDetails,
                'ecommerce': {
                    'currencyCode': _getCurrencyCodes(),
                    'detail': {
                        'products': products
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Product Details
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Promotion View
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcaPromotionViewBanner = function (pos) {
        try {
            dataLayer.push({
                'event': _evento.promotionView,
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': _constantes.IdBennerDuoPerfecto,
                                'name': _texto.armaTuDuoPerfecto,
                                'position': pos + ' - Dúo Perfecto',
                                'creative': 'Banner'
                            }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaPromotionView = function (codigoSeccion, data, pos) {
        try {
            if (_constantes.isTest)
                alert("Marcación promotion view.");
            var promotions = _autoMapperV2(codigoSeccion, data, pos);
            if (promotions.length === 0)
                return false;

            dataLayer.push({
                'event': _evento.promotionView,
                'ecommerce': {
                    'promoView': {
                        'promotions': promotions
                    }
                }
            });
        } catch (e) {
            console.log("marca Promotion View - " + _texto.excepcion + e);
        }
    }

    var marcaPromotionViewCarrusel = function () {
        try {
            dataLayer.push({
                'event': _evento.promotionView,
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': _constantes.IdBannerGanadorasVerMas,
                                'name': 'Tenemos Más Opciones Para ti - Las Más Ganadoras',
                                'position': 'Contenedor - Home',
                                'creative': 'Banner'
                            }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaPromotionViewArmaTuPack = function (origenPedido, esInPedido, isClick) {

        isClick = isClick || false;

        if (origenPedido !== "") {
            if (origenPedido == CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPackGuion) {
                var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(origenPedido) + ""; //using new function
                dataLayer.push({
                    'event': !isClick ? _evento.promotionView : _evento.promotionClick,
                    'ecommerce': {
                        'promoView': {
                            'promotions': [
                                {
                                    'id': _constantes.IdBannerArmaTuPack,
                                    'name': 'Arma tu Pack - ' + (esInPedido ? "Modifica" : "Comienza"),
                                    'position': textoCategory,
                                    'creative': "Banner"
                                }
                            ]
                        }
                    }
                });
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Promotion View
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Promotion Click
    ////////////////////////////////////////////////////////////////////////////////////////
    
    var marcaPromotionClicBanner = function (OrigenPedidoWeb, texto, url) {
        try {
            var pos = _getParametroListSegunOrigen(OrigenPedidoWeb, url);
            dataLayer.push({
                'event': 'promotionClick',
                'ecommerce': {
                    'promoClick': {
                        'promotions': [
                            {
                                'id': _constantes.IdBennerDuoPerfecto,
                                'name': _texto.armaTuDuoPerfecto,
                                'position': pos,
                                'creative': 'Banner'
                            }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    var marcaClicBanner = function (data) {
        var pos = indexPosCarruselLan || 0;
        try {
            if (_constantes.isTest)
                alert("Marcación clic banner.");
            var estrategia = $(data).closest("div:has(*[data-estrategia])").children("[data-estrategia]").data("estrategia");
            var codigoOrigenWeb = $(data).closest("div:has(.seccion-content-contenedor)").data("origenpedidoweb");

            dataLayer.push({
                'event': _evento.promotionClick,
                'ecommerce': {
                    'promoClick': {
                        'promotions': [
                            {
                                'id': estrategia.CUV2,
                                'name': AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigenWeb) + " - " + estrategia.DescripcionCompleta + " - " + "Ver producto",
                                'position': fnObtenerContenedor() + " - " + (pos + 1),
                                'creative': 'Banner'
                            }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    function marcarClickMasOfertasPromotionClickMG() {
        try {
            dataLayer.push({
                'event': _evento.promotionClick,
                'ecommerce': {
                    'promoClick': {
                        'promotions': [
                            {
                                'id': _constantes.IdBannerGanadorasVerMas,
                                'name': 'Tenemos Más Opciones Para ti - Las Más Ganadoras',
                                'position': fnObtenerContenedor(),
                                'creative': 'Banner'
                            }]
                    }
                }
            });

        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }
    }


    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Promotion Click
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Evento Promotion Checkout
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcaGuardarPedidoExito = function (data) {
        try {

            var arrayEstrategiasAnalytics = [];
            data.pedidoDetalle = data.pedidoDetalle || [];
            $.each(data.pedidoDetalle, function (index, value) {
                var estrategia = {
                    'name': value.name,
                    'id': value.id,
                    'price': $.trim(value.price),
                    'brand': value.brand,
                    'category': _texto.notavaliable,
                    'variant': _texto.estandar,
                    'quantity': value.quantity
                };
                arrayEstrategiasAnalytics.push(estrategia);
            });

            dataLayer.push({
                'event': _evento.productCheckout,
                'action': 'Guardar',
                'label': 'Tu pedido se guardó con éxito',
                'ecommerce': {
                    'checkout': {
                        'actionField': { 'step': '1', 'option': 'Tu pedido se guardó con éxito', 'action': 'checkout' },
                        'products': arrayEstrategiasAnalytics

                    }
                }
            });

        } catch (e) {
            console.log('marcaGuardarPedidoExito - ' + _texto.excepcion + e);
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Evento Promotion Checkout
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Buscador Miguel
    ////////////////////////////////////////////////////////////////////////////////////////

    var _getMarca = function (marcaId) {
        switch (marcaId) {
            case 1:
                return "L'Bel";
            case 2:
                return "Ésika";
            case 3:
                return "Cyzone";
            case 4:
                return "S&M";
            case 5:
                return "Home Collection";
            case 6:
                return "Finart";
            case 7:
                return "Generico";
            case 8:
                return "Glance";
            default:
                return "Generico";
        }
    }

    var _getCurrencyCodes = function () {
        try {
            var codigoPais = _constantes.codigoPais();
            var currencyInfo = _constantes.currencyCodes.find(function (element) {
                return element.CountryCode == codigoPais;
            });
            return currencyInfo != undefined ? currencyInfo.Code : _texto.notavaliable;
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    };

    var _getPalancaBySeccion = function (codigoSeccion) {
        try {

            var seccion = _constantes.seccionesPalanca.find(function (element) {
                return element.CodigoSeccion == codigoSeccion;
            });
            return seccion != undefined ? seccion.Palanca : _texto.notavaliable;
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    };

    var getPalancaByOrigenPedido = function (codigoOrigenPedido) {
        try {
            codigoOrigenPedido = codigoOrigenPedido || "";
            var codigoPalanca = codigoOrigenPedido.toString().substring(3, 5);
            var seccion = _constantes.origenpedidoWeb.find(function (element) {
                return element.CodigoPalanca == codigoPalanca;
            });
            return seccion != undefined ? seccion.Palanca : _texto.notavaliable;
        } catch (e) {
            console.log('getPalancaByOrigenPedido = ' + _texto.excepcion + e);
        }
    };

    var getSeccionHomeByOrigenPedido = function (codigoOrigenPedido) {
        try {
            var codigo = codigoOrigenPedido.toString().substr(1, 5);
            var seccion = _constantes.origenpedidoWebHome.find(function (element) {
                return element.Codigo == codigo;
            });
            return seccion != undefined ? seccion.Descripcion : _texto.notavaliable;
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    };

    var getContenedorByOrigenPedido = function (event, codigoOrigenPedido, estoyEnLaFicha) {
        try {
            var contenedor = "";
            var codigoPagina = codigoOrigenPedido.toString().substring(1, 3);
            var codigoSeccion = codigoOrigenPedido.toString().substring(5, 7);
            var seccion = _constantes.secciones.find(function (element) {
                return element.CodigoSeccion == codigoSeccion;
            });

            var pagina = _constantes.paginas.find(function (element) {
                return element.CodigoPagina == codigoPagina;
            });

            var esVerMas = typeof seccion !== "undefined" ? seccion.Seccion == "Carrusel Ver Más" : false;
            var esFicha = typeof seccion !== "undefined" ? seccion.Seccion == "Ficha" : false;
            var esCarrusel = false;
            if (!(event == null)) {
                if (codigoSeccion == '05' || codigoSeccion == '01')
                    esCarrusel = true;
            }

            if (typeof window.fichaModule !== "undefined")
                esFicha = true;

            var contenedorFicha = esCarrusel ? _texto.contenedorDetalleSets : _texto.contenedorDetalle;
            switch (pagina.Pagina) {
                case "Home": !esFicha ? contenedor = "Contenedor - Inicio" : contenedor = contenedorFicha; break;
                case "Contenedor": !esFicha ? contenedor = "Contenedor - Inicio" : contenedor = contenedorFicha; break;
                case "Landing Ofertas Para Ti": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing Dúo Perfecto": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing Pack de Nuevas": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Pedido": contenedor = "Carrito de compras"; break;
                case "Otras": contenedor = !esFicha ? _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing Showroom": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing GND": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing Herramientas de Venta": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing Liquidación": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Landing Ganadoras": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                case "Buscador": contenedor = "Buscador"; break;

            }

            return contenedor;
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    };

    var marcaBarraBusqueda = function () {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Buscador SB',
                'action': 'Selección',
                'label': _texto.notavaliable
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaBarraBusquedaMobile = function (url) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Buscador SB',
                'action': 'Selección',
                'label': _texto.notavaliable,
                'eventCallback': function () {
                    document.location = url
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaAnadirCarritoGenerico = function (event, codigoOrigenPedido, estrategia) {
        try {
            var codigoPagina = codigoOrigenPedido.toString().substring(1, 3);

            var pagina = _constantes.paginas.find(function (element) {
                return element.CodigoPagina == codigoPagina;
            });

            if (pagina == undefined) {
                return false;
            }

            //Marcar analytics cuando es Ganadoras en ficha y 
            var estoyEnLaFicha = typeof fichaModule !== "undefined";

            var codigoSeccion = codigoOrigenPedido.toString().substring(5, 7);
            var seccion = _constantes.secciones.find(function (element) {
                return element.CodigoSeccion == codigoSeccion;
            });

            if (seccion == undefined) {
                return false;
            }

            var model = {
                'DescripcionCompleta': estrategia.DescripcionCompleta,
                'CUV': estrategia.CUV2,
                'Precio': estrategia.Precio2,
                'DescripcionMarca': estrategia.CUV2,
                'CodigoTipoEstrategia': estrategia.CodigoEstrategia,
                'MarcaId': estrategia.MarcaID,
                'Cantidad': estrategia.Cantidad,
                'Palanca': estrategia.Palanca
            };

            var _pagina = pagina.Pagina;
            var valorBuscar = localStorage.getItem('valorBuscador');

            if (_pagina === "Landing Buscador") {
                AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, "Ficha de producto", valorBuscar);
                return;
            }

            if (pagina.Pagina.includes("Landing"))
                _pagina = "Landing";

            switch (_pagina) {
                case "Buscador":
                case "Landing Buscador":
                    AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, "Ficha de producto", valorBuscar);
                    break;
                case "Home":
                    seccion.Seccion == "Banner Superior"
                        ? AnalyticsPortalModule.MarcaAnadirCarritoHomeBanner(null, codigoOrigenPedido, estrategia)
                        : AnalyticsPortalModule.MarcaAnadirCarritoHome(null, codigoOrigenPedido, estrategia);
                    break;
                // Inicio Analytics Oferta Miguel
                case "Contenedor": AnalyticsPortalModule.MarcaAnadirCarrito(event, codigoOrigenPedido, estrategia); break;
                case "Landing": AnalyticsPortalModule.MarcaAnadirCarrito(event, codigoOrigenPedido, estrategia); break;
                case "Pedido": AnalyticsPortalModule.MarcaAnadirCarrito(event, codigoOrigenPedido, estrategia); break;
                // Fin Analytics Oferta Miguel
            }

        } catch (e) {

        }
    }

    var marcaEligeUnaOpcion = function (url, textobusqueda) {
        try {
            localStorage.setItem('valorBuscador', textobusqueda);
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Buscador SB',
                'action': 'Elige tu opción',
                'label': textobusqueda,
                'eventCallback': function () {
                    document.location = url;
                }
            });

        } catch (e) {

        }
    }

    var _obtenerNombrePalanca = function (tipoEstrategiaId) {
        switch (tipoEstrategiaId) {
            case ConstantesModule.TipoEstrategia.GuiaDeNegocioDigitalizada:
                return "Guía de negocio";
            case ConstantesModule.TipoEstrategia.HerramientasVenta:
                return "Herramientas de Venta";
            case ConstantesModule.TipoEstrategia.ShowRoom:
                return "ShowRoom";
            case ConstantesModule.TipoEstrategia.OfertaDelDia:
                return "Oferta del Día";
            case ConstantesModule.TipoEstrategia.OfertaParaTi:
                return "Oferta para Ti";
            case ConstantesModule.TipoEstrategia.OfertasParaMi:
                return "Oferta para Mi";
            case ConstantesModule.TipoEstrategia.Lanzamiento:
                return "Lanzamiento";
            case ConstantesModule.TipoEstrategia.PackAltoDesembolso:
                return "Packs Ganadores";
            default:
                return "Gana+";
        }
    }
    
    var marcaSeleccionarContenidoBusqueda = function (busqueda) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Buscador SB',
                'action': 'Buscar',
                'label': busqueda
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaVerTodosLosResultadosBuscador = function (busqueda) {
        try {

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Buscador SB',
                'action': 'Ver más resultados',
                'label': busqueda
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaBusquedaSinResultadosBuscador = function (busqueda) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Buscador SB',
                'action': 'Búsqueda - sin Resultados',
                'label': busqueda
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaClicOpcionesFiltrarBuscador = function (busqueda) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Ordenar Por',
                'label': busqueda
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaEligeTuOpcionBuscador = function (busqueda) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Elige tu opción',
                'label': busqueda
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaRedesSocialesBuscador = function (network, label) {
        try {
            dataLayer.push({
                'event': _evento.socialEvent,
                'network': network,
                'action': 'Compartir',
                'label': label
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaFiltroPorSeccion = function (seccion, label) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Filtrar por ' + seccion,
                'label': label
            });
        } catch (e) {
            console.error(e);
        }

    }

    var marcaEliminarEtiqueta = function (label) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Eliminar Filtro',
                'label': label
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaLimpiarFiltros = function () {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Clic en Botón',
                'label': 'Limpiar Filtros'
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaBotonFiltro = function () {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Clic en Botón',
                'label': 'Filtrar'
            });
        } catch (e) {
            console.error(e);
        }
    }

    var marcaBotonAplicarFiltro = function (label) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Resultados de Búsqueda',
                'action': 'Aplicar Filtros',
                'label': label
            });
        } catch (e) {
            console.error(e);
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Buscador Miguel
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Home 1 Miguel
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcaGanaOfertas = function (data, url) {

        try {

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Home',
                'action': 'Click Botón',
                'label': 'Club GANA+ - Ofertas para tí',
                'eventCallback': function () {
                    document.location = url;
                }
            });


        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }
    
    var marcaSucribete = function (url) {

        try {

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Home – Club GANA+',
                'action': 'Banner Suscripción Gana+',
                'label': 'Subscríbete gratis',
                'eventCallback': function () {
                    document.location = url;
                }
            });


        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }

    //var marcaGenericaLista = function (seccion, data, pos) {
    //    try {
    //        console.log('marca Generica Lista- ini', seccion, data, pos);

    //        // mantener la seccion para LAN, luego ponerlo dentro de data como origen
    //        if (typeof seccion === "undefined")
    //            return false;

    //        seccion = seccion.replace("Lista", "");

    //        switch (seccion) {
    //            case _codigoSeccion.LAN:
    //            case _codigoSeccion.DP:
    //                _marcaPromotionViewBanner(seccion, data, pos); break;
    //            default:
    //                _marcarProductImpresionSegunLista(data); break;
    //        }
    //    } catch (e) {
    //        console.log('marca Generica Lista - ' + _texto.excepcion, e);
    //    }

    //}
    
    var marcaNotificaciones = function (tipo, url) {
        try {
            if (_constantes.isTest)
                alert("Marcación Notificaciones.");

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Navegacion',
                'action': tipo,
                'label': tipo == 'Superior' ? 'Notificaciones' : 'Ver Notificaciones > Abrir',
                'eventCallback': function () {
                    document.location = url
                }
            });

        } catch (e) {
            document.location = url
            console.log(_texto.excepcion + e);
        }

    }

    var marcaClicSeguimientoPedido = function (url) {
        try {
            if (_constantes.isTest)
                alert("Marcación Clic seguimiento pedido.");

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Navegacion',
                'action': 'Cuerpo',
                'label': 'Seguimiento a tu pedido',
                'eventCallback': function () {
                    document.location = url;
                }
            });

        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }
    }

    var marcaClicPagarLinea = function (url) {
        try {
            if (_constantes.isTest)
                alert("Marcación Clic pago en línea.");

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home – Mi estado de cuenta',
                'action': 'Click Botón',
                'label': 'PAGA EN LÍNEA',
                'eventCallback': function () {
                    if (url.length > 0)
                        document.location = url;
                }
            });

        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }

    //var marcaClicVideoBienvenida = function () {
    //    try {
    //        if (_constantes.isTest)
    //            alert("Marcación Clic seguimiento pedido.");
    //        dataLayer.push({
    //            'event': 'virtualEvent',
    //            'category': 'Home',
    //            'action': 'Video de Bienvenida: Iniciar Video',
    //            'label': 'SomosBelcorp.com ¡se renueva para ti!'
    //        });
    //    } catch (e) {
    //        console.log(_texto.excepcion + e);
    //    }
    //}

    var marcaClicFacturacionElectronica = function (url) {
        try {
            if (_constantes.isTest)
                alert("Marcación Clic pago en línea.");

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home – Mi estado de cuenta',
                'action': 'Click Botón',
                'label': 'FACTURACIÓN ELECTRÓNICA',
                'eventCallback': function () {
                    document.location = url;
                }
            });

        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }

    var marcaComparteCatalogos = function (url) {
        try {
            if (_constantes.isTest)
                alert("Marcación Clic comparte catalogos.");

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home',
                'action': 'Click Botón',
                'label': 'COMPARTE TUS CATÁLOGOS',
                'eventCallback': function () {
                    document.location = url;
                }
            });

        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }

    var marcaVerLanzamientos = function (url) {
        try {

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home – Club GANA+',
                'action': 'Club Gana+',
                'label': 'Ver lanzamientos',
                'eventCallback': function () {
                    document.location = url;
                }
            });
        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }
    }

    var marcaVerOtrasOfertasHome = function (url, codigo) {
        try {
            codigo = codigo || "";
            if (codigo == _codigoSeccion.LAN) {
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home – Club GANA+',
                    'action': 'Club Gana+',
                    'label': 'Ver lanzamientos',
                    'eventCallback': function () {
                        document.location = url;
                    }
                });
            }
            else if (codigo == _codigoSeccion.RD) {
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    'category': 'Home - Club GANA+',
                    'action': 'Click Botón',
                    'label': 'VER MÁS OFERTAS',
                    'eventCallback': function () {
                        document.location = url;
                    }
                });
            }
            else {
                document.location = url;
            }
        } catch (e) {
            document.location = url;
            console.log("marcaVerOtrasOfertasHome", _texto.excepcion + e);
        }
    }

    var marcaVerMasLiquidaciones = function (url) {
        try {

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home – Liquidaciones Web',
                'action': 'Click Botón',
                'label': 'VER MÁS',
                'eventCallback': function () {
                    document.location = url;
                }
            });
        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }
    }

    var marcaClicFechaLiquidacion = function (direccion) {
        try {

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Home – Liquidaciones Web',
                'action': 'Flechas de productos',
                'label': direccion
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaFlechaHome = function (flecha) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home – Club GANA+',
                'action': 'Flechas de Productos',
                'label': flecha
            });
        } catch (e) {

        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Home 1 Miguel
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Ofertas Miguel
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcaClicFlechaBanner = function (data) {
        try {

            if (_constantes.isTest)
                alert("Marcación clic flecha banner.");
            var codigoOrigenPedido = $(data).parents("[data-OrigenPedidoWeb]").data("origenpedidoweb");
            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigenPedido);


            var tipoFlecha = $(data).data("direccionflecha");
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': "Contenedor - Home",
                'action': palanca + ' - Flechas de banner',
                'label': tipoFlecha
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    //var _marcaPromotionViewBanner = function (codigoSeccion, data, pos) {
    //    try {
    //        if (_constantes.isTest)
    //            alert("Marcación promotion view.");
    //        var promotions = _autoMapperV2(codigoSeccion, data, pos);
    //        if (promotions.length === 0)
    //            return false;
    //        dataLayer.push({
    //            'event': _evento.promotionView,
    //            'ecommerce': {
    //                'promoView': {
    //                    'promotions': promotions
    //                }
    //            }
    //        });
    //    } catch (e) {
    //        console.log(_texto.excepcion + e);
    //    }
    //}

    var _autoMapperV2 = function (codigoSeccion, data, pos) {
        var collection = [];
        var element;

        if (codigoSeccion == _codigoSeccion.LAN) {
            element = $("[data-seccion=" + codigoSeccion + "]");
            var codigo = element.data("origenpedidoweb");
            $.each(data, function (index) {
                var item = data[index];
                var element = {
                    'id': item.CUV2,
                    'name': AnalyticsPortalModule.GetPalancaByOrigenPedido(codigo) + " - " + item.DescripcionCompleta + " - " + "Ver producto",
                    'position': fnObtenerContenedor() + (pos != undefined ? (" - " + (pos + 1)) : ""),
                    'creative': "Banner"
                };
                collection.push(element);
            });
        }

        //para duo solo se registra uno
        if (codigoSeccion == _codigoSeccion.DP) {
            element = {
                'id': _constantes.IdBennerDuoPerfecto,
                'name': _texto.armaTuDuoPerfecto,
                'position': (pos !== undefined) ? pos + ' - Dúo Perfecto' : '',
                'creative': "Banner"
            };
            collection.push(element);
        }

        return collection;
    };

    function fnObtenerContenedor(event) {

        var estoyEnLaFicha = typeof fichaModule !== "undefined";
        var esLanding = typeof listaSeccion === 'undefined';
        var esRevisar = window.actionName == "revisar";
        var contenedor = "";

        switch (window.controllerName) {
            case "ofertas": contenedor = esRevisar ? _texto.contenedorRevisar : _texto.contenedorHome; break;
            case "pedido": contenedor = _texto.contenedorRevisar; break;
            case "masganadoras": contenedor = _texto.contenedorMasGanadoras; break;
            default: contenedor = _texto.contenedor; break;
        }

        return contenedor;
    }
    
    var marcaClicVerMasOfertas = function (url, origenPedido, titulo, clicEnBanner) {
        try {
            if (_constantes.isTest)
                alert("Marcación Ver más ofertas.");

            var textoCategory = _getParametroListSegunOrigen(origenPedido, url);

            if (typeof clicEnBanner !== "undefined" && typeof clicEnBanner !== undefined) {
                if (clicEnBanner) {
                    marcaPromotionClicBanner(origenPedido, titulo);
                }
            }

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': textoCategory,
                'action': 'Click Botón',
                'label': titulo
            });

            document.location = url;

        } catch (e) {
            console.log(_texto.excepcion + e);
            document.location = url;
        }

    }
    
    var marcaManagerFiltros = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación filtros");
            if (data.selectedIndex == -1)
                return;
            var filtro = data.options[data.selectedIndex].text;
            var tipoFiltro = $(data).data("filtro-campo");
            var textoFiltro = tipoFiltro == "precio" ? "Ordenar por precio" : "Filtrar por marca";
            var codigoOrigenWeb = $(data).parents("[data-OrigenPedidoWeb]").data("origenpedidoweb")
            var contenedor = AnalyticsPortalModule.GetContenedorByOrigenPedido(null, codigoOrigenWeb);
            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigenWeb);
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': contenedor + " - " + palanca,
                'action': 'Filtro contenedor',
                'label': textoFiltro + " - " + filtro
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaCompartirRedesSociales = function (tipo, url) {
        try {
            dataLayer.push({
                'event': 'socialEvent',
                'network': tipo == "FB" ? 'Facebook' : "Whatsapp",
                'action': 'Compartir',
                'target': url == "" ? undefined : url
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaVerTodoMiPedido = function (data) {
        try {
            var value = $(data).attr("title");

            if (value !== "Ver mi pedido")
                return;

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': fnObtenerContenedor(),
                'action': 'Click Botón',
                'label': 'Ver todo mi pedido'
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarRemoveFromCart = function (data, cantidad) {
        try {
            codigoOrigen = data.data.OrigenPedidoWeb;
            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigen);
            dataLayer.push({
                'event': _evento.virtualRemoveEvent,
                'ecommerce': {
                    'remove': {
                        'products': [{
                            'name': data.data.DescripcionProducto,
                            'id': data.data.CUV,
                            'price': data.data.Precio,
                            'brand': data.data.DescripcionMarca,
                            'category': "NO DISPONIBLE",
                            'variant': data.data.DescripcionOferta == "" ? "Estándar" : data.data.DescripcionOferta,
                            'quantity': Number(cantidad),
                            'ListaProducto': 'Contenedor - Home - ' + palanca + " - Campaña " + $('#hdCampaniaCodigo').val()
                        }]
                    }
                }
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    var marcaEliminarPedidoCompleto = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic eliminar pedido completo.");

            var products = [];
            $.each(data, function (index) {
                var item = data[index];
                var product = {
                    "id": item.CUV, "name": item.DescripcionProd, "price": item.ImporteTotal, "brand": item.DescripcionLarga, category: _texto.notavaliable, variant: _texto.estandar, quantity: item.Cantidad, 'ListaProducto': AnalyticsPortalModule.GetContenedorByOrigenPedido(null, item.OrigenPedidoWeb) + " - " + AnalyticsPortalModule.GetPalancaByOrigenPedido(item.OrigenPedidoWeb) + " - " + _constantes.campania + item.CampaniaID
                };
                products.push(product);
            });

            dataLayer.push({
                'event': _evento.virtualRemoveEvent,
                'ecommerce': {
                    'remove': {
                        'products': products
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarGuardaTuPedido = function () {
        try {
            dataLayer.push({
                'category': _texto.CarritoCompras,
                'action': 'Intencion de Guardar pedido',
                'label': 'Guardar Pedido'
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarPedidoGuardoExito = function () {
        try {
            dataLayer.push({
                'category': _texto.CarritoCompras,
                'action': 'Intencion de Guardar pedido',
                'label': 'Guardar Pedido'
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    
    var marcaBannersInferioresDescontinuados = function (strLabel) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': _texto.CarritoCompras,
                'action': 'Click Botón',
                'label': strLabel
            });
        } catch (e) {

        }
    };

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Ofertas Miguel
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Rama TiposAnalytics
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcarImagenProducto = function (opcion, detalle) {
        try {
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": _texto.contenedorfichaProducto,
                "action": 'Seleccionar imagen del producto',
                "label": opcion.DescripcionCompleta + " - " + detalle[0].NombreBulk
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarPopupEligeUnaOpcion = function (opcion) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': _texto.contenedorfichaProducto,
                'action': 'Ver Popup Elige 1 opción',
                'label': opcion.DescripcionCompleta
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarCerrarPopupEligeUnaOpcion = function (opcion) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige 1 opción',
                'action': 'Cerrar pop up Elige 1 opción',
                'label': opcion.DescripcionCompleta
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarPopupBotonEligeloSoloUno = function (estrategia, componentes) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': "Contenedor - Pop up Elige 1 opción",
                'action': 'Elígelo',
                'label': estrategia.DescripcionCompleta + '-' + componentes.HermanosSeleccionados[0].NombreBulk
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarBotonAplicarSeleccion = function (estrategia, componentes) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige 1 opción',
                'action': 'Aplicar selección',
                'label': estrategia.DescripcionCompleta + '-' + componentes.resumenAplicados[0].NombreBulk
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarEliminarOpcionSeleccionada = function (estrategia, nombreComponentes) {
        try {
            var textoCategory = "Contenedor - Pop up Elige 1 opción";
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': textoCategory,
                'action': 'Desenmarcar Producto',
                'label': estrategia.DescripcionCompleta + '-' + nombreComponentes
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarCambiarOpcion = function (opcion) {

        var codUbigeo = opcion.CodigoUbigeoPortal || "";
        if (codUbigeo !== "") {
            if (codUbigeo === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionCarritoComprasGuionFichaResumida) {
                var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(codUbigeo); //using new function
                try {
                    dataLayer.push({
                        'event': _evento.virtualEvent,
                        'category': textoCategory,
                        'action': 'Ver Popup Cambiar opciones',
                        'label': opcion.DescripcionCompleta
                    });
                } catch (e) {
                    console.log(_texto.excepcion + e);
                }
            }

        } else {  //Cambia Opcione normal
            try {
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    'category': _texto.contenedorfichaProducto,
                    'action': 'Cambiar opción',
                    'label': opcion.DescripcionCompleta
                });
            } catch (e) {
                console.log(_texto.excepcion + e);
            }
        }
    }
    var marcarPopupEligeXOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': _texto.contenedorfichaProducto,
                'action': 'Ver Popup Elige más de una opción',
                'label': opcion.DescripcionCompleta
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarPopupCerrarEligeXOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Cerrar pop up Elige más de una opción',
                'label': opcion.DescripcionCompleta
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarPopupBotonEligeloVariasOpciones = function (estrategia, componentes) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Elígelo',
                'label': estrategia.DescripcionCompleta + ' - ' + componentes
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarPopupBotonAplicarSeleccionVariasOpciones = function (componentes_Concatenados) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Aplicar selección',
                'label': componentes_Concatenados
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarEliminarOpcionSeleccionadaVariasOpciones = function (estrategia, nombreComponentes) {
        try {

            var textoCategory = "Contenedor - Pop up Elige más de una opción";
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': textoCategory,
                'action': 'Desenmarcar opción',
                'label': estrategia.DescripcionCompleta + ' - ' + nombreComponentes
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarAumentardisminuirOpcionProducto = function (operacion, estrategia, nombreComponentes) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': operacion,
                'label': estrategia.DescripcionCompleta + ' - ' + nombreComponentes
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    var marcarCambiarOpcionVariasOpciones = function (opcion) {

        try {
            var codUbigeo = opcion.CodigoUbigeoPortal || "";

            if (codUbigeo !== "") {
                if (codUbigeo === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionCarritoComprasGuionFichaResumida) {
                    var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(codUbigeo); //using new function
                    try {
                        dataLayer.push({
                            'event': _evento.virtualEvent,
                            'category': textoCategory,
                            'action': 'Ver Popup Cambiar opciones',
                            'label': opcion.DescripcionCompleta
                        });
                    } catch (e) {
                        console.log(_texto.excepcion + e);
                    }
                }

            } else { //Cambia Opcione normal
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    'category': 'Contenedor - Ficha de producto',
                    'action': 'Cambiar opciones',
                    'label': opcion.DescripcionCompleta
                });
            }
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Rama TiposAnalytics
    ////////////////////////////////////////////////////////////////////////////////////////
    // Ini - Analytics Ganadoras
    ////////////////////////////////////////////////////////////////////////////////////////

    var _getDirection = function (direction) {
        switch (direction) {
            case 1:
                return _texto.siguiente;
            case 2:
                return _texto.anterior;
        }
    }

    var _virtualEventPush = function (label) {

        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": fnObtenerContenedor(),
            "action": "Las Más Ganadoras - Clic Flechas",
            "label": label
        });
    };

    function clickArrowMG(direction) {
        _virtualEventPush(_getDirection(direction));
    }

    function clickOnBreadcrumb(url, codigoPalanca, titulo) {

        try {
            if (codigoPalanca === _codigoSeccion.MG)
                dataLayer.push({
                    "event": _evento.virtualEvent,
                    "category": _texto.fichaProducto,
                    "action": 'Breadcrumb - Clic en Botón',
                    "label": titulo || "",
                    'eventCallback': function () {
                        document.location = url;
                    }
                });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
    
    function clickTabGanadoras(codigo) {
        if (codigo === _codigoSeccion.MG)
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": fnObtenerContenedor(),
                "action": 'Clic tab',
                "label": 'Las Más Ganadoras'
            });
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Ganadoras
    ////////////////////////////////////////////////////////////////////////////////////////


    ////////////////////////////////////////////////////////////////////////////////////////
    // Inicio - Analytics Buscador
    ////////////////////////////////////////////////////////////////////////////////////////

    var marcaRecomendacionesFlechaSiguiente = function () {
        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": 'Pedido',
            "action": 'Ofertas Relacionadas - Clic Flechas',
            "label": 'Ver siguiente'
        });
    }

    var marcaRecomendacionesFlechaAnterior = function () {
        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": 'Pedido',
            "action": 'Ofertas Relacionadas - Clic Flechas',
            "label": 'Ver anterior'
        });
    }

    var marcaOcultarRecomendaciones = function () {
        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": 'Pedido',
            "action": 'Ofertas Relacionadas - Clic Botón',
            "label": 'No ver ofertas por ahora'
        });
    }

    var marcaCategoria = function (categoria) {
        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": 'Buscador SB',
            "action": 'Clic en categoría',
            "label": categoria
        });
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Buscador
    ////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////
    // Inicio - Analytics Ficha Resumida
    ////////////////////////////////////////////////////////////////////////////////////////
    var marcaFichaResumidaClickDetalleProducto = function (producto) {
        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": _texto.CarritoCompras,
            "action": 'Visualizar Producto',
            "label": producto
        });
    }
    var marcaFichaResumidaClickDetalleCliente = function (nombreBoton) {
        dataLayer.push({
            "event": _evento.virtualEvent,
            "category": _texto.CarritoCompras + " - Ficha Resumida",
            "action": 'Click Botón',
            "label": nombreBoton
        });
    }
    var marcaFichaResumidaClickModificar = function (origenPedido, isChangeTono, isChangeCantidad, isChangeCliente) {
        origenPedido = origenPedido || "";
        var textoCategory = "";

        if (origenPedido != "") {
            if (origenPedido == CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionCarritoComprasGuionFichaResumida) {
                textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(origenPedido);  //using new function

                var label = isChangeTono ? "Tono " : "";
                label += (isChangeCliente ? ((label === "" ? "" : "- ") + "Cliente ") : "");
                label += (isChangeCantidad ? ((label === "" ? "" : "- ") + "Cantidad") : "");
                dataLayer.push({
                    "event": _evento.virtualEvent,
                    "category": textoCategory,
                    "action": 'Modificar',
                    "label": label
                });
            }
        }

    }

    var marcaPromotionClickArmaTuPack = function (origenPedido, textoLabel, actionText) {

        if (origenPedido !== "") {
            if (origenPedido == CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPack ||
                origenPedido == CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPackGuion) {
                var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(origenPedido) + ""; //using new function
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    "category": textoCategory,
                    "action": actionText,
                    "label": textoLabel + ""
                });
            }
        }
    }

    var marcaEliminaClickArmaTuPack = function (origenPedido, estrategia) {

        if (origenPedido !== "") {
            if (origenPedido === CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPack) {
                var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(origenPedido) + ""; //using new function
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    "category": textoCategory,
                    "action": 'Eliminar Producto',
                    "label": estrategia.DescripcionCompleta + ""
                });
            }
        }
    }
    
    var marcaClickAgregarArmaTuPack = function (codigoubigeoportal, textoLabel, actionText) {

        if (codigoubigeoportal !== "") {
            if (codigoubigeoportal == CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionContenedorArmaTuPack) {
                var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(codigoubigeoportal) + ""; //using new function
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    "category": textoCategory,
                    "action": actionText,
                    "label": textoLabel + ""
                });
            }
        }
    }
    var marcaClickCerrarPopupArmaTuPack = function (codigoubigeoportal, textoLabel, actionText) {

        if (codigoubigeoportal !== "") {
            if (codigoubigeoportal == CodigoUbigeoPortal.MaestroCodigoUbigeo.GuionCarritoComprasGuionFichaResumida) {
                var textoCategory = CodigoUbigeoPortal.GetTextoSegunCodigo(codigoubigeoportal) + ""; //using new function
                dataLayer.push({
                    'event': _evento.virtualEvent,
                    "category": textoCategory,
                    "action": actionText,
                    "label": textoLabel + ""
                });
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////
    // Fin - Analytics Ficha Resumida
    ////////////////////////////////////////////////////////////////////////////////////////

    return {


        // Ini - Analytics Evento Product Impression
        MarcaGenericaLista: marcaGenericaLista,
        MarcaProductImpressionRecomendaciones: marcaProductImpressionRecomendaciones,
        MarcaProductImpressionViewRecomendaciones: marcaProductImpressionViewRecomendaciones,
        // Fin - Analytics Evento Product Impression

        // Ini - Analytics Evento Promotion View
        MarcaPromotionViewBanner: marcaPromotionViewBanner,
        MarcaPromotionView: marcaPromotionView,
        MarcaPromotionViewCarrusel: marcaPromotionViewCarrusel,
        MarcaPromotionViewArmaTuPack: marcaPromotionViewArmaTuPack,
        // Fin - Analytics Evento Promotion View

        // Ini - Metodos Iniciales
        MarcarIniciarPlayVideo: marcarIniciarPlayVideo,
        // Fin - Metodos Iniciales

        // Ini - Rama TiposAnalytics
        MarcarImagenProducto: marcarImagenProducto,
        MarcarPopupEligeUnaOpcion: marcarPopupEligeUnaOpcion,
        MarcarCerrarPopupEligeUnaOpcion: marcarCerrarPopupEligeUnaOpcion,
        MarcarPopupBotonEligeloSoloUno: marcarPopupBotonEligeloSoloUno,
        MarcarBotonAplicarSeleccion: marcarBotonAplicarSeleccion,
        MarcarEliminarOpcionSeleccionada: marcarEliminarOpcionSeleccionada,
        MarcarCambiarOpcion: marcarCambiarOpcion,
        MarcarPopupEligeXOpciones: marcarPopupEligeXOpciones,
        MarcarPopupCerrarEligeXOpciones: marcarPopupCerrarEligeXOpciones,
        MarcarPopupBotonEligeloVariasOpciones: marcarPopupBotonEligeloVariasOpciones,
        MarcarPopupBotonAplicarSeleccionVariasOpciones: marcarPopupBotonAplicarSeleccionVariasOpciones,
        MarcarEliminarOpcionSeleccionadaVariasOpciones: marcarEliminarOpcionSeleccionadaVariasOpciones,
        MarcarAumentardisminuirOpcionProducto: marcarAumentardisminuirOpcionProducto,
        MarcarCambiarOpcionVariasOpciones: marcarCambiarOpcionVariasOpciones,
        // Fin - Rama TiposAnalytics

        // Ini - Analytics Buscador Miguel
        MarcaBarraBusqueda: marcaBarraBusqueda,
        GetPalancaByOrigenPedido: getPalancaByOrigenPedido,
        GetSeccionHomeByOrigenPedido: getSeccionHomeByOrigenPedido,
        GetContenedorByOrigenPedido: getContenedorByOrigenPedido,
        MarcaEligeUnaOpcion: marcaEligeUnaOpcion,
        MarcaBarraBusquedaMobile: marcaBarraBusquedaMobile,
        MarcaAnadirCarritoBuscador: marcaAnadirCarritoBuscador,
        MarcaSeleccionarContenidoBusqueda: marcaSeleccionarContenidoBusqueda,
        MarcaAnadirCarritoGenerico: marcaAnadirCarritoGenerico,
        // Fin - Analytics Buscador Miguel

        MarcaVerTodosLosResultadosBuscador: marcaVerTodosLosResultadosBuscador,
        MarcaBusquedaSinResultadosBuscador: marcaBusquedaSinResultadosBuscador,
        MarcaClicOpcionesFiltrarBuscador: marcaClicOpcionesFiltrarBuscador,
        MarcaEligeTuOpcionBuscador: marcaEligeTuOpcionBuscador,
        MarcaRedesSocialesBuscador: marcaRedesSocialesBuscador,
        // Ini - Analytics Home 1 
        MarcaGanaOfertas: marcaGanaOfertas,
        MarcaSucribete: marcaSucribete,
        MarcaAnadirCarritoHome: marcaAnadirCarritoHome,
        MarcaVerDetalleProducto: marcaVerDetalleProducto,
        MarcaDetalleProductoBienvenida: marcaDetalleProductoBienvenida,
        MarcaNotificaciones: marcaNotificaciones,
        MarcaClicSeguimientoPedido: marcaClicSeguimientoPedido,
        MarcaClicPagarLinea: marcaClicPagarLinea,
        MarcaClicFacturacionElectronica: marcaClicFacturacionElectronica,
        MarcaComparteCatalogos: marcaComparteCatalogos,
        MarcaVerLanzamientos: marcaVerLanzamientos,
        MarcaVerMasLiquidaciones: marcaVerMasLiquidaciones,
        MarcaClicFechaLiquidacion: marcaClicFechaLiquidacion,
        //MarcaClicVideoBienvenida: marcaClicVideoBienvenida,
        MarcaVerOtrasOfertasHome: marcaVerOtrasOfertasHome,
        MarcaFlechaHome: marcaFlechaHome,
        MarcaAnadirCarritoLiquidacion: marcaAnadirCarritoLiquidacion,
        MarcaAnadirCarritoHomeBanner: marcaAnadirCarritoHomeBanner,
        MarcarRemoveFromCart: marcarRemoveFromCart,
        MarcaVerTodoMiPedido: marcaVerTodoMiPedido,
        // Fin - Analytics Home 1 

        // Ini - Analytics Ofertas  
        MarcaClicFlechaBanner: marcaClicFlechaBanner,
        MarcaClicBanner: marcaClicBanner,
        MarcaClicVerMasOfertas: marcaClicVerMasOfertas,
        MarcaAnadirCarrito: marcaAnadirCarrito,
        MarcaManagerFiltros: marcaManagerFiltros,
        MarcaCompartirRedesSociales: marcaCompartirRedesSociales,
        MarcaVisualizarDetalleProducto: marcaVisualizarDetalleProducto,
        MarcaEliminarPedidoCompleto: marcaEliminarPedidoCompleto,
        MarcarGuardaTuPedido: marcarGuardaTuPedido,
        MarcarPedidoGuardoExito: marcarPedidoGuardoExito,
        MarcaGuardarPedidoExito: marcaGuardarPedidoExito,
        MarcaBannersInferioresDescontinuados: marcaBannersInferioresDescontinuados,
        // Fin - Analytics Ofertas

        // Ini - Analytics Ganadoras
        MarcarClickMasOfertasPromotionClickMG: marcarClickMasOfertasPromotionClickMG,
        ClickArrowMG: clickArrowMG,
        ClickOnBreadcrumb: clickOnBreadcrumb,
        ClickAddCartFicha: clickAddCartFicha,
        ClickTabGanadoras: clickTabGanadoras,
        // Fin - Analytics Ganadoras

        //MarcaProductImpressionViewRecomendacionesMobile: marcaProductImpressionViewRecomendacionesMobile,
        MarcaRecomendacionesFlechaSiguiente: marcaRecomendacionesFlechaSiguiente,
        MarcaRecomendacionesFlechaAnterior: marcaRecomendacionesFlechaAnterior,
        MarcaOcultarRecomendaciones: marcaOcultarRecomendaciones,
        MarcaPromotionClicBanner: marcaPromotionClicBanner,
        MarcaCategoria: marcaCategoria,
        MarcaAnadirCarritoRecomendaciones: marcaAnadirCarritoRecomendaciones,
        MarcaFiltroPorSeccion: marcaFiltroPorSeccion,
        MarcaEliminarEtiqueta: marcaEliminarEtiqueta,
        MarcaLimpiarFiltros: marcaLimpiarFiltros,
        MarcaBotonFiltro: marcaBotonFiltro,
        MarcaBotonAplicarFiltro: marcaBotonAplicarFiltro,
        MarcaFichaDetalleRecomendado: marcaFichaDetalleRecomendado,
        GetCurrencyCode: _getCurrencyCodes,
        MarcaFichaResumidaClickDetalleProducto: marcaFichaResumidaClickDetalleProducto,
        MarcaFichaResumidaClickDetalleCliente: marcaFichaResumidaClickDetalleCliente,
        MarcaFichaResumidaClickModificar: marcaFichaResumidaClickModificar,
        MarcaPromotionClickArmaTuPack: marcaPromotionClickArmaTuPack,
        MarcaEligeloClickArmaTuPack: marcaEligeloClickArmaTuPack,
        MarcaEliminaClickArmaTuPack: marcaEliminaClickArmaTuPack,
        MarcarAddCarArmaTuPack: marcarAddCarArmaTuPack,
        MarcaClickAgregarArmaTuPack: marcaClickAgregarArmaTuPack,
        MarcaClickCerrarPopupArmaTuPack: marcaClickCerrarPopupArmaTuPack
    }
})();
