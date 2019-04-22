﻿$(document).ready(function () {
    Carusel();

    var nivelactual = $("#hfNivelActual").val();
    for (var i = 1; i <= nivelactual; i++)
        $(".pt" + i).addClass("activo");

    $(".pt" + nivelactual).addClass("brillante");

    $('#OfertasEspeciales').click(function () {
        TagClickBotonVerOfertas();
    });

    $(window).scroll(function (event) {
        var windowHeight = $(window).scrollTop(); 

        var contenido0 = $("#ProgressBar").offset();
        contenido0 = contenido0.top;

        var contenido1 = $("#BeneficiosPrincipal").offset();
        contenido1 = contenido1.top;

        var contenido2 = $("#cont-logros").offset();
        contenido2 = contenido2.top;

        if (windowHeight < contenido0) {
            //alert(contenido0);
            return;
        }

        if (windowHeight <= contenido1 && contenido1 < contenido2) {
            //alert("estas en beneficios");
            return;
        }

        if (contenido2 > contenido1) {
           //alert("estas en logros");
            return;
        }
    });

    $('#loadingScreen').hide();
});


$('#btnCerrarNiveles').click(function () {
    CerrarBeneficios();
});


function Carusel() {
    var owl = $('.owl-crec');
    owl.owlCarousel({
        stagePadding: 35,
        margin: 20,
        nav: true,
        loop: false,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            1000: {
                items: 2
            }
        }
    })

    var mont = $('.owl-mont');
    mont.owlCarousel({
        stagePadding: 30,
        margin: 10,
        nav: true,
        loop: false,
        responsive: {
            0: {
                items: 1
            },
            410: {
                items: 2
            },
            1500: {
                items: 1
            }
        }
    })
}


function TagClickSeleccionNivel(nivelConsultora) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Seleccionar nivel',
        'label': 'Nivel: ' + nivelConsultora
    });
}

function TagMostrarPopupNivel(nivelConsultora) {   
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Ver Pop-up del nivel',
        'label': 'Nivel: ' + nivelConsultora
    });
}

function TagClickBotonVerOfertas() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios–Mis beneficios de nivel',
        'action': 'Selección: Ver Ofertas',
        'label': '(not available)'
    });
}

function CerrarBeneficios() {
    var nivelconsultora = $("#hfNivelActual").val();
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Cerrar Pop-up del nivel',
        'label': 'Nivel: ' + nivelconsultora
    });
}

