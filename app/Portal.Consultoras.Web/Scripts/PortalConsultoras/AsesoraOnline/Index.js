var vista;

$(document).ready(function () {

    var LandingAsesoraOnline;

    LandingAsesoraOnline = function () {

        var me = this;

        me.Eventos = {

            irASeccionFormulario: function (e) {

                e.preventDefault();

                var atributoEnlaceQuieroInscribirme = $(".cta_inscripcion").attr("href");

                $('html,body').animate({
                    scrollTop: $(atributoEnlaceQuieroInscribirme).offset().top
                }, 650, "easeOutSine");

            }

        };

        me.Funciones = {

            removerEnlace: function () {

                setTimeout(function () {
                    $('a[href*="//apps.elfsight.com/panel/"]').remove();
                }, 1500);

            },

            cambiarTexto: function () {

                if (window.matchMedia("(max-width:767px)").matches) {

                    $(".descripcion_asesora_online").html("<span>Recibe por correo y mensaje de texto la mejor asesoría para ganar más.</span><span>¡Sólo debes confirmar tus datos de contacto!</span>");

                } else {

                    $(".descripcion_asesora_online").html("<span>Recibe por correo y mensaje de texto la mejor asesoría para ganar más, gestionar tus clientes, comprar ofertas exclusivas y mucho más.</span><span>¡Sólo debes confirmar tus datos de contacto!</span>");
                }

            },

            inicializarEventos: function () {

                $("body").on("click", ".cta_inscripcion", me.Eventos.irASeccionFormulario);

            }

        };

        me.Inicializar = function () {

            me.Funciones.removerEnlace();
            me.Funciones.cambiarTexto();
            me.Funciones.inicializarEventos();
            $(window).resize(me.Funciones.cambiarTexto);

        };

    };

    vista = new LandingAsesoraOnline();
    vista.Inicializar();

});