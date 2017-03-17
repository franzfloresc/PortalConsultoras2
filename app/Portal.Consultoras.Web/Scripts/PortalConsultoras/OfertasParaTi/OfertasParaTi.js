
// 1: escritorio Home   11 : escritorio Pedido 
// 2: mobile  Home      21 : mobile pedido         261: mobile OfertasParaTi index      262: mobile OfertasParaTi detalle
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";


// Cuarto Dígito
// 0. Sin popUp         1. Con popUp
var conPopup = conPopup || "";

$(document).ready(function () {

    $(".texto_sin_tono").on("click", function () {
        $('.content_tonos_select').show(); //muestro mediante id  
        $(".texto_sin_tono").parent().addClass("tono_por_elegir");
    });
    $(".content_tono_elegido").on("click", function () {
        $('.content_tonos_select').hide();
        $(".texto_sin_tono").parent().removeClass("tono_por_elegir");

    });

});
