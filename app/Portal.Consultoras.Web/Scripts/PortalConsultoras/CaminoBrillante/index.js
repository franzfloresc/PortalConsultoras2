var scrollBeneficios = true
var scrollLogros = true

$(document).ready(function () {
    Handlebars.registerPartial("kit_template", $("#template-kit").html());
    Handlebars.registerPartial("demostrador_template", $("#template-demostrador").html());

    CargarCarrusel();
    CargarGanancias();

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

function CargarCarrusel() {
    $.ajax({
        type: 'GET',
        url: urlGetCarrusel,        
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                ArmarCarrusel(data);
            }
        },
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            cargandoRegistros = false;
        }
    });
}

function CargarGanancias() {
    $.ajax({
        type: 'GET',
        url: urlGetMisGanancias,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                ArmarMisGanancias(data);
            }
        },
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
        }
    });
}


function ArmarMisGanancias(data) {
    if (!data) return;

    var ctx = document.getElementById('canvas').getContext('2d');

    var labels = [];
    var serie = [];

    for (x = 0; x < data.MisGanancias.length; x++) {
        var item = data.MisGanancias[x];
        labels.push(item.LabelSerie);
        serie.push(item.ValorSerie);
    };

    var myBar = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    backgroundColor: "#ffdaf3",
                    data: serie
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
                    barPercentage: 0.6,
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
        }
    });

    var onClickEvent = function (evt) {
        var activePoints = myBar.getElementsAtEvent(evt);
        if (activePoints.length > 0) {
            var clickedElementindex = activePoints[0]["_index"];
            var item = data.MisGanancias[clickedElementindex];
            $("#ganancia-campania-nombre").text("Ganancia "+item.LabelSerie);
            $("#ganancia-campania").text(variablesPortal.SimboloMoneda+" "+item.GananciaCampaniaFormat);
            $("#ganancia-periodo").text(variablesPortal.SimboloMoneda+" "+item.GananciaPeriodoFormat);
        }
    };
    $("#canvas").click( onClickEvent );
}

function ArmarCarrusel(data) {
    var htmlDiv = SetHandlebars("#template-carrusel", data);
    $('#carrusel').append(htmlDiv);
    $('#carrusel').show();

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
    
}