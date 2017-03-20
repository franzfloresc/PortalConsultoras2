
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
    $(".content_tonos_select .content_tono_elegido").on("click", function () {
        $('.content_tonos_select').hide();
        $(".texto_sin_tono").parent().removeClass("tono_por_elegir");

    });

    $(document).on('click', '[data-tono-change]', function (e) {
        var accion = $(this).attr("data-tono-change");
        if (accion == 1) {
            $('.content_tonos_select').show();
            $(this).parent().addClass("tono_por_elegir");
            return true;
        }

        var cuv = $(this).attr("data-tono-cuv");
        var objSet = $("[data-tono-change='1']");
        objSet.find("img").attr("src", $(this).find("img").attr("src"));
        objSet.find(".tono_seleccionado").show();
        objSet.find(".texto_tono_seleccionado").html($(this).attr("data-tono-nombre"));

        objSet.parent().addClass("tono_escogido");
        objSet.parents("[data-set-componente]").find("[data-tono-nombrecomercial]").html($(this).attr("data-tono-descripcion"));

        var objCompartir = objSet.parents("[data-item]").find("[data-compartir-campos]");
        objCompartir.find(".CUV").val(cuv);
        objCompartir.find(".Nombre").val($(this).attr("data-tono-descripcion"));

        //objSet.parent().attr("class", "");
        //objSet.attr("class", "tono_escogido");

        //$("select[data-tono-change]").val(cuv);
        //$(this).parents("[data-tono]").attr("data-tono-select", cuv);
        //$(this).parents("[data-tono]").find("[data-tono-div] [data-tono-change]")
        //    .removeClass("borde_seleccion_tono")
        //    .parent().find("[data-tono-cuv='" + cuv + "']")
        //    .addClass("borde_seleccion_tono");

        //$(this).parents("[data-tono]").find(".content_tono_principal img").attr("src", $(this).find("img").attr("src"));
        //var estrategia = $(this).parents("[data-estrategia]").attr("data-estrategia");
        //if (estrategia == "2003" || estrategia == "2001") {
        //    var nombre = $(this).parents("[data-tono]").find("select").find("[value='" + cuv + "']").attr("data-tono-nombre");
        //    var descripcionComercial = $(this).parents("[data-tono]").find("select").find("[value='" + cuv + "']").attr("data-tono-descripcionComercial");
        //    nombre = nombre || $(this).find("img").attr("data-tono-nombre");
        //    descripcionComercial = descripcionComercial || $(this).find("img").attr("data-tono-descripcionComercial");
        //    $(this).parents("[data-tono]").find("[data-tono-visible]").find("[data-tono-nombre]").html(descripcionComercial);
        //    $(this).parents("[data-tono]").find("[data-tono-select-html]").html(nombre);
        //}

    });
});
