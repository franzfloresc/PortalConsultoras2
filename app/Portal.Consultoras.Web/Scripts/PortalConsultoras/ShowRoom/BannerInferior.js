"use strict";

var belcorp = belcorp || {};
belcorp.showroom = belcorp.showroom || {};
belcorp.showroom.initialize = function (config) {
    var self = this;

    function initBindings() {
        if (config.botonCerrar) {
            config.botonCerrar.addEventListener("click", desactivarBanner);

            dataLayer.push({
                'event': 'promotionView',
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': config.banner.id,
                                'name': 'Banner Ofertas Insuperables',
                                'position': 'Home Pop-up',
                                'creative': 'Banner'
                            }]
                    }
                }
            });

            var child = config.banner.firstElementChild;
            if (child)
                child.addEventListener("click", redirect);
        }

    }

    function redirect() {
        if (config.urlRedirectBarra != "") {

            dataLayer.push({
                'event': 'promotionClick',
                'ecommerce': {
                    'promoClick': {
                        'promotions': [
                            {
                                'id': config.banner.id,
                                'name': 'Ofertas Insuperables',
                                'position': 'Home Pop-up',
                                'creative': 'Banner Pop-up'
                            }]
                    }
                }
            });

            document.location.href = config.urlRedirectBarra;
        }
        return false;
    }

    function desactivarBanner(banner) {
        desactivarPromise()
        .then(function (result) {
            if (!result.Success)
                err(result);

            config.banner.style.display = "none";

            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home',
                'action': 'Ofertas Insuperables',
                'label': 'Cerrar Pop-up'
            });

        }, err);
    }

    function desactivarPromise() {
        return jQuery.ajax({
            type: "GET",
            url: config.urlDesactivarBarra,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true
        });
    }

    function err(message) {
        console.log(message);
    }

    initBindings();
}
