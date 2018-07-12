
if (!jQuery) { throw new Error("AnalyticsPortal.js requires jQuery"); }

+function ($) {
    "use strict";

}(window.jQuery);

var _evento = {
    virtualEvent: "virtualEvent",
    productDetails: "productDetails"
};

var _texto = {
    excepcion: "Excepción en AnalyticsPortal.js > ",
    estandar: "Estándar",
    fichaProducto: "Ficha de Producto",
    iniciarVideo: "Iniciar Video"
};

var _constantes = {
    simboloSolPeru: "S/.",
    solPeru: "PEN"
};

var AnalyticsPortal = {
    fcEnviarInformacionProducto: function (tipoMoneda, producto, cuv, precio, marca, categoria, variante, palanca) {
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
    },

    fcVerificarTipoMoneda: function (simboloMoneda) {
        var tipoMoneda = "";
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
    },

    fcEnviarInformacionVideo: function (producto) {
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
};