﻿function actualizarCelularModule() {
    'use strict';

    var me = this;
    me.Datos = {
        CelularValido: false,
        Expired: true
    };
    me.Funciones = (function() {
        function inicializarEventos() {
            var body = $('body');
            body.on('click', '.btn_continuar', me.Eventos.Continuar);
            body.on('click', '.enlace_cambiar_correo', me.Eventos.BackEdiNumber);
            body.on('click', '.enlace_reenviar_instrucciones', me.Eventos.SendSmsCode);
            body.on('click', '.btn_acept', me.Eventos.Finish);
            body.on('click', '.enlace_cancelar', me.Eventos.Cancelar);
            body.on('change', '.campo_ingreso_codigo_sms', me.Eventos.ChangeCodeSms);
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
                return Promise.resolve({
                    Success: false,
                    ErrorMessage: 'El número no puede estar vacío.'
                });
            }
            var reg = /^\d+$/;
            if (!reg.test(numero)) {
                return Promise.resolve({
                    Success: false,
                    ErrorMessage: 'No es un número válido.'
                });
            }

            var result = validarPhonePais(IsoPais, numero);
            if (!result.valid) {
                return Promise.resolve({
                    Success: false,
                    ErrorMessage: 'El número debe tener ' + result.length + ' digitos.'
                });
            }
            // call ajax
            return Promise.resolve({ Success: true });
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

        function sendSmsCode() {
            return Promise.resolve({ Success: true });
        }

        function redirecToPerfil() {
            window.location.href = "/MiPerfil";
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
            SendSmsCode: sendSmsCode,
            RedirecToPerfil: redirecToPerfil,
            Counter: counter,
            ShowError: showError
        };

    })();
    me.Eventos = (function() {
        function continuar() {
            var nuevoCelular = $('#NuevoCelular').val();

            me.Funciones.ValidarCelular(nuevoCelular)
                .then(function(r) {
                    me.Datos.CelularValido = r.Success;
                    if (!me.Datos.CelularValido) {
                        me.Funciones.ShowError(r.ErrorMessage);
                        return;
                    }

                    $('.form_actualizar_celular').hide();
                    $('.revisa_tu_celular').show();
                    me.Funciones.SendSmsCode()
                        .then(function(r) {
                            if (r.Success) {
                                // sms enviado
                                me.Funciones.Counter(3 * 60000);
                                return;
                            }
                            me.Funciones.ShowError(r.ErrorMessage);
                        });
                });

        }

        function backEdiNumber() {
            $('.revisa_tu_celular').hide();
            $('.form_actualizar_celular').show();

            $('.icono_validacion_codigo_sms').hide();
        }

        function sendSmsCode() {
            me.Funciones.SendSmsCode()
                .then(function(r) {
                    if (r.Success) {
                        // sms enviado
                        me.Funciones.Counter(3 * 60000);
                    }
                });
        }

        function changeCodeSms() {
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

        function finish() {
            me.Funciones.RedirecToPerfil();
        }

        function cancelar() {
            me.Funciones.RedirecToPerfil();
        }

        return {
            Continuar: continuar,
            BackEdiNumber: backEdiNumber,
            SendSmsCode: sendSmsCode,
            ChangeCodeSms: changeCodeSms,
            Finish: finish,
            Cancelar: cancelar
        };
    })();
    me.Inicializar = function() {
        me.Funciones.InicializarEventos();
    };

};

$(document).ready(function () {
    var mod = new actualizarCelularModule();
    mod.Inicializar();
});