
if (!jQuery) { throw new Error("AnalyticsPortal.js requires jQuery"); }

+function ($) {
    "use strict";

}(window.jQuery);

var AnalyticsPortalModule = (function () {
    var _evento = {
        virtualEvent: "virtualEvent",
        productDetails: "productDetails",
        productClick: "productClick",
        productImpression: "productImpression",
        socialEvent: "socialEvent",
        addToCart: "addToCart"
    };


    var _texto = {
        excepcion: "Excepción en AnalyticsPortal.js > ",
        estandar: "Estándar",
        fichaProducto: "Ficha de Producto",
        iniciarVideo: "Iniciar Video",
        seleccionTonoCombo: "Selección Tono - ComboBox",
        seleccionTonoCuadro: "Selección Tono - Cuadrados",
        migajaPan: "Breadcrumb",
        // Ini - Analytics Buscador Miguel
        notavaliable: "(not avaliable)",
        // Fin - Analytics Buscador Miguel
    };


    var _constantes = {
        simboloSolPeru: "S/.",
        solPeru: "PEN",
        // Ini - Analytics Buscador Miguel
        isTest: false,
        currencyCodes: [{ "Country": "Peru", "CountryCode": "PE", "Currency": "Nuevo Sol", "Code": "PEN" }, { "Country": "Venezuela", "CountryCode": "VE", "Currency": "Bolivar", "Code": "VEF" }, { "Country": "Bolivia", "CountryCode": "BO", "Currency": "Boliviano", "Code": "BOB" }, { "Country": "Chile", "CountryCode": "CL", "Currency": "Chilean Peso", "Code": "CLP" }, { "Country": "Brazil", "CountryCode": "BR", "Currency": "Brazil", "Code": "BRL" }, { "Country": "Colombia", "CountryCode": "CO", "Currency": "Peso", "Code": "COP" }, { "Country": "Costa Rica", "CountryCode": "CR", "Currency": "Costa Rican Colon", "Code": "CRC" }, { "Country": "Ecuador", "CountryCode": "EC", "Currency": "Sucre", "Code": "ECS" }, { "Country": "El Salvador", "CountryCode": "SV", "Currency": "Salvadoran Colon", "Code": "SVC" }, { "Country": "United States", "CountryCode": "US", "Currency": "USD", "Code": "USD" },],
        seccionesPalanca: [{ "CodigoSeccion": "LAN", "Palanca": "Lo Nuevo" }, { "CodigoSeccion": "RD", "Palanca": "Revista  Digital" }, { "CodigoSeccion": "HV", "Palanca": "Herramientas de Ventas" }, { "CodigoSeccion": "ODD", "Palanca": "Ofertas del día" }, { "CodigoSeccion": "SR", "Palanca": "ShowRoom" }],
        origenpedidoWeb: [{ "CodigoPalanca": "00", "Palanca": "Ofertas Para Ti" }, { "CodigoPalanca": "01", "Palanca": "Showroom" }, { "CodigoPalanca": "02", "Palanca": "Lanzamientos" }, { "CodigoPalanca": "03", "Palanca": "Oferta Del Día" }, { "CodigoPalanca": "04", "Palanca": "Oferta Final" }, { "CodigoPalanca": "05", "Palanca": "GND" }, { "CodigoPalanca": "06", "Palanca": "Liquidación" }, { "CodigoPalanca": "07", "Palanca": "Producto Sugerido" }, { "CodigoPalanca": "08", "Palanca": "Herramientas de Venta" }, { "CodigoPalanca": "09", "Palanca": "Banners" }, { "CodigoPalanca": "10", "Palanca": "Digitado" }, { "CodigoPalanca": "11", "Palanca": "Catalogo Lbel" }, { "CodigoPalanca": "12", "Palanca": "Catalogo Esika" }, { "CodigoPalanca": "13", "Palanca": "Catalogo Cyzone" }],
        origenpedidoWebHome: [{ "Codigo": "010306", "Descripcion": "Banner Header" }, { "Codigo": "010601", "Descripcion": "Liquidaciones Web" }, { "Codigo": "010001", "Descripcion": "Club GANA+" }],
        paginas: [{ "CodigoPagina": "00", "Pagina": "Landing Herramientas de Venta" }, { "CodigoPagina": "01", "Pagina": "Home" }, { "CodigoPagina": "02", "Pagina": "Pedido" }, { "CodigoPagina": "03", "Pagina": "Landing Liquidación" }, { "CodigoPagina": "04", "Pagina": "Buscador" }, { "CodigoPagina": "05", "Pagina": "Landing Showroom" }, { "CodigoPagina": "06", "Pagina": "Landing GND" }, { "CodigoPagina": "07", "Pagina": "Landing Ofertas Para Ti" }, { "CodigoPagina": "08", "Pagina": "Contenedor" }, { "CodigoPagina": "09", "Pagina": "Otras" }, { "CodigoPagina": "10", "Pagina": "Landing Buscador" }],
        secciones: [{ "CodigoSeccion": "01", "Seccion": "Carrusel" }, { "CodigoSeccion": "02", "Seccion": "Ficha" }, { "CodigoSeccion": "03", "Seccion": "Banner" }, { "CodigoSeccion": "04", "Seccion": "Desplegable Buscador" }, { "CodigoSeccion": "05", "Seccion": "Carrusel Ver Más" }, { "CodigoSeccion": "06", "Seccion": "Banner Superior" }, { "CodigoSeccion": "07", "Seccion": "Sub Campaña" }],
        codigoPais: !(typeof userData === 'undefined') ? userData.pais : ""
        // Fin - Analytics Buscador Miguel
    };


    var marcarVerFichaProducto = function (tipoMoneda, producto, cuv, precio, marca, categoria, variante, palanca) {
        try {
            dataLayer.push({
                "event": _evento.productDetails,
                "ecommerce": {
                    "currencyCode": tipoMoneda,
                    "detail": {
                        "products": [{
                            "name": producto,
                            "id": cuv,
                            "price": precio,
                            "brand": marca,
                            "category": categoria || "",
                            "variant": variante == "" ? _texto.estandar : variante,
                            "dimension11": palanca
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var fcVerificarTipoMoneda = function (simboloMoneda) {
        tipoMoneda = "";
        try {
            switch (simboloMoneda) {
                case _constantes.simboloSolPeru:
                    tipoMoneda = _constantes.solPeru;
                    break;
            }
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
        return tipoMoneda;
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
            console.log(_texto.exception + e);
        }
    }

    var marcarCambiaColorCombo = function (producto, tono) {
        try {
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": _texto.fichaProducto,
                "action": _texto.seleccionTonoCombo,
                "label": producto + " - " + tono
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }

    var marcarCambiaColorCuadro = function (producto, tono) {
        try {
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": _texto.fichaProducto,
                "action": _texto.seleccionTonoCuadro,
                "label": producto + " - " + tono
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcarAgregaProductoCarro = function (tipoMoneda, producto, precio, marca, cuv, categoria, variante, cantidad, palanca) {
        try {
            dataLayer.push({
                "event": _evento.addToCart,
                "ecommerce": {
                    "currencyCode": tipoMoneda,
                    "add": {
                        "products": [
                            {
                                "name": producto,
                                "price": precio,
                                "brand": marca,
                                "id": cuv,
                                "category": categoria || "",
                                "variant": variante,
                                "quantity": cantidad,
                                "dimension11": palanca,
                                "dimension12": _texto.fichaProducto
                            }
                        ]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }

    var marcarComparteRedesSociales = function (producto, tono) {
        try {
            dataLayer.push({
                'event': _evento.socialEvent,
                'socialNetwork': '{red_social}',
                'socialAction': 'Share',
                'socialTarget': '{url_producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }




    var marcarClicSetProductos = function (infoItem) {

        var tipoMoneda = AnalyticsPortalModule.FcVerificarTipoMoneda(variablesPortal.SimboloMoneda);


        try {
            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': tipoMoneda,
                    'click': {
                        'actionField': {
                            'list': infoItem.DescripcionCompleta + ' – Set productos'
                        },
                        'products': [{
                            'name': infoItem.DescripcionCompleta,
                            'id': infoItem.CUV2,
                            'price': infoItem.Precio2,
                            'brand': infoItem.DescripcionMarca,
                            'category': infoItem.CodigoCategoria,
                            'variant': (infoItem.CodigoVariante !== "" || (typeof infoItem.CodigoVariante === "undefined")) ? infoItem.CodigoVariante : 'Estándar',
                            'position': infoItem.Posicion
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }


    }
    //Impresiones por productos en el carrusel
    var marcarImpresionSetProductos = function (ArrayItems) {


        var tipoMoneda = AnalyticsPortalModule.FcVerificarTipoMoneda(variablesPortal.SimboloMoneda);
        try {
            dataLayer.push({
                'event': _evento.productImpression,
                'ecommerce': {
                    'currencyCode': tipoMoneda,
                    'impressions': [
                        ArrayItems
                    ]
                }
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }


    }

    var marcarFichaBreadcrumb = function (opcion) {
        try {
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": _texto.fichaProducto,
                "action": _texto.migajaPan,
                "label": opcion || ""
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    // Ini - Analytics Buscador Miguel
        var getCurrencyCodes = function (codigoPais) {
            try {

                var currencyInfo = _constantes.currencyCodes.find(function (element) {
                    return element.CountryCode == codigoPais;
                });
                return currencyInfo != undefined ? currencyInfo.Code : _texto.notavaliable;
            } catch (e) {
                console.log(_texto.excepcion + e);
            }
        };

        var getPalancaBySeccion = function (codigoSeccion) {
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
                var codigoPalanca = codigoOrigenPedido.toString().substring(3, 5);
                var seccion = _constantes.origenpedidoWeb.find(function (element) {
                    return element.CodigoPalanca == codigoPalanca;
                });
                return seccion != undefined ? seccion.Palanca : _texto.notavaliable;
            } catch (e) {
                console.log(_texto.excepcion + e);
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

        var getContenedorByOrigenPedido = function (event, codigoOrigenPedido) {
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

                //var esCarrusel = seccion.Seccion == "Carrusel";
                var esVerMas = typeof seccion !== "undefined" ? seccion.Seccion == "Carrusel Ver Más" : false;
                var esFicha = typeof seccion !== "undefined" ? seccion.Seccion == "Ficha" : false;
                var esCarrusel = false;
                if (!(event == null)) {
                    var elementCarrusel = $(event.target).closest("div:has(*[data-item-tag])");
                    var esCarrusel = elementCarrusel.hasClass("content_item_carrusel");
                }
                var contenedorFicha = esCarrusel ? _texto.contenedorDetalleSets : _texto.contenedorDetalle;
                switch (pagina.Pagina) {
                    case "Home": !esFicha ? contenedor = "Contenedor - Home" : contenedor = contenedorFicha; break;
                    case "Contenedor": !esFicha ? contenedor = "Contenedor - Home" : contenedor = contenedorFicha; break;
                    case "Landing Ofertas Para Ti": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                    case "Pedido": contenedor = "Carrito de compras"; break;
                    case "Otras": contenedor = !esFicha ? _texto.contenedor : contenedor = contenedorFicha; break;
                    case "Landing Showroom": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                    case "Landing GND": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                    case "Landing Herramientas de Venta": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                    case "Landing Liquidación": !esFicha ? contenedor = _texto.contenedor : contenedor = contenedorFicha; break;
                    case "Buscador": contenedor = "Buscador"; break;

                }

                return contenedor;
            } catch (e) {
                console.log(_texto.excepcion + e);
            }
        };

    var marcaBarraBusqueda = function ()
    {
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
    var marcaAnadirCarritoGenerico = function (event, codigoOrigenPedido, estrategia)
    {
        try {
            var codigoPagina = codigoOrigenPedido.toString().substring(1, 3);       

            var pagina = _constantes.paginas.find(function (element) {
                return element.CodigoPagina == codigoPagina;
            });

            var model = {
                'DescripcionProd': estrategia.DescripcionCompleta,
                'CUV': estrategia.PrecioVenta,
                'PrecioUnidad': estrategia.DescripcionMarca,
                'DescripcionMarca': estrategia.CUV2,
                'Cantidad': estrategia.Cantidad
            };

            var valorBuscar = localStorage.getItem('valorBuscador');
            switch (pagina.Pagina) {
                case "Buscador": AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, codigoOrigenPedido, valorBuscar); break;
               
            }

        } catch (e) {

        }
    }
    
    
    var marcaEligeUnaOpcion = function (url)
    {
        try {
            var esMobile = url.includes("Mobile");
            var value = esMobile ? $("#CampoBuscadorProductosMobile").val() : $("#CampoBuscadorProductos").val();
            localStorage.setItem('valorBuscador', value);
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Buscador SB',
                'action': 'Elige tu opción',
                'label': value,
                'eventCallback': function () {
                    document.location = url
                }
            });

        } catch (e) {

        }
    }

    var marcaAnadirCarritoBuscador = function (model, origenPedidoWebEstrategia, campoBuscar)
    {
        try {
            var desplegable = "Desplegable";
            if ($.isNumeric(campoBuscar) && campoBuscar.length == 5 )
                desplegable = "Desplegable por CUV";
            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(origenPedidoWebEstrategia);
            var contenedor = AnalyticsPortalModule.GetContenedorByOrigenPedido(null, origenPedidoWebEstrategia);
            var lista = contenedor + " - " + palanca + " - " + desplegable;
            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
                    'add': {
                        'actionField': { 'list': lista },
                        'products': [{
                            'name': model.DescripcionProd,
                            'id': model.CUV,
                            'price': model.PrecioUnidad,
                            'brand': model.DescripcionMarca,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'quantity': mode.Cantidad

                        }]
                    }
                }
            });
        } catch (e) {
        }
    }

    var marcaSeleccionarContenidoBusqueda = function (busqueda)
    {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Buscador SB',
                'action': 'Buscar',
                'label': busqueda
            });
        } catch (e) {

        }
    }
    // Fin - Analytics Buscador Miguel

    return {
        MarcarVerFichaProducto: marcarVerFichaProducto,
        FcVerificarTipoMoneda: fcVerificarTipoMoneda,
        MarcarIniciarPlayVideo: marcarIniciarPlayVideo,
        MarcarCambiaColorCombo: marcarCambiaColorCombo,
        MarcarCambiaColorCuadro: marcarCambiaColorCuadro,
        MarcarAgregaProductoCarro: marcarAgregaProductoCarro,
        MarcarComparteRedesSociales: marcarComparteRedesSociales,
        MarcarClicSetProductos: marcarClicSetProductos,
        MarImpresionSetProductos: marcarImpresionSetProductos,
        MarcarFichaBreadcrumb: marcarFichaBreadcrumb,
        // Inicio - Analytics Buscador Miguel
        MarcaBarraBusqueda: marcaBarraBusqueda,
        GetCurrencyCodes: getCurrencyCodes,
        GetPalancaBySeccion: getPalancaBySeccion,
        GetPalancaByOrigenPedido: getPalancaByOrigenPedido,
        GetSeccionHomeByOrigenPedido: getSeccionHomeByOrigenPedido,
        GetContenedorByOrigenPedido: getContenedorByOrigenPedido,
        MarcaEligeUnaOpcion: marcaEligeUnaOpcion,
        MarcaBarraBusquedaMobile: marcaBarraBusquedaMobile,
        MarcaAnadirCarritoBuscador: marcaAnadirCarritoBuscador,
        MarcaSeleccionarContenidoBusqueda: marcaSeleccionarContenidoBusqueda,
        MarcaAnadirCarritoGenerico: marcaAnadirCarritoGenerico
        // Fin - Analytics Buscador Miguel
    }
})();