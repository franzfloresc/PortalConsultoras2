var vista;

$(document).ready(function () {

    var asesoraOnlineObj = AsesoraOnline({
        enviarFormularioUrl: baseUrl + 'AsesoraOnline/EnviarFormulario',
        irAModificarMisDatosUrl: baseUrl + 'Bienvenida/IndexVC'
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
            
            },

            mostrarBotonSuscripcionMobile: function () {

                if(window.matchMedia("(max-width:767px)").matches) {

                    if ($(window).scrollTop() > $("#cta-suscribirme").offset().top + 45) {

                        $(".cta_inscripcion_fixed").addClass("mostrar_cta_inscripcion_mobile_fijo");

                    } else {

                        $(".cta_inscripcion_fixed").removeClass("mostrar_cta_inscripcion_mobile_fijo");

                    }

                }

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
                $(document).on("scroll", me.Eventos.mostrarBotonSuscripcionMobile);

            }

        };

        me.Inicializar = function () {

            me.Funciones.removerEnlace();
            me.Funciones.cambiarTexto();
            me.Funciones.inicializarEventos();
            $(window).resize(me.Funciones.cambiarTexto);

            $("#enviar-form").on("click", asesoraOnlineObj.enviarFormulario);
            $("#modificar_mis_datos").on("click", asesoraOnlineObj.irAModificarMisDatos);
            $("#modificar_mis_datos_ya_registrado").on("click", asesoraOnlineObj.irAModificarMisDatos);
        };

    };

    vista = new LandingAsesoraOnline();
    vista.Inicializar();

});