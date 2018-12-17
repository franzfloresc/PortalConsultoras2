
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


