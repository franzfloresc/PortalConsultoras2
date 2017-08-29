var AsesoraOnline = function (config) {

    var _config = {
        asesoraOnlineUrl: config.asesoraOnlineUrl || '',
        actualizarUsuarioUrl: config.actualizarUsuarioUrl || '',
        codigoConsultora: config.codigoConsultora || '',
        isoPais: config.isoPais || '',
        origen: 'SB',
        actualizarEstadoConfiguracionPaisDetalleUrl: config.actualizarEstadoConfiguracionPaisDetalleUrl || '',
        tipoPopup : config.tipoPopup

    };

    var _armarAsesoraOnlineUrl = function (isoPais, codigoConsultora, origen) {
        return _config.asesoraOnlineUrl + '?isoPais=' + isoPais + '&codigoConsultora=' + codigoConsultora + '&origen=' + origen;
    };

    var _hidePopup = function () {
        $("#fondoComunPopUp").hide();
        $("#virtual-coach-dialog").hide();
    };

    var _hidePopupModificarDatos = function () {
        $("#fondoComunPopUp").hide();
        $("#popupMisDatos").show();
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
                alert(data.message);
                _hidePopup();
            }
        });
    };

    var _asignarEventos = function (isoPais, codigoConsultora) {
        $("#quiero-tips-ofertas").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen) + '#formulario-inscripcion');
        $("#ver-mas-informacion").attr("href", _armarAsesoraOnlineUrl(_config.isoPais, _config.codigoConsultora, _config.origen));
        $("#cerrar-virtual-coach-dialog").on("click", _hidePopup);
        $("#no-volver-mostrar-mensaje").on("click",function(){ _actualizarEstadoConfiguracionPaisDetalle(isoPais, codigoConsultora);});
        $("#btnActualizarAO").on("click", _actualizarUsuario);
    };

    var _setValuesPopupModificarDatos = function () {
        $("#codigoUsurioMD").text(codigoUsuario);
        $("#nombresUsuarioMD").text(nombreConsultora);
        $("#nombreGerenteZonal").text(nombreGerenteZonal);
        $("#txtSobrenombreMD").val(sobreNombre);
        $("#txtEMailMD").val(correo);
        $("#txtTelefonoMD").val(telefono);
        $("#txtCelularMD").val(celular);
        $("#txtTelefonoTrabajoMD").val(telefonoTrabajo);
    };

    var _actualizarUsuario = function () {

        var codigoUsuario = $("#codigoUsurioMD").text();
        var nombreConsultora = $("#nombresUsuarioMD").text();
        var nombreGerenteZonal = $("#nombreGerenteZonal").text();
        var sobrenombre = $("#txtSobrenombreMD").val();
        var eMail = $("#txtEMailMD").val();
        var telefono = $("#txtTelefonoMD").val();
        var celular = $("#txtCelularMD").val();
        var telefonoTrabajo = $("#txtTelefonoTrabajoMD").val();

        var TYCchecked = $("#chkAceptoContratoMD").prop('checked')

        if (!TYCchecked) {
            $("#AcepteTYC").show();
            setTimeout(function () { $("#AcepteTYC").hide(); }, 3000);
            return false
        }

        var params = {
            CodigoUsuario: codigoUsuario,
            NombreConsultora:  nombreConsultora,
            NombreGerenteZonal: nombreGerenteZonal,
            Sobrenombre: sobrenombre,
            EMail: eMail,
            Telefono: telefono,
            Celular: celular,
            TelefonoTrabajo: telefonoTrabajo,
            PaisID: viewBagPaisID
        };

        jQuery.ajax({
            type: 'POST',
            url: _config.actualizarUsuarioUrl,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(params),
            async: true,
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    _hidePopupModificarDatos();
                }
            },
            error: function (data, error) {
                alert(data.message);
            }
        });

        return false;

    };   

    var _mostrar = function () {
        $("#fondoComunPopUp").show();
        $("#virtual-coach-dialog").show();
    };

    var _mostrarModificarDatos = function () {
        $("#fondoComunPopUp").show();
        $("#popupMisDatos").show();
        _setValuesPopupModificarDatos();
    };

    return {
        asignarEventos: _asignarEventos,
        mostrar: _mostrar,
        mostrarModificarDatos: _mostrarModificarDatos,
        tipoPopup: _config.tipoPopup
    }
}