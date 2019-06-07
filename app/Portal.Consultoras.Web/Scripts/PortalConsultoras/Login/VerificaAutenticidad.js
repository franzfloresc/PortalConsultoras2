var nroIntentosCo = 0;
var nroIntentosSms = 0;
var t;
var tipo = 0;
var numeroNuevo = "";
/*var counterElement = $('#time_counter');*/

var VerificaAutenticidad;

var urls = urlProvider;

/*para Numero*/
var localData = {
    CelularActual: null,
    InicialNumero: '',
    CelularValido: false,
    CelularNuevo: null,
    Expired: true,
    IsoPais: null,
    IsConfirmar: null,
    UrlPaginaPrevia: _UrlPaginaPrevia,
    UrlPaginaLogin: _UrlPaginaLogin
};



var panels = [
    $('.form_actualizar_celular'),
    $('.revisa_tu_celular'),
    $('.celular_actualizado')
];
var interval;
var counterElement = $('#time_counter');
var cantMsInterval = 1000;
var irALogin = true;



$(document).ready(function () {


    var vistaVerificaAutenticidad;

    vistaVerificaAutenticidad = function () {
        var me = this;
        me.Elements = {
            getInputCelular: function () {
                return $('#NuevoCelular');
            },

            getIconValidacionSms: function () {
                return $('.icono_validacion_codigo_sms');
            },

            getErrorText: function () {
                return $('#ValidateCelular');
            },

            getInputsCodeSms: function () {
                return $('.campo_ingreso_codigo_sms');
            },

            getCelularNuevoText: function () {
                return $('#NumeroMensajeEnviado');
            },
            getIsConfirmar: function () {
                return localData.IsConfirmar;
            }

        },
            me.Funciones = {


                InicializarEventos: function () {
                    $('body').on('blur', '.grupo_form_cambio_datos input, .grupo_form_cambio_datos select', me.Eventos.LabelActivo);
                    $('body').on('click', '#btnCambiarCelular', me.Eventos.EditarSms);                    
                    $('body').on('click', '#btnCambiarEmail', me.Eventos.EditarCorreo );

                    /*---------INI Celular ----------------------------------- */
                    var body = $('body');
                    //INI HD-3897
                    body.on('click', '#btnGuardarNumero', me.Eventos.Continuar);
                    if (localData.IsConfirmar == 1) {
                        $('#NuevoCelular').val(localData.CelularActual);
                        $('#NuevoCelular').addClass('campo_con_datos');
                    }
                    //FIN HD-3897
                    body.on('click', '.enlace_cambiar_numero_celular', me.Eventos.BackEdiNumber);
                    body.on('click', '#linkRenviarSms', me.Eventos.SendSmsCode);
                    body.on('keyup', '.campo_ingreso_codigo_sms', me.Eventos.ChangeCodeSms);
                    body.on('keydown', '.campo_ingreso_codigo_sms', me.Eventos.OnlyNumberCodeSms);
                    body.on('keydown', '#NuevoCelular', me.Eventos.OnlyNumberCodeSms);
                    body.on('cut copy paste', '#NuevoCelular', function (e) { e.preventDefault(); });
                    body.on('click', '#hrefTerminosMD', me.Eventos.EnlaceTerminosCondiciones);
                    body.on('click', '.ContinuarBienvenida', me.Services.ContinuarLogin);

                    //INI HD-3897
                    $('.form_actualizar_celular input').on('keyup change', function () { me.Funciones.ActivaGuardar(); return $(this).val() });
                    $('#NuevoCelular').on('focusout', function () { me.Funciones.MensajeError(); });
                    $('.btnVolver').on('click', function () {
                        if (irALogin) {
                            window.location.href = localData.UrlPaginaLogin;
                        } else {
                            window.location.href = localData.UrlPaginaPrevia;
                        }

                    });
                    //FIN HD-3897
                    /*---------FIN Celular ----------------------------------- */
                    /*-------------------------------------------------------- */

                },

                PuedeActualizar: function () {
                    if ($('#hdn_PuedeActualizar').val() == '0' || $('#hdn_PuedeActualizar').val() == false) {

                        $('#btnCambiarCelular').bind('click', false);
                        $('#btnCambiarEmail').bind('click', false);                        
                        //INI HD-3897
                        $('.btn_confirmar_dato').bind('click', false);
                        //FIN HD-3897
                    }
                },
                PuedeCambiarTelefono: function () {
                    var smsFlag = $('#hdn_ServicioSMS').val();
                    if (smsFlag == '0' || smsFlag == false) {
                        $('#btnCambiarCelular').hide();
                        //INI HD-3897
                        $('#grupo_form_cambio_datos_sms_opcionsms').hide();
                        //FIN HD-3897
                    } else {
                        $('#txtCelularMD').prop('readonly', true);
                    }
                },
                CamposFormularioConDatos: function () {
                    var camposFormulario = $('.grupo_form_cambio_datos input, .grupo_form_cambio_datos select');
                    $.map(camposFormulario, function (campoFormulario, key) {
                        if ($(campoFormulario).val()) {
                            $(campoFormulario).addClass('campo_con_datos');
                        }
                    });
                },
                //INI HD-3897
                ValidacionCheck: function () {


                    var btnCambiarCelular = document.getElementById("btnCambiarCelular");;
                    var btnCambiarCorreo = document.getElementById("btnCambiarEmail");;

                    var checkSMS = true;
                    var checkCorreo = true;


                    if (btnCambiarCelular) {
                        //SMS
                        if ($("#hdn_FlgCheckSMS").val()) {
                            $("#grupo_form_cambio_datos_sms").removeClass("opcion_verificacion_autenticidad--pendiente");
                            $("#grupo_form_cambio_datos_sms").addClass("opcion_verificacion_autenticidad--confirmado");
                            $("#grupo_form_cambio_datos_sms .mensaje_validacion_campo").hide();
                            $("#btn_confirmar_dato_sms").hide();

                        } else {
                            $("#grupo_form_cambio_datos_sms").removeClass("opcion_verificacion_autenticidad--confirmado");
                            $("#grupo_form_cambio_datos_sms").addClass("opcion_verificacion_autenticidad--pendiente");
                            $("#grupo_form_cambio_datos_sms .mensaje_validacion_campo").show();
                            $("#btn_confirmar_dato_sms").show();
                            checkSMS = false;
                        }

                        //------btnConfirmar
                        if ($('#txtCelularMD').val().trim() == "") $("#btn_confirmar_dato_sms").hide();
                        else if ($('#hdn_PuedeConfirmarAllSms').val()) $("#btn_confirmar_dato_sms").show();
                    }

                    if (btnCambiarCorreo) {
                        //EMAIL
                        if ($("#hdn_FlgCheckEMAIL").val()) {
                            $("#grupo_form_cambio_datos_email").removeClass("opcion_verificacion_autenticidad--pendiente");
                            $("#grupo_form_cambio_datos_email").addClass("opcion_verificacion_autenticidad--confirmado");
                            $("#grupo_form_cambio_datos_email .mensaje_validacion_campo").hide();
                            $("#btn_confirmar_dato_email").hide();

                        } else {
                            $("#grupo_form_cambio_datos_email").removeClass("opcion_verificacion_autenticidad--confirmado");
                            $("#grupo_form_cambio_datos_email").addClass("opcion_verificacion_autenticidad--pendiente");
                            $("#grupo_form_cambio_datos_email .mensaje_validacion_campo").show();
                            $("#btn_confirmar_dato_email").show();
                            checkCorreo = false;
                        }

                        //------btnConfirmar
                        if ($('#txtEMailMD').val().trim() == "") $("#btn_confirmar_dato_email").hide();
                        else if ($('#hdn_PuedeConfirmarAllEmail').val()) $("#btn_confirmar_dato_email").show();

                        if (checkSMS && checkCorreo) {
                            $('.ContinuarBienvenida').removeClass('btn_deshabilitado');
                        }
                    }


                },
                //FIN HD-3897
                EvitandoCopiarPegar: function () {
                    FuncionesGenerales.AvoidingCopyingAndPasting('txtCelularMD');
                },

                ValidacionSoloLetras: function () {

                    $("#txtCelularMD").keypress(function (evt) {
                        var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
                        if (!charCode) return false;
                        if (charCode <= 13) {
                            return false;
                        }
                        else {
                            var keyChar = String.fromCharCode(charCode);
                            var re = /[0-9+ *#-]/;
                            return re.test(keyChar);
                        }
                    });
                },

                ShowLoading: function () {
                    if (me.Funciones.isMobile()) {
                        ShowLoading();
                    } else {
                        waitingDialog();
                    }
                },
                isMobile: function () {
                    if (sessionStorage.desktop)
                        return false;
                    else if (localStorage.mobile)
                        return true;
                    var mobile = [
                        'iphone', 'ipad', 'android', 'blackberry', 'nokia', 'opera mini', 'windows mobile', 'windows phone',
                        'iemobile'
                    ];
                    for (var i = 0; i < mobile.length; i++) {
                        if (navigator.userAgent.toLowerCase().indexOf(mobile[i].toLowerCase()) > 0)
                            return true;
                    }


                    return false;
                },
                CloseLoading: function () {
                    if (me.Funciones.isMobile()) {
                        CloseLoading();
                    } else {
                        closeWaitingDialog();
                    }
                },



                /*------------INI CELULAR-------------------------*/
                //INI HD-3897
                ActivaGuardar: function () {
                    var btn = $("#btnGuardarNumero");
                    var obj = $.trim(IfNull($('#NuevoCelular').val(), ''));
                    btn.removeClass('btn_deshabilitado')

                    if (!me.Funciones.ValidarCelular(obj).Success || !$('#chkAceptoContratoMD').prop('checked')) btn.addClass('btn_deshabilitado');
                },
                MensajeError: function () {
                    var obj = $.trim(IfNull($('#NuevoCelular').val(), ''));
                    var band;
                    var result = me.Funciones.ValidarCelular(obj);
                    me.Funciones.ShowError("");



                    if (obj == "") band = null;
                    else if (obj != "" && !result.Success) {
                        me.Funciones.ShowError(result.Messages.join('<br>'));
                        band = false;
                    } else band = true;

                    me.Funciones.ActivaCheck(band);
                },
                ActivaCheck: function (band) {
                    var obj = $(".form_actualizar_celular .grupo_form_cambio_datos");
                    obj.removeClass("grupo_form_cambio_datos--validacionExitosa");
                    obj.removeClass("grupo_form_cambio_datos--validacionErronea");
                    if (band == null) return;

                    if (band) obj.addClass("grupo_form_cambio_datos--validacionExitosa");
                    else obj.addClass("grupo_form_cambio_datos--validacionErronea");

                },
                //FIN HD-3897

                GetLengthPais: function (iso) {
                    var paises = {
                        'PE': 9,
                        'MX': 10,
                        'EC': 10,
                        'CL': 9,
                        'BO': 8,
                        'PR': 10,
                        'DO': 10,
                        'CR': 8,
                        'GT': 8,
                        'PA': 8,
                        'SV': 8
                    };

                    return paises[iso];
                },

                ValidarPhonePais: function (iso, numero) {
                    var length = me.Funciones.GetLengthPais(iso);
                    if (!length) {
                        return {
                            valid: false,
                            length: 0
                        };
                    }

                    return {
                        valid: numero.length === length,
                        length: length
                    };
                },

                GetValidators: function () {
                    var success = {
                        Success: true
                    };

                    var onlyNumbers = function (numero) {
                        var pattern = /^\d+$/;
                        if (!pattern.test(numero)) {
                            return {
                                Success: false,
                                Message: 'El número no cumple con el formato.'
                            };
                        }

                        return success;
                    }

                    var byCountryLength = function (numero) {
                        var result = me.Funciones.ValidarPhonePais(localData.IsoPais, numero);
                        if (!result.valid) {
                            return {
                                Success: false,
                                Message: 'El número debe tener ' + result.length + ' digitos.'
                            };
                        }

                        return success;
                    }

                    var byCountryFormat = function (numero) {
                        if (localData.InicialNumero) {
                            if (numero.charAt(0) !== localData.InicialNumero) {
                                return {
                                    Success: false,
                                    Message: 'El número debe empezar con ' + localData.InicialNumero + '.'
                                }
                            }
                        }

                        return success;
                    }

                    return [
                        onlyNumbers,
                        byCountryLength,
                        byCountryFormat
                    ];
                },

                ValidarCelular: function (numero) {
                    if (!numero) {
                        return {
                            Success: false,
                            Messages: ['Debe ingresar celular.']
                        };
                    }

                    var validators = me.Funciones.GetValidators();
                    var messages = [];

                    for (var i = 0; i < validators.length; i++) {
                        var validator = validators[i];
                        var result = validator(numero);
                        if (!result.Success) {
                            messages.push(result.Message);
                        }
                    }

                    if (messages.length > 0) {
                        return {
                            Success: false,
                            Messages: messages
                        }
                    }

                    return { Success: true };
                },

                SetReadOnlySmsCodeInput: function (disabled) {
                    me.Elements.getInputsCodeSms().each(function () {
                        $(this).prop('readonly', disabled);
                    });
                },

                GetSmsCode: function () {
                    var code = '';
                    me.Elements.getInputsCodeSms().each(function () {
                        code += $(this).val();
                    });

                    return code;
                },

                SetSmsCode: function (value) {
                    value = value || '';
                    me.Elements.getInputsCodeSms().each(function (idx) {
                        var char = value.charAt(idx);
                        $(this).val(char);
                    });
                },

                MarkSmsCodeStatus: function (valid) {
                    var icon = me.Elements.getIconValidacionSms();

                    icon.show();
                    if (!valid) {
                        icon.removeClass('validacion_exitosa')
                            .addClass('validacion_erronea');

                        return;
                    }

                    icon.removeClass('validacion_erronea')
                        .addClass('validacion_exitosa');
                },

                ResetSmsCode: function () {
                    me.Funciones.SetSmsCode('');
                    me.Elements.getIconValidacionSms().hide();
                },

                Format2: function (value) {
                    if (value < 10) return '0' + value;

                    return value;
                },

                StepCounter: function (segs) {
                    clearInterval(interval);

                    localData.Expired = false;
                    var now = 0;
                    interval = setInterval(function () {

                        now += cantMsInterval;
                        var distance = segs - now;

                        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                        counterElement.text(me.Funciones.Format2(minutes) + ":" + me.Funciones.Format2(seconds));

                        if (distance < 0) {
                            localData.Expired = true;
                            clearInterval(interval);
                            counterElement.text("00:00");
                            me.Funciones.ResetSmsCode();
                            me.Eventos.BackEdiNumber()
                        }
                    }, cantMsInterval);
                },

                /*Counter*/
                InitCounter: function () {
                    counterElement.text('03:00');
                    me.Funciones.StepCounter(3 * 60000);
                },

                ShowError: function (text) {
                    me.Elements.getErrorText().html(text);
                },

                VerifySmsCode: function (code) {
                    if (localData.Expired) {
                        return;
                    }

                    AbrirLoad();
                    var successConfirmarSmsCode = function (r) {

                        CerrarLoad();
                        if (!r.Success) {
                            me.Funciones.MarkSmsCodeStatus(false);
                            AbrirAlert(r.Message);
                            return;
                        }

                        me.Funciones.SetReadOnlySmsCodeInput(true);
                        me.Funciones.MarkSmsCodeStatus(true);
                        setTimeout(function () {
                            me.Funciones.NavigatePanel(2);

                            mostrarLluvia();
                        },
                            1000);
                        setTimeout(function () {
                            /*window.location.href = localData._UrlPaginaPrevia;*/
                            $(".btnVolver").trigger("click");
                        },
                            3000);

                    };

                    me.Services.confirmarSmsCode(code)
                        .then(successConfirmarSmsCode, function (er) {
                            CerrarLoad();
                            me.Funciones.HandleError(er);
                        });
                },

                NavigatePanel: function (index) {
                    panels.forEach(function (item, idx) {
                        if (idx === index) {
                            item.show();
                        } else {
                            item.hide();
                        }
                    });
                },

                SetIsoPais: function (iso) {
                    localData.IsoPais = iso;

                    var len = me.Funciones.GetLengthPais(iso);
                    if (len) {
                        me.Elements.getInputCelular().prop('maxLength', len);
                    }
                },

                HandleError: function (er) {
                    AbrirAlert('Ocurrio un error inesperado.');
                }
                /*----------------FIN CELULAR----------------------------------*/
                /*-----------------------------------------------------------*/


            },
            me.Eventos = {
                LabelActivo: function () {
                    var campoDatos = $(this).val();
                    if (campoDatos) {
                        $(this).addClass('campo_con_datos');
                    } else {
                        $(this).removeClass('campo_con_datos');
                    }
                },
                EditarSms: function () {
                    tipo = 2;
                    nroIntentosSms = nroIntentosSms + 1;

                    me.Services.CargarEditarNumero();
                },
                EditarCorreo: function () {
                    //tipo = 2;
                    // nroIntentosSms = nroIntentosSms + 1;

                    me.Services.CargarEditarCorreo();
                },
                /*---------INI Celular ----------------------------------- */
                Continuar: function () {
                    var nuevoCelular = me.Elements.getInputCelular().val();

                    var result = me.Funciones.ValidarCelular(nuevoCelular);
                    if (!result.Success) {
                        me.Funciones.ShowError(result.Messages.join('<br>'));
                        return;
                    }

                    if (document.getElementById('chkAceptoContratoMD').checked == false) {
                        AbrirAlert('Debe aceptar los términos y condiciones para poder actualizar sus datos');
                        return false;
                    }

                    localData.CelularNuevo = nuevoCelular;
                    me.Funciones.ResetSmsCode();
                    AbrirLoad();
                    //INI HD-3897
                    var successEnviarSmsCode = function (r) {
                        $('#celularNuevo').text(nuevoCelular);
                        CerrarLoad();
                        if (!r.Success) {
                            me.Funciones.ShowError(r.Message);
                            me.Funciones.ActivaCheck(false);
                            return;
                        }
                        me.Elements.getCelularNuevoText().text(nuevoCelular);
                        me.Funciones.NavigatePanel(1);
                        me.Funciones.ShowError('');
                        me.Funciones.InitCounter();
                    };

                    me.Services.enviarSmsCode(nuevoCelular)
                        .then(successEnviarSmsCode, function (er) {
                            CerrarLoad();
                            me.Funciones.HandleError(er);
                        });

                    //FIN HD-3897
                },
                //INI HD-3897
                Confirmar: function () {
                    me.Funciones.ResetSmsCode();
                    AbrirLoad();
                    $(".form_actualizar_celular").hide();

                    var successEnviarSmsCode = function (r) {
                        $('#celularNuevo').text(localData.CelularNuevo);
                        CerrarLoad();
                        if (!r.Success) {
                            me.Funciones.ShowError(r.Message);
                            return;
                        }
                        me.Elements.getCelularNuevoText().text(localData.CelularNuevo);
                        $(".form_actualizar_celular").show();
                        me.Funciones.NavigatePanel(1);

                        me.Funciones.ShowError('');
                        me.Funciones.InitCounter();
                    };

                    me.Services.enviarSmsCode(localData.CelularNuevo)
                        .then(successEnviarSmsCode, function (er) {
                            CerrarLoad();
                            me.Funciones.HandleError(er);
                        });

                },
                //FIN HD-3897
                EnlaceTerminosCondiciones: function () {
                    // var enlace = $('#hdn_enlaceTerminosCondiciones').val();
                    var enlace = config.EnlaceTerminosCondiciones;
                    $('#hrefTerminosMD').attr('href', enlace);
                },

                BackEdiNumber: function () {
                    me.Funciones.NavigatePanel(0);
                },

                SendSmsCode: function () {
                    me.Funciones.ResetSmsCode();
                    AbrirLoad();
                    me.Services.enviarSmsCode(localData.CelularNuevo)
                        .then(function (r) {
                            CerrarLoad();
                            if (!r.Success) {
                                me.Funciones.ShowError(r.Message);
                                me.Funciones.NavigatePanel(0);

                                return;
                            }

                            me.Funciones.InitCounter();
                        }, function (er) {
                            CerrarLoad();
                            me.Funciones.HandleError(er);
                        });
                },

                ChangeCodeSms: function (e) {
                    var input = $(this);
                    if (input.val()) {
                        input.parent().next().find('.campo_ingreso_codigo_sms').focus();
                    }

                    if (e.keyCode === 8) {
                        input.parent().prev().find('.campo_ingreso_codigo_sms').focus();
                    }

                    var code = me.Funciones.GetSmsCode();
                    if (code.length !== 6) {
                        return;
                    }

                    me.Funciones.VerifySmsCode(code);
                },

                OnlyNumberCodeSms: function (e) {
                    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                        (e.keyCode >= 35 && e.keyCode <= 40)) {
                        return;
                    }
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                }
                /*---------FIN Celular ----------------------------------- */
                /*-------------------------------------------------------- */


            },
            me.Services = {
                ContinuarLogin: function (CambioClave) {
                    var param = "";
                    if (CambioClave == 1) //Para Desktop
                        param = "?verCambioClave=1"

                    waitingDialog();
                    var o = 1;
                    $.ajax({
                        type: 'POST',
                        url: urlContinuarLogin,
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        async: true,
                        success: function (response) {
                            if (EsMobile == "True" && CambioClave == 1) {

                                document.location.href = VerCambioClaveMobile;
                            }
                            else {

                                document.location.href = response.redirectTo + param;
                            }
                        },
                        error: function (data, error) {
                            if (checkTimeout(data)) {
                                closeWaitingDialog();
                            }
                        }
                    });
                },
                /*---------INI Celular ----------------------------------- */
                CargarEditarNumero: function () {
                    me.Funciones.ShowLoading();
                    $.ajax({
                        url: UrlCargarEditaNumero,
                        type: 'POST',
                        data: null,
                        dataType: 'json',
                        success: function (response) {
                            me.Funciones.CloseLoading();
                            if (!response.success) {
                                AbrirAlert(response.message);
                                return false;
                            }

                            localData.CelularActual = response.data.Celular;
                            localData.InicialNumero = response.data.IniciaNumeroCelular.toString();
                            localData.CelularValido = false;
                            localData.CelularNuevo = (response.data.IsConfirmarCel == 1) ? response.data.Celular : '';
                            localData.Expired = true;
                            localData.IsoPais = response.data.IsoPais;
                            localData.IsConfirmar = response.data.IsConfirmarCel;

                            $('#divPaso1').hide();
                            $("#ActualizarCelular").show();

                            irALogin = false;

                            me.Funciones.SetIsoPais(localData.IsoPais);
                            //actualizarCelularModule.Inicializar();
                            //INI HD-3897
                            if (me.Elements.getIsConfirmar() == 1) {
                                me.Eventos.Confirmar();
                            }
                            //FIN HD-3897

                        },
                        error: function (data, error) {
                            if (checkTimeout(data)) {
                                me.Funciones.CloseLoading();
                                AbrirAlert('Error al cargar pantalla editar número');
                            }
                        }
                    });
                },

                enviarSmsCode: function (numero) {
                    return $.ajax({
                        url: urls.enviarSmsCodigo,
                        method: 'POST',
                        data: {
                            celular: numero
                        }
                    });
                },

                confirmarSmsCode: function (code) {
                    return $.ajax({
                        url: urls.confirmarSmsCode,
                        method: 'POST',
                        data: {
                            smsCode: code,
                            nuevoNumero: me.Elements.getInputCelular().val()
                        }
                    });
                },
                /*---------FIN Celular ----------------------------------- */
                /*-------------------------------------------------------- */



                /*---------INI CORREO ----------------------------------- */
                CargarEditarCorreo: function () {
                    me.Funciones.ShowLoading();
                    $.ajax({
                        url: UrlCargarEditaCorreo,
                        type: 'POST',
                        data: null,
                        dataType: 'json',
                        success: function (response) {
                            me.Funciones.CloseLoading();
                            if (!response.success) {
                                AbrirAlert(response.message);
                                return false;
                            }

                            config.CorreoActual = response.data.CorreoActual;
                            config.IsConfirmar = response.data.IsConfirmar;
                            config.EnlaceTerminosCondiciones = response.data.UrlPdfTerminosyCondiciones;
                            //localData.CelularNuevo = (response.data.IsConfirmarCel == 1) ? response.data.Celular : '';
                            //localData.Expired = true;
                            //localData.IsoPais = response.data.IsoPais;
                            //localData.IsConfirmar = response.data.IsConfirmarCel;

                            $('#divPaso1').hide();
                            $("#ActualizarCorreo").show();

                            irALogin = false;                            

                            if ($(this).data("pag") ) {
                                config.VistaActual = $(this).data("pag");
                            }

                            if (config.IsConfirmar == 1) {
                                me.Correo.postActualizarEnviarCorreo({ correoNuevo: config.CorreoActual }, me.Correo.irVista2(config.CorreoActual));
                            } else {
                                me.Correo.irVista(config.VistaActual);
                            }

                            var inputEmail = document.getElementById("NuevoCorreo");                            
                            FuncionesGenerales.AutoCompletarEmailAPartirDeArroba(inputEmail);
                        },
                        error: function (data, error) {
                            if (checkTimeout(data)) {
                                me.Funciones.CloseLoading();
                                AbrirAlert('Error al cargar pantalla editar número');
                            }
                        }
                    });
                }

                /*---------FIN CORREO ----------------------------------- */
                /*------------------------------------------------------- */




            },
            me.Correo = {
                activaGuardar: function () {
                    var btn = $("#btnActualizarCorreo");
                    btn.removeClass('btn_deshabilitado')
                    if (me.Correo.getDataArrayError(me.Correo.getData()).length > 0 || !$('#chkAceptoContratoMDCorreo').prop('checked')) btn.addClass('btn_deshabilitado');

                },
                mensajeError: function () {
                    var obj = me.Correo.getData().correoNuevo;
                    var band;
                    $("#ValidateCorreo").hide();

                    if (obj == "") band = null;
                    else if (obj != "" && !validateEmail(obj)) {
                        $("#ValidateCorreo").show();
                        band = false;
                    } else band = true;


                    me.Correo.activaCheck(band);
                },
                activaCheck: function (band) {
                    var obj = $("div[vista-id=1] .grupo_form_cambio_datos");
                    obj.removeClass("grupo_form_cambio_datos--validacionExitosa");
                    obj.removeClass("grupo_form_cambio_datos--validacionErronea");
                    if (band == null) return;

                    if (band) obj.addClass("grupo_form_cambio_datos--validacionExitosa");
                    else obj.addClass("grupo_form_cambio_datos--validacionErronea");

                },
                //FIN HD-3897

                showSuccess: function (message) { AbrirAlert(message); },
                showError: function (error) { AbrirAlert(error); },
                showArrayError: function (arrayError) {
                    var mensaje = '';
                    for (var i = 0; i <= arrayError.length - 2; i++) {
                        mensaje += arrayError[i] + '<br/>';
                    }
                    mensaje += arrayError[arrayError.length - 1];

                    me.Correo.showError(mensaje);
                },

                getData: function () {
                    return {
                        correoNuevo: $.trim(IfNull($('#NuevoCorreo').val(), ''))
                    };
                },
                getDataArrayError: function (data) {
                    var arrayError = [];

                    if (data.correoNuevo === '') arrayError.push('Debe ingresar un email.');
                    else if (!validateEmail(data.correoNuevo)) arrayError.push('El formato del email ingresado no es correcto.');

                    return arrayError;
                },
            postActualizarEnviarCorreo: function (data, fnSuccess) {                
                    nroIntentosCo = nroIntentosCo + 1;
                    var parametros = {
                        CantidadEnvios: nroIntentosCo,
                        CorreoActualizado: me.Correo.getData().correoNuevo
                    };
                    AbrirLoad();
                    $.post(config.UrlActualizarEnviarCorreo, parametros)
                        .done(function (response) {
                            if (!response.success) {
                                me.Correo.showError(response.message);
                                return;
                            }

                            if ($.isFunction(fnSuccess)) fnSuccess(data);
                        })
                        .fail(function () { me.Correo.showError(config.MensajeError); })
                        .always(CerrarLoad);
                },
                actualizarEnviarCorreo: function (fnSuccess) {
                    var data = me.Correo.getData();
                    //INI HD-3897
                    var arrayError = me.Correo.getDataArrayError(data);
                    if (arrayError.length > 0) {
                        me.Correo.showArrayError(arrayError);
                        return;
                    }
                    //FIN HD-3897
                    if (document.getElementById('chkAceptoContratoMDCorreo').checked == false) {
                        AbrirAlert('Debe aceptar los términos y condiciones para poder actualizar sus datos');
                        return false;
                    }

                    me.Correo.postActualizarEnviarCorreo(data, fnSuccess);
                },
                enlaceTerminosCondiciones: function () {
                    var enlace = config.EnlaceTerminosCondiciones;
                    $('#hrefTerminosMD2').attr('href', enlace);
                },
                irPaginaPrevia: function () { window.location.href = config.UrlPaginaPrevia; },
                irVista: function (vistaId) {
                    $('div[vista-id]').hide();
                    $('div[vista-id=' + vistaId + ']').show();
                    config.VistaActual = vistaId;
                },
                irVista2: function (email) {
                    me.Correo.irVista(2);
                    $('#txtCorreoEnviado').html(email);
                },
                asignarEventos: function () {


                    //$('#btnVolver').on('click', function () {
                    //    if (config.VistaActual == 1 || config.IsConfirmar == 1) me.Correo.irPaginaPrevia();
                    //    else if (config.VistaActual == 2) me.Correo.irVista(1);
                    //});
                    $('#btnCancelar').on('click', me.Correo.irPaginaPrevia);
                    $('#btnReescribirCorreo').on('click', function () {                        
                        if (config.IsConfirmar == 1) {
                            $('#NuevoCorreo').val(config.CorreoActual);
                            $('#NuevoCorreo').addClass('campo_con_datos');
                        } me.Correo.irVista(1);
                    });

                    $('#btnReenviameInstruciones').on('click', function () {                        
                        var MsjSuccess = function () { $("#spnReenviarInstrucciones").show(); };
                        if (config.IsConfirmar == 1) {
                            me.Correo.postActualizarEnviarCorreo({ correoNuevo: config.CorreoActual }, MsjSuccess);
                        } else {
                            me.Correo.actualizarEnviarCorreo(MsjSuccess);
                        }
                    });
                    $('#btnActualizarCorreo').on('click', function () { me.Correo.actualizarEnviarCorreo(function (data) { me.Correo.irVista2(data.correoNuevo); }); });
                    $('#hrefTerminosMD2').on('click', function () { me.Correo.enlaceTerminosCondiciones(); });

                    //INI HD-3897
                    $('div[vista-id=1] input').on('keyup change', function () { me.Correo.activaGuardar(); return $(this).val() });
                    $('#NuevoCorreo').on('focusout', function () {
                        setTimeout(function () { me.Correo.mensajeError(); }, 200);
                        
                    });
                    //FIN HD-3897

                    FuncionesGenerales.AvoidingCopyingAndPasting('NuevoCorreo');
                }
            }
        me.Inicializar = function () {

            me.Funciones.InicializarEventos();
            me.Funciones.CamposFormularioConDatos();

            me.Funciones.PuedeActualizar();
            me.Funciones.PuedeCambiarTelefono();
            //INI HD-3897
            me.Funciones.ValidacionCheck();
            //FIN HD-3897
            me.Funciones.EvitandoCopiarPegar();
            me.Funciones.ValidacionSoloLetras();

            me.Correo.asignarEventos();

        }
    }

    VerificaAutenticidad = new vistaVerificaAutenticidad();
    VerificaAutenticidad.Inicializar();


    $('#hrefTerminosMD').click(function () { me.Eventos.EnlaceTerminosCondiciones(); });

    function ShowLoading() { $("#loading-spin").fadeIn(); }

    function CloseLoading() { $("#loading-spin").fadeOut("fast"); }
});


