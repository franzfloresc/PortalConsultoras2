var AsesoraOnline = function (config) {
    var _config = {
        asesoraOnlineUrl: config.asesoraOnlineUrl || '',
        cerrarPopupInicialUrl: config.cerrarPopupInicialUrl || '',
        codigoConsultora: config.codigoConsultora || '',
        isoPais: config.isoPais || '',
        origen: 'SB',
        actualizarEstadoConfiguracionPaisDetalleUrl: config.actualizarEstadoConfiguracionPaisDetalleUrl || ''
    };

    var _armarAsesoraOnlineUrl = function (isoPais, codigoConsultora, origen) {
        return _config.asesoraOnlineUrl + '?param=' + isoPais + codigoConsultora + origen;
    };

    var _hidePopup = function () {

        waitingDialog();
        $.post(config.cerrarPopupInicialUrl)
            .always(closeWaitingDialog)
            .done(function () {
                _dataLayerVirutalCoach("Banner Inscribirme a Mi Guía Digital", "Cerrar popup");
                $("#fondoComunPopUp").hide();
                $("#virtual-coach-dialog").hide();
            })
    };

    var _actualizarEstadoConfiguracionPaisDetalle = function (isoPais, codigoConsultora) {
        var params = {
            isoPais: typeof isoPais === "undefined" ? '' : isoPais,
            codigoConsultora: typeof codigoConsultora === "undefined" ? '' : codigoConsultora
        };

        jQuery.ajax({
            type: 'POST',
            url: _config.actualizarEstadoConfiguracionPaisDetalleUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                if (data.success) {
                    _hidePopup();
                }
            },
            error: function (data, error) {
                _hidePopup();
            }
        });
    };

    var _asignarEventos = function (isoPais, codigoConsultora) {

        $("#quiero-tips-ofertas").on("click", function () {

            dataLayer.push({
                'event': 'promotionClick',
                'ecommerce': {
                    'promoClick': {
                        'promotions': [{
                            'id': TipoPopUpMostrar,
                            'name': 'Coach Virtual - Inscribirme a Mi Guía Digital',
                            'position': 'Home pop-up',
                            'creative': 'Banner'
                        }]
                    }
                }
            });
            window.location = _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen) + '#formulario-inscripcion';
        });
        $("#ver-mas-informacion").on("click", function () {
            _dataLayerVirutalCoach("Banner Inscribirme a Mi Guía Digital", "Ver más Información");
            window.location = _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen);
        });
        $("#cerrar-virtual-coach-dialog").on("click", _hidePopup);
        $("#no-volver-mostrar-mensaje").on("click", function () {
            _dataLayerVirutalCoach("Banner Inscribirme a Mi Guía Digital", "No volver a ver este mensaje");
            _actualizarEstadoConfiguracionPaisDetalle(isoPais, codigoConsultora);
        });
    };

    var _mostrar = function () {
        $("#fondoComunPopUp").show();
        $("#virtual-coach-dialog").show();

        dataLayer.push({
            'event': 'promotionView',
            'ecommerce': {
                'promoView':
                {
                    'promotions': [{
                        'id': TipoPopUpMostrar,
                        'name': 'Coach Virtual - Inscribirme a Mi Guía Digital',
                        'position': 'Home pop-up',
                        'creative': 'Banner'
                    }]
                }
            }
        });

    };
    var _dataLayerVirutalCoach = function (action, label) {

        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Coach Virtual',
            'action': action,
            'label': label
        });
    };
    return {
        asignarEventos: _asignarEventos,
        mostrar: _mostrar,
        hidePopup: _hidePopup
    }
}