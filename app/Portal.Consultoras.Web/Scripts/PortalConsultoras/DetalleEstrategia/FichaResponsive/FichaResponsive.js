/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselPresenter.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselModel.js" />
/// <reference path="~/Scripts/PortalConsultoras/DetalleEstrategia/FichaResponsive/Carrusel/CarruselView.js" />

var detalleEstrategia = DetalleEstrategiaProvider;
var fichaResponsiveEvents = FichaResponsiveEvents();

var estrategiaView = EstrategiaView();
var estrategiaPresenter = EstrategiaPresenter({
    estrategiaView: estrategiaView,
    generalModule: GeneralModule,
    fichaResponsiveEvents: fichaResponsiveEvents
});

var componentesView = ComponentesView();
var componentesPresenter = ComponentesPresenter({
    componentesView: componentesView
});
componentesView.setPresenter(componentesPresenter);

$(document).ready(function () {
    $("#data-estrategia").data("estrategia", detalleEstrategia.getEstrategia(params));
    var estrategia = $("#data-estrategia").data("estrategia");
    estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
    componentesPresenter.onEstrategiaModelLoaded(estrategia);

    let carruselModel = new CarruselModel(
        params.palanca,
        params.campania,
        params.cuv,
       "/Estrategia/FichaObtenerProductosUpSellingCarrusel",
        params.origen,
        "Ficha",
        estrategia.DescripcionCompleta,
        estrategia.Hermanos.length,
        estrategia.CodigoProducto,
        estrategia.Precio2,
        estrategia.Hermanos,
        0);
    let carruselPresenter = new CarruselPresenter();

    let carruselView = new CarruselView(carruselPresenter);

    carruselPresenter.initialize(carruselModel, carruselView);

    //function tabs_resposive(id, mostar) {
    //    var selector = id + " ul li a";
    //    var selector_first = selector + ":nth-child(" + mostar + ")";
    //    //console.log(selector_first);
    //    var mostra_div = id + " .seciones_tabs article";
    //    var mostra_div_first = id + " .seciones_tabs #tab" + mostar;

    //    $(selector_first).addClass("active");
    //    $(mostra_div).hide();
    //    $(mostra_div_first).show();

    //    $(selector).click(function () {
    //        $(selector).removeClass('active');
    //        $(this).addClass('active');
    //        $(mostra_div).hide();

    //        var activeTab = $(this).attr('href');
    //        var activeTabDinamico = id + " .seciones_tabs " + activeTab;
    //        //console.log(activeTabDinamico);
    //        $(activeTabDinamico).fadeIn();
    //        return false;
    //    });
    //};

    //function acordeon_responsive(id, mostrar) {
    //    var selector = id + " li a";
    //    var elemento = id + " li > div";
    //    $(elemento).hide();
    //    $(".tab" + mostrar).show();
    //    $(selector).click(function () {
    //        if ($(this).hasClass('activo')) {
    //            $(this).removeClass('activo');
    //            $(this).next().slideUp();
    //        } else {
    //            $(selector).removeClass('activo');
    //            $(this).addClass('activo');
    //            $(elemento).slideUp();
    //            $(this).next().slideDown();
    //        }
    //    });
    //};


    //var tab = [];
    //for (var i = 1; i < 5; i++) {
    //    var obtener = "#tab" + i;
    //    tab[i] = $(obtener).html();
    //    $(".tab" + i).append(tab[i])
    //}

    //tabs_resposive("#tabs_ficha", 4);
    //acordeon_responsive("#tabs_ficha", 4);

    //tabs_resposive("#tabs_ficha_popup", 4);
    //acordeon_responsive("#tabs_ficha_popup", 4);

    //modal_lateral("#popup_tonos", ".tono_select_opt");

    //modal_lateral("#popup_ficha_enriquecida", ".button_ver_detalle");
});