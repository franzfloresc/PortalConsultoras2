var nroIntentosCo = 0;
var nroIntentosSms = 0;
var t;
var tipo = 0;
var numeroNuevo = "";
var counterElement = $('#time_counter');

var VerificaAutenticidad;

var urls = urlProvider;

var localData = {
    CelularActual: null,
    InicialNumero: '',
    CelularValido: false,
    CelularNuevo: null,
    Expired: true,
    IsoPais: null,
    IsConfirmar: null,
    UrlPaginaPrevia: _UrlPaginaPrevia
};


var panels = [
    $('.form_actualizar_celular'),
    $('.revisa_tu_celular'),
    $('.celular_actualizado')
];
var interval;
var counterElement = $('#time_counter');
var cantMsInterval = 1000;

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
                    body.on('click', '.enlace_reenviar_instrucciones', me.Eventos.SendSmsCode);
                    body.on('keyup', '.campo_ingreso_codigo_sms', me.Eventos.ChangeCodeSms);
                    body.on('keydown', '.campo_ingreso_codigo_sms', me.Eventos.OnlyNumberCodeSms);
                    body.on('keydown', '#NuevoCelular', me.Eventos.OnlyNumberCodeSms);
                    body.on('cut copy paste', '#NuevoCelular', function (e) { e.preventDefault(); });
                    body.on('click', '#hrefTerminosMD', me.Eventos.EnlaceTerminosCondiciones);

                    //INI HD-3897
                    $('.form_actualizar_celular input').on('keyup change', function () { me.Funciones.ActivaGuardar(); return $(this).val() });
                    $('#NuevoCelular').on('focusout', function () { me.Funciones.MensajeError(); });
                    $('#btnVolver').on('click', function () {
                        window.location.href = localData.UrlPaginaPrevia;

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

                    //SMS
                    if ($("#hdn_FlgCheckSMS").val()) {
                        $("#grupo_form_cambio_datos_sms").addClass("grupo_form_cambio_datos--confirmado");
                        $("#grupo_form_cambio_datos_sms .mensaje_validacion_campo").hide();
                        $("#btn_confirmar_dato_sms").hide();

                    } else {
                        $("#grupo_form_cambio_datos_sms").addClass("grupo_form_cambio_datos--confirmacionPendiente");
                        $("#grupo_form_cambio_datos_sms .mensaje_validacion_campo").show();
                        $("#btn_confirmar_dato_sms").show();

                    }

                    //EMAIL
                    if ($("#hdn_FlgCheckEMAIL").val()) {
                        $("#grupo_form_cambio_datos_email").addClass("grupo_form_cambio_datos--confirmado");
                        $("#grupo_form_cambio_datos_email .mensaje_validacion_campo").hide();
                        $("#btn_confirmar_dato_email").hide();

                    } else {
                        $("#grupo_form_cambio_datos_email").addClass("grupo_form_cambio_datos--confirmacionPendiente");
                        $("#grupo_form_cambio_datos_email .mensaje_validacion_campo").show();
                        $("#btn_confirmar_dato_email").show();

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
                debugger;
                    if (localData.Expired) {
                        return;
                    }

                    AbrirLoad();
                    var successConfirmarSmsCode = function (r) {
             
                        CerrarLoad();
                        if (!r.Success) {
                            me.Funciones.MarkSmsCodeStatus(false);
                            alert(r.Message);
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
                            window.location.href = localData._UrlPaginaPrevia;
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
                    alert('Ocurrio un error inesperado.');
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
                /*---------INI Celular ----------------------------------- */
                Continuar: function () {
                    var nuevoCelular = me.Elements.getInputCelular().val();

                    var result = me.Funciones.ValidarCelular(nuevoCelular);
                    if (!result.Success) {
                        me.Funciones.ShowError(result.Messages.join('<br>'));
                        return;
                    }

                    if (document.getElementById('chkAceptoContratoMD').checked == false) {
                        alert('Debe aceptar los términos y condiciones para poder actualizar sus datos');
                        return false;
                    }

                    localData.CelularNuevo = nuevoCelular;
                    me.Funciones.ResetSmsCode();
                    AbrirLoad();
                    //INI HD-3897
                    var successEnviarSmsCode = function (r) {
                        debugger;
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
                    var enlace = $('#hdn_enlaceTerminosCondiciones').val();
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
                /*---------INI Celular ----------------------------------- */
                CargarEditarNumero: function () {
                    me.Funciones.ShowLoading();
                    $.ajax({
                        url: UrlCargarEditaNumero,
                        type: 'POST',
                        data: null,
                        dataType: 'json',
                        success: function (response) {
                            debugger;
                            me.Funciones.CloseLoading();
                            if (!response.success) {
                                alert(response.message);
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
                                alert('Error al cargar pantalla editar número');
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
                            smsCode: code
                        }
                    });
                }
                /*---------FIN Celular ----------------------------------- */
                /*-------------------------------------------------------- */


            },       
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

            }
    }

    VerificaAutenticidad = new vistaVerificaAutenticidad();
    VerificaAutenticidad.Inicializar();


    $('#hrefTerminosMD').click(function () { me.Eventos.EnlaceTerminosCondiciones(); });

});


