
/*
 * SECCION DE MARCACIONES DE ANALYTICS PARA ACCESO REVISTA DIGITAL 
 * 
 */

function AccessRDAnalytics(source) {
    switch (source) {
    case "home":
        VirtualEventPush("Home", "Ésika para mí", "Click banner Ver todas mis ofertas");
        return false;
    case "catalogo":
        VirtualEventPush("Catálogos y revistas", "Ésika para mí", "Click banner Ver todas mis ofertas");
        return false;
    case "pedido":
        VirtualEventPush("Pedido", "Ésika para mí", "Click banner Ver todas mis ofertas");
        return false;
    default:
        return false;
    }
}

function TabsRDAnalytics(label, campaniaId) {
    var category = "Ésika para mí";
    switch (label) {
    case "x":
            VirtualEventPush(category, "Click tab", "Comprar campaña " + campaniaId);
        return false;
    case "x1":
            VirtualEventPush(category, "Click tab", "Ver campaña " + campaniaId);
        return false;
    case "info":
            VirtualEventPush(category, "Click tab", "Saber más de Ésika para mí");
        return false;
    default:
        return false;
    }
}

function VerLanzamientoHomeRDAnalytics() {
    if (isMobile())
        VirtualEventPush("MobileHome", "Ésika para mí", "Ver más lanzamientos");
    else
        VirtualEventPush("Home", "Ésika para mí", "Ver más lanzamientos");
    return false;
}

function OrdenarProductoRDAnalytics(label) {
    VirtualEventPush("Ésika para mí", "Ordenar", label);
    return false;
}

function FiltrarProductoRDAnalytics(label) {
    VirtualEventPush("Ésika para mí", "Filtrar por marca", label);
    return false;
}

function AgregarProductoRDAnalytics(source, name, price, brand, id, variant, quantity) {
    switch (source) {
    case "carrusel-lan":
        AddToCartPush("Esika para mí - Banner Principal", name, price, brand, id, variant, quantity);
        return false;
    case "popup-detalle":
        AddToCartPush("Esika para mí - Detalle Banner Principal", name, price, brand, id, variant, quantity);
        return false;
    case "mis-ofertas":
        AddToCartPush("Esika para mí - Mis Ofertas", name, price, brand, id, variant, quantity);
        return false;
    case "detalle-lan":
        AddToCartPush("Esika para mí - Detalle Mis Ofertas", name, price, brand, id, variant, quantity);
        return false;
    default:
        return false;
    }
}

function VerDetalleComprarRDAnalytics(source, name, price, brand, id, variant, quantity) {
    switch (source) {
    case "carrusel-lan":
        ProductClickPush("Esika para mí - Banner Principal", name, price, brand, id, variant, quantity);
        return false;
    case "popup-detalle":
        ProductClickPush("Esika para mí - Detalle Banner Principal", name, price, brand, id, variant, quantity);
        return false;
    case "mis-ofertas":
        ProductClickPush("Esika para mí - Mis Ofertas", name, price, brand, id, variant, quantity);
        return false;
    case "detalle-lan":
        ProductClickPush("Esika para mí - Detalle Mis Ofertas", name, price, brand, id, variant, quantity);
        return false;
    default:
        return false;
    }
}

function AgregarProductoDeshabilitadoRDAnalytics(source, campania, name) {
    var category = "Ésika para mí";
    var label = campania + " - " + name;
    switch (source) {
    case "carrusel-lan":
        VirtualEventPush(category, "Agregar producto - Banner Principal", label);
        return false;
    case "popup-detalle":
        VirtualEventPush(category, "Agregar producto - Detalle Banner Principal", label);
        return false;
    case "mis-ofertas":
        VirtualEventPush(category, "Agregar producto - Mis Ofertas", label);
        return false;
    case "detalle-lan":
        VirtualEventPush(category, "Agregar producto - Detalle Mis Ofertas", label);
        return false;
    default:
        return false;
    }
}

function VerDetalleDeshabilitadoRDAnalytics(source, name) {
    var category = "Ésika para mí";
    var label = campania + " - " + name;
    VirtualEventPush(category, "Ver producto", label);
}

function CompartirProductoRDAnalytics(tipo, url, name) {
    var category = "Ésika para mí";
    url = "{" + url + "}";
    var label = name + " - " + url;

    switch (tipo) {
    case "facebook":
        SocialEventPush("Google", "+1", url);
        return false;
    case "wharsapp":
        VirtualEventPush(category, "Enviar por Whatsapp", label);
        return false;
    case "youtube-inicio":
        VirtualEventPush(category, "Iniciar video", label);
        return false;
    case "youtube-fin":
        VirtualEventPush(category, "Finalizar video", label);
        return false;
    default:
        return false;
    }
}

/*
 * SECCION DE ANALYTICS PARA REVISTA DIGITAL
 * 
 */

function MostrarPopupRDAnalytics() {
    PromotionViewPush("Revista Online - Inscribirme a Ésika para mí",
        "Home pop-up - 1",
        "Banner");
}

function InscripcionRDAnalytics() {
    PromotionClickPush("Revista Online - Inscribirme a Ésika para mí",
        "Home pop-up - 1",
        "Banner");
}

function SuscripcionExistosaRDAnalytics() {
    VirtualEventPush("Revista Online", "Suscripción Exitosa", "(not available)");
}

function SaberMasRDAnalytics() {
    VirtualEventPush("Revista Online", "Click Botón", "Saber más de Ésika para mí");
}

function CerrarPopUpRDAnalytics(tipoBanner) {
    VirtualEventPush("Revista Online", "Cerrar popup", tipoBanner);
}

function IrCancelarSuscripcionRDAnalytics() {
    VirtualEventPush("Revista Online", "Click Link Cancelar Suscripción", "Banner");
}

function CancelarSuscripcionRDAnalytics() {
    VirtualEventPush("Revista Online", "Cancelar inscripción", "(not available)");
}

/*
 * SECCION DE ANALYTICS GENERICOS
 * 
 */

function VirtualEventPush(category, action, label) {
    dataLayer.push({
        "event": "virtualEvent",
        "category": category,
        "action": action,
        "label": label
    });
}

function PromotionClickPush(name, position, creative) {
    dataLayer.push({
        "event": "promotionClick",
        "ecommerce": {
            "promoView": {
                "promotions": [
                    {
                        "id": "1",
                        "name": name,
                        "position": position,
                        "creative": creative
                    }]
            }
        }
    });
}

function PromotionViewPush(name, position, creative) {
    dataLayer.push({
        "event": "promotionView",
        "ecommerce": {
            "promoView": {
                "promotions": [
                    {
                        "id": "1",
                        "name": name,
                        "position": position,
                        "creative": creative
                    }]
            }
        }
    });
}

function AddToCartPush(list, name, price, brand, id, variant, quantity) {
    dataLayer.push({
        "event": "addToCart",
        "ecommerce": {
            "currencyCode": "PEN",
            "add": {
                "actionField": { "list": list },
                "products": [
                    {
                        "name": name,
                        "price": price,
                        "brand": brand,
                        "id": id,
                        "category": "",
                        "variant": variant,
                        "quantity": quantity
                    }
                ]
            }
        }
    });
}

function ProductClickPush(list, name, price, brand, id, variant, quantity) {
    dataLayer.push({
        "event": "productClick",
        "ecommerce": {
            "currencyCode": "PEN",
            "click": {
                "actionField": { "list": list },
                "products": [{
                    "name": name,
                    "id": id,
                    "price": price,
                    "brand": brand,
                    "category": "",
                    "variant": variant,
                    "position": quantity
                }]
            }
        }
    });
}

function SocialEventPush(socialNetwork, socialAction, socialUrl) {
    dataLayer.push({
        'event': 'socialEvent',
        'socialNetwork': socialNetwork,
        'socialAction': socialAction,
        'socialUrl': socialUrl
    });
}