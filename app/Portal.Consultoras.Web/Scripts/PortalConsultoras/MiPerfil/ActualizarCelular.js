var actualizarCelularModule = (function (urls, $) {
    'use strict';

    var me = {};

    var localData = {
        CelularValido: false,
        CelularNuevo: '',
        Expired: true,
        IsoPais: IsoPais
    };

    me.Services = (function() {
        function enviarSmsCode (numero) {
            return $.ajax({
                url: urls.enviarSmsCodigo,
                method: 'POST',
                data: {
                    celular: numero
                }
            });
        };

        function confirmarSmsCode (code) {
            return $.ajax({
                url: urls.confirmarSmsCode,
                method: 'POST',
                data: {
                    smsCode: code
                }
            });
        };

        return {
            enviarSmsCode: enviarSmsCode,
            confirmarSmsCode: confirmarSmsCode
        };
    })();
    me.Funciones = (function() {
        var panels = [
            $('.form_actualizar_celular'),
            $('.revisa_tu_celular'),
            $('.celular_actualizado')
        ];
        var interval;
        var counterElement = $('#time_counter');

        function inicializarEventos() {
            var body = $('body');
            body.on('click', '.btn_continuar', me.Eventos.Continuar);
            body.on('click', '.enlace_cambiar_correo', me.Eventos.BackEdiNumber);
            body.on('click', '.enlace_reenviar_instrucciones', me.Eventos.SendSmsCode);
            body.on('keyup', '.campo_ingreso_codigo_sms', me.Eventos.ChangeCodeSms);
        };

        function validarPhonePais(iso, numero) {
            var paises = {
                'PE': 9,
                'MX': 15,
                'EC': 10,
                'CL': 15,
                'BO': 15,
                'PR': 15,
                'DO': 15,
                'CR': 8,
                'GT': 8,
                'PA': 8,
                'SV': 8
            };

            var length = paises[iso];
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
        }

        function validarCelular(numero) {
            if (!numero) {
                return {
                    Success: false,
                    Message: 'El número no puede estar vacío.'
                };
            }
            var reg = /^\d+$/;
            if (!reg.test(numero)) {
                return {
                    Success: false,
                    Message: 'No es un número válido.'
                };
            }

            var result = validarPhonePais(localData.IsoPais, numero);
            if (!result.valid) {
                return {
                    Success: false,
                    Message: 'El número debe tener ' + result.length + ' digitos.'
                };
            }
            // call ajax
            return { Success: true };
        }

        function getSmsCode() {
            var code = '';
            $('.campo_ingreso_codigo_sms').each(function() {
                code += $(this).val();
            });

            return code;
        }

        function markSmsCodeStatus(valid) {
            var icon = $('.icono_validacion_codigo_sms');

            icon.show();
            if (!valid) {
                icon.removeClass('validacion_exitosa')
                    .addClass('validacion_erronea');

                return;
            }

            icon.removeClass('validacion_erronea')
                .addClass('validacion_exitosa');
        }

        function format2(value) {
            if (value < 10) return '0' + value;

            return value;
        }

        function stepCounter(segs) {
            clearInterval(interval);

            localData.Expired = false;
            var now = 0;
            interval = setInterval(function() {
                
                    now += 1000;
                    var distance = segs - now;

                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    counterElement.text(format2(minutes) + ":" + format2(seconds));

                    if (distance < 0) {
                        localData.Expired = true;
                        clearInterval(interval);
                        counterElement.text("EXPIRÓ");
                    }
                },
                500);
        }

        function counter() {
            counterElement.text('03:00');
            stepCounter(3 * 60000);
        }

        function showError(text) {
            $('.text-error').text(text);
        }

        function verifySmsCode(code) {
            if (localData.Expired) {
                return;
            }

            var resultSmsCode = function(r) {
                if (!r.Success) {
                    if (r.Message) {
                        me.Funciones.ShowError(r.Message);
                        me.Funciones.NavigatePanel(0);
                    } else {
                        me.Funciones.MarkSmsCodeStatus(false);
                    }

                    return;
                }

                me.Funciones.MarkSmsCodeStatus(true);

                setTimeout(function() {
                        me.Funciones.NavigatePanel(2);
                    },
                    1000);
            };

            me.Services.confirmarSmsCode(code)
                .then(resultSmsCode, me.Funciones.HandleError);
        }

        function navigatePanel(index) {
            panels.forEach(function(item, idx) {
                if (idx === index) {
                    item.show();
                } else {
                    item.hide();
                }
            });
        }

        function setIsoPais(iso) {
            localData.IsoPais = iso;
        }

        function handleError(er) {
            alert('Ocurrio un error inesperado.');
        }

        return {
            InicializarEventos: inicializarEventos,
            ValidarCelular: validarCelular,
            GetSmsCode: getSmsCode,
            MarkSmsCodeStatus: markSmsCodeStatus,
            InitCounter: counter,
            VerifySmsCode: verifySmsCode,
            ShowError: showError,
            NavigatePanel: navigatePanel,
            SetIsoPais: setIsoPais,
            HandleError: handleError
        };

    })();
    me.Eventos = (function() {
        function continuar() {
            var nuevoCelular = $('#NuevoCelular').val();

            var result = me.Funciones.ValidarCelular(nuevoCelular);
            if (!result.Success) {
                me.Funciones.ShowError(result.Message);
                return;
            }

            localData.CelularNuevo = nuevoCelular;
            me.Services.enviarSmsCode(nuevoCelular)
                .then(function(r) {
                    localData.CelularValido = r.Success;
                    if (!r.Success) {
                        me.Funciones.ShowError(r.Message);
                        return;
                    }
                    me.Funciones.NavigatePanel(1);
                    $('.icono_validacion_codigo_sms').hide();
                    me.Funciones.ShowError('');

                    me.Funciones.InitCounter();
                }, me.Funciones.HandleError);
        }

        function backEdiNumber() {
            me.Funciones.NavigatePanel(0);
        }

        function sendSmsCode() {
            me.Services.enviarSmsCode(localData.CelularNuevo)
                .then(function(r) {
                    if (!r.Success) {
                        me.Funciones.ShowError(r.Message);
                        me.Funciones.NavigatePanel(0);

                        return;
                    }

                    me.Funciones.InitCounter();
                }, me.Funciones.HandleError);
        }

        function changeCodeSms() {
            var input = $(this);
            if (input.val()) {
                input.next().focus();
            }

            var code = me.Funciones.GetSmsCode();
            if (code.length !== 6) {
                return;
            }

            me.Funciones.VerifySmsCode(code);
        }

        return {
            Continuar: continuar,
            BackEdiNumber: backEdiNumber,
            SendSmsCode: sendSmsCode,
            ChangeCodeSms: changeCodeSms
        };
    })();
    me.Inicializar = function() {
        me.Funciones.InicializarEventos();
    };

    return me;
})(urlProvider, jQuery);

window.actualizarCelularModule = actualizarCelularModule;

$(document).ready(function () {
    actualizarCelularModule.Funciones.SetIsoPais(IsoPais);
    actualizarCelularModule.Inicializar();
});