//virtualEvent('Buscador SB', 'Búsqueda - sin Resultados', valorBusqueda);
function virtualEvent(category, action, label) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': category,
        'action': action,
        'label': label
    });
}

function virtualEventAddToCart(currencyCode, list, name, brand, id, category, variant, quantity) {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'currencyCode': currencyCode,
            'add': {
                'actionField': {
                    'list': list
                },
                'products': [{
                    'name': name,
                    'price': price,
                    'brand': brand,
                    'id': id,
                    'category': category,
                    'variant': variant,
                    'quantity': quantity
                }]
            }
        }
    });
}