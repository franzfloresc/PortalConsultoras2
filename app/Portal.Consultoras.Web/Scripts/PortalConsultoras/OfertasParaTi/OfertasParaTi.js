
// 1: escritorio Home   11 : escritorio Pedido 
// 2: mobile  Home      21 : mobile pedido         261: mobile OfertasParaTi index      262: mobile OfertasParaTi detalle
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";


// Cuarto Dígito
// 0. Sin popUp         1. Con popUp
var conPopup = conPopup || "";

$(document).ready(function () {
    $(document).on('click', '[data-tono-change]', function (e) {
        var accion = $(this).attr("data-tono-change");
        if (accion == 1) {
            $(this).parents("[data-tono]").find('.content_tonos_select').attr("data-visible", "1");
            $(this).parents("[data-tono]").find('.content_tonos_select').show();
            $(this).parent().addClass("tono_por_elegir");
            return true;
        }
        
        var hideSelect = $(this).parents("[data-tono]").find('.content_tonos_select').attr("data-visible");
        if (hideSelect == "1") {
            $(this).parents("[data-tono]").find('.content_tonos_select').hide();
            $(this).parents("[data-tono]").find('.content_tonos_select').attr("data-visible", "0");
            $(this).parents("[data-tono]").find("[data-tono-change='1']").parent().removeClass("tono_por_elegir");
        }

        var cuv = $.trim($(this).attr("data-tono-cuv"));
        var prod = $(this).parents("[data-tono]");
        var objSet = prod.find("[data-tono-change='1']");
        objSet.find("img").attr("src", $(this).find("img").attr("src"));
        objSet.find(".tono_seleccionado").show();
        objSet.find(".texto_tono_seleccionado").html($(this).attr("data-tono-nombre"));

        objSet.parent().addClass("tono_escogido");
        prod.find("[data-tono-select-nombrecomercial]").html($(this).attr("data-tono-descripcion"));
        prod.attr("data-tono-select", cuv);

        prod.find("[data-tono-div]").find("[data-tono-cuv]").removeClass("borde_seleccion_tono");
        var estrategia = prod.parents("[data-estrategia='2001']").length;
        if (estrategia > 0) {
            prod.find("[data-tono-div]").find("[data-tono-cuv='" + cuv + "']").addClass("borde_seleccion_tono");
        }

        var objCompartir = prod.find("[data-item]").find("[data-compartir-campos]");
        objCompartir.find(".CUV").val(cuv);
        objCompartir.find(".Nombre").val($(this).attr("data-tono-descripcion"));
        
        var listaDigitables = prod.parents("[data-item]").find("[data-tono-digitable='1']");
        var btnActivar = true;
        $.each(listaDigitables, function (i, item) {
            var cuv = $.trim($(item).attr("data-tono-select"));
            btnActivar = btnActivar ? !(cuv == "") : btnActivar;
        });

        if (btnActivar) {
            prod.parents("[data-item]").find("#tbnAgregarProducto").removeClass("btn_desactivado_general");
        }
        
    });
});


