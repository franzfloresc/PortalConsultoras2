﻿var tipoOrigen = tipoOrigen || "";// 1: escritorio      2: mobile
var agregoOfertaFinal = 0;
var idProdOf = 0;

var esParaOFGanaMas = false;
var cuvOfertaProl = cuvOfertaProl || "";
var oRegaloPN = null;

var esUpselling = false;
var objUpselling = null;
var upSellingGano = null;
var montoPedidoInicial = 0;

var totalProductosOF = 0;

$(document).ready(function () {

    $("body").on("click", ".agregarOfertaFinal", function () {
        if (tipoOrigen == "1") {
            AbrirSplash();
        }
        else {
            ShowLoading();
        }

        var divPadre = $(this).parents("[data-item='ofertaFinal']").eq(0);
        var cuv = $(divPadre).find(".hdOfertaFinalCuv").val();
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var tipoOfertaSisID = $(divPadre).find(".hdOfertaFinalTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdOfertaFinalConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdOfertaFinalIndicadorMontoMinimo").val();
        var tipo = $(divPadre).find(".hdOfertaFinalTipo").val();
        var marcaID = $(divPadre).find(".hdOfertaFinalMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdOfertaFinalPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdOfertaFinalDescripcionProd").val();
        var pagina = $(divPadre).find(".hdOfertaFinalPagina").val();
        var descripcionCategoria = $(divPadre).find(".hdOfertaFinalDescripcionCategoria").val();
        var descripcionMarca = $(divPadre).find(".hdOfertaFinalDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdOfertaFinalDescripcionEstrategia").val();
        var tipoEstrategiaId = $(divPadre).find(".hdOfertaFinalTipoEstrategiaID").val();
        var OrigenPedidoWeb = tipoOrigen == "1" ? DesktopPedidoOfertaFinal : MobilePedidoOfertaFinal;
        tipoOfertaFinal_Log = $(divPadre).find(".hdTipoMeta").val();

        if (!isInt(cantidad)) {
            alert_msg("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $(this).parent().find('[data-input="cantidad"]').val(1);
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            $(this).parent().find('[data-input="cantidad"]').val(1);
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        var model = {
            CUV: cuv,
            Cantidad: cantidad,
            PrecioUnidad: precioUnidad,
            TipoEstrategiaID: tipoEstrategiaId,
            OrigenPedidoWeb: OrigenPedidoWeb,
            MarcaID: marcaID,
            DescripcionProd: descripcionProd,
            TipoOfertaSisID: tipoOfertaSisID,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            ConfiguracionOfertaID: configuracionOfertaID
        };
        var add;
        if (tipoOrigen == "1") {
            var add = AgregarProducto('PedidoInsertar', model, "", false, false);
        }
        else {
            var add = InsertarProducto(model, false);
        }

        if (add == null || !add.success) {
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_Log, gap_Log, 1, 'Producto Agregado');

        ActulizarValoresPopupOfertaFinal(add, true);

        $("#divCarruselOfertaFinal").find(".hdOfertaFinalCuv[value='" + cuv + "']").parents('[data-item="ofertaFinal"]').find('.agregado').show();
        if (tipoOrigen == "1") {
            CerrarSplash();
        }
        else {
            CloseLoading();
        }
    });

    $("body").on("click", '.btnNoGraciasOfertaFinal', function () {
        PopupOfertaFinalCerrar();
    });

    $("body").on("click", ".agregarOfertaFinalVerDetalle", function () {
        if (tipoOrigen == "1") {
            AbrirSplash();
        }
        else {
            ShowLoading();
        }

        var prodId = $(this).attr("data-popup-verdetalle");

        var divPadre = $("#divCarruselOfertaFinal").find("[data-id=" + prodId + "]").eq(0);
        var cuv = $(divPadre).find(".hdOfertaFinalCuv").val();
        var cantidad = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-input='cantidad']").val();
        var tipoOfertaSisID = $(divPadre).find(".hdOfertaFinalTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdOfertaFinalConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdOfertaFinalIndicadorMontoMinimo").val();
        var tipo = $(divPadre).find(".hdOfertaFinalTipo").val();
        var marcaID = $(divPadre).find(".hdOfertaFinalMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdOfertaFinalPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdOfertaFinalDescripcionProd").val();
        var pagina = $(divPadre).find(".hdOfertaFinalPagina").val();
        var descripcionCategoria = $(divPadre).find(".hdOfertaFinalDescripcionCategoria").val();
        var descripcionMarca = $(divPadre).find(".hdOfertaFinalDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdOfertaFinalDescripcionEstrategia").val();
        var tipoEstrategiaId = $(divPadre).find(".hdOfertaFinalTipoEstrategiaID").val();
        var OrigenPedidoWeb = tipoOrigen == "1" ? DesktopPedidoOfertaFinal : MobilePedidoOfertaFinal;

        if (!isInt(cantidad)) {
            alert_msg("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        if (cantidad <= 0) {
            alert_msg("La cantidad ingresada debe ser mayor que cero, verifique");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        var model = {
            CUV: cuv,
            Cantidad: cantidad,
            PrecioUnidad: precioUnidad,
            TipoEstrategiaID: tipoEstrategiaId,
            OrigenPedidoWeb: OrigenPedidoWeb,
            MarcaID: marcaID,
            DescripcionProd: descripcionProd,
            TipoOfertaSisID: tipoOfertaSisID,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            ConfiguracionOfertaID: configuracionOfertaID
        };

        var add;
        if (tipoOrigen == "1") {
            var add = AgregarProducto('PedidoInsertar', model, "", false, false);
        }
        else {
            var add = InsertarProducto(model, false);
        }

        if (add == null || !add.success) {
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_Log, gap_Log, 1, 'Producto Agregado');

        ActulizarValoresPopupOfertaFinal(add, true);
        $("#divCarruselOfertaFinal").find(".hdOfertaFinalCuv[value='" + cuv + "']").parents('[data-item="ofertaFinal"]').find('.agregado').show();
        $("#contenedor_popup_ofertaFinalVerDetalle").hide();
        if (tipoOrigen == "1") {
            CerrarSplash();
        }
        else {
            CloseLoading();
        }
    });

    if (typeof ofertaFinalEstado !== 'undefined' && typeof ofertaFinalAlgoritmo !== 'undefined') {
        if (ofertaFinalEstado == 'True' && ofertaFinalAlgoritmo == 'OFR') {
            esUpselling = true;
        }
    }

    if (cuvOfertaProl != "") {
        EjecutarPROL(cuvOfertaProl);
    }

});

function PopupOfertaFinalCerrar() {
    if (agregoOfertaFinal == 1) {
        setTimeout(function () {
            $("#divOfertaFinal").hide();
            EjecutarServicioPROLSinOfertaFinal();
        }, 1000);
    }
    $("#divOfertaFinal").hide();
    $('body').css({ 'overflow-y': 'scroll' });
    $("#btnGuardarPedido").show();
}

function MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar) {
    var aux = "of";
    if (tipoOrigen == "2") {
        aux = "h";
    }

    cumpleOferta.productosMostrar = cumpleOferta.productosMostrar || new Array();
    if (cumpleOferta.productosMostrar.length == 0) {
        return false;
    }

    $('.js-slick-prev-' + aux).remove();
    $('.js-slick-next-' + aux).remove();
    $('#divCarruselOfertaFinal.slick-initialized').slick('unslick');

    $('#divOfertaFinal').html('<div style="text-align: center;">Actualizando Productos de Oferta Final<br><img src="' + urlLoad + '" /></div>');

    if (cumpleOferta.upselling != null) {
        objUpselling = cumpleOferta.upselling;
        //objUpselling.Meta = GetRegaloMontoMeta();
        upSellingGano = GetUpSellingGanado();
        if (upSellingGano != null)
            objUpselling.Meta.MontoMeta = upSellingGano.MontoPedido;
    }

    totalProductosOF = cumpleOferta.productosMostrar.length;

    var objOf = cumpleOferta.productosMostrar[0];
    objOf.MetaPorcentaje = $.trim(objOf.TipoMeta);
    objOf.Detalle = cumpleOferta.productosMostrar;
    objOf.TotalPedido = $("#hdfTotal").val();
    objOf.Simbolo = objOf.Simbolo || $("#hdSimbolo").val();
    objOf.Upselling = objUpselling;
    montoPedidoInicial = objOf.TotalPedido;

    var foto1, foto2;
    if (tipoOrigen == "2") {
        if (objUpselling != null) {
            foto1 = (objUpselling.Regalos.length > 0) ? objUpselling.Regalos[0].Imagen : "";
            foto2 = (objUpselling.Regalos.length > 1) ? objUpselling.Regalos[1].Imagen : "";
            objOf.RegaloFoto1 = foto1;
            objOf.RegaloFoto2 = foto2;
        }
    }

    objOf.Cross = objOf.TipoMeta == "GM" ? objOf.Detalle.Find("TipoCross", true).length > 0 ? "1" : "0" : "0";
    objOf.ofIconoSuperior = objOf.TipoMeta == "MM" ? tipoOrigen == 1 ? "icono_exclamacion" : "exclamacion_icono_mobile" : tipoOrigen == 1 ? "icono_check_alerta" : "check_icono_mobile";

    SetHandlebars("#ofertaFinal-template", objOf, "#divOfertaFinal");
    $("#btnGuardarPedido").hide();

    $("#linkRegaloSorpresa").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        
        if (upSellingGano != null) {
            $('#divGanoRegalo').toggle(effect, options, duration, function () {
                $('#ContentSorpresaMobile').hide();
            });
        }
        else {
            $('#ContentSorpresaMobile').toggle(effect, options, duration, function () {
                $('#divGanoRegalo').hide();
            });

            $('#divCarruselRegaloMobile.slick-initialized').slick('unslick');

            $('#divCarruselRegaloMobile').slick({
                infinite: true,
                vertical: false,
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: false,
                centerMode: false,
                centerPadding: '0',
                tipo: 'p',
                prevArrow: '<a class="draw_arrow_left" style="top: 40%; width: auto; height: auto;"><hr class="draw_line color_white line_1_left"><hr class="draw_line color_white line_2_left"></a>',
                nextArrow: '<a class="draw_arrow_right" style="top: 40%; width: auto; height: auto;"><hr class="draw_line color_white line_1_right"><hr class="draw_line color_white line_2_right"></a>'
            }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                $('#of-regalo-actual').text(nextSlide + 1);
            });

            $('#divCarruselRegaloMobile').prepend($(".js-slick-prev-" + aux));
            $('#divCarruselRegaloMobile').prepend($(".js-slick-next-" + aux));

            $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
            $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
        }
    });

    $("[data-regresar-of]").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        
        if (upSellingGano != null) {
            if ($('#divGanoRegalo').is(':visible'))
            {
                $('#divGanoRegalo').toggle(effect, options, duration, function () {
                    
                });

                $('#ContentSorpresaMobile').hide();
                $('#divCarruselRegaloMobile.slick-initialized').slick('unslick');
            }
            else
            {
                $('#divCarruselRegaloMobile').prepend($(".js-slick-prev-" + aux));
                $('#divCarruselRegaloMobile').prepend($(".js-slick-next-" + aux));

                $('#ContentSorpresaMobile').toggle(effect, options, duration, function () {
                    $('#divCarruselRegaloMobile.slick-initialized').slick('unslick');
                    $('#divGanoRegalo').hide();
                });
            }
        }
        else {
            $('#ContentSorpresaMobile').toggle(effect, options, duration, function () {
                $('#divCarruselRegaloMobile.slick-initialized').slick('unslick');
                $('#divGanoRegalo').hide();
            });
        }

        $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
    });

    $("#btn_sigue_comprando_gana").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        
        $('#ContentSorpresaMobile').toggle(effect, options, duration, function() {
            $('#divCarruselRegaloMobile.slick-initialized').slick('unslick');
            $('#divGanoRegalo').hide();
        });

        $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
    });

    $("#btnCambiarRegalo").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;

        $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));

        $('#ContentSorpresaMobile').toggle(effect, options, duration, function () {
            
        });

        $('#divGanoRegalo').hide();

        $('#divCarruselRegaloMobile.slick-initialized').slick('unslick');

        $('#divCarruselRegaloMobile').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p',
            prevArrow: '<a class="draw_arrow_left" style="top: 40%; width: auto; height: auto;"><hr class="draw_line color_white line_1_left"><hr class="draw_line color_white line_2_left"></a>',
            nextArrow: '<a class="draw_arrow_right" style="top: 40%; width: auto; height: auto;"><hr class="draw_line color_white line_1_right"><hr class="draw_line color_white line_2_right"></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            $('#of-regalo-actual').text(nextSlide + 1);
        });

        $('#divCarruselRegaloMobile').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselRegaloMobile').prepend($(".js-slick-next-" + aux));

        $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
    });
    
    $("#btnCambiarRegalo1").click(function () {
        $('#container-of-regalo').show();
        $('#divGanoRegalo').hide();

        $('#divCarruselRegalo.slick-initialized').slick('unslick');

        $('#divCarruselRegalo').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p',
            prevArrow: '<a class="draw_arrow_left" style="top: 40%; width: auto; height: 70px;"><hr class="draw_line color_white line_1_left"><hr class="draw_line color_white line_2_left"></a>',
            nextArrow: '<a class="draw_arrow_right" style="top: 40%; width: auto; height: 70px;"><hr class="draw_line color_white line_1_right"><hr class="draw_line color_white line_2_right"></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {

        });

        $('#divCarruselRegalo').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselRegalo').prepend($(".js-slick-next-" + aux));

        $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
        $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
    });

    //if (objOf.TipoMeta != 'MM') {
        if (esUpselling) {
            if (objUpselling != null) {
                MostrarOfertaFinalRegalo(objOf.TotalPedido);
                //GanoOfertaFinalRegalo(objOf.TotalPedido);
            }
        }
    //}

    if (consultoraRegaloPN == 'True') {
        mostrarMensajeRegaloPN(objOf.TipoMeta, objOf.TotalPedido, objOf.MetaMontoStr, objOf.Simbolo, 1)
    }

    $("#divOfertaFinal").show();
    of_google_analytics_cargar_productos(tipoOrigen, objOf.TipoMeta);

    if (tipoOrigen == "2") {
        $('body').css({ 'overflow-y': 'hidden' });
        $('#divCarruselOfertaFinal').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p',
            prevArrow: '<a class="draw_arrow_left" style="top: 40%; width: auto; height: auto;"><hr class="draw_line line_1_left"><hr class="draw_line line_2_left"></a>',
            nextArrow: '<a class="draw_arrow_right" style="top: 40%; width: auto; height: auto;"><hr class="draw_line line_1_right"><hr class="draw_line line_2_right"></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            of_google_analytics_producto_impresion_arrows(event, slick, currentSlide, nextSlide, tipoOrigen, objOf.TipoMeta, objOf.Detalle);
        });
    }
    else {
        $('#divCarruselOfertaFinal').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p',
            prevArrow: '<a class="draw_arrow_left" style="top: 40%; width: auto; height: auto;"><hr class="draw_line line_1_left"><hr class="draw_line line_2_left"></a>',
            nextArrow: '<a class="draw_arrow_right" style="top: 40%; width: auto; height: auto;"><hr class="draw_line line_1_right"><hr class="draw_line line_2_right"></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            of_google_analytics_producto_impresion_arrows(event, slick, currentSlide, nextSlide, tipoOrigen, objOf.TipoMeta, objOf.Detalle);
        });
    }

    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));

    if (tipoOrigen == "2") {
        if (foto1 == "") $('#of-regalo-foto1').hide();
        if (foto2 == "") $('#of-regalo-foto2').hide();
    }

    of_google_analytics_producto_impresion(tipoOrigen, objOf.TipoMeta, objOf.Detalle);
    agregoOfertaFinal = tipoPopupMostrar == 1 ? 1 : agregoOfertaFinal;

    AgregarOfertaFinalLog("", 0, cumpleOferta.tipoOfertaFinal_Log, cumpleOferta.gap_Log, 2, 'Popup Mostrado');
    AgregarOfertaFinalLogBulk(cumpleOferta.tipoOfertaFinal_Log, cumpleOferta.gap_Log, cumpleOferta.productosMostrar);

    if (cuvOfertaProl != "") {
        objOf.Detalle = objOf.Detalle || new Array();
        if (objOf.Detalle.length > 0) {
            var cantActivo = 3;
            var objProdIni = new Object();
            $.each(objOf.Detalle, function (ind, itemDet) {
                if (cantActivo > ind || cantActivo == 0) {
                    if (itemDet.CUV == cuvOfertaProl) {
                        objProdIni = itemDet;
                    }
                }
            });

            if (objProdIni.CUV == cuvOfertaProl) {
                var input = $($("#divOfertaFinal").find(".hdOfertaFinalCuv[value=" + cuvOfertaProl + "]")[0]).parents("[data-item]").find("[data-verdetalle]")[0];
                CargarVerDetalleOF(input);
            }
        }
    }

    if (tipoOrigen === "1") {
        if ($("#id_btn_noGracias_agregarProductos").length > 0) {
            $("#id_btn_noGracias_agregarProductos").css({ 'margin': "auto", "line-height": "49px" });
            $("#id_btn_noGracias_agregarProductos").hide();
            $("#id_btn_noGracias_agregarProductos").show();
        }
    }

    return true;
}

function MostrarOfertaFinalRegalo(totalPedido) {
    var container = (tipoOrigen == '1') ? $('#container-of-regalo') : $('#ContentSorpresaMobile');
    if (container.length > 0) {
        if (tipoOrigen == '2') {
            $('#linkRegaloSorpresa').show();
            $('.popup_ofertaFinal').css({ "padding-top": "0px" });
        }

        validarGanoRegalo(totalPedido);

        if (tipoOrigen == '1') {
            $("#divOfertaFinal").show();

            if (upSellingGano != null) {
                $('#divGanoRegalo').show();
                $('#container-of-regalo').hide();
            }
            else {
                $(container).show();
                $('#divGanoRegalo').hide();

                /* Carrusel Regalos */
                $('#divCarruselRegalo.slick-initialized').slick('unslick');

                $('#divCarruselRegalo').slick({
                    infinite: true,
                    vertical: false,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    autoplay: false,
                    centerMode: false,
                    centerPadding: '0',
                    tipo: 'p',
                    prevArrow: '<a class="draw_arrow_left" style="top: 40%; width: auto; height: 70px;"><hr class="draw_line color_white line_1_left"><hr class="draw_line color_white line_2_left"></a>',
                    nextArrow: '<a class="draw_arrow_right" style="top: 40%; width: auto; height: 70px;"><hr class="draw_line color_white line_1_right"><hr class="draw_line color_white line_2_right"></a>'
                }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                    $('#of-regalo-actual').text(nextSlide + 1);
                });

                $('#divCarruselRegalo').prepend($(".js-slick-prev-of"));
                $('#divCarruselRegalo').prepend($(".js-slick-next-of"));

                /* Carrusel Regalos */
            }
            
            //$('div.popup_ofertaFinal').addClass('fondo_gris_OF');
            $('#count-ofertas').text(totalProductosOF);
            $('#div-count-ofertas').show();
        }

        $('#of-regalo-total').text(objUpselling.Regalos.length);

        //url terminos y condiciones
        if (objUpselling.Meta.TipoRango != null && objUpselling.Meta.TipoRango != "") {
            var href = $('#of-regalo-terminos').attr('href');
            var xhref = href.replace('RGX', objUpselling.Meta.TipoRango);
            $('#of-regalo-terminos').attr('href', xhref);
        }

    }
}

function GanoOfertaFinalRegalo(totalPedido) {
    var container = (tipoOrigen == '1') ? $('#container-of-regalo') : $('#ContentSorpresaMobile');
    if (container.length > 0) {

        validarGanoRegalo(totalPedido);

        if (tipoOrigen == '1') {
            (container).show();
        }
    }
}

function validarGanoRegalo(totalPedido) {
    var simbolo = $("#hdSimbolo").val();
    $('#content-regalo-agrega').hide();

    if (objUpselling != null) {
        $('#of-regalo-estuyo').text(objUpselling.TextoGanastePremio);
        $('#of-regalo-recuerda').text(objUpselling.TextoInferior);

        if (totalPedido >= objUpselling.Meta.MontoMeta) {
            $('.span_1_regalo_sorpresa').html('¡FELICITACIONES<br>');
            $('.span_2_regalo_sorpresa').html('GANASTE!<br>');
            //$('.span_link_regalo_sorpresa').text('ESCOGE TU PREMIO');
            $('.span_2_regalo_sorpresa').html(objUpselling.TextoGanastePrincipal + '<br>');
            $('[data-agregar-regalo]').val(objUpselling.TextoGanasteBoton);

            $('#of-regalo-msg1').show();
            $('#of-regalo-msg2').hide();
            //$('#of-regalo-msg3').html('<b>¡ESCOGE TU PREMIO!</b>');
            $('#of-regalo-msg3').html(objUpselling.TextoGanastePrincipal + '<br>');
            $('[data-agregar-regalo]').show();
            $('#btn_sigue_comprando_gana').hide();

            if (upSellingGano != null) {
                $('#of-regalo-descripcion').text(upSellingGano.Descripcion);
                $('#of-regalo-imagen').attr('src', upSellingGano.RegaloImagenUrl);
                $('#of-regalo-descripcion-larga').text(upSellingGano.RegaloDescripcion);
            }
        }
        else {
            var agrega = DecimalToStringFormat(objUpselling.Meta.MontoMeta - totalPedido);
            $('.span_1_regalo_sorpresa').html('¡AGREGA ' + simbolo + agrega + ' Y<br>');
            //$('.span_2_regalo_sorpresa').html('ESCOGE TU PREMIO!<br>');
            $('.span_2_regalo_sorpresa').html(objUpselling.TextoGanastePrincipal + '<br>');
            $('.span_link_regalo_sorpresa').text('VER PREMIOS');

            //$('#of-regalo-msg3').html('<b>¡MIRA LO QUE<br>TE PUEDES LLEVAR!</b>');
            $('#of-regalo-msg3').html('<b>' + objUpselling.TextoMetaPrincipal + '</b>');
            $('#of-regalo-msg1').hide();
            $('#of-regalo-msg2').hide();
            $('[data-agregar-regalo]').hide();
            $('#btn_sigue_comprando_gana').show();

            $('#of-regalo-agrega').text(simbolo + agrega);
            $('#of-regalo-montometa').text(simbolo + objUpselling.Meta.FormatoMontoMeta);
            $('#content-regalo-agrega').show();
        }
    }
}

function ActulizarValoresPopupOfertaFinal(data, popup) {
    var tipoMeta = $("#divOfertaFinal div[data-meta]").attr("data-meta") || data.TipoMeta;
    var simbolo = $("#hdSimbolo").val();

    var metaMonto = $("#msjOfertaFinal").attr("data-meta-monto");
    if (isNaN(metaMonto)) metaMonto = 0;
    var metaTotal = $("#divOfertaFinal div[data-meta-total]").attr("data-meta-total");

    //var valoresOFR = GetValoresOfertaFinalRegalo(data);
    //var minimo = 0;
    //if (valoresOFR != null) minimo = valoresOFR.minimo;

    if (consultoraRegaloPN == 'True') {
        var montoMeta = parseFloat(metaMonto) + parseFloat(metaTotal);
        mostrarMensajeRegaloPN(tipoMeta, data.total, montoMeta, simbolo, 2)
    }

    if (tipoMeta == "MM") {
        var montolimite = parseFloat(metaMonto) + parseFloat(metaTotal);
        //if (valoresOFR != null) montolimite = minimo;

        if (parseFloat(data.total) >= montolimite) {
            var msj = "Ahora tu ganancia estimada total es ";

            if (consultoraRegaloPN != 'True')
                $("#spnTituloOfertaFinal span").html("¡LLEGASTE AL <b>MONTO MÍNIMO!</b>");

            //if (valoresOFR != null) {
            //    if (valoresOFR.meta > 0 && valoresOFR.total > 0 && valoresOFR.total >= valoresOFR.meta) {
            //        if (consultoraRegaloPN != 'True')
            //            $("#spnTituloOfertaFinal span").html("FELICIDADES " + nombreConsultora + "</br><b>!GANASTE EL PREMIO!</b>");
            //    }
            //}

            if (tipoOrigen == "1") {
                $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
            }

            if (consultoraRegaloPN == 'True') {  // CASE 3,4,5
                var nivel = oRegaloPN.CodigoNivel;
                var sep1 = (tipoOrigen == 1) ? ' | ' : '<br />';
                var msg3 = 'Monto Total de Pedido: ' + simbolo + ' ' + data.formatoTotal + sep1 + 'Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr;

                if (nivel == '01' || nivel == '02' || nivel == '03') {
                    $('#msjOfertaFinal span').html(msg3);
                }
                else {
                    if (tipoOrigen == 1)
                        $("#msjOfertaFinal span").html(msg3);
                    else
                        $("#msjOfertaFinal span").html('Monto Total de Pedido: ' + simbolo + ' ' + data.formatoTotal);

                    $('#msjOfertaFinal').css('margin-bottom', '0');
                }
                $('#msjOfertaFinal').show();
            }
            else
                $("#msjOfertaFinal span").html("<b>" + msj + simbolo + " " + data.DataBarra.MontoGananciaStr + "</b><br />Monto total: " + simbolo + " " + data.formatoTotal);

            if (tipoOrigen == 1) {
                $("#ofIconoSuperior").removeClass("icono_exclamacion");
                $("#ofIconoSuperior").addClass("icono_check_alerta");
            }
            else {
                $("#ofIconoSuperior").removeClass("exclamacion_icono_mobile");
                $("#ofIconoSuperior").addClass("check_icono_mobile");
            }

            agregoOfertaFinal = 1;
            $("#btnNoGraciasOfertaFinal").show();

            if (esUpselling) {
                if (objUpselling != null) {
                    MostrarOfertaFinalRegalo(data.total);
                    //GanoOfertaFinalRegalo(data.total);
                }
            }
        }
        else {
            $("#msjOfertaFinal").parent().find("span[data-monto]").html(DecimalToStringFormat(montolimite - parseFloat(data.total)));
            $("#btnNoGraciasOfertaFinal").hide();
        }

        $("#msjOfertaFinal").attr("data-meta-monto", totalPedido - parseFloat(data.total));
        $("#divOfertaFinal > div").attr("data-meta-total", data.total);
    }
    else if (tipoMeta == "RG") {
        if (esUpselling) {
            //if (valoresOFR != null) {
            //    if (valoresOFR.total >= valoresOFR.meta && valoresOFR.meta > 0 && valoresOFR.total > 0)
            //        $("#spnTituloOfertaFinal span").html("FELICIDADES " + nombreConsultora + "</br><b>!GANASTE EL PREMIO!</b>");
            //}

            if (objUpselling != null) {
                GanoOfertaFinalRegalo(data.total);
            }
        }

        if (tipoOrigen == "1") {
            $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
        }
        agregoOfertaFinal = 1;
    }
    else if (tipoMeta == "GM") {
        if (consultoraRegaloPN == 'True') {
            var nivel = oRegaloPN.CodigoNivel;
            var sep2 = (tipoOrigen == 1) ? ' ' : '<br />';
            var disclaimer = '*En caso tu pedido no tenga observaciones y supere el monto mínimo.';

            if (nivel == '01' || nivel == '02' || nivel == '03') {
                // CASE 9
                var msg1 = '<b>AHORA TU MONTO TOTAL' + sep2 + 'DE PEDIDO ES ' + simbolo + ' ' + data.formatoTotal + '</b>';
                $('#spnTituloOfertaFinal span').html(msg1);

                $('#msjOfertaFinal span').html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);

                if (tipoOrigen == 2) $('#msjOfertaFinal').css('margin-top', '15px');
                if (tipoOrigen == 1) $('div.contenedor_bloques_agregaProductos').css('padding-top', '10px');
                $('#msjOfertaFinal').show();
                $('#div-regalo-pn').hide();
            }
            else {
                var stp = (oRegaloPN.TippingPoint > 0) ? (parseFloat(oRegaloPN.TippingPoint) - parseFloat(data.total)) : 0;

                if (data.total >= oRegaloPN.TippingPoint) {
                    // CASE 11
                    var msg1 = '<b>AHORA TU MONTO TOTAL' + sep2 + 'DE PEDIDO ES DE ' + simbolo + ' ' + data.formatoTotal + '</b>';
                    msg1 += '<br /><span style="font-weight: normal;font-size:14px;"><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg1 += ', AHORA PUEDES ACCEDER A PACKS EXCLUSIVOS NUEVAS**</span>';

                    $('#spnTituloOfertaFinal span').html(msg1);

                    if (tipoOrigen == 1) {
                        $('#spnTituloOfertaFinal').css('max-width', '700px');
                        $('#spnTituloOfertaFinal').css('margin', '0 auto');

                        $('#msjOfertaFinal span').html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);
                        $('#msjOfertaFinal').css('padding-top', '10px');
                        $('#msjOfertaFinal').show();
                    }
                    else {
                        $('#msjOfertaFinal').hide();
                    }

                    $('#div-regalo-pn').hide();
                }
                else {
                    // CASE 10
                    var msg1 = '<b>AHORA TU MONTO TOTAL' + sep2 + 'DE PEDIDO  ES ' + simbolo + ' ' + data.formatoTotal + '</b>';
                    $('#spnTituloOfertaFinal span').html(msg1);

                    if (tipoOrigen == 1) {
                        $('#msjOfertaFinal span').html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);
                        $('#msjOfertaFinal').css('margin-bottom', '0');
                        $('#msjOfertaFinal').show();
                    }

                    var msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';

                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);
                    $('#div-regalo-pn').show();
                }
                disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep1 + '**Encuéntralos en la seccion de Oferta para Ti.';
            }

            $('#txt-disclaimer-pn').html(disclaimer);
        }
        else
            $("#spnTituloOfertaFinal span").html("¡AHORA TU <b>GANANCIA ESTIMADA ES " + simbolo + " " + data.DataBarra.MontoGananciaStr + "!</b>");

        if (tipoOrigen == "1") {
            $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
        }
        agregoOfertaFinal = 1;
    }
    else {
        var faltante = $("#msjOfertaFinal").attr("data-meta-monto");
        var totalPedido = $("#divOfertaFinal div[data-meta-total]").attr("data-meta-total");
        var montolimite = parseFloat(faltante) + parseFloat(totalPedido);

        if (parseFloat(data.total) >= montolimite) {
            var msj = tipoOrigen == "2" ? "Ganancia estimada total: " : "Ahora tu ganancia estimada total es ";
            var porc = $("#msjOfertaFinal").attr("data-meta-porcentaje");
            if (consultoraRegaloPN !== 'True')
                $("#spnTituloOfertaFinal span").html("¡LLEGASTE AL <b>" + porc + "% DSCTO!</b>");
            if (tipoOrigen == "1") {
                $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
            }
            $("#msjOfertaFinal span").html("<b>" + msj + simbolo + " " + data.DataBarra.MontoGananciaStr + "</b><br />Monto total: " + simbolo + " " + data.formatoTotal);
        }
        else {
            $("#msjOfertaFinal span[data-monto]").html(DecimalToStringFormat(montolimite - parseFloat(data.total)));
        }

        $("#msjOfertaFinal").attr("data-meta-monto", montolimite - parseFloat(data.total));
        $("#divOfertaFinal > div").attr("data-meta-total", data.total);
        agregoOfertaFinal = 1;
    }

    return data;
}

function getAbrevNumPedido(nivel) {
    var abrev = '';
    switch (nivel) {
        case 1:
            abrev = 'ER.';
            break;
        case 2:
            abrev = 'DO.';
            break;
        case 3:
            abrev = 'ER.';
            break;
        case 4:
        case 5:
        case 6:
            abrev = 'TO.';
            break;
    }
    return abrev;
}

function mostrarMensajeRegaloPN(tipoMeta, montoTotal, montoSaldo, simbolo, flag) {
    if (oRegaloPN == null)
        oRegaloPN = GetRegaloProgramaNuevas();

    if (oRegaloPN != null) {
        var msg1 = '', msg2 = '';
        var nivel = oRegaloPN.CodigoNivel;
        var montoMeta = (flag == 1) ? (parseFloat(montoTotal) + parseFloat(montoSaldo)) : montoSaldo;
        var stp = (oRegaloPN.TippingPoint > 0) ? (parseFloat(oRegaloPN.TippingPoint) - parseFloat(montoTotal)) : 0;
        var sep = (tipoOrigen == 1) ? ' | ' : '<br />';
        var disclaimer = '*En caso tu pedido no tenga observaciones y supere el monto mínimo.';

        if (tipoOrigen == 1) $('#div-popup-ofertafinal').css('padding-top', '0');
        if (tipoOrigen == 2) $('#div-content-of-titulo').addClass('margenSuperiorProgramaNuevas');

        $('#msjOfertaFinal').hide();
        $('#div-regalo-pn').hide();
        $('#div-count-ofertas').hide();

        $('#numero-pd').text(parseInt(nivel));
        $('#posicion-pd').text(getAbrevNumPedido(parseInt(nivel)));
        $('#div-numero-pedido').show();

        if (tipoOrigen == 2) {
            $('#ofIconoSuperior').css('width', '35px');
            $('#ofIconoSuperior').css('height', '35px');
        }

        if (oRegaloPN.UrlImagenRegalo != null && oRegaloPN.UrlImagenRegalo != "") {
            $('#img-regalo-pn').attr('src', oRegaloPN.UrlImagenRegalo);
            ('div.content_imagen_alternativo').show();
        }

        if (tipoMeta == 'MM') {
            if (montoTotal >= montoMeta) {
                if (nivel == '01' || nivel == '02' || nivel == '03') {
                    // CASE 3
                    msg1 = '<b>¡LLEGASTE AL MONTO MÍNIMO</b>';
                    msg1 += '<br /><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*!</b>';

                    $('#spnTituloOfertaFinal span').html(msg1);
                    $('#div-regalo-pn').hide();
                    if (tipoOrigen == 1) $('div.contenedor_bloques_agregaProductos').css('padding-top', '10px');
                }
                else {
                    if (montoTotal >= oRegaloPN.TippingPoint) {
                        // CASE 5
                        msg1 = '<b>¡LLEGASTE AL MONTO MÍNIMO!</b>';
                        msg1 += '<br /><span style="font-weight: normal;font-size:14px;"><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                        msg1 += ', AHORA PUEDES ACCEDER A PACKS EXCLUSIVOS NUEVAS**</span>';

                        $('#spnTituloOfertaFinal span').html(msg1);
                    }
                    else {
                        // CASE 4
                        msg1 = '<b>¡LLEGASTE AL MONTO MÍNIMO!</b>';
                        msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                        msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';

                        $('#spnTituloOfertaFinal span').html(msg1);
                        $('#msg-regalo-pn').html(msg2);
                        $('#msg-regalo-pn2').html(msg2);
                        $('#div-regalo-pn').show();
                    }
                    disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep + '**Encuéntralos en la seccion de Oferta para Ti.';
                }
            }
            else {
                if (nivel == '01' || nivel == '02' || nivel == '03') {
                    // CASE 1
                    msg2 = 'ALCÁNZALO CON ESTAS OFERTAS Y <b>GANA UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    if (oRegaloPN.Valorizado > 0)
                        msg2 += ', PUEDES VENDERLO A ' + simbolo + ' ' + oRegaloPN.PrecioValorizadoFormat;

                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);
                }
                else {
                    // CASE 2
                    msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';

                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);
                    disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep + '**Encuéntralos en la seccion de Oferta para Ti.';
                }

                $('#div-regalo-pn').show();
            }
        }
        else if (tipoMeta == 'GM') {
            if (nivel == '01' || nivel == '02' || nivel == '03') {
                // CASE 6
                msg1 = '<b>¡GUARDASTE TU PEDIDO CON ÉXITO</b>';
                msg1 += '<br /><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*!</b>';
                msg2 = (tipoOrigen == 1) ? 'APROVECHA ESTAS OFERTAS Y <b>GANA MÁS</b> ESTA CAMPAÑA' : 'APROVECHA ESTAS <b>OFERTAS</b>';

                $('#spnTituloOfertaFinal span').html(msg1);
                $('#msg-regalo-pn').html(msg2);
                $('#msg-regalo-pn2').html(msg2);
                $('#div-regalo-pn').show();
                $('div.content_imagen_alternativo').hide();
                $('#msg-regalo-pn2').css('padding-top', '10px');
                if (tipoOrigen == 1) $('#msjOfertaFinal').css('margin-bottom', '10px');
            }
            else {
                if (montoTotal >= oRegaloPN.TippingPoint) {
                    // CASE 8
                    msg1 = '<b>¡GUARDASTE TU PEDIDO CON ÉXITO!</b>';
                    msg1 += '<br /><span style="font-weight: normal;font-size:14px;"><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg1 += ', AHORA PUEDES ACCEDER A PACKS EXCLUSIVOS NUEVAS**</span>';

                    $('#spnTituloOfertaFinal span').html(msg1);

                    if (tipoOrigen == 1)
                        $('#msjOfertaFinal span').html('Monto Total de Pedido: ' + simbolo + ' ' + dataBarra.TotalPedidoStr + ' | ' + 'Ganancia Estimada Total: ' + simbolo + ' ' + dataBarra.MontoGananciaStr);
                    else
                        $('#msjOfertaFinal span').html('Monto Total de Pedido: ' + simbolo + ' ' + montoTotal);

                    $('#msjOfertaFinal').show();
                }
                else {
                    // CASE 7
                    msg1 = '<b>¡GUARDASTE TU PEDIDO CON ÉXITO!</b>';
                    msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';
                    if (tipoOrigen == 1) msg2 += ' ¡APROVECHA ESTAS OFERTAS!';

                    $('#spnTituloOfertaFinal span').html(msg1);
                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);
                    $('#div-regalo-pn').show();
                }
                disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep + '**Encuéntralos en la seccion de Oferta para Ti.';
            }
        }

        $('#txt-disclaimer-pn').html(disclaimer);
        $('#txt-disclaimer-pn').show();
    }
}

function CargandoValoresPopupOfertaFinal(tipoPopupMostrar, mostrarGanaMas, montoFaltante, porcentajeDescuento) {

    var formatoMontoFaltante = DecimalToStringFormat(montoFaltante);
    var montoMinimo = DecimalToStringFormat(parseFloat($("#hdMontoMinimo").val()));

    $('#spCabeceraMontominimo').hide();

    if (tipoPopupMostrar == 1) {

        $("#divIconoOfertaFinal").removeClass("icono_exclamacion");
        $("#divIconoOfertaFinal").addClass("icono_aprobacion");
        $("#spnTituloOfertaFinal").html("RESERVASTE TU<b>&nbsp;PEDIDO CON ÉXITO!</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        if (mostrarGanaMas) {
            $('#of_descripcion1').hide();
            $('#of_descripcion2').show();
        } else {
            $("#spnMensajeOfertaFinal").html("&nbsp;para conseguir " + porcentajeDescuento + "% DSCTO y ganar más esta campaña.");
        }

        if (mostrarGanaMas) {
            if (viewBagPaisID == 3) {
                $("#spnSubTituloOfertaFinal").html("Gana más con estas ofertas que tenemos solo para ti.");
            } else if (viewBagPaisID == 11) {
                $("#spnSubTituloOfertaFinal").html("Gana más con estos productos que tenemos para ti.");
            }
        }
        else {
            if (viewBagPaisID == 3) {
                $("#spnSubTituloOfertaFinal").html("Alcanza el " + porcentajeDescuento + "% DSCTO con estas ofertas que tenemos solo para ti");
            } else if (viewBagPaisID == 11) {
                $("#spnSubTituloOfertaFinal").html("Alcanza el " + porcentajeDescuento + "% DSCTO con estos productos que tenemos para ti");
            }
        }
    }
    else {
        $("#divIconoOfertaFinal").removeClass("icono_aprobacion");
        $("#divIconoOfertaFinal").addClass("icono_exclamacion");
        $("#spnTituloOfertaFinal").html("<b>LO SENTIMOS...</b>&nbsp; NO PUDIMOS GUARDAR TU PEDIDO");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $('#spMontoMinimoCabecera').html(montoMinimo);
        $('#spCabeceraMontominimo').show();
        $("#spnMensajeOfertaFinal").html("&nbsp;para poder pasar tu pedido.");
        if (viewBagPaisID == "3") {
            $("#spnSubTituloOfertaFinal").html("Compra en oferta los complementos de tu pedido");
        } else if (viewBagPaisID == "11") {
            $("#spnSubTituloOfertaFinal").html("Compra en oferta los complementos de tu pedido");
        }
    }

    $("#divOfertaFinal").show();
}

function CumpleOfertaFinalMostrar(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    if (tipoOrigen == "1") AbrirSplash();
    else ShowLoading();

    var cumpleOferta = CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
    if (cumpleOferta.resultado) {
        cumpleOferta.resultado = MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar);
    }
    return cumpleOferta;
}

function CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var montoFaltante = 0;
    var porcentajeDescuento = 0;
    var tipoMeta = 0;
    //var regaloOF = null;
    var _upselling = null;

    var tipoOfertaFinal = $("#hdOfertaFinal").val();
    var esOfertaFinalZonaValida = $("#hdEsOfertaFinalZonaValida").val();
    var esFacturacion = $("#hdEsFacturacion").val();
    var resultado = tipoOfertaFinal == "1" || tipoOfertaFinal == "2";

    if (resultado) {
        resultado = esFacturacion == "True" && esOfertaFinalZonaValida == "True";
    }

    var productoOfertaFinal = new Object();
    if (resultado == true) {

        resultado = false;

        if (tipoPopupMostrar == 1) { // supero MM

            if (codigoMensajeProl == '00') {
                resultado = true;
            }
            else {
                var flagObs = true;
                for (i = 0; i < listaObservacionesProl.length; i++) {
                    if (listaObservacionesProl[i].Caso != 0) {
                        flagObs = false;
                        break;
                    }
                }
                resultado = flagObs;
            }
        }
        else { // MM
            if (codigoMensajeProl == "01") {
                if (listaObservacionesProl.length == 1) {
                    if (listaObservacionesProl[0].Caso == 95)
                        resultado = listaObservacionesProl[0].CUV == "XXXXX";
                }
            }
        }

        if (resultado == true) {
            productoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);

            if (productoOfertaFinal.lista.length != 0) {
                tipoMeta = productoOfertaFinal.lista[0].TipoMeta;
                if (esUpselling) {
                    _upselling = GetUpSelling();
                }
            }
        }
    }
    else {
        if (tipoOrigen == "1") CerrarSplash()
        else CloseLoading();
    }

    tipoOfertaFinal_Log = tipoMeta || 0;

    return {
        resultado: resultado,
        productosMostrar: productoOfertaFinal.lista || new Array(),
        montoFaltante: montoFaltante, //REVISAR
        porcentajeDescuento: porcentajeDescuento, //REVISAR
        muestraGanaMas: 0, //REVISAR
        tipoOfertaFinal_Log: tipoMeta, //REVISAR
        gap_Log: 0,//REVISAR,
        //regaloOF: regaloOF
        upselling: _upselling
    };
}

function ObtenerProductosOfertaFinal(tipoOfertaFinal) {
    var item = { tipoOfertaFinal: tipoOfertaFinal };
    var lista = null;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerProductosOfertaFinal',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (tipoOrigen == "1") CerrarSplash()
                else CloseLoading();

                if (response.success) {
                    lista = response.data;
                } else {
                    lista = null;
                }
            }
        },
        error: function (data, error) {
            if (tipoOrigen == "1") CerrarSplash()
            else CloseLoading();
            if (checkTimeout(data)) {
                lista = null;
            }
        }
    });

    return {
        lista: lista
    };
}

function GetUpSelling() {
    var obj = null;

    jQuery.ajax({
        type: 'GET',
        url: baseUrl + 'UpSelling/ObtenerUpSellingFull',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    //if (response.Data.length > 0) {
                        //obj = response.Data[0];
                    //}
                    obj = response.data;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.log(error);
            }
        }
    });

    return obj;
}
/*
function GetRegaloMontoMeta() {
    var obj = null;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerRegaloMontoMeta',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    obj = response.data;
                }
            }
        },
        error: function (data, error) { }
    });

    return obj;
}
*/

//function GetUpSellingRegalo() {
function GetUpSellingGanado() {
    var obj = null;

    jQuery.ajax({
        type: 'GET',
        //url: baseUrl + 'Pedido/ObtenerOfertaFinalRegalo',
        url: baseUrl + 'UpSelling/ObtenerRegaloGanado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    obj = response.data;
                }
            }
        },
        error: function (data, error) { }
    });

    return obj;
}

function InsertUpSellingRegalo(id, cuv) {
    var ok = false;
    var item = {
        Cuv: cuv,
        RangoId: objUpselling.Meta.RangoId,
        GapMinimo: objUpselling.Meta.GapMinimo,
        GapMaximo: objUpselling.Meta.GapMaximo,
        GapAgregar: objUpselling.Meta.GapAgregar,
        MontoMeta: objUpselling.Meta.MontoMeta,
        TipoRango: objUpselling.Meta.TipoRango,
        MontoPedido: montoPedidoInicial,
        UpSellingDetalleId: id
    };

    if (tipoOrigen == "1") AbrirSplash();
    else ShowLoading();

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'UpSelling/GuardarRegalo',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    if (response.code == 1) {
                        ok = true;
                        // mostrar regalo ganado
                        var div = $('#of-regalo-' + id);
                        if (typeof div !== 'undefined') {
                            var descripcion = div.find('.titulo_regalo_producto').text();
                            var imagen = div.find('.of-regalo-imagen').attr('src');
                            var descripcionLarga = div.find('.descripcion_regalo').text();

                            $('#of-regalo-descripcion').text(descripcion);
                            $('#of-regalo-imagen').attr('src', imagen);
                            $('#of-regalo-descripcion-larga').text(descripcionLarga);

                            var effect = 'slide';
                            var options = { direction: 'right' };
                            var duration = 500;

                            upSellingGano = GetUpSellingGanado();

                            if (tipoOrigen == "1") {
                                $('#divCarruselRegalo.slick-initialized').slick('unslick');
                                $('#divGanoRegalo').show();
                                $('#container-of-regalo').hide();
                            }
                            else {
                                $('#divGanoRegalo').toggle(effect, options, duration, function () {
                                    $('#ContentSorpresaMobile').hide();
                                });
                            }
                        }
                    }
                    else if (response.code == -1) {
                        alert("El producto seleccionado no tiene stock.");
                    }

                    if (tipoOrigen == "1") CerrarSplash();
                    else CloseLoading();
                }
                else {
                    alert("No se pudo guardar el producto seleccionado.");

                    if (tipoOrigen == "1") CerrarSplash();
                    else CloseLoading();
                }
            }
        },
        error: function (data, error) {
            alert("No se pudo guardar el producto seleccionado");

            if (tipoOrigen == "1") CerrarSplash();
            else CloseLoading();

            if (checkTimeout(data)) {
                console.log(error);
            }
        }
    });

    return ok;
}

function AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_log, gap_Log, tipoRegistro, desTipoRegistro) {
    var param = {
        CUV: cuv,
        cantidad: cantidad,
        tipoOfertaFinal_Log: tipoOfertaFinal_log,
        gap_Log: gap_Log,
        tipoRegistro: tipoRegistro,
        desTipoRegistro: desTipoRegistro
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarOfertaFinalLog',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success == true) {
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AjaxError(data, error);
            }
        }
    });
}

function AgregarOfertaFinalLogBulk(tipoOfertaFinal_log, gap_Log, listaProductos) {
    if (listaProductos.length == 0) return;

    var params = [];

    $.each(listaProductos, function (index, value) {
        var producto = {};
        producto['CUV'] = value.CUV;
        producto['Cantidad'] = 0;
        producto['TipoOfertaFinal'] = value.TipoMeta;
        producto['GAP'] = value.MontoMeta;
        producto['TipoRegistro'] = 3;
        producto['DesTipoRegistro'] = 'Producto Expuesto';
        params.push(producto);
    });

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarOfertaFinalLogBulk',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success == true) {
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AjaxError(data, error);
            }
        }
    });
}

function CargarVerDetalleOF(objInput, e) {
    idProdOf = idProdOf + 1;
    $(objInput).parents('[data-item="ofertaFinal"]').attr("data-id", idProdOf);

    var divPadre = $(objInput).parents('[data-item="ofertaFinal"]').eq(0);

    var objEntidad = new Object();
    objEntidad.id = idProdOf;
    objEntidad.ImagenProductoSugerido = $(divPadre).find(".hdOfertaFinal" + "ImagenProductoSugeridoMedium").val();
    objEntidad.DescripcionComercial = $(divPadre).find(".hdOfertaFinal" + "DescripcionComercial").val();
    objEntidad.Volumen = $(divPadre).find(".hdOfertaFinal" + "Volumen").val();
    objEntidad.Descripcion = $(divPadre).find(".hdOfertaFinal" + "NombreComercial").val();
    objEntidad.Simbolo = $("#hdSimbolo").val();
    objEntidad.PrecioValorizado = $(divPadre).find(".hdOfertaFinal" + "PrecioValorizado").val();
    objEntidad.PrecioValorizadoString = $(divPadre).find(".hdOfertaFinal" + "PrecioValorizadoString").val();
    objEntidad.PrecioCatalogoString = $(divPadre).find(".hdOfertaFinal" + "PrecioCatalogoString").val();
    objEntidad.DescripcionRelacionado = $.trim($(divPadre).find(".hdOfertaFinal" + "DescripcionRelacionado").val());
    objEntidad.CUVPedidoImagen = $.trim($(divPadre).find(".hdOfertaFinal" + "CUVPedidoImagen").val());
    objEntidad.MarcaID = $(divPadre).find(".hdOfertaFinal" + "MarcaID").val();
    objEntidad.DescripcionMarca = $(divPadre).find(".hdOfertaFinal" + "DescripcionMarca").val();
    objEntidad.CUV = $(divPadre).find(".hdOfertaFinal" + "Cuv").val();
    objEntidad.UrlCompartirFB = $(divPadre).find(".hdOfertaFinal" + "UrlCompartirFB").val();
    objEntidad.NombreComercial = $(divPadre).find(".hdOfertaFinal" + "NombreComercial").val();
    objEntidad.ID = $(divPadre).find(".hdOfertaFinal" + "ID").val();
    objEntidad.TipoMeta = $(divPadre).find(".hdOfertaFinal" + "TipoMeta").val();

    SetHandlebars("#ofertaFinalVerDetalle-template", objEntidad, "#contenedor_popup_ofertaFinalVerDetalle");

    $('#contenedor_popup_ofertaFinalVerDetalle').show();
}

function GetRegaloProgramaNuevas() {
    var obj = null;

    jQuery.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetRegaloProgramaNuevas',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: false,
        cache: false,
        success: function (response) {
            if (!checkTimeout(response)) {
                return false;
            }
            if (response.success) {
                obj = response.data;
            }
        },
        error: function (data, error) { }
    });

    return obj;
}

function of_google_analytics_cargar_productos(origen, meta) {
    var pageUrl = "";
    if (origen == 1) { pageUrl = "/desktop/ofertafinal/"; }
    if (origen == 2) { pageUrl = getMobilePrefixUrl() + "/ofertafinal/"; }

    var pageName = "Oferta Final - ";
    if (meta == "MM") { pageName = pageName + "Pedido Mínimo"; }
    if (meta == "GM") { pageName = pageName + "Gana más"; }
    if (meta == "") { pageName = pageName + "Descuento Adicional"; }

    dataLayer.push({
        'event': 'virtualPage',
        'pageUrl': pageUrl,
        'pageName': pageName
    });
}

function of_google_analytics_producto_impresion(origen, meta, lista) {
    var impresions = [];

    var list = "Oferta Final - ";
    if (meta == "MM") { list = list + "Pedido Mínimo"; }
    if (meta == "GM") { list = list + "Gana más"; }
    if (meta == "") { list = list + "Descuento Adicional"; }

    if (origen == 1) {
        if (lista.length >= 3) {

            for (i = 0; i < 3; i++) {
                var impresion;
                var item;
                item = lista[i];
                if (item.DescripcionEstrategia == "") {
                    item.DescripcionEstrategia = "Estándar";
                }

                impresion =
                    {
                        name: item.NombreComercialCorto,
                        id: item.CUV,
                        price: item.PrecioCatalogoString,
                        brand: item.DescripcionMarca,
                        category: 'No Disponible',
                        variant: item.DescripcionEstrategia,
                        list: list,
                        position: i + 1
                    };
                impresions.push(impresion);
            }
        }
    }

    if (origen == 2) {
        var impresion;
        var item;
        item = lista[0];
        if (item.DescripcionEstrategia == "")
            item.DescripcionEstrategia = "Estándar";
        impresion =
            {
                name: item.NombreComercialCorto,
                id: item.CUV,
                price: item.PrecioCatalogoString,
                brand: item.DescripcionMarca,
                category: 'No Disponible',
                variant: item.DescripcionEstrategia,
                list: list,
                position: 1
            };
        impresions.push(impresion);
    }

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': impresions
        }
    });
}

function of_google_analytics_producto_impresion_arrows(event, slick, currentSlide, nextSlide, origen, meta, lista) {
    if (currentSlide != nextSlide) {
        var accion = "";
        var index = 0;
        var impresions = [];

        if (nextSlide == 0 && currentSlide + 1 == lista.length) {
            accion = 'next';
        } else if (currentSlide == 0 && nextSlide + 1 == lista.length) {
            accion = 'prev';
        } else if (nextSlide > currentSlide) {
            accion = 'next';
        } else {
            accion = 'prev';
        };

        if (accion == "prev") {
            index = nextSlide;
        }
        if (accion == "next") {
            if (origen == 1) { index = nextSlide + 2; }
            if (origen == 2) { index = nextSlide + 0; }
        }
        if (index >= lista.length) {
            index = index - lista.length;
        }

        var list = "Oferta Final - ";
        if (meta == "MM") { list = list + "Pedido Mínimo"; }
        if (meta == "GM") { list = list + "Gana más"; }
        if (meta == "") { list = list + "Descuento Adicional"; }

        var impresion;
        var item;
        item = lista[index];
        if (item.DescripcionEstrategia == "") {
            item.DescripcionEstrategia = "Estándar";
        }

        impresion =
            {
                name: item.NombreComercialCorto,
                id: item.CUV,
                price: item.PrecioCatalogoString,
                brand: item.DescripcionMarca,
                category: 'No Disponible',
                variant: item.DescripcionEstrategia,
                list: list,
                position: index + 1
            };
        impresions.push(impresion);
    }
}

function of_google_analytics_addtocar(entorno, ubic, element, meta) {
    var origen;
    var products = [];
    var product;
    var list;
    var name, price, brand, id, variant, quantity, position

    if (entorno != "desktop" && entorno != "mobile")
        return;

    if (ubic != "list" && ubic != "detail")
        return;

    position = element + 1;

    list = "Oferta Final - ";
    if (meta == "MM") { list = list + "Pedido Mínimo"; }
    if (meta == "GM") { list = list + "Gana más"; }
    if (meta == "") { list = list + "Descuento Adicional"; }

    if (entorno == "desktop") {
        if (ubic == "list") {
            origen = "Popup Oferta Final - Listado";
            name = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalNombreComercial").val();
            price = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioCatalogo").val();
            brand = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionMarca").val();
            id = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalCuv").val();
            variant = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionEstrategia").val();
            quantity = $("#divOfertaFinal").find("[data-id = " + element + "]").find("[data-input='cantidad']").val();
            if (variant == "") { variant = "Estándar"; }
            product = {
                name: name,
                price: price,
                brand: brand,
                id: id,
                category: 'NO DISPONIBLE',
                variant: variant,
                quantity: quantity,
                position: position,
                timeAddToCart: '100',
                origen: origen
            }
        }

        if (ubic == "detail") {
            origen = "Popup Oferta Final - Detalle";
            name = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".Nombre").val();

            var precio_valorizado = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizado").val();
            var precio_valorizado_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizadoString").val();
            var precio_catalogo_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioCatalogoString").val();
            if (precio_valorizado > 0) {
                price = precio_valorizado_string
            }
            else {
                price = precio_catalogo_string
            }

            brand = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".MarcaNombre").val();
            id = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".CUV").val();
            variant = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".DescripcionEstrategia").val();
            quantity = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find("[data-input='cantidad']").val();
            if (variant == "") { variant = "Estándar"; }
            product = {
                name: name,
                price: price,
                brand: brand,
                id: id,
                category: 'NO DISPONIBLE',
                variant: variant,
                quantity: quantity,
                position: position,
                timeAddToCart: '100',
                origen: origen
            }
        }
    }

    if (entorno == "mobile") {
        if (ubic == "list") {
            origen = "Popup Oferta Final - Listado";
            name = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalNombreComercial").val();

            var precio_valorizado = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizado").val();
            var precio_valorizado_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizadoString").val();
            var precio_catalogo_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioCatalogoString").val();
            if (precio_valorizado > 0) {
                price = precio_valorizado_string
            }
            else {
                price = precio_catalogo_string
            }

            brand = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionMarca").val();
            id = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalCuv").val();
            variant = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionEstrategia").val();
            quantity = $("#divOfertaFinal").find("[data-id = " + element + "]").find("[data-input='cantidad']").val();
            if (variant == "") { variant = "Estándar"; }
            product = {
                name: name,
                price: price,
                brand: brand,
                id: id,
                category: 'NO DISPONIBLE',
                variant: variant,
                quantity: quantity,
                position: position,
                timeAddToCart: '100',
                origen: origen
            }
        }

        if (ubic == "detail") {
            origen = "Popup Oferta Final - Detalle";
            name = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".Nombre").val();

            var precio_valorizado = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizado").val();
            var precio_valorizado_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizadoString").val();
            var precio_catalogo_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioCatalogoString").val();
            if (precio_valorizado > 0) {
                price = precio_valorizado_string
            }
            else {
                price = precio_catalogo_string
            }

            brand = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".MarcaNombre").val();
            id = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".CUV").val();
            variant = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".DescripcionEstrategia").val();
            quantity = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find("[data-input='cantidad']").val();
            if (variant == "") { variant = "Estándar"; }
            product = {
                name: name,
                price: price,
                brand: brand,
                id: id,
                category: 'NO DISPONIBLE',
                variant: variant,
                quantity: quantity,
                position: position,
                timeAddToCart: '100',
                origen: origen
            }
        }
    }

    if (product != null)
        products.push(product);

    if (products.length > 0) {
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': list },
                    'products': products
                }
            }
        });
    }
}

function of_google_analytics_product_click(entorno, element, meta) {
    var list;
    var name, price, brand, id, variant, position;

    list = "Oferta Final - ";
    if (meta == "MM") { list = list + "Pedido Mínimo"; }
    if (meta == "GM") { list = list + "Gana más"; }
    if (meta == "") { list = list + "Descuento Adicional"; }

    position = element + 1;

    origen = "Popup Oferta Final - Listado";
    name = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalNombreComercial").val();

    var precio_valorizado = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizado").val();
    var precio_valorizado_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizadoString").val();
    var precio_catalogo_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioCatalogoString").val();
    if (precio_valorizado > 0) {
        price = precio_valorizado_string
    }
    else {
        price = precio_catalogo_string
    }

    brand = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionMarca").val();
    id = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalCuv").val();
    variant = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionEstrategia").val();
    if (variant == "") { variant = "Estándar"; }

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'currencyCode': 'PEN',
            'click': {
                'actionField': { 'list': list },
                'products': [{
                    'name': name,
                    'price': price,
                    'brand': brand,
                    'id': id,
                    'category': 'NO DISPONIBLE',
                    'variant': variant,
                    'position': position
                }]
            }
        }
    });
}

function of_google_analytics_cerrar_popup() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ingresa tu pedido',
        'action': 'Oferta final',
        'label': 'Cerrar Popup'
    });
}

function GetValoresOfertaFinalRegalo(data) {
    var total = parseFloat(data.total);
    var minimo = parseFloat($("#hdMontoMinimo").val());
    var tipo = "MM";
    var meta = 0;

    if (objUpselling != null)
        meta = objUpselling.Meta.MontoMeta;
    
    if (ofertaFinalAlgoritmo == "OFR" && tipoOrigen == "2") {
        if (minimo > 0 && total > 0 && total >= minimo) {
            tipo = "RG";
            if (meta > 0 && total > 0 && total >= meta)
                tipo = "GM";
        }
        return {
            tipo: tipo,
            minimo: minimo,
            total: total,
            meta: meta
        };
    }

    return null;
}