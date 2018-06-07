(function($) {
    'use strict';

    function VistaActualizaCelular() {
    var me = this;
    me.Datos = {
        CelularValido: false,
        Expired: true
    };
    me.Funciones = {
        InicializarEventos: function () {
            var body = $('body');
            body.on('click', '.btn_continuar', me.Eventos.Continuar);
            body.on('click', '.enlace_cambiar_correo', me.Eventos.BackEdiNumber);
            body.on('click', '.enlace_reenviar_instrucciones', me.Eventos.SendSmsCode);
            body.on('click', '.btn_acept', me.Eventos.Finish);
            body.on('click', '.enlace_cancelar', me.Eventos.Cancelar);
            body.on('change', '.campo_ingreso_codigo_sms', me.Eventos.ChangeCodeSms);
        },
        ValidarCelular: function(numero) {
            // call ajax
            return Promise.resolve({valid: true});
        },
        GetSmsCode: function() {
            var code = '';
            $('.campo_ingreso_codigo_sms').each(function() {
                code += $(this).val();
            });

            return code;
        },
        ValidarSmsCode: function(code) {
            // call ajax
            return Promise.resolve({valid: true});
        },
        MarkSmsCodeStatus: function(valid) {
            var icon = $('.icono_validacion_codigo_sms');

            icon.show();
            if (!valid) {
                icon.removeClass('validacion_exitosa')
                    .addClass('validacion_erronea');

                return;
            }

            icon.removeClass('validacion_erronea')
                .addClass('validacion_exitosa');
        },
        SendSmsCode: function() {
            return Promise.resolve({Success: true});
        },
        RedirecToPerfil: function() {
            window.location.href = "/MiPerfil";
        },
        format2: function (value) {
            if (value < 10) return '0' + value;
  
            return value;
        },
        Counter: function(segs) {
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
                element.innerHTML = me.Funciones.format2(minutes) + ":" + me.Funciones.format2(seconds);
    
                // If the count down is over, write some text 
                if (distance < 0) {
                    me.Datos.Expired = true;
                    clearInterval(x);
                    element.innerHTML = "EXPIRED";
                }
            }, 1000);
        }
    };
    me.Eventos = {
        Continuar: function () {
            var nuevoCelular = $('#NuevoCelular').val();

            me.Funciones.ValidarCelular(nuevoCelular)
                .then(function(r) {
                    me.Datos.CelularValido = r.valid;
                    if (!me.Datos.CelularValido) {
                        // show errros
                    }
                    
                    $('.form_actualizar_celular').hide();
                    $('.revisa_tu_celular').show();
                    me.Funciones.SendSmsCode()
                        .then(function(r) {
                            if (r.Success) {
                                // sms enviado
                                me.Funciones.Counter(3 * 60000);
                            }
                        });
                });

        },
        BackEdiNumber: function() {
            $('.revisa_tu_celular').hide();
            $('.form_actualizar_celular').show();

            $('.icono_validacion_codigo_sms').hide();
        },
        SendSmsCode: function() {
            me.Funciones.SendSmsCode()
                .then(function(r) {
                    if (r.Success) {
                        // sms enviado
                        me.Funciones.Counter(3 * 60000);
                    }
                });
        },
        ChangeCodeSms: function() {
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
                    if (!r.valid) {
                        me.Funciones.MarkSmsCodeStatus(false);
                        return;
                    }
                    me.Funciones.MarkSmsCodeStatus(true);

                    setTimeout(function() {
                        $('.revisa_tu_celular').hide();
                        $('.celular_actualizado').show();
                    }, 1000);
                });
        },
        Finish: function() {
            me.Funciones.RedirecToPerfil();
        },
        Cancelar: function() {
            me.Funciones.RedirecToPerfil();
        }
    };
    me.Inicializar = function () {
        me.Funciones.InicializarEventos();
    }
}

$(document).ready(function () {
    var view = new VistaActualizaCelular();
    view.Inicializar();
});

})(jQuery);