var rdPopup = (function () {
    "use strict"

    var _constants = {
        PopupSuscripcion: 'PopRDSuscripcion',
        PopupSuscripcionId: '#PopRDSuscripcion',
        PopupSuscripcionTemplate: "#RDPopup-template"
    }

    var _url = {
        urlPopupDatos: baseUrl + 'RevistaDigital/PopupDatos'
    };

    var _elements = {

    };

    var _setting = {
        NoVolverMostrar: false
    };

    var _popupCrear = function (modelo) {
        SetHandlebars(_constants.PopupSuscripcionTemplate, modelo, _constants.PopupSuscripcionId);
    };

    var MostrarPopup = function () {

        if (typeof PopupMostrar === "undefined" || _setting.NoVolverMostrar) {
            return false;
        }

        AbrirLoad();
        $.ajax({
            type: 'POST',
            url: _url.urlPopupDatos,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                CerrarLoad();
                if (data.success === false || data.modelo === undefined) {
                    return false;
                }
                _setting.NoVolverMostrar = true;
                _popupCrear(data.modelo);
                PopupMostrar(_constants.PopupSuscripcion);
                if (rdAnalyticsModule) {
                    rdAnalyticsModule.MostrarPopup();
                }
            },
            error: function (data, error) {
                CerrarLoad();
            }
        });
    };
    
    return {
        MostrarPopup: MostrarPopup
    };

})();