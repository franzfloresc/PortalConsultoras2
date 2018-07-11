var AnalyticsPortal = {
    _evento: {
        virtualEvent: "virtualEvent",
        productDetails: "productDetails"
    },

    _texto: {
        excepcion: "Excepción en AnalyticsPortal.js > ",
        estandar: "Estándar"
    },

    fcEnviarProducto: function (tipoMoneda, producto, cuv, precio, marca, categoria, variante = _texto.estandar, palanca) {
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
                            "variant": variante || _texto.estandar,
                            "dimension11": palanca
                        }]
                    }
                }
            });
        } catch (e) {
            console.log(_texto.excepcion + e);
        }
    }
};