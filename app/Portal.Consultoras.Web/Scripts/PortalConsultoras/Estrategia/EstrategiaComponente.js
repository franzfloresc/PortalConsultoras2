var estrategiaComponenteModule = (function (config) {
    
    var elementos = {
        nombre: ""
    }

    var _mostrarMasTonos = function(menos) {
        if (!isMobile()) {
            return false;
        }

        if (menos) {
            var tonos = $("#popupDetalleCarousel_lanzamiento [data-tono-div] [data-tono-change]");
            var h = $(tonos[0]).height();
            var w = $(tonos[0]).width();
            var total = tonos.length;
            var t = $("#popupDetalleCarousel_lanzamiento [data-tono-div]").width();
            if (w * total > t) {
                $(".indicador_tono").show();
            }
            else {
                $(".indicador_tono").hide();
            }
            $("#popupDetalleCarousel_lanzamiento [data-tono-div]").css("height", Math.max(h, w) + 5);
        } else {
            $("#popupDetalleCarousel_lanzamiento [data-tono-div]").css("height", "auto");
        }
        return false;
    }
    

    var _ValidarSeleccionTono=  function (objInput) {
        var attrClass = $.trim($(objInput).attr("class"));
        if ((" " + attrClass + " ").indexOf(" btn_desactivado_general ") >= 0) {
            if (isMobile()) {
                if (origenPedidoWebEstrategia == 2731) {
                    window.scrollTo(0, 540);
                }
            }

            $(objInput).parents("[data-item]").find("[data-tono-select='']").find("[data-tono-change='1']").parent().addClass("tono_no_seleccionado");
            setTimeout(
                function () {
                    $(objInput).parents("[data-item]").find("[data-tono-change='1']").parent().removeClass("tono_no_seleccionado");
                }, 500);
            return true;
        }
        return false;
    }
    
    var _eventos = 
    {
        clickChangeTono: function () {
            var accion = $(this).attr("data-tono-change");

            var hideSelect = $(this).parents("[data-tono]").find(".content_tonos_select").attr("data-visible");
            if (hideSelect == "1") {
                $(this).parents("[data-tono]").find(".content_tonos_select").hide();
                $(this).parents("[data-tono]").find(".content_tonos_select").attr("data-visible", "0");
                $(this).parents("[data-tono]").find("[data-tono-change='1']").parent().removeClass("tono_por_elegir");
                if (accion == 1)
                    return true;
            }

            if (accion == 1) {
                $("[data-tono]").find(".content_tonos_select").hide();
                $("[data-tono]").find(".content_tonos_select").attr("data-visible", "0");
                $("[data-tono]").find("[data-tono-change='1']").parent().removeClass("tono_por_elegir");

                $(this).parents("[data-tono]").find(".content_tonos_select").attr("data-visible", "1");
                $(this).parents("[data-tono]").find(".content_tonos_select").show();
                $(this).parent().addClass("tono_por_elegir");
                return true;
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
                prod.parents("[data-item]").find('#btnAgregalo').removeClass('btn_desactivado_general');
            }
        },
        mouseMoveTono: function() {
            var activo = $(this).parents("[data-tono]").find(".content_tonos_select").attr("data-visible");
            if (activo == 1) {
                $(this).parents("[data-tono]").find(".content_tonos_select").show();
            }
        },
        mouseLeaveSelectArea: function() {
            $(this).hide();
            $(this).attr("data-visible", "0");
        }
    }

    var _bindingEvents = function () {
        $("body").on("click", "[data-tono-change]", _eventos.clickChangeTono);
        
        if (!isMobile()) {
            $(document).on("mousemove", "[data-tono-change]", _eventos.mouseMoveTono);
            $(document).on("mouseleave", "[data-tono-select-area]", _eventos.mouseLeaveSelectArea);
        }
    }
    
    function Inicializar() {
        _bindingEvents();
        
    }
    
    return {
        Inicializar: Inicializar,
        MostrarMasTonos: _mostrarMasTonos,
        ValidarSeleccionTono: _ValidarSeleccionTono()
    };
    
})();

$(document).ready(function () {
    estrategiaComponenteModule.Inicializar();
});
