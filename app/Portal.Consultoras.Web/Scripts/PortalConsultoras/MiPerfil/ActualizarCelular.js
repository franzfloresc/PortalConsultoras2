function actualizarCelularModule(urls) {
    'use strict';

    var me = this;
    me.Datos = {
        CelularValido: false,
        CelularNuevo: '',
        Expired: true
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
                    ErrorMessage: 'El número no puede estar vacío.'
                };
            }
            var reg = /^\d+$/;
            if (!reg.test(numero)) {
                return {
                    Success: false,
                    ErrorMessage: 'No es un número válido.'
                };
            }

            var result = validarPhonePais(IsoPais, numero);
            if (!result.valid) {
                return {
                    Success: false,
                    ErrorMessage: 'El número debe tener ' + result.length + ' digitos.'
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

        function validarSmsCode(code) {
            // call ajax
            return Promise.resolve({ Success: true });
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

        function counter(segs) {
            me.Datos.Expired = false;
            var now = 0;
            var element = document.getElementById("time_counter");
            // Update the count down every 1 second
            var x = setInterval(function() {

                    // Get todays date and time

                    // Find the distance between now an the count down date
                    now += 1000;
                    var distance = segs - now;

                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                    // Output the result in an element with id="demo"
                    element.innerHTML = format2(minutes) + ":" + format2(seconds);

                    // If the count down is over, write some text 
                    if (distance < 0) {
                        me.Datos.Expired = true;
                        clearInterval(x);
                        element.innerHTML = "EXPIRED";
                    }
                },
                1000);
        }

        function showError(text) {
            $('.text-error').text(text);
        }

        return {
            InicializarEventos: inicializarEventos,
            ValidarCelular: validarCelular,
            GetSmsCode: getSmsCode,
            ValidarSmsCode: validarSmsCode,
            MarkSmsCodeStatus: markSmsCodeStatus,
            RedirecToPerfil: redirecToPerfil,
            Counter: counter,
            ShowError: showError
        };

    })();
    me.Eventos = (function() {
        function continuar() {
            var nuevoCelular = $('#NuevoCelular').val();

            var result = me.Funciones.ValidarCelular(nuevoCelular);
            if (!result.Success) {
                me.Funciones.ShowError(result.ErrorMessage);
                return;
            }

            me.Datos.CelularNuevo = nuevoCelular;
            me.Services.enviarSmsCode(nuevoCelular)
                .then(function(r) {
                    me.Datos.CelularValido = r.Success;
                    if (!r.Success) {
                        me.Funciones.ShowError(r.ErrorMessage);
                        return;
                    }

                    $('.form_actualizar_celular').hide();
                    $('.revisa_tu_celular').show();
                    me.Funciones.Counter(3 * 60000);
                });
        }

        function backEdiNumber() {
            $('.revisa_tu_celular').hide();
            $('.form_actualizar_celular').show();

            $('.icono_validacion_codigo_sms').hide();
        }

        function sendSmsCode() {
            me.Funciones.SendSmsCode(me.Datos.CelularNuevo)
                .then(function(r) {
                    if (!r.Success) {
                        // error envio

                        return;
                    }

                    me.Funciones.Counter(3 * 60000);
                });
        }

        function changeCodeSms() {
            var input = $(this);
            if (input.val()) {
                input.next().focus();
            }

            var code = me.Funciones.GetSmsCode();
            console.log("Code: " + code);
            if (code.length !== 6) {
                return;
            }

            if (me.Datos.Expired) {
                return;
            }

            me.Funciones.ValidarSmsCode(code)
                .then(function(r) {
                    if (!r.Success) {
                        me.Funciones.MarkSmsCodeStatus(false);
                        return;
                    }
                    me.Funciones.MarkSmsCodeStatus(true);

                    setTimeout(function() {
                            $('.revisa_tu_celular').hide();
                            $('.celular_actualizado').show();
                        },
                        1000);
                });
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

};

$(document).ready(function () {
    var mod = new actualizarCelularModule(urlProvider);
    mod.Inicializar();
});