var scrollBeneficios = true
var scrollLogros = true

$(document).ready(function () {
    Carusel();

    var nivelactual = $("#hfNivelActual").val();
    for (var i = 1; i <= nivelactual; i++)
        $(".pt" + i).addClass("activo");

    $(".pt" + nivelactual).addClass("brillante");

    $('#OfertasEspeciales').click(function () {
        TagClickBotonVerOfertas();
    });

    $('#btnCerrarNiveles').click(function () {
        TagCerrarBeneficios($("#btnCerrarNiveles").val());
    });

    $('#loadingScreen').hide();

    $(".regular").slick({
        dots: true,
        infinite: true,
        slidesToShow: 4,
        slidesToScroll: 1,
        dots: false,
        prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',
        nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',
        responsive: [
            {
                breakpoint: 768,
                settings: {

                    slidesToShow: 2,
                }
            }
        ]
    });


});
$(window).on("load", function () {
    TagNivelBeneficios('Mi Nivel');
    
});

$(window).on("scroll", function () {
    
    var windowHeight = $(window).scrollTop() ;
    var topBeneficios = $('#BeneficiosPrincipal').offset().top  - 100
    var topLogros = $('#cont-logros').offset().top - 200

    if (windowHeight >= topBeneficios && windowHeight <= topLogros ) {
        if (scrollBeneficios) {
            TagNivelBeneficios('Mis Beneficios');
            scrollBeneficios = false;
        }
    }

    if (windowHeight >= topLogros) {
        if (scrollLogros) {
            TagNivelBeneficios('Mis Logros');
            scrollLogros = false;
        }
    }

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

function TagVerTodos(MisLogros) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios – Mis Logros',
        'action': 'Detalle ' + MisLogros ,
        'label': '(not available)'
    });
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

    TagClickSeleccionNivel(nivelConsultora);

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

function TagCerrarBeneficios(nivelConsultora) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Cerrar Pop-up del nivel',
        'label': 'Nivel: ' + nivelConsultora
    });
}

function TagNivelBeneficios(pagina) {
        dataLayer.push({
            'event': 'virtualPage',
            'pageUrl': 'CaminoBrillante/pv/nivel-y-beneficios/' + pagina,
            'pageName': 'Nivel y beneficios - ' + pagina
        });
}





window.onload = function () {
    var ctx = document.getElementById('canvas').getContext('2d');
    window.myBar = new Chart(ctx, {
        type: 'bar',
        data: {

            labels: ["C05", "C06", "C07", "C08", "C09", "C10"],
            datasets: [
                {

                    label: "Unidad (Millones) ",
                    backgroundColor: ["#ffdaf3", "#4f0036", "#ffdaf3", "#ffdaf3", "#ffdaf3", "#ffdaf3"],
                    data: [2478, 3267, 734, 784, 433, 403]
                }
            ]
        },



        options: {
            tooltips: {
                enabled: false
            },
            scales: {
                yAxes: [{
                    ticks: {

                        fontColor: "#000",
                        fontSize: 14
                    },
                    gridLines: {
                        color: "#f7f7f7",
                        lineWidth: 1,
                        zeroLineColor: "#000",
                        zeroLineWidth: 0
                    }
                }],

                xAxes: [{
                    ticks: {
                        fontColor: "#000",
                        fontSize: 14
                    },
                    gridLines: {
                        color: "#f7f7f7",
                        lineWidth: 1,
                        zeroLineColor: "#000",
                        zeroLineWidth: 0
                    }
                }]

            },

            legend: { display: false },
            title: {
                display: true
            },
            onClick: alertBox

        }
    });

};

function alertBox() {
    alert("click");
    $(".box-left-ganancias span").text("Hello world!");
}