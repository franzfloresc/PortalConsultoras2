
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
        addToCart: "addToCart",
        //Inicio Analytics Home 1
        promotionView:"promotionView"
        //Fin Analytics Home 1
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

    // Inicio - Analytics Home 1 (Miguel)
    var _codigoSeccion = {
        LAN: "LAN",
        HV: "HV",
        RD: "RD",
        SR: "SR",
        CART: "CART",
        ODD: "ODD",
        HOME: "HOME",
        HOMEOFERTA: "HOMEOFERTA"
    };
    // Fin - Analytics Home 1 (Miguel)

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
                            'name':     infoItem.DescripcionCompleta,
                            'id':       infoItem.CUV2,
                            'price':    infoItem.Precio2,
                            'brand':    infoItem.DescripcionMarca,
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

    var marcaAnadirCarritoGenerico = function (event, codigoOrigenPedido, estrategia) {
        try {
            var codigoPagina = codigoOrigenPedido.toString().substring(1, 3);
         
            var pagina = _constantes.paginas.find(function (element) {
                return element.CodigoPagina == codigoPagina;
            });

            var codigoSeccion = codigoOrigenPedido.toString().substring(5, 7);
            var seccion = _constantes.secciones.find(function (element) {
                return element.CodigoSeccion == codigoSeccion;
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
                case "Home": seccion.Seccion == "Banner Superior" ? AnalyticsPortalModule.MarcaAnadirCarritoHomeBanner(null, codigoOrigenPedido, estrategia) : AnalyticsPortalModule.MarcaAnadirCarritoHome(null, codigoOrigenPedido, estrategia); break;

            }

        } catch (e) {

        }
    }

     
    // Fin - Analytics Buscador Miguel

    // Inicio Analytics Home 1 Miguel
    var marcaGanaOfertas = function (data,url) {

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
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
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

            list = "Home" + " - " + "Banner Header";

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
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


    var marcaVerOfertasHome = function (url) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic ver ofertas.");
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Home – Banner Header',
                'action': 'Ofertas ¡SOLO HOY! - Click Botón',
                'label': 'Ver más Ofertas',
                'eventCallback': function () {
                    document.location = url;
                }
            });
        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }
    };

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

    var marcaGenericaLista = function (seccion, data, limit) {
        try {

            seccion = seccion.replace("Lista", "");

            switch (seccion) {
                case _codigoSeccion.HOME: AnalyticsPortalModule.MarcaProductImpressionHome(seccion, data, limit); break;
                case _codigoSeccion.HOMEOFERTA: AnalyticsPortalModule.MarcaPromotionViewOferta(seccion, data); break;
                 // Inicio Analytics Ofertas  
                case _codigoSeccion.LAN: AnalyticsPortalModule.MarcaPromotionViewBanner(seccion, data); break;
                // Fin Analytics Ofertas Miguel
            }
        } catch (e) {

        }

    }

    var marcaProductImpressionHome = function (codigoSeccion, data, limit) {
        try {
         
            if (_constantes.isTest)
                alert("Marcación product impression.");


            var lista = data.lista;
            var campania = lista[0];


            var impressions = [];
            $.each(lista, function (index) {
                if (index == limit)
                    return false;
                var item = lista[index];
                var impression = {
                    'id': item.CUV == undefined ? item.CUV2 : item.CUV,
                    'name': item.Descripcion == undefined ? item.DescripcionCompleta : item.Descripcion,
                    'price': item.PrecioString == undefined ? item.PrecioVenta : item.PrecioString,
                    'brand': item.DescripcionMarca == undefined ? item.DescripcionMarca : item.DescripcionMarca,
                    'category': _texto.notavaliable,
                    'variant': _texto.estandar,
                    'list': limit == 1 ? 'Home – Liquidaciones Web' : 'Home – Club GANA+',
                    'position': item.Posicion
                };

                impressions.push(impression);

            });


            dataLayer.push({
                'event': _evento.productImpression,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
                    'impressions': impressions
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    var marcaPromotionViewOferta = function (codigoSeccion, data) {
        try {
            if (_constantes.isTest)
                alert("Marcación promotion view.");

            var cuv = data.data.ListaOferta[0].CUV2;

            dataLayer.push({
                'event': _evento.promotionView,
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': cuv,
                                'name': 'Ofertas ¡SOLO HOY!',
                                'position': 'Home – Banner Header',
                                'creative': 'Banner'
                            }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    var marcaGenericaClic = function (element,codigoOrigenPedido) {
        var codigoPagina = codigoOrigenPedido.toString().substring(1, 3);

        var page = _constantes.paginas.find(function (element) {
            return element.CodigoPagina == codigoPagina;
        });
        try {
            switch (page.Pagina) {

                case "Home": AnalyticsPortalModule.MarcaDetalleProductoBienvenida(element,codigoOrigenPedido);
              
            }


        } catch (e) {

        }

    }

    var marcaDetalleProductoBienvenida = function (element, codigoOrigenPedido) {
        try {

            var item = element;

            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
                    'click': {
                        'actionField': { 'list': 'Home - Club GANA+' },
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

        var marcaClicVideoBienvenida = function () {
            try {
                if (_constantes.isTest)
                    alert("Marcación Clic seguimiento pedido.");

                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Video de Bienvenida: Iniciar Video',
                    'label': 'SomosBelcorp.com ¡se renueva para ti!'
                });

            } catch (e) {
                console.log(_texto.excepcion + e);
            }

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

    var marcaClicVideoBienvenida = function () {
        try {
            if (_constantes.isTest)
                alert("Marcación Clic seguimiento pedido.");

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home',
                'action': 'Video de Bienvenida: Iniciar Video',
                'label': 'SomosBelcorp.com ¡se renueva para ti!'
            });

        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

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

            if (codigo == _codigoSeccion.LAN)
            {
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
          
        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
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

    var marcaFlechaHome = function (flecha)
    {
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

    var marcaAnadirCarritoLiquidacion = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic añadir al carrito.");


            list = "Home" + " - " + "Liquidaciones Web";

            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
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
    // Fin Analytics Home 1 Miguel

     // Inicio Analytics Ofertas Miguel
        /*
        * 1.2. Banners
        * 1.2.1. Clic en Flechas de Banner
        * Nombre Archivo Desktop: Scripts\PortalConsultoras\EstrategiaPersonalizada\Index.js
        * Linea de Código Desktop: 367,368
        */
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

        /*
        * 1.2.2. Promotion View
        * Nombre Archivo Desktop: Scripts\PortalConsultoras\RevistaDigital\RevistaDigital-Landing.js
        * Linea de Código Desktop: 256
     */
        var marcaPromotionViewBanner = function (codigoSeccion, data) {
            try {
                if (_constantes.isTest)
                    alert("Marcación promotion view.");
                var promotions = AnalyticsPortalModule.AutoMapper(codigoSeccion, data);
                if (promotions.length == 0)
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
                console.log(_texto.excepcion + e);
            }

    }

    var autoMapper = function (codigoSeccion, data) {
        var collection = [];
        if (codigoSeccion == _codigoSeccion.LAN) {
            var element = $("[data-seccion=" + codigoSeccion + "]");
            var codigo = element.data("origenpedidoweb");
            $.each(data.lista, function (index) {
                var item = data.lista[index];
                var element = {
                    'id': item.CUV2,
                    'name': AnalyticsPortalModule.GetPalancaByOrigenPedido(codigo) + " - " + item.DescripcionCompleta + " - " + "Ver producto",
                    'position': fnObtenerContenedor(),
                    'creative': "Banner"
                };
                collection.push(element);
            });
        }

        return collection;
    };
     // Fin Analytics Ofertas Miguel

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
        GetCurrencyCodes: getCurrencyCodes,
        GetPalancaBySeccion: getPalancaBySeccion,
        GetPalancaByOrigenPedido: getPalancaByOrigenPedido,
        GetSeccionHomeByOrigenPedido: getSeccionHomeByOrigenPedido,
        GetContenedorByOrigenPedido: getContenedorByOrigenPedido,
        MarcaAnadirCarritoGenerico: marcaAnadirCarritoGenerico,
        // Fin - Analytics Buscador Miguel
        // Inicio Analytics Home 1 Miguel
        MarcaGanaOfertas: marcaGanaOfertas,
        MarcaVerOfertasHome: marcaVerOfertasHome,
        MarcaSucribete: marcaSucribete,
        MarcaGenericaLista: marcaGenericaLista,
        MarcaProductImpressionHome: marcaProductImpressionHome,
        MarcaAnadirCarritoHome: marcaAnadirCarritoHome,
        MarcaGenericaClic: marcaGenericaClic,
        MarcaDetalleProductoBienvenida: marcaDetalleProductoBienvenida,
        MarcaPromotionViewOferta: marcaPromotionViewOferta,
        MarcaNotificaciones: marcaNotificaciones,
        MarcaClicSeguimientoPedido: marcaClicSeguimientoPedido,
        MarcaClicPagarLinea: marcaClicPagarLinea,
        MarcaClicFacturacionElectronica: marcaClicFacturacionElectronica,
        MarcaComparteCatalogos: marcaComparteCatalogos,
        MarcaVerLanzamientos: marcaVerLanzamientos,
        MarcaVerMasLiquidaciones: marcaVerMasLiquidaciones,
        MarcaClicFechaLiquidacion: marcaClicFechaLiquidacion,
        MarcaClicVideoBienvenida: marcaClicVideoBienvenida,
        MarcaVerOtrasOfertasHome: marcaVerOtrasOfertasHome,
        MarcaFlechaHome: marcaFlechaHome,
        MarcaAnadirCarritoLiquidacion: marcaAnadirCarritoLiquidacion,
        MarcaAnadirCarritoHomeBanner: marcaAnadirCarritoHomeBanner,
        // Fin Analytics Home 1 Miguel
         // Inicio Analytics Ofertas  
        MarcaClicFlechaBanner: marcaClicFlechaBanner,
        MarcaPromotionViewBanner: marcaPromotionViewBanner,
        AutoMapper: autoMapper
         // Fin Analytics Ofertas Miguel
    }
})();