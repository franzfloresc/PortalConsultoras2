﻿
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
        seleccionTonoCuadro: "Selección Tono - Cuadrados"
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

    var marcarAgregaProductoCarro = function (producto, tono) {
        try {
            dataLayer.push({
                'event': _evento.addToCart,
                'ecommerce': {
                    'currencyCode': 'PEN',
                    'add': {
                        'products': [
                            {
                                'name': 'Labial Color HD Alta Definición',
                                'price': '19.90',
                                'brand': 'Esika',
                                'id': '13223',
                                'category': 'Maquillaje > Cuerpo',
                                'variant': 'Fucsia Vibrante',
                                'quantity': 2,
                                'dimension11': '{nombre_palanca}',
                                'dimension12': 'Ficha de producto'
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

    var marcarSlideCarruselProducto = function (producto, tono) {
        try {
            dataLayer.push({
                'event': _evento.productImpression,
                'ecommerce': {
                    'currencyCode': 'PEN',
                    'impressions': [
                        {
                            'name': 'Giulia Free EDP',
                            'id': '873654577',
                            'price': '44.90',
                            'brand': 'Cyzone',
                            'category': 'Maquillaje > Cuerpo',
                            'variant': 'Estándar',
                            'list': '{nombre_producto} - Set productos',
                            'position': 1
                        },
                        {
                            'name': 'Blazer Taylor',
                            'id': '873274577',
                            'price': '89.90',
                            'brand': 'Cyzone',
                            'category': 'Moda',
                            'variant': 'Estándar',
                            'list': '{nombre_producto} - Set productos',
                            'position': 2
                        }]
                }
            });
        } catch (e) {
            console.log(_texto.exception + e);
        }
    }

    var marcarClicSetProductos = function (producto, tono) {
        try {
            dataLayer.push({
                'event': _evento.productClick,
                'ecommerce': {
                    'currencyCode': 'PEN',
                    'click': {
                        'actionField': {
                            'list': '{nombre_producto} – Set productos'},
                            'products': [{
                              'name': 'LABIAL COLORFIX XP',
                              'id': '8648756835',
                              'price': '56.00',
                              'brand': 'Cyzone',
                              'category': 'Maquillaje > Cuerpo',
                              'variant': 'Estándar',
                                'position': 1
                            }]
                            }
                            }
            });
        } catch (e) {
            console.log(_texto.exception + e);
>>>>>>> 408ce44f7a80f37abcc04742de0372efff29ee47
        }
    }

    return {
        MarcarVerFichaProducto: marcarVerFichaProducto,
        FcVerificarTipoMoneda: fcVerificarTipoMoneda,
        MarcarIniciarPlayVideo: marcarIniciarPlayVideo,
        MarcarCambiaColorCombo: marcarCambiaColorCombo,
<<<<<<< HEAD
        MarcarCambiaColorCuadro: marcarCambiaColorCuadro
=======

        MarcarCambiaColorCuadro: marcarCambiaColorCuadro,
        MarcarAgregaProductoCarro: marcarAgregaProductoCarro,
        MarcarComparteRedesSociales: marcarComparteRedesSociales,
        MarcarSlideCarruselProducto: marcarSlideCarruselProducto,
        MarcarClicSetProductos: marcarClicSetProductos
>>>>>>> 408ce44f7a80f37abcc04742de0372efff29ee47
    }
})();