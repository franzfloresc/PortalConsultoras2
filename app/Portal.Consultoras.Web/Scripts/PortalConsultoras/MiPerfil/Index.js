var MiPerfil;

$(document).ready(function () {
    'use strict';

    var vistaMiPerfil;

    vistaMiPerfil = function () {
        var me = this;

        //me.Globals = {

        //},
        me.Funciones = {
            InicializarEventos: function () {
                $('body').on('blur', '.grupo_form_cambio_datos input', me.Eventos.LabelActivo);
                $('body').on('click', '.enlace_agregar_num_adicional', me.Eventos.AgregarOtroNumero);
                $('body').on('click', '.enlace_eliminar_numero_adicional', me.Eventos.EliminarNumeroAdicional);
                $('body').on('click', '.enlace_ver_password', me.Eventos.MostrarPassword);
            },
            CamposFormularioConDatos: function () {
                var camposFormulario = $('.grupo_form_cambio_datos input');
                $.map(camposFormulario, function (campoFormulario, key) {
                    if ($(campoFormulario).val() != '') {
                        $(campoFormulario).addClass('campo_con_datos');
                    }
                });
            }
        },
        me.Eventos = {
            LabelActivo: function () {
                var campoDatos = $(this).val();
                if(campoDatos != ''){
                    $(this).addClass('campo_con_datos');
                } else {
                    $(this).removeClass('campo_con_datos');
                }
            },
            AgregarOtroNumero: function (e) {
                e.preventDefault();
                $(this).fadeOut(150);
                $('.label_num_adicional').fadeIn(100);
                $('.contenedor_campos_num_adicional').fadeIn(150);
            },
            EliminarNumeroAdicional: function (e) {
                e.preventDefault();
                $('.contenedor_campos_num_adicional').fadeOut(150);
                $('.label_num_adicional').fadeOut(100);
                $('.enlace_agregar_num_adicional').fadeIn(150);
                $('.contenedor_campos_num_adicional input').val('');
            },
            MostrarPassword: function (e) {
                e.preventDefault();
                var _this = e.target;
                var campoPassword = $(_this).parent().find('input');
                if (campoPassword.val() != '') {
                    if ($(_this).is('.icono_ver_password_activo')) {
                        $(_this).removeClass('icono_ver_password_activo');
                        campoPassword.attr('type', 'password');
                    } else {
                        $(_this).addClass('icono_ver_password_activo');
                        campoPassword.attr('type', 'text');
                    }
                }
            }
        },
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
            me.Funciones.CamposFormularioConDatos();
        }
    }

    MiPerfil = new vistaMiPerfil();
    MiPerfil.Inicializar();

});