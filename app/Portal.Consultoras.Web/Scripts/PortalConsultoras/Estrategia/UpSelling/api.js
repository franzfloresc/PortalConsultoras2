"use strict";

var belcorp = belcorp || {};
belcorp.estrategias = belcorp.estrategias || {};
belcorp.estrategias.upselling = belcorp.estrategias.upselling || {};
belcorp.estrategias.upselling.api = belcorp.estrategias.upselling.api || {};
belcorp.estrategias.upselling.api.initialize = function (config) {
    var self = this;
    var settings = {
        urlUpSellingObtenerRegalos: config.urlUpSellingObtenerRegalos,
        urlUpSellingGuardar: config.urlUpSellingGuardar,
        urlUpSellingEliminar: config.urlUpSellingEliminar,
        urlUpSellingActualizarCabecera: config.urlUpSellingActualizarCabecera,
    };

    self.upSellingRegalosObtenerPromise = function (upsellingId) {
        return jQuery.ajax({
            type: "GET",
            url: settings.urlUpSellingObtenerRegalos,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: {
                upsellingId: upsellingId
            },
            async: true
        });
    }

    self.upSellingEliminarPromise = function (upsellingId) {
        return jQuery.ajax({
            type: "POST",
            url: settings.urlUpSellingEliminar,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ upsellingId: upsellingId }),
            async: true
        });
    }

    self.upSellingActualizarCabeceraPromise = function (upSellingModel) {
        return jQuery.ajax({
            type: "POST",
            url: settings.urlUpSellingActualizarCabecera,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(upSellingModel),
            async: true
        });
    }

    self.upSellingGuardarPromise = function (upSellingModel) {
        return jQuery.ajax({
            type: "POST",
            url: settings.urlUpSellingGuardar,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(upSellingModel),
            async: true
        });
    }
}