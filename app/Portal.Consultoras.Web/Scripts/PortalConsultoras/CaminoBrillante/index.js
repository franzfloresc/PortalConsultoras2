var scrollBeneficios = true
var scrollLogros = true
var tamañoFont = $("#fontGanancia").val()

$(document).ready(function () {

    Carusel();
    if (TineCarrusel == "1" && $("#template-kit").length > 0) {
        Handlebars.registerPartial("kit_template", $("#template-kit").html());
        Handlebars.registerPartial("demostrador_template", $("#template-demostrador").html());
        CargarCarrusel();
    }

    if (TieneGanancias == "1") CargarGanancias();
    var nivelactual = $("#hfNivelActual").val();

    //Barra monto Acumulado
    if (TieneMontoAcumulado == '1') {

        var progreso = $("#bar-progreso");
        if (progreso.length > 0) {
            var maxBar = $(progreso).data("max");
            var curBar = $(progreso).data("cur");
            var perc = Math.min((curBar / maxBar) * 100, 100);
            $('.new-bar').width(perc + '%');
            var minBar = $(progreso).data("min");
            var percTope = Math.min((minBar / maxBar) * 100, 100);
            $('.progress-barnew .tope').css("left", percTope + '%');
        }
        if (nivelactual == '1' || nivelactual == '5') {
            $(".bord-bot").addClass("centtopacio");
        }
    }

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

    $('.regulardoc').slick({
        dots: true,
        infinite: true,
        autoplay: true,
        autoplaySpeed: 4500,
        fade: true,
    });

    $('.slick-next').click(function () {
        $('.regulardoc').slick('slickPause');
    });

    if (TieneGananciaAnim == 'True') {
        $(".box-right-ganancias").append("<strong><i></i></strong>");
    }

    $('.box-right-ganancias strong').click(function () {
        $(this).hide();
        $('.box-right-ganancias strong i').hide();

        $.ajax({
            type: 'POST',
            url: urlAnims + '?key=Gesture&repeat=0',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
        });
    });

    $(".btnemp").click(function () { $("#Modalunbord").hide(); });
    $('#btnAceptarOnboardding').click(function () {
        var esChecked = $("#volvermostrar").prop('checked') ? "0" : "1";
        $.ajax({
            type: 'POST',
            url: urlAnims + '?key=Onbording&repeat=' + esChecked,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
        });
    });

    $("#Modalunbord, #Modalunbordseguir").modal({
        show: false,
        keyboard: false,
        backdrop: 'static'
    });
});
$(window).on("load", function () {
    TagNivelBeneficios('Mi Nivel');
    if (TieneOnboardingAnim === 'True') {
        $('#Modalunbord').modal('show');
    }
});



$(window).on("load", function () {
    TagNivelBeneficios('Mi Nivel');
});

$(window).on("scroll", function () {

    var windowHeight = $(window).scrollTop();
    var topBeneficios = $('#BeneficiosPrincipal').offset().top - 100
    var topLogros = $('#cont-logros').offset().top - 200

    if (windowHeight >= topBeneficios && windowHeight <= topLogros) {
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

$("#carrusel").on('click', '.boton_agregar_ofertas', function (e) {
    var descTipoOferta = "";
    var cantidad = 1;
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(contenedor).find('div [data-estrategia]').attr("data-estrategia"));
    var imagenProducto = obj.FotoProductoMedium;
    if (obj.TipoOferta == 1) {
        descTipoOferta = "kits";
    } else if (obj.TipoOferta == 2) {
        descTipoOferta = "Demostradores";
        var cantidad = $(contenedor).find("#txtCantidad").val();
        if (cantidad <= 0) {
            AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
            CerrarSplash();
        }
    }
    AgregarProducto(obj, cantidad, imagenProducto, contenedor, descTipoOferta, false);
    if (obj.TipoOferta == 1) { $(contenedor).addClass("producto_desactivado"); }
});

function TagVerTodos(MisLogros) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios – Mis Logros',
        'action': 'Detalle ' + MisLogros,
        'label': '(not available)'
    });
}


function TagClickSeleccionNivel(nivelConsultora, codigoNivel, urlImagenActiva) {

    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Seleccionar nivel',
        'label': 'Nivel: ' + nivelConsultora
    });

    for (var i = 1; i <= 6; i++) {

        if ($("#" + i).hasClass('urlImagenActiva')) {
            $("#" + i).hide();
        }
    }

    $("#" + codigoNivel).addClass("urlImagenActiva");
    $("#" + codigoNivel).show();
    $("#" + codigoNivel).attr('src', urlImagenActiva);

}

function TagMostrarPopupNivel(nivelConsultora, codigoNivel, urlImagenActiva) {

    TagClickSeleccionNivel(nivelConsultora, codigoNivel, urlImagenActiva);
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Ver Pop-up del nivel',
        'label': 'Nivel: ' + nivelConsultora
    });
}

function MostrarSecciones(nivelSeleccionado) {
    var nivelActual = $("#hfNivelActual").val();
    if (nivelSeleccionado == nivelActual) {
        $("#BeneficiosPrincipal").show();
        $("#boxganancias").show();
        $("#progress-b").show();
        $("#carrusel").show();
        $(".bglogros").show();
        $("#cont-logros").show();
        $('.tab-content').removeClass('current');
        $(".urlImagenActiva").hide();
    }
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
    $("#boxganancias").hide();
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
    if (!data) {
        return;
    }
    $("#boxganancias").show();

    var ctx = document.getElementById('canvas').getContext('2d');

    var labels = []; var serie = []; var titles = [];
    var backgroundColors = []; var hoverBackgrounds = [];
    var indexSeleccion = -1;
    var colorBar = "#ffdaf3"; var colorBarSelected = "#4f0036";
    var sizeMinBar = 6;

    var x = 0;

    for (x = 0; x < data.MisGanancias.length; x++) {
        var item = data.MisGanancias[x];
        labels.push(item.LabelSerie);
        serie.push(item.ValorSerie);
        titles.push(item.ValorSerieFormat);
        backgroundColors.push(colorBar);

        if (item.FlagSeleccionMisGanancias) {
            indexSeleccion = x;
        }
    };

    for (; x < sizeMinBar; x++) {
        labels.push("");
        serie.push(0);
        titles.push("");
        backgroundColors.push(colorBar);
    }

    Chart.pluginService.register({
        beforeRender: function (chart) {
            if (chart.config.options.showAllTooltips) {
                chart.pluginTooltips = [];
                chart.config.data.datasets.forEach(function (dataset, i) {
                    chart.getDatasetMeta(i).data.forEach(function (sector, j) {
                        chart.pluginTooltips.push(new Chart.Tooltip({
                            _chart: chart.chart,
                            _chartInstance: chart,
                            _data: chart.data,
                            _options: chart.options.tooltips,
                            _active: [sector]
                        }, chart));
                    });
                });
                chart.options.tooltips.enabled = false;
            }
        },
        afterDraw: function (chart, easing) {
            if (chart.config.options.showAllTooltips) {
                if (!chart.allTooltipsOnce) {
                    if (easing !== 1)
                        return;
                    chart.allTooltipsOnce = true;
                }
                chart.options.tooltips.enabled = true;
                Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
                    tooltip.initialize();
                    tooltip.update();
                    tooltip.pivot();
                    tooltip.transition(easing).draw();
                });
                chart.options.tooltips.enabled = false;
            }
        }
    });

    if (indexSeleccion != -1) {
        backgroundColors[indexSeleccion] = colorBarSelected;
    } else {
        $("#boxganancias").hide();
    }

    var myBar = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {

                    borderColor: "#ffdaf3",
                    borderWidth: 0,

                    backgroundColor: backgroundColors,
                    hoverBackgroundColor: backgroundColors,
                    data: serie
                }
            ]
        },
        options: {
            showAllTooltips: true,
            onClick: function (evt, elements) {

                var datasetIndex;
                var dataset;
                if (elements.length) {
                    var index = elements[0]._index;
                    datasetIndex = elements[0]._datasetIndex;
                    backgroundColors[indexSeleccion] = colorBar;
                    // Reset old state
                    dataset = myBar.data.datasets[datasetIndex];

                    dataset.backgroundColor = backgroundColors.slice();
                    dataset.hoverBackgroundColor = dataset.backgroundColor;

                    dataset.backgroundColor[index] = colorBarSelected;
                    dataset.hoverBackgroundColor[index] = colorBarSelected;
                }
                myBar.update();
            },
            tooltips: {

                mode: 'line',
                displayColors: false,
                titleFontSize: 7,

                bodyFontSize: tamañoFont,

                titleFontFamily: 'Helvetica',
                titleFontStyle: 'normal',
                titleMarginBottom: 1,
                cornerRadius: 0,
                color: 'rgb(0, 0, 0)',
                backgroundColor: 'rgba(255, 255, 255)',
                titleFontColor: 'rgb(0, 0, 0)',
                bodyFontColor: 'rgb(0, 0, 0)',
                fontSize: 7,
                xPadding: 2,
                yPadding: 1,
                yAlign: 'bottom',
                xAlign: 'center',
                custom: function (tooltip) {
                    if (!tooltip) return;
                    tooltip.displayColors = false;
                },
                callbacks: {
                    label: function (tooltipItem, data) {
                        if (tooltipItem) {
                            return titles[tooltipItem.index];
                        }
                        return tooltipItem.yLabel;
                    },
                    title: function (tooltipItem, data) {
                        return;
                    }
                }
            },
            scales: {
                yAxes: [{
                    ticks: {

                        display: false,
                        suggestedMin: 50,
                        suggestedMax: 20,
                        padding: 0,

                        fontColor: "#000",
                        fontSize: 12
                    },

                    gridLines: {

                        lineWidth: 0.8,
                        zeroLineWidth: 1,
                        display: false,
                        color: "#000",

                    }
                }],
                xAxes: [{
                    categoryPercentage: 1.1,
                    ticks: {

                        fontColor: "#000",
                        fontSize: 12
                    },
                    barPercentage: 0.6,
                    gridLines: {

                        zeroLineWidth: 1,
                        lineWidth: 0.8,
                        display: false,
                        color: "#000",
                    }
                }]
            },
            legend: { display: false },
            hover: {
                onHover: function (e) {
                    var point = this.getElementAtEvent(e);
                    if (point.length) e.target.style.cursor = 'pointer';
                    else e.target.style.cursor = 'default';
                }
            },
            title: { display: true },
            responsive: true
        }
    });

    if (indexSeleccion > -1) {
        var item = data.MisGanancias[indexSeleccion];

        $("#ganancia-campania-nombre").text("Ganancia " + item.LabelSerie);
        $("#ganancia-campania").text(variablesPortal.SimboloMoneda + " " + item.GananciaCampaniaFormat);
        $("#ganancia-periodo").text(variablesPortal.SimboloMoneda + " " + item.GananciaPeriodoFormat);
    }

    $("#titulo-ganancia").text(data.Titulo);
    $("#titulo-subtitulo").text(data.SubTitulo);

    var onClickEvent = function (evt) {
        var activePoints = myBar.getElementsAtEvent(evt);
        if (activePoints.length > 0) {
            var clickedElementindex = activePoints[0]["_index"];
            var item = data.MisGanancias[clickedElementindex];
            $("#ganancia-campania-nombre").text("Ganancia " + item.LabelSerie);
            $("#ganancia-campania").text(variablesPortal.SimboloMoneda + " " + item.GananciaCampaniaFormat);
            $("#ganancia-periodo").text(variablesPortal.SimboloMoneda + " " + item.GananciaPeriodoFormat);
        }
    };
    $("#canvas").click(onClickEvent);
}

function ArmarCarrusel(data) {

    if (data.Items.length == 0) return;

    var htmlDiv = SetHandlebars("#template-carrusel", data);
    $('#carrusel').append(htmlDiv);
    $('#carrusel').show();

    $(".regular").slick({
        infinite: true,
        slidesToShow: 4,
        centerMode: false,
        centerPadding: "0px",
        slidesToScroll: 1,
        initialSlide: 0,
        dots: false,
        prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',
        nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',

        responsive: [
            {
                breakpoint: 426,
                settings: { slidesToShow: 2, slidesToScroll: 2, centerPadding: "25px", infinite: true }
            }
        ]
    });

}

$(window).load(function () {
    $("#overlayer").delay(200).fadeOut("slow");
})

$(".tog-vermas").click(function () {
    $(".boxtom").slideToggle();
    $(this).toggleClass("tog-vermenos");
    if ($(".tog-vermas").hasClass("tog-vermenos")) {
        $(this).text("Ver menos");
    }
    else {
        $(this).text("Ver más");
    }
});

function MostrarBeneficios(tab_id, codigoNivel, urlImagenActiva) {

    $("#OfertasEspeciales").hide();
    $("#BeneficiosPrincipal").hide();
    $("#boxganancias").hide();
    $("#progress-b").hide();
    $("#carrusel").hide();
    $(".bglogros").hide();
    $("#cont-logros").hide();
    $('.tab-content').removeClass('current');
    $("#" + tab_id).addClass('current');

    TagMostrarPopupNivel(tab_id, codigoNivel, urlImagenActiva);
}
