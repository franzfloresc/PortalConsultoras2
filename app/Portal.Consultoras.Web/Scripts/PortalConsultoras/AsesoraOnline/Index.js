var vista;

$(document).ready(function () {

    var asesoraOnlineObj = AsesoraOnline({
        enviarFormularioUrl: baseUrl + 'AsesoraOnline/EnviarFormulario'
    });

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

            },

            cerrarPopupsAsesoraOnline: function (e) {

                e.preventDefault();

                $(this).parents(".contenedor_fondo_popup").fadeOut(400);
                $(this).parent().fadeOut(400);
            
            }

        };

        me.Funciones = {

            removerEnlace: function () {

                setTimeout(function () {
                    $('a[href*="//apps.elfsight.com/panel/"]').remove();
                }, 2000);

            },

            cambiarTexto: function () {

                if (window.matchMedia("(max-width:767px)").matches) {

                    $(".texto_titulo span").first().html("¿Cuál es tu método de venta preferido con tus clientes?");
                    $(".textoOpcionDejarCatalogo label").html("<span></span>Dejo el catálogo a mis clientes");
                    $(".textoOpcionTienda label").html("<span></span>Tengo un negocio");

                } else {

                    $(".texto_titulo span").first().html("¿Cuál es tu forma de vender ganadora?");
                    $(".textoOpcionDejarCatalogo label").html("<span></span>Dejo el catálogo a mis clientes");
                    $(".textoOpcionTienda label").html("<span></span>Mis clientes vienen a mi tienda");
                }

            },

            inicializarEventos: function () {

                $("body").on("click", ".cta_inscripcion", me.Eventos.irASeccionFormulario);
                $("body").on("click", ".cerrar_popup_inscripcion", me.Eventos.cerrarPopupsAsesoraOnline);
            }

        };

        me.Inicializar = function () {

            me.Funciones.removerEnlace();
            me.Funciones.cambiarTexto();
            me.Funciones.inicializarEventos();
            $(window).resize(me.Funciones.cambiarTexto);

            $("#enviar-form").on("click", asesoraOnlineObj.enviarFormulario);

        };

    };

    vista = new LandingAsesoraOnline();
    vista.Inicializar();

});