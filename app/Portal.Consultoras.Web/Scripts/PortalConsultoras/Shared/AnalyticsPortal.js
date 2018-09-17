
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

        contenedorfichaProducto: "Contenedor - Ficha de producto",
    };

    var _constantes = {
        simboloSolPeru: "S/.",
        solPeru: "PEN"
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

    //Nuevos métodos para HU EMP-1442 (Jira)
    var marcarImagenProducto = function (opcion, detalle) {
        try {
            dataLayer.push({
                "event": _evento.virtualEvent,
                "category": _texto.contenedorfichaProducto,
                "action": 'Seleccionar imagen del producto',
                "label": opcion.DescripcionCompleta + " - " + detalle[0].NombreBulk
            });
        } catch (e) {
            console.log(_texto.exception + e);
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
            console.log(_texto.exception + e);
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
            console.log(_texto.exception + e);
        }
    }
    var marcarPopupBotonEligeloSoloUno = function (opcion, componentes) {
        try {
            dataLayer.push({
                'event': _evento.virtualEvent,
                'category': 'Contenedor - Pop up Elige 1 opción',
                'action': 'Elígelo',
                'label': opcion.DescripcionCompleta + '-' + componentes.HermanosSeleccionados[0].NombreBulk
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarBotonAplicarSeleccion = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige 1 opción',
                'action': 'Aplicar selección',
                'label': '{Nombre del producto} - {variedad del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarEliminarOpcionSeleccionada = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige 1 opción',
                'action': 'Desenmarcar Producto',
                'label': '{Nombre del producto} - {variedad del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarCambiarOpcion = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Ficha de producto',
                'action': 'Cambiar opción',
                'label': '{nombre del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarPopupEligeXOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Ficha de producto',
                'action': 'Ver Popup Elige más de una opción',
                'label': '{Nombre del set de productos}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarPopupCerrarEligeXOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Cerrar pop up Elige más de una opción',
                'label': '{Nombre del set de productos}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarPopupBotonEligeloVariasOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Elígelo',
                'label': '{Nombre del producto} - {variedad del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarPopupBotonAplicarSeleccionVariasOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Aplicar selección',
                'label': '{Nombre de los productos seleccionados}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarEliminarOpcionSeleccionadaVariasOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': 'Desenmarcar opción',
                'label': ' {Nombre del producto} - {variedad del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarAumentardisminuirOpcionProducto = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Pop up Elige más de una opción',
                'action': '{Operación realizada}',
                'label': ' {Nombre del producto} - {variedad del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }
    var marcarCambiarOpcionVariasOpciones = function (opcion) {
        try {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Contenedor - Ficha de producto',
                'action': 'Cambiar opciones',
                'label': ' {Nombre del producto}'
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }

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
        MarcarCambiarOpcionVariasOpciones: marcarCambiarOpcionVariasOpciones
    }
})();