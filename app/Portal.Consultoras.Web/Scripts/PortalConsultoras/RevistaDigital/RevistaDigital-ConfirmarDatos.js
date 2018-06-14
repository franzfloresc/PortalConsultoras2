var revistaDigitalConfirmarDatosModule = (function (){
    var _elements = {
        lblErrorCampos : ".popup_confirmacion_datos .form-datos .input #errorCampos",
        hdnCorreoAnterior : ".popup_confirmacion_datos .form-datos .input input#CorreoAnterior",
        txtCorreo : ".popup_confirmacion_datos .form-datos .input input#Email",
        lblErrorCorreo : ".popup_confirmacion_datos .form-datos .input #errorEmail",
        txtCelular : ".popup_confirmacion_datos .form-datos .input input#Celular",
        lblErrorCelular : ".popup_confirmacion_datos .form-datos .input #errorPhone",
        hdnCantidadCaracteresMinimoCelular : 'hdn_CaracterMinimo',
        hdnCantidadCaracteresMaximoCelular : 'hdn_CaracterMaximo',
        chkTerminosYCondiciones : "#chkinput",
        lblTerminosYCondiciones : "label[for='chkinput']",
        btnConfirmarDatos : ".popup_confirmacion_datos .form-datos button",
        btnCerrarPopupConfirmarDatos : "a[data-popup-close=PopRDSuscripcion]",
        classActivarBoton : "activar_boton_popup_confirma_datos",
        classDesacctivarBoton : "desactivar_boton_popup_confirma_datos",
        classObligatorio : "obligatorio"
    };
    
    var _isEmptyTextbox = function(selector){
        var text = $.trim($(selector).val());
        return text == '';
    };

    var _limpiarMensajesError = function () {
        $(_elements.lblErrorCorreo).fadeOut();
        $(_elements.lblErrorCelular).fadeOut();
        $(_elements.lblErrorCampos).fadeOut();
    };

    var _verificarBotonConfirmarDatos = function () {
        var correoEnBlanco = _isEmptyTextbox(_elements.txtCorreo);
        var celularEnBlanco = _isEmptyTextbox(_elements.txtCelular);
        if (!correoEnBlanco || !celularEnBlanco) {
            $(_elements.btnConfirmarDatos).removeAttr("disabled");
            $(_elements.btnConfirmarDatos).addClass(_elements.classActivarBoton);
            $(_elements.btnConfirmarDatos).removeClass(_elements.classDesacctivarBoton);
        }
        else {
            $(_elements.btnConfirmarDatos).attr("disabled", "disabled");
            $(_elements.btnConfirmarDatos).addClass(_elements.classDesacctivarBoton);
            $(_elements.btnConfirmarDatos).removeClass(_elements.classActivarBoton);
            _limpiarMensajesError();
        }
    };

    var _verificarCorreo = function () {
        var result = true;

        _limpiarMensajesError();
        var correo = $.trim($(_elements.txtCorreo).val());
        if (correo != '' && !validateEmail(correo)){
            $(_elements.txtCorreo).focus();
            $(_elements.lblErrorCorreo).text("El formato del correo ingresado no es correcto.").fadeIn();
            result =  false;
        } 

        return result;
    };

    var _limitarTextoMinimo = function (texto, cantidadCaracteres) {
        var result = true;
        if (texto.length < cantidadCaracteres && texto.trim() != '') {
            result= false;
        } 
        return result;
    };

    var _esNroCelularValido = function (celular) {
        var resultado = false;
    
        var item = {
            Telefono: celular
        };
    
        jQuery.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/ValidadTelefonoConsultora",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(item),
            async: false,
            cache: false,
            success: function (data) {
                closeWaitingDialog();
                if (!checkTimeout(data))
                    resultado = false;
                else
                    resultado = data.success;
            },
            error: function (data, error) {
                closeWaitingDialog();
            }
        });
    
        return resultado;
    };

    var _verificarCelular = function () {
        var result = true;

        _limpiarMensajesError();
        var cadenaNrocelular = $.trim($(_elements.txtCelular).val());
        if (cadenaNrocelular !== '') {
            var cantidadCaracteresMinimosCelular = parseInt($(_elements.hdnCantidadCaracteresMinimoCelular).val());
            if(isNaN(cadenaNrocelular)){
                $(_elements.txtCelular).focus();
                $(_elements.lblErrorCelular).text("El formato del celular no es correcto.").fadeIn();
                result = false;
            } else if (!_limitarTextoMinimo(cadenaNrocelular, cantidadCaracteresMinimosCelular)) {
                $(_elements.txtCelular).focus();
                $(_elements.lblErrorCelular).text("El formato del celular no es correcto.").fadeIn();
                result = false;
            } else if (!_esNroCelularValido(cadenaNrocelular)) {
                $(_elements.lblErrorCelular).text("El número de celular ya está en uso.").fadeIn();
                result = true;
            }
        }
        return result;
    };

    var _verificarTerminosYCondiciones = function () {
        var result = false;
        if ($(_elements.chkTerminosYCondiciones).attr("checked") || $(_elements.chkTerminosYCondiciones).is(":checked")) {
            $(_elements.lblTerminosYCondiciones).css("border", "none");
            $("." + _elements.classObligatorio).fadeOut();
            result = true;
        } else {
            $(_elements.lblTerminosYCondiciones).css("border", "1px solid red");
            $("." + _elements.classObligatorio).fadeIn();
            result = false;
        }
        return result;
    };
    
    var RDConfirmarDatosPromise = function (confirmarDatosModel) {
        var d = $.Deferred();
    
        var promise = $.ajax({
            type: "POST",
            url: baseUrl + "RevistaDigital/ActualizarDatos",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(confirmarDatosModel),
            async: true
        });
    
        promise.done(function(response) {
            d.resolve(response);
        });
    
        promise.fail(d.reject);
    
        return d.promise();
    };

    var _redireccionarAlContenedorOfertas = function(){
        window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
    };

    var _btnConfirmarDatos_onClick = function () {
        AbrirLoad();
        if (_verificarTerminosYCondiciones() && _verificarCorreo() && _verificarCelular()) {
            AbrirLoad();
            var correoAnterior = $.trim($(_elements.hdnCorreoAnterior).val());
            var celular = $.trim($(_elements.txtCelular).val());
            var email = $.trim($(_elements.txtCorreo).val());
    
            var confirmarDatosModel = {
                Email: email,
                Celular: celular,
                CorreoAnterior: correoAnterior
            };
    
            rdAnalyticsModule.GuardarDatos();
            RDConfirmarDatosPromise(confirmarDatosModel).then(
                function(data) {
                    CerrarLoad();
                    _redireccionarAlContenedorOfertas();
                },
                function(xhr, status, error) {
                    CerrarLoad();
                }
            );
        } else {
            CerrarLoad();
        }
    }; 
    
    var _limitarTextoMaximo = function (e, texto, cantidadCaracteres, id) {
        var unicode = e.keyCode ? e.keyCode : e.charCode;
        if (unicode == 8 || unicode == 46 || unicode == 13 || unicode == 9 || unicode == 37 ||
            unicode == 39 || unicode == 38 || unicode == 40 || unicode == 17 || unicode == 67 || unicode == 86)
            return true;
    
        if (texto.length >= cantidadCaracteres) {
            selectedText = document.getSelection();
            if (selectedText == texto) {
                $("#" + id).val("");
                return true;
            } else if (selectedText != "") {
                return true;
            } else {
                return false;
            }
        }
        return true;
    };
    
    var _bindEvents = function () {
        $(_elements.txtCorreo).on("keyup", function (event) {
            event.stopPropagation();
            _verificarBotonConfirmarDatos();
        });
        $(_elements.txtCelular).on("keydown", function (event) {
            event.stopPropagation();
            var _this = this;
            var cantidadCaracteresMaximoCelular = parseInt($('#' + _elements.hdnCantidadCaracteresMaximoCelular).val());
            return FuncionesGenerales.ValidarSoloNumeros(event) &&
            _limitarTextoMaximo(event, $(_this).val(), cantidadCaracteresMaximoCelular, 'Celular');
        });
        $(_elements.txtCelular).on("keyup", function (event) {
            event.stopPropagation();
            _verificarBotonConfirmarDatos();
        });
        $(_elements.txtCorreo).on("blur", function (event) {
            event.stopPropagation();
            _verificarCorreo();
        });
        $(_elements.txtCelular).on("blur", function (event) {
            event.stopPropagation();
            _verificarCelular();
        });
        $(_elements.chkTerminosYCondiciones).on("change", function (event) {
            event.stopPropagation();
            _verificarTerminosYCondiciones();
        });
        $(_elements.btnConfirmarDatos).on("click", function (event) {
            event.stopPropagation();
            _btnConfirmarDatos_onClick();
            event.preventDefault();
        });
        $(_elements.btnCerrarPopupConfirmarDatos).on("click", function () {
            rdAnalyticsModule.CerrarPopUp("ConfirmarDatos");
            _redireccionarAlContenedorOfertas();
        });
    };


    var _init = function(){
        _bindEvents();
    };
    
    return {
        init : _init
    };
}());

$(document).ready(function () {
    revistaDigitalConfirmarDatosModule.init();
});