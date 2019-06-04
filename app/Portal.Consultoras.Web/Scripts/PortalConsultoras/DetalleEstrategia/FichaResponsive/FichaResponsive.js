/// <reference path="estrategia/estrategiapresenter.js" />
/// <reference path="componentes/componentespresenter.js" />
/// <reference path="../../../general.js" />
/// <reference path="../detalleestrategiaprovider.js" />

var detalleEstrategia = DetalleEstrategiaProvider;
var fichaResponsiveEvents = FichaResponsiveEvents();
var estrategiaView = EstrategiaView();
var estrategiaPresenter = EstrategiaPresenter({
    estrategiaView: estrategiaView,
    generalModule: GeneralModule,
    fichaResponsiveEvents: fichaResponsiveEvents
});

var componenteView = ComponenteView();
var componentePresenter = ComponentePresenter({
    componenteView: componenteView
});

$(document).ready(function () {
    function modal_lateral(id, disparador) {

        if ($("body").find(".modal-fondo").length == 0) {
            $("body").append('<div class="modal-fondo" style="opacity: 0.8; display:none"></div>');
        };

        $(disparador).on("click", function () {
            $("body").css('overflow', 'hidden');
            $('.modal-fondo').css('opacity', '.8');
            $('.modal-fondo').show();
            $(id).addClass("popup_active");
        });

        var selector_cerrar = id + " .button_cerrar"
        function cerra_modal() {
            $(id).removeClass('popup_active')
            $('.modal-fondo').css('opacity', '0');
            $('.modal-fondo').hide();
            $("body").css('overflow', 'auto');
        }

        $(selector_cerrar).on("click", function () {
            cerra_modal();
        });

        $(document).on('keyup', function (evt) {
            if (evt.keyCode == 27) {
                cerra_modal();
            }
        });
    };

    function tabs_resposive(id, mostar) {
        var selector = id + " ul li a";
        var selector_first = selector + ":nth-child(" + mostar + ")";
        //console.log(selector_first);
        var mostra_div = id + " .seciones_tabs article";
        var mostra_div_first = id + " .seciones_tabs #tab" + mostar;

        $(selector_first).addClass("active");
        $(mostra_div).hide();
        $(mostra_div_first).show();

        $(selector).click(function () {
            $(selector).removeClass('active');
            $(this).addClass('active');
            $(mostra_div).hide();

            var activeTab = $(this).attr('href');
            var activeTabDinamico = id + " .seciones_tabs " + activeTab;
            //console.log(activeTabDinamico);
            $(activeTabDinamico).fadeIn();
            return false;
        });
    };

    function acordeon_responsive(id, mostrar) {
        var selector = id + " li a";
        var elemento = id + " li > div";
        $(elemento).hide();
        $(".tab" + mostrar).show();
        $(selector).click(function () {
            if ($(this).hasClass('activo')) {
                $(this).removeClass('activo');
                $(this).next().slideUp();
            } else {
                $(selector).removeClass('activo');
                $(this).addClass('activo');
                $(elemento).slideUp();
                $(this).next().slideDown();
            }
        });
    };


    var tab = [];
    for (var i = 1; i < 5; i++) {
        var obtener = "#tab" + i;
        tab[i] = $(obtener).html();
        $(".tab" + i).append(tab[i])
    }

    tabs_resposive("#tabs_ficha", 4);
    acordeon_responsive("#tabs_ficha", 4);

    tabs_resposive("#tabs_ficha_popup", 4);
    acordeon_responsive("#tabs_ficha_popup", 4);

    modal_lateral("#popup_tonos", ".tono_select_opt");

    modal_lateral("#popup_ficha_enriquecida", ".button_ver_detalle");
    
    $("#data-estrategia").data("estrategia", detalleEstrategia.getEstrategia(params));
    var estrategia = $("#data-estrategia").data("estrategia");
    estrategiaPresenter.onEstrategiaModelLoaded(estrategia);
    componentePresenter.onEstrategiaModelLoaded(estrategia);
});