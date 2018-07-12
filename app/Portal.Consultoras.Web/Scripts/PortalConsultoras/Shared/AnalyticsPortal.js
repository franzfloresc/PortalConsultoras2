
if (!jQuery) { throw new Error("AnalyticsPortal.js requires jQuery"); }

+function ($) {
    "use strict";

}(window.jQuery);

var AnalyticsPortalModule = (function () {
    var _evento = {
        virtualEvent: "virtualEvent",
        productDetails: "productDetails"
    };

    var _texto = {
        excepcion: "Excepción en AnalyticsPortal.js > ",
        estandar: "Estándar",
        fichaProducto: "Ficha de Producto",
        iniciarVideo: "Iniciar Video",
        seleccionTonoCombo: "Selección Tono - ComboBox",
        selectionTonoCuadro: "Selección Tono - Cuadro"
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
                            "category": categoria,
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

    return {
        MarcarVerFichaProducto: marcarVerFichaProducto,
        FcVerificarTipoMoneda: fcVerificarTipoMoneda,
        MarcarIniciarPlayVideo: marcarIniciarPlayVideo,
        MarcarCambiaColorCombo: marcarCambiaColorCombo
    }
})();