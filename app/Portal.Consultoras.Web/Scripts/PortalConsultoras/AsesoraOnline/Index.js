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
            scrollDownArrow: function (e) {
                e.preventDefault();

                var atributoTitulo = $(".arrow_down_coach_virtual").attr("href");

                $('html,body').animate({
                    scrollTop: $(atributoTitulo).offset().top - 30
                }, 650, "easeOutSine");
            },
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
                //$(this).parent().fadeOut(400);            
            },
            mostrarBotonSuscripcionMobile: function () {
                if (window.matchMedia("(max-width:767px)").matches) {
                    if ($(window).scrollTop() > $("#formulario-inscripcion").offset().top - 200) {
                        $(".cta_inscripcion_fixed").removeClass("mostrar_cta_inscripcion_mobile_fijo");
                    }
                    else if ($(window).scrollTop() > $("#cta-suscribirme").offset().top + 45) {
                        $(".cta_inscripcion_fixed").addClass("mostrar_cta_inscripcion_mobile_fijo");
                    }
                    else {
                        $(".cta_inscripcion_fixed").removeClass("mostrar_cta_inscripcion_mobile_fijo");
                    }
                }
            }
        };

        me.Funciones = {
            inicializarEventos: function () {

                $("body").on("click", ".cta_inscripcion", function () {
                    me.Funciones.dataLayerVirtualCoach("Click Botón", "Quiero Subscribirme");
                    me.Eventos.irASeccionFormulario;
                });
                $("body").on("click", ".cerrar_popup_inscripcion", function () { me.Funciones.dataLayerVirtualCoach("Banner Confirmación", "Cerrar popup"); $(this).parents(".contenedor_fondo_popup").fadeOut(400); });
                $("body").on("click", "#datos_son_correctos", function () { me.Funciones.dataLayerVirtualCoach("Banner Confirmación", "Click botón Todos mis datos son correctos"); $(this).parents(".contenedor_fondo_popup").fadeOut(400); });

                $("body").on("click", ".arrow_down_coach_virtual", me.Eventos.scrollDownArrow);
                $(document).on("scroll", me.Eventos.mostrarBotonSuscripcionMobile);
                $("#enviar-form").on("click", asesoraOnlineObj.enviarFormulario);
                $("#modificar_mis_datos").on("click", asesoraOnlineObj.irAModificarMisDatos);
                $("#modificar_mis_datos_ya_registrado").on("click", asesoraOnlineObj.irAModificarMisDatos);
            },
            dataLayerVirtualCoach: function (action, label) {
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Coach Virtual',
                    'action': action,
                    'label': label
                });

            }
        };

        me.Inicializar = function () {
            me.Funciones.inicializarEventos();
            $("#terminos-condiciones").prop("checked", true);
        };
    };

    vista = new LandingAsesoraOnline();
    vista.Inicializar();
});