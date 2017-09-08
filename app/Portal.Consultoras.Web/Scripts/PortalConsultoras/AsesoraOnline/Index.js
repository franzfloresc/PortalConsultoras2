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
                    }
                    else {
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
            inicializarEventos: function () {
                $("body").on("click", ".cta_inscripcion", me.Eventos.irASeccionFormulario);
                $("body").on("click", ".cerrar_popup_inscripcion", me.Eventos.cerrarPopupsAsesoraOnline);
                $("body").on("click", "#datos_son_correctos", me.Eventos.cerrarPopupsAsesoraOnline);
                $(document).on("scroll", me.Eventos.mostrarBotonSuscripcionMobile);

                $("#enviar-form").on("click", asesoraOnlineObj.enviarFormulario);
                $("#modificar_mis_datos").on("click", asesoraOnlineObj.irAModificarMisDatos);
                $("#modificar_mis_datos_ya_registrado").on("click", asesoraOnlineObj.irAModificarMisDatos);
            }
        };

        me.Inicializar = function () {
            me.Funciones.removerEnlace();
            me.Funciones.inicializarEventos();
            $("#terminos-condiciones").prop("checked", true);
        };
    };

    vista = new LandingAsesoraOnline();
    vista.Inicializar();
});