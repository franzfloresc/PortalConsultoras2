
/*
 * SECCION DE MARCACIONES DE ANALYTICS PARA ACCESO REVISTA DIGITAL 
 * 
 */

// Primer Dígito -- Plataforma
// 1: Desktop                   2: Mobile

// Segundo Dígito -- Pantalla
// 1: Home                      2: Pedido
// 3: Liquidacion               4: Catalogo Personalizado
// 5: ShowRoom                  9: General
// 6: OfertaParaTi
// 7: RevistaDigital

// Tercer Dígito -- Sección dentro de la Pantalla
// 1: Banners                   2: Ofertas para ti
// 3: Catalogo Personalizado    4: Liquidacion
// 5: Producto Sugerido         6: Oferta Final
// 7: ShowRoom                  8: Consultora Online
// 9: Oferta del dia            0: Revista Digital
// 1: index
// 2: OfertaParaTi Detalle

// Cuarto Dígito
// 1. Sin popUp                 2. Con popUp

function AccessRDAnalytics(origenWeb) {
    try {
        var origenWebString = origenWeb.toString();
        switch (origenWebString) {
            case "1101": //Home
                VirtualEventPush("Home", "Ésika para mí", "Click banner Ver todas mis ofertas");
                break;
            case "1401": //Catalogos
                VirtualEventPush("Catálogos y revistas", "Ésika para mí", "Click banner Ver todas mis ofertas");
                break;
            case "1201": //Pedido
                VirtualEventPush("Pedido", "Ésika para mí", "Click banner Ver todas mis ofertas");
                break;
            case "1103": //Lanzamiento
                VirtualEventPush("Home", "Ésika para mí", "Ver más lanzamientos");
                break;
            case "2103": //Lanzamiento mobile
                VirtualEventPush("MobileHome", "Ésika para mí", "Ver más lanzamientos");
                break;
        }
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}

function TabsRDAnalytics(label, campaniaId) {
    try {
        var category = "Ésika para mí";
        var labelString = label.toString();
        switch (labelString) {
            case "1":
                VirtualEventPush(category, "Click tab", "Comprar campaña " + campaniaId);
                break;
            case "2":
                VirtualEventPush(category, "Click tab", "Ver campaña " + campaniaId);
                break;
            case "3":
                VirtualEventPush(category, "Click tab", "Saber más de Ésika para mí");
                break;
        }
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}

function OrdenarProductoRDAnalytics(label) {
    VirtualEventPush("Ésika para mí", "Ordenar", label);
}

function FiltrarProductoRDAnalytics(label) {
    VirtualEventPush("Ésika para mí", "Filtrar por marca", label);
}

function AgregarProductoRDAnalytics(origenWeb, estrategia, popup = false) {
    try {
        var origenWebString = origenWeb.toString();
        switch (origenWebString) {
            case "1721"://Lan desktop
                if (popup) AddToCartPush("Esika para mí - Detalle Banner Principal", estrategia);
                else AddToCartPush("Esika para mí - Banner Principal", estrategia);
                break;
            case "2721"://Lan Mobile
                if (popup) AddToCartPush("Esika para mí - Detalle Banner Principal", estrategia);
                else AddToCartPush("Esika para mí - Banner Principal", estrategia);
                break;
            case "1711": //Mis Ofertas
                if (!popup) AddToCartPush("Esika para mí - Mis Ofertas", estrategia);
                break;
            case "2711": //Mis Ofertas Mobile
                AddToCartPush("Esika para mí - Mis Ofertas", estrategia);
                break;
            case "1731": //Mis Ofertas Mobile
                AddToCartPush("Esika para mí - Detalle Mis Ofertas", estrategia);
                break;
            case "2731": //Mis Ofertas Mobile
                AddToCartPush("Esika para mí - Detalle Mis Ofertas", estrategia);
                break;
        }
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}

function VerDetalleComprarRDAnalytics(origenWeb, estrategia) {
    try {
        var origenWebString = origenWeb.toString();
        switch (origenWebString) {
            case "1721":
                ProductClickPush("Esika para mí - Banner Principal", estrategia);
                break;
            case "2721":
                ProductClickPush("Esika para mí - Banner Principal", estrategia);
                break;
            case "1711":
                ProductClickPush("Esika para mí - Mis Ofertas", estrategia);
                break;
            case "2711":
                ProductClickPush("Esika para mí - Mis Ofertas", estrategia);
                break;
            case "1731": //Mis Ofertas 
                ProductClickPush("Esika para mí - Detalle Mis Ofertas", estrategia);
                break;
            case "2731": //Mis Ofertas Mobile
                ProductClickPush("Esika para mí - Detalle Mis Ofertas", estrategia);
                break;
        }
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}

function AgregarProductoDeshabilitadoRDAnalytics(origenWeb, campania, name, popup) {
    try {
        var category = "Ésika para mí";
        var label = campania + " - " + name;
        var origenWebString = origenWeb.toString();
        switch (origenWebString) {
            case "1721":
                if (popup) VirtualEventPush(category, "Agregar producto - Detalle Banner Principal", label);
                else VirtualEventPush(category, "Agregar producto - Banner Principal", label);
                break;
            case "2721":
                if (popup) VirtualEventPush(category, "Agregar producto - Detalle Banner Principal", label);
                else VirtualEventPush(category, "Agregar producto - Banner Principal", label);
                break;
            case "1711": //Mis Ofertas
                if (!popup) VirtualEventPush(category, "Agregar producto - Mis Ofertas", label);
                break;
            case "2711": //Mis Ofertas Mobile
                VirtualEventPush(category, "Agregar producto - Mis Ofertas", label);
                break;
            case "1731": //Mis Ofertas Mobile
                VirtualEventPush(category, "Agregar producto - Detalle Mis Ofertas", label);
                break;
            case "2731": //Mis Ofertas Mobile
                VirtualEventPush(category, "Agregar producto - Detalle Mis Ofertas", label);
                break;
        }
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}

function VerDetalleLanRDAnalytics(campania, name) {
    try {
        var category = "Ésika para mí";
        var label = campania + " - " + name;
        VirtualEventPush(category, "Ver producto", label);
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}

function CompartirProductoRDAnalytics(tipo, url, name) {
    try {
        var category = "Ésika para mí";
        url = "{" + url + "}";
        var label = name + " - " + url;

        switch (tipo) {
            case "FB":
                SocialEventPush("Google", "+1", url);
                break;
            case "WA":
                VirtualEventPush(category, "Enviar por Whatsapp", label);
                break;
            case "YTI":
                VirtualEventPush(category, "Iniciar video", label);
                break;
            case "YTF":
                VirtualEventPush(category, "Finalizar video", label);
                break;
        }
    } catch (e) {
        console.log("Exeption on analytics RD " + e);
    }
}
function SuscripcionExistosaRDAnalytics2() {
    VirtualEventPush("Ésika para mí", "Suscripción Exitosa", "(not available)");
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

function AddToCartPush(list, estrategia) {
    dataLayer.push({
        "event": "addToCart",
        "ecommerce": {
            "currencyCode": "PEN",
            "add": {
                "actionField": { "list": list },
                "products": [
                    {
                        "name": estrategia.DescripcionResumen,
                        "price": estrategia.Precio2,
                        "brand": estrategia.DescripcionMarca,
                        "id": estrategia.CUV2,
                        "category": "NO DISPONIBLE",
                        "variant": estrategia.DescripcionEstrategia,
                        "quantity": parseInt(estrategia.Cantidad)
                    }
                ]
            }
        }
    });
}

function ProductClickPush(list, estrategia) {
    dataLayer.push({
        "event": "productClick",
        "ecommerce": {
            "currencyCode": "PEN",
            "click": {
                "actionField": { "list": list },
                "products": [{
                    "name": estrategia.DescripcionCUV2,
                    "id": estrategia.CUV2,
                    "price": estrategia.Precio2,
                    "brand": estrategia.DescripcionMarca,
                    "category": "NO DISPONIBLE",
                    "variant": estrategia.DescripcionEstrategia,
                    "position": parseInt(estrategia.posicionItem)
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