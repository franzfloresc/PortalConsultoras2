
var pagina = "";

function TagManagerCarruselInicio(arrayItems) {
    arrayItems = arrayItems || new Array();
    pagina = isHome() ? "Home" : "Pedido";
    var cantidadRecomendados = $('#divListadoEstrategia').find(".slick-active").length;
    var arrayEstrategia = [];
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = arrayItems[i];
        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': $.trim(recomendado.Precio2),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – ' + pagina,
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);
    }
    var add = false;

    if (arrayEstrategia.length > 0) {
        add = true;
        if (!isMobile()) {
            add = false;
            var sentListEstrategia = false;
            if (typeof (Storage) !== 'undefined') {
                var nunX = isHome() ? "1" : "2";
                var sle = localStorage.getItem('sentListEstrategia' + nunX);
                if (sle !== null && sle === '1') {
                    sentListEstrategia = true;
                }
                else {
                    localStorage.setItem('sentListEstrategia' + nunX, '1');
                }
            }

            if (!sentListEstrategia) {
                add = true;
            }
        }
    }

    if (add) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}

function TagManagerClickAgregarProductoOfertaParaTI(item) {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Ofertas para ti – Home' },
                'products': [
                    {
                        'name': (item.DescripcionResumen + " " + item.DescripcionCortada).trim(),
                        'price': item.Precio2.toString(),
                        'brand': item.DescripcionMarca,
                        'id': item.CUV2,
                        'category': 'NO DISPONIBLE',
                        'variant': (item.DescripcionEstrategia === undefined) ? "Estándar" : item.DescripcionEstrategia,
                        'quantity': parseInt(item.Cantidad),
                        'position': parseInt(item.posicionItem)

                    }
                ]
            }
        }
    });
}


