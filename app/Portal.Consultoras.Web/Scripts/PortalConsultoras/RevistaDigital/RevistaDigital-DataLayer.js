
/*
 * SECCION DE MARCACIONES DE ANALYTICS PARA ACCESO REVISTA DIGITAL 
 * 
 */

function AccessRDAnalytics(source) {
    if(source === 'home')
        VirtualEventPush('Home', 'Ésika para mí', 'Click banner Ver todas mis ofertas');
    else if (source === 'catalogo')
        VirtualEventPush('Catálogos y revistas', 'Ésika para mí', 'Click banner Ver todas mis ofertas');
    else if (source === 'pedido')
        VirtualEventPush('Pedido', 'Ésika para mí', 'Click banner Ver todas mis ofertas');
}

function TabsRDAnalytics(label, campaniaId) {
    if (label === 'x')
        VirtualEventPush('Ésika para mí', 'Click tab', 'Comprar campaña ' + campaniaId);
    else if (label === 'x1')
        VirtualEventPush('Ésika para mí', 'Click tab', 'Ver campaña ' + campaniaId);
    else if (label === 'saber')
        VirtualEventPush('Ésika para mí', 'Click tab', 'Saber más de Ésika para mí');
}

function VerLanzamientoHomeRDAnalytics() {
    if (isMobile())
        VirtualEventPush('MobileHome', 'Ésika para mí', 'Ver más lanzamientos');
    else
        VirtualEventPush('Home', 'Ésika para mí', 'Ver más lanzamientos');
}

function OrdenarProductoRDAnalytics(label) {
    VirtualEventPush('Ésika para mí', 'Ordenar', label);
}

function FiltrarProductoRDAnalytics(label) {
    VirtualEventPush('Ésika para mí', 'Filtrar por marca', label);
}

function AgregarProductoCarruselLanRDAnalytics() {
    
}

/*
 * SECCION DE ANALYTICS PARA REVISTA DIGITAL
 * 
 */

function MostrarPopupRDAnalytics() {
    PromotionViewPush('Revista Online - Inscribirme a Ésika para mí',
        'Home pop-up - 1',
        'Banner');
}

function InscripcionRDAnalytics() {
    PromotionClickPush('Revista Online - Inscribirme a Ésika para mí',
        'Home pop-up - 1',
        'Banner');
}

function SuscripcionExistosaRDAnalytics() {
    VirtualEventPush('Revista Online', 'Suscripción Exitosa', '(not available)');
}

function SaberMasRDAnalytics() {
    VirtualEventPush('Revista Online', 'Click Botón', 'Saber más de Ésika para mí');
}

function CerrarPopUpRDAnalytics(tipoBanner) {
    VirtualEventPush('Revista Online', 'Cerrar popup', tipoBanner);
}

function IrCancelarSuscripcionRDAnalytics() {
    VirtualEventPush('Revista Online', 'Click Link Cancelar Suscripción', 'Banner');
}

function CancelarSuscripcionRDAnalytics() {
    VirtualEventPush('Revista Online', 'Cancelar inscripción', '(not available)');
}

/*
 * SECCION DE ANALYTICS GENERICOS
 * 
 */

function VirtualEventPush(category, action, label) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': category,
        'action': action,
        'label': label
    });
}

function PromotionClickPush(name, position, creative) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoView': {
                'promotions': [
                    {
                        'id': '1',
                        'name': name,
                        'position': position,
                        'creative': creative
                    }]
            }
        }
    });
}

function PromotionViewPush(name, position, creative) {
    dataLayer.push({
        'event': 'promotionView',
        'ecommerce': {
            'promoView': {
                'promotions': [
                    {
                        'id': '1',
                        'name': name,
                        'position': position,
                        'creative': creative
                    }]
            }
        }
    });
}

function AddToCartPush(list, name, price, brand, id, variant, quantity) {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'currencyCode': 'PEN',
            'add': {
                'actionField': { 'list': list },
                'products': [
                    {
                        'name': name,
                        'price': price,
                        'brand': brand,
                        'id': id,
                        'category': '',
                        'variant': variant,
                        'quantity': quantity
                    }
                ]
            }
        }
    });
}