
if (!jQuery) { throw new Error("AnalyticsPortal.js requires jQuery"); }

+function ($) {
    "use strict";

}(window.jQuery);

var AnalyticsPortalModule = (function () {
    var _evento = {
        virtualEvent: "virtualEvent",
        virtualRemoveEvent: "removeFromCart",
        productDetails: "productDetails",
        productClick: "productClick",
        productImpression: "productImpression",
        socialEvent: "socialEvent",
        addToCart: "addToCart",
        //Inicio Analytics Home 1
        promotionView:"promotionView",
        //Fin Analytics Home 1
        //Inicio Analytics Ofertas
        promotionClick: "promotionClick",
        productCheckout: "productCheckout"
        //Fin Analytics Ofertas
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
        // Ini - Analytics Ofertas (Miguel)
        eligetuopcion: "eligetuopcion",
        verdetalle: "verdetalle",
        contenedor: "Contenedor",
        contenedorDetalle: "Contenedor - Detalle de Producto",
        contenedorDetalleSets: "Contenedor - Detalle de Producto - Ver más Sets",
        contenedorRevisar: "Contenedor - Revisar",
        CarritoCompras: "Carrito de compras"
        // Fin - Analytics Ofertas (Miguel)
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
        origenpedidoWebEstrategia: [{ "Codigo": "1020001", "Descripcion": "Desktop Pedido Ofertas Para Ti Carrusel" }, { "Codigo": "2020001", "Descripcion": "Mobile Pedido Ofertas Para Ti Carrusel" }],
        paginas: [{ "CodigoPagina": "00", "Pagina": "Landing Herramientas de Venta" }, { "CodigoPagina": "01", "Pagina": "Home" }, { "CodigoPagina": "02", "Pagina": "Pedido" }, { "CodigoPagina": "03", "Pagina": "Landing Liquidación" }, { "CodigoPagina": "04", "Pagina": "Buscador" }, { "CodigoPagina": "05", "Pagina": "Landing Showroom" }, { "CodigoPagina": "06", "Pagina": "Landing GND" }, { "CodigoPagina": "07", "Pagina": "Landing Ofertas Para Ti" }, { "CodigoPagina": "08", "Pagina": "Contenedor" }, { "CodigoPagina": "09", "Pagina": "Otras" }, { "CodigoPagina": "10", "Pagina": "Landing Buscador" }],
        secciones: [{ "CodigoSeccion": "01", "Seccion": "Carrusel" }, { "CodigoSeccion": "02", "Seccion": "Ficha" }, { "CodigoSeccion": "03", "Seccion": "Banner" }, { "CodigoSeccion": "04", "Seccion": "Desplegable Buscador" }, { "CodigoSeccion": "05", "Seccion": "Carrusel Ver Más" }, { "CodigoSeccion": "06", "Seccion": "Banner Superior" }, { "CodigoSeccion": "07", "Seccion": "Sub Campaña" }],
        codigoPais: !(typeof userData === 'undefined') ? userData.pais : "",
        // Fin - Analytics Buscador Miguel
         // Ini - Analytics Ofertas
        contenedorHome: "Contenedor - Home",
        campania: "Campaña "
          // Fin - Analytics Ofertas
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

    

    var marcarClicSetProductos = function (infoItem, event, origenPedidoWebEstrategia, estoyEnLaFicha) {
         
       // var $btnAgregar = $(event.target);
       // var origenPedidoWebEstrategia = EstrategiaAgregarModule.GetOrigenPedidoWeb($btnAgregar);
        var tipoMoneda = AnalyticsPortalModule.FcVerificarTipoMoneda(variablesPortal.SimboloMoneda);
        var contenedor = AnalyticsPortalModule.GetContenedorByOrigenPedido(event, origenPedidoWebEstrategia, estoyEnLaFicha);
        

        try {
            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': tipoMoneda,
                    'click': {
                        'actionField': {
                            'list': contenedor + " - Campaña "+  $('#hdCampaniaCodigo').val()
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

                //var esCarrusel = seccion.Seccion == "Carrusel";
                var esVerMas = typeof seccion !== "undefined" ? seccion.Seccion == "Carrusel Ver Más" : false;
                var esFicha = typeof seccion !== "undefined" ? seccion.Seccion == "Ficha" : false;
                var esCarrusel = false;
                if (!(event == null)) {
                    var elementCarrusel = $(event.target || event).parents("[data-item]");
                    esCarrusel = elementCarrusel.hasClass("slick-slide");
                }
                //if (estoyEnLaFicha !== "undefined")
                if (typeof window.fichaModule !== "undefined")
                    esFicha = true;

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
            var _pagina = pagina.Pagina;
            if (pagina.Pagina.includes("Landing"))
                _pagina = "Landing";

            var valorBuscar = localStorage.getItem('valorBuscador');
            switch (_pagina) {
                case "Buscador": AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, codigoOrigenPedido, valorBuscar); break;
                case "Home": seccion.Seccion == "Banner Superior" ? AnalyticsPortalModule.MarcaAnadirCarritoHomeBanner(null, codigoOrigenPedido, estrategia) : AnalyticsPortalModule.MarcaAnadirCarritoHome(null, codigoOrigenPedido, estrategia); break;
                // Inicio Analytics Oferta Miguel
                case "Contenedor": AnalyticsPortalModule.MarcaAnadirCarrito(event, codigoOrigenPedido, estrategia); break;
                case "Landing": AnalyticsPortalModule.MarcaAnadirCarrito(event, codigoOrigenPedido, estrategia); break;
                case "Pedido": AnalyticsPortalModule.MarcaAnadirCarrito(event, codigoOrigenPedido, estrategia); break;
                 // Fin Analytics Oferta Miguel
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
             // Inicio Analytics Ofertas 
            var esLanding = typeof listaSeccion === 'undefined' ? false : true;
            // Fin Analytics Ofertas Miguel

            switch (seccion) {
                case _codigoSeccion.HOME: AnalyticsPortalModule.MarcaProductImpressionHome(seccion, data, limit); break;
                case _codigoSeccion.HOMEOFERTA: AnalyticsPortalModule.MarcaPromotionViewOferta(seccion, data); break;
                 // Inicio Analytics Ofertas  
                case _codigoSeccion.LAN: AnalyticsPortalModule.MarcaPromotionViewBanner(seccion, data); break;
                case _codigoSeccion.HV: esLanding ? AnalyticsPortalModule.MarcaProductImpression(seccion, data) : AnalyticsPortalModule.MarcaProductImpressionLanding(seccion, data); break;
                case _codigoSeccion.RD: esLanding ? AnalyticsPortalModule.MarcaProductImpression(seccion, data) : AnalyticsPortalModule.MarcaProductImpressionLanding(seccion, data); break;
                case _codigoSeccion.ODD: esLanding ? AnalyticsPortalModule.MarcaProductImpression(seccion, data) : AnalyticsPortalModule.MarcaProductImpressionLanding(seccion, data); break;
                case _codigoSeccion.CART: AnalyticsPortalModule.MarcaProductImpressionCart(seccion, data); break;
                case _codigoSeccion.SR: esLanding ? AnalyticsPortalModule.MarcaProductImpression(seccion, data) : AnalyticsPortalModule.MarcaProductImpressionLanding(seccion, data); break;

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

        var pagina = _constantes.paginas.find(function (element) {
            return element.CodigoPagina == codigoPagina;
        });

        var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigenPedido);
        var _pagina = pagina.Pagina;
        if (pagina.Pagina.includes("Landing"))
            _pagina = "Landing";
        try {
            switch (_pagina) {

                case "Home": AnalyticsPortalModule.MarcaDetalleProductoBienvenida(element, codigoOrigenPedido); break;
                case "Contenedor": palanca == "Lanzamientos" ? AnalyticsPortalModule.MarcaClicBanner(element) : AnalyticsPortalModule.MarcaDetalleProducto(element); break;
                //case "Pedido": AnalyticsPortalModule.MarcaDetalleProductoCarrito(data); break;
                case "Pedido": AnalyticsPortalModule.MarcaDetalleProductoCarrito(element); break;
                case "Landing": AnalyticsPortalModule.MarcaDetalleProducto(element); break;
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
                var promotions = AnalyticsPortalModule.AutoMapperV2(codigoSeccion, data);
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

    //Add by JNIZAMA
    var autoMapperV2 = function (codigoSeccion, data) {
        var collection = [];
        if (codigoSeccion == _codigoSeccion.LAN) {
            var element = $("[data-seccion=" + codigoSeccion + "]");
            var codigo = element.data("origenpedidoweb");
            $.each(data, function (index) {
                var item = data[index];
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

    function fnObtenerContenedor(event) {

        var estoyEnLaFicha = typeof fichaModule !== "undefined";
        var esLanding = typeof listaSeccion === 'undefined' ? true : false;
        //var esOfertas = window.controllerName == "ofertas" ? true : false;
        //var esOfertas = window.controllerName == "ofertas" ? true : false;
        var esRevisar = window.actionName == "revisar" ? true : false;
        var contenedor = "";



        switch (window.controllerName)
        {
            case "ofertas": contenedor = esRevisar ? _texto.contenedorRevisar : _constantes.contenedorHome; break;
            case "pedido": contenedor = _texto.contenedorRevisar; break;
            default: contenedor = _texto.contenedor; break;
        }

        //if (estoyEnLaFicha) {
        //    var elementCarrusel = $(event.target).closest("div:has(*[data-item-tag])");
        //    var esCarrusel = elementCarrusel.hasClass("content_item_carrusel");

        //    if (esCarrusel)
        //        contenedor = _texto.contenedorDetalleSets;
        //    else
        //        contenedor = _texto.contenedorDetalle;

        //}
        //else if (_constantes.esCarrito)
        //    contenedor = $("#hdfichaContenedor").val();
        //else if (esOfertas) {
        //    if (esRevisar)
        //        contenedor = _texto.contenedorRevisar;
        //    else
        //        contenedor = _constantes.contenedor;
        //}
        //else {
        //    if (esRevisar)
        //        contenedor = _texto.contenedorRevisar;
        //    else
        //        contenedor = _texto.contenedor;
        //}

        return contenedor;
    }

    /*
* 1.2.3. Clic en Banner
* Nombre Archivo Desktop: Views\EstrategiaPersonalizada\presentacion-seccion-carrusel-individuales.cshtml
* Linea de Código Desktop: 56
*/
    var marcaClicBanner = function (data) {
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
                                'position': _constantes.contenedor || _constantes.contenedorHome,
                                'creative': 'Banner'
                            }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    /*
*1.3. Secciones de contenedor
*1.3.1. Ver más ofertas
* Nombre Archivo Desktop: Scripts\PortalConsultoras\Shared\MenuContenedor.js
* Linea de Código Desktop: 284
*/
    var marcaClicVerMasOfertas = function (url, origenPedido) {
        try {
            if (_constantes.isTest)
                alert("Marcación Ver más ofertas.");

            var esRevisar = window.actionName == "revisar" ? true : false;
            var nombreBoton = "Ver más Ofertas";
            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(origenPedido);
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': fnObtenerContenedor(),
                'action': esRevisar ? 'Click Botón' + ' - ' + palanca : 'Click Botón' + ' - ' + nombreBoton,
                'label': esRevisar ? nombreBoton : palanca,
                'eventCallback': function () {
                    document.location = url;
                }
            });

        } catch (e) {
            document.location = url;
            console.log(_texto.excepcion + e);
        }

    }

    /*
* 1.3.2. Product Impression
* Nombre Archivo Desktop: Scripts\PortalConsultoras\RevistaDigital\RevistaDigital-Landing.js
* Linea de Código Desktop: 261,262,263
*/
    var marcaProductImpression = function (codigoSeccion, data) {
        try {
            if (_constantes.isTest)
                alert("Marcación product impression.");

            var element = $("[data-seccion=" + codigoSeccion + "]");
            var codigo = element.data("origenpedidoweb");
            var lista = data.lista;
            var campania = lista[0];

            var cantidadMostrar = listaSeccion[codigoSeccion + "-" + campania.CampaniaID] == undefined ? lista.length : listaSeccion[codigoSeccion + "-" + campania.CampaniaID].CantidadProductos;
            var contenedor = fnObtenerContenedor();


            var palanca = codigoSeccion == "ODD" ? AnalyticsPortalModule.GetPalancaBySeccion(codigoSeccion) : AnalyticsPortalModule.GetPalancaByOrigenPedido(codigo);
            var impressions = [];
            $.each(lista, function (index) {
                if (index == cantidadMostrar)
                    return false;
                var item = lista[index];
                var impression = {
                    'id': item.CUV2,
                    'name': item.DescripcionCompleta,
                    'price': item.PrecioVenta,
                    'brand': item.DescripcionMarca,
                    'category': _texto.notavaliable,
                    'variant': _texto.estandar,
                    'list': contenedor + " - " + palanca + " - " + _constantes.campania + campania.CampaniaID,
                    'position': index + 1
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

    var marcaProductImpressionLanding = function (codigoSeccion, data) {
        try {     

            if (_constantes.isTest)
                alert("Marcación product impression.");

            var codigo = $("#RDListado").data("origenpedidoweb");
            var lista = data.lista;
            var campania = lista[0];

            var cantidadMostrar = lista.length;
            var contenedor = _texto.contenedor;


            var palanca = codigoSeccion == "ODD" || codigoSeccion == "SR" ? AnalyticsPortalModule.GetPalancaBySeccion(codigoSeccion) : AnalyticsPortalModule.GetPalancaByOrigenPedido(codigo);
            var impressions = [];
            $.each(lista, function (index) {
                if (index == cantidadMostrar)
                    return false;
                var item = lista[index];
                var impression = {
                    'id': item.CUV2,
                    'name': item.DescripcionCompleta,
                    'price': item.PrecioVenta,
                    'brand': item.DescripcionMarca,
                    'category': _texto.notavaliable,
                    'variant': _texto.estandar,
                    'list': contenedor + " - " + palanca + " - " + _constantes.campania + campania.CampaniaID,
                    'position': index + 1
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

    /*
* 2.1.7.2. Visualizar productos
* Nombre Archivo Desktop: 
* Linea de Código Desktop: 
*/
    var marcaProductImpressionCart = function (codigoSeccion, data) {
        try {

            if (!_constantes.esCarrito)
                return;
            if (_constantes.isTest)
                alert("Marcación product impression cart.");
            var lista = data.lista;
            var campania = lista[0];
            var impressions = [];
            $.each(lista, function (index) {
                if (index == 4)
                    return false;
                var item = lista[index];
                var impression = {
                    'id': item.CUV2,
                    'name': item.DescripcionCompleta,
                    'price': item.PrecioVenta,
                    'brand': item.DescripcionMarca,
                    'category': _texto.notavaliable,
                    'variant': _texto.estandar,
                    'list': "Carrito de compras – Club Gana+",
                    'position': index + 1
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

    /* 
    *  1.3.3. Añadir al carrito
    * Nombre Archivo Desktop: Scripts\PortalConsultoras\EstrategiaAgregar\EstrategiaAgregar.js
    * Linea de Código Desktop: 309
 */
    var marcaAnadirCarrito = function (event, codigoOrigen, data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic añadir al carrito.");

            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoOrigen);
            var contenedor = AnalyticsPortalModule.GetContenedorByOrigenPedido(event, codigoOrigen);
            var esCarrusel = false;
            if (!(event == null)) {
                var elementCarrusel = $(event.target || event).parents("[data-item]");
                esCarrusel = elementCarrusel.hasClass("slick-slide");
            }

            var producto = data;
            var list = "";
            //Si es carrusel de la ficha
            if (esCarrusel)
                list = contenedor + " - " + _constantes.campania + producto.CampaniaID;
            else
               list = contenedor + " - " + palanca + " - " + _constantes.campania + producto.CampaniaID;

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

    /*
    *   1.3.4. Detalles de producto
    * Nombre Archivo Desktop: Scripts\PortalConsultoras\EstrategiaPersonalizada\EstrategiaUrls.js
    * Linea de Código Desktop: 3
 */
    var marcaDetalleProducto = function (data) {
        try {


            var esLanding = typeof listaSeccion === 'undefined' ? true : false;
             esLanding ? AnalyticsPortalModule.MarcaDetalleProductoPrincipalLanding(data) : AnalyticsPortalModule.MarcaDetalleProductoPrincipal(data);
           


        } catch (e) {
            console.log(_texto.excepcion + e);
        }

    }

    var marcaDetalleProductoPrincipal = function (data) {
        try {

            if (_constantes.isTest)
                alert("Marcación clic detalle producto.");

            var contenedor = fnObtenerContenedor();
            var codigoSeccion = $(data).closest("div:has(.seccion-content-contenedor)").data("seccion");
            var codigoorigen = $(data).parents("[data-OrigenPedidoWeb]").data("origenpedidoweb");
            var palanca = codigoSeccion == "ODD" ? AnalyticsPortalModule.GetPalancaBySeccion(codigoSeccion) : AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoorigen);
            var text = $(data).data("item-tag");
            var eq = text == _texto.verdetalle ? ":eq(2)" : ":eq(4)";
            var item = $(data).parents(eq).find("div [data-estrategia]").data("estrategia");
            var list = contenedor + " - " + palanca + " - " + _constantes.campania + item.CampaniaID;


            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
                    'click': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': item.DescripcionCompleta,
                            'id': item.CUV2,
                            'price': item.PrecioVenta,
                            'brand': item.DescripcionMarca,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'position': 1
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    var marcaDetalleProductoPrincipalLanding = function (data) {
        try {
            if (_constantes.isTest)
                alert("Marcación clic detalle producto.");

            var contenedor = fnObtenerContenedor();
            var codigoSeccion = $(data).parents("[data-OrigenPedidoWeb]").data("origenpedidoweb");
            var palanca = AnalyticsPortalModule.GetPalancaByOrigenPedido(codigoSeccion);
            var text = $(data).data("item-tag");
            var eq = text == _texto.verdetalle ? ":eq(2)" : ":eq(4)";
            var item = $(data).parents(eq).find("div [data-estrategia]").data("estrategia");
            var list = contenedor + " - " + palanca + " - " + _constantes.campania + item.CampaniaID;

            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
                    'click': {
                        'actionField': { 'list': list },
                        'products': [{
                            'name': item.DescripcionCompleta,
                            'id': item.CUV2,
                            'price': item.PrecioVenta,
                            'brand': item.DescripcionMarca,
                            'category': _texto.notavaliable,
                            'variant': _texto.estandar,
                            'position': 1
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }


    var marcaDetalleProductoCarrito = function (data) {
        try {

            var item = $(data).parents(":eq(2)").find("div [data-estrategia]").data("estrategia");

            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Carrito de compras – Club Gana+',
                'action': 'Ver detalles de producto',
                'label': item.DescripcionCompleta + " - " + item.DescripcionMarca
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    /*
     * 1.4. Catálogos de ofertas (visualizar todos los productos de una palanca)
     * 1.4.1. Visualización de producto
     * Nombre Archivo Desktop:  Scripts\PortalConsultoras\RevistaDigital\RevistaDigital-Landing.js
     * Linea de Código Desktop: 265
  */
    var marcaVisualizacionProducto = function (data) {
        try {
            if (_constantes.isTest)
                alert("marcación visualización de producto.");

            var impressions = [];
            $.each(data.lista, function (index) {
                var item = data.lista[index];
                var impression = { "name": item.DescripcionCompleta, "id": item.CUV2, "price": item.PrecioVenta, "brand": item.DescripcionMarca, "category": _constantes.notavaliable, "variant": _constantes.estandar, "list": _texto.contenedor, "position": index + 1 };
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

    /*
    * 1.4.4. Filtros
    * Nombre Archivo Desktop:  /Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js
    * Linea de Código Desktop: 31
    */
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
            var contenedor = AnalyticsPortalModule.GetContenedorByOrigenPedido(null,codigoOrigenWeb);
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

    var marcaCompartirRedesSociales = function (tipo,url)
    {
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

    /*
     * 1.5.2. Visualizar detalle de producto
     * Nombre Archivo Desktop: Scripts\PortalConsultoras\DetalleEstrategia\FichaModule.js
     * Linea de Código Desktop: 177
  */
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
                    'currencyCode': AnalyticsPortalModule.GetCurrencyCodes(_constantes.codigoPais),
                    'detail': {
                        'products': products
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }

    /*
     * 1.5.4. Visualizar lista de otros productos
     * Nombre Archivo Desktop: Scripts\PortalConsultoras\DetalleEstrategia\CarruselModule.js
     * Linea de Código Desktop: 177
  */
    var marcaVisualizarOtrosProductos = function (data) {
        try {

            var contenedor = "Contenedor - Detalle de Producto - Ver más Sets - ";
            var impressions = [];
            $.each(data, function (index) {
                var item = data[index];
                var impression = { "id": item.CUV2, "name": item.DescripcionCompleta, "price": item.PrecioVenta, "brand": item.DescripcionMarca, "category": _texto.notavaliable, "variant": _texto.estandar, "list": contenedor + _constantes.campania + item.CampaniaID, "position": item.Posicion };
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
                            'ListaProducto': 'Contenedor - Home - ' + palanca + " - Campaña "+  $('#hdCampaniaCodigo').val()
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
    var marcarPedidoGuardoExito = function() {
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

    /*
* 2.1.6. Pedido guardado con éxito
* Nombre Archivo Desktop: 
* Linea de Código Desktop: 
*/
    var marcaGuardarPedidoExito = function (data) {
        var arrayEstrategiasAnalytics = [];
        data.pedidoDetalle = data.pedidoDetalle || [];
        $.each(data.pedidoDetalle, function (index, value) {
            var estrategia = {
                'name': value.name,
                'id': value.id,
                'price': $.trim(value.price),
                'brand': value.brand,
                'category': "NO DISPONIBLE",
                'variant': value.variant == "" ? "Estándar" : value.variant,
                'quantity': value.quantity
            };
            arrayEstrategiasAnalytics.push(estrategia);
        });
        
        try {
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
            console.log(_texto.excepcion + e);
        }
    }

    /*
* 2.1.7. Ofertas club gana más
* 2.1.7.1. Ver ofertas
* Nombre Archivo Desktop: 
* Linea de Código Desktop: 
*/
    var marcaVerOfertas = function (origenPedidoWebEstrategia) {
        origenPedidoWebEstrategia = origenPedidoWebEstrategia || "";
        var codigo = origenPedidoWebEstrategia.toString();
        var seccion = _constantes.origenpedidoWebEstrategia.find(function (element) {
            return element.Codigo === codigo;
        });

        if (origenPedidoWebEstrategia.toString() !== seccion.Codigo.toString()) return;
        try {
            if (_constantes.isTest)
                alert("Marcación clic ver ofertas.");
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Carrito de compras – Gana+',
                'action': 'Click Botón',
                'label': 'Ver Ofertas'
            });
        } catch (e) {

        }
    };

/*
* 2.1.7. Ofertas club gana más
* 2.1.7.3. Agregar productos
*/
    //var marcaAgregarProductosCarrito = function (data) {
    //    var arrayEstrategiasAnalytics = [];
    //    data.pedidoDetalle = data.pedidoDetalle || [];
    //    $.each(data.pedidoDetalle, function (index, value) {
    //        var estrategia = {
    //            'name': value.name,
    //            'id': value.id,
    //            'price': $.trim(value.price),
    //            'brand': value.brand,
    //            'category': "NO DISPONIBLE",
    //            'variant': value.variant == "" ? "Estándar" : value.variant,
    //            'quantity': value.quantity
    //        };
    //        arrayEstrategiasAnalytics.push(estrategia);
    //    });

    //    try {
    //        dataLayer.push({
    //            'event': _evento.addToCart,
    //            'ecommerce': {
    //                'currencyCode': "PEN",
    //                'add': {
    //                    'actionField': { 'list': "Carrito de compras - Club Gana+" },
    //                    'products': arrayEstrategiasAnalytics
    //                }
    //            }
    //        });


    //    } catch (e) {
    //        console.log(_texto.excepcion + e);
    //    }
    //};

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
        // Inicio - Analytics Buscador 
        GetCurrencyCodes: getCurrencyCodes,
        GetPalancaBySeccion: getPalancaBySeccion,
        GetPalancaByOrigenPedido: getPalancaByOrigenPedido,
        GetSeccionHomeByOrigenPedido: getSeccionHomeByOrigenPedido,
        GetContenedorByOrigenPedido: getContenedorByOrigenPedido,
        MarcaAnadirCarritoGenerico: marcaAnadirCarritoGenerico,
        // Fin - Analytics Buscador 
        // Inicio Analytics Home 1 
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
        MarcarRemoveFromCart: marcarRemoveFromCart,

        MarcaVerTodoMiPedido: marcaVerTodoMiPedido,
        // Fin Analytics Home 1 
        // Inicio Analytics Ofertas  
        MarcaClicFlechaBanner: marcaClicFlechaBanner,
        MarcaPromotionViewBanner: marcaPromotionViewBanner,
        AutoMapper: autoMapper,
        AutoMapperV2: autoMapperV2,
        MarcaClicBanner: marcaClicBanner,
        MarcaClicVerMasOfertas: marcaClicVerMasOfertas,
        MarcaProductImpression: marcaProductImpression,
        MarcaProductImpressionLanding: marcaProductImpressionLanding,
        MarcaProductImpressionCart: marcaProductImpressionCart,
        MarcaAnadirCarrito: marcaAnadirCarrito,
        MarcaDetalleProducto: marcaDetalleProducto,
        MarcaDetalleProductoPrincipal: marcaDetalleProductoPrincipal,
        MarcaDetalleProductoPrincipalLanding: marcaDetalleProductoPrincipalLanding,
        MarcaDetalleProductoCarrito: marcaDetalleProductoCarrito,
        MarcaVisualizacionProducto: marcaVisualizacionProducto,
        MarcaManagerFiltros: marcaManagerFiltros,
        MarcaCompartirRedesSociales: marcaCompartirRedesSociales,
        MarcaVisualizarDetalleProducto: marcaVisualizarDetalleProducto,
        MarcaVisualizarOtrosProductos: marcaVisualizarOtrosProductos,
        MarcaEliminarPedidoCompleto: marcaEliminarPedidoCompleto,
        MarcarGuardaTuPedido: marcarGuardaTuPedido,
        MarcarPedidoGuardoExito: marcarPedidoGuardoExito,
        MarcaGuardarPedidoExito: marcaGuardarPedidoExito,
        MarcaVerOfertas: marcaVerOfertas
        //MarcaAgregarProductosCarrito: marcaAgregarProductosCarrito
         // Fin Analytics Ofertas
        
    }
})();