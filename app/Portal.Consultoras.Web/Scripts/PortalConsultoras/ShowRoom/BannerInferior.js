"use strict";

var belcorp = belcorp || {};
belcorp.showroom = belcorp.showroom || {};
belcorp.showroom.initialize = function (config) {
    var self = this;

    function initBindings() {
        config.botonCerrar.addEventListener("click", desactivarBanner)
    }


    function desactivarBanner(banner) {
        desactivarPromise()
        .then(function (result) {
            if (!result.Success)
                err(result);

            config.banner.style.display = "none";
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