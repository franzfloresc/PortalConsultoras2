"use strict";

var belcorp = belcorp || {};
belcorp.showroom = belcorp.showroom || {};
belcorp.showroom.initialize = function (config) {
    var self = this;

    function initBindings() {
        $(config.element).on("click", document.Body, desactivarBanner)
    }


    function desactivarBanner(banner) {
        desactivarPromise()
        .then(function () {
            $(banner).hide();
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