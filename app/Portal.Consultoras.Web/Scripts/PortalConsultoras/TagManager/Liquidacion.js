

function TagManagerClickAgregarProductoLiquidacion(item) {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Home - Liquidaciones Web' },
                'products': [
                    {
                        'name': item.descripcionProd,
                        'price': item.PrecioUnidad,
                        'brand': item.descripcionMarca,
                        'id': item.CUV,
                        'category': 'NO DISPONIBLE',
                        'variant': item.descripcionEstrategia,
                        'quantity': parseInt(item.Cantidad),
                        'position': parseInt(item.Posicion)
                    }
                ]
            }
        }
    });
}
