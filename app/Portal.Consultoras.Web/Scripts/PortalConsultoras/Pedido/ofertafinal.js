var tipoOrigen = tipoOrigen || "";// 1: escritorio      2: mobile
var agregoOfertaFinal = 0;
var idProdOf = 0;

/*EPD-991*/
var esParaOFGanaMas = false;
/*EPD-991*/

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
        var OrigenPedidoWeb = tipoOrigen == "1" ? DesktopPedidoOfertaFinal : MobilePedidoOfertaFinal;

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
            TipoOfertaSisID: tipoOfertaSisID,
            ConfiguracionOfertaID: configuracionOfertaID,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            MarcaID: marcaID,
            Cantidad: cantidad,
            PrecioUnidad: precioUnidad,
            CUV: cuv,
            Tipo: tipo,
            DescripcionProd: descripcionProd,
            Pagina: pagina,
            DescripcionCategoria: descripcionCategoria,
            DescripcionMarca: descripcionMarca,
            DescripcionEstrategia: descripcionEstrategia,
            EsSugerido: false,
            OrigenPedidoWeb: OrigenPedidoWeb
        };
        var add = new Object();
        if (tipoOrigen == "1") {
            var add = AgregarProducto('Insert', model, "", false, false);
        }
        else
        {
            var add = InsertarProducto(model, false);
        }
        if (!add.success) {
            //alert_msg("Vuelva a intentarlo.");
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_Log, gap_Log, 1);
        //TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
        //setTimeout(function () {
        //    $("#divOfertaFinal").hide();
        //    EjecutarServicioPROLSinOfertaFinal();
        //}, 1000);
        
        ActulizarValoresPopupOfertaFinal(add);

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
        //var divPadre = $(this).parents("[data-item='ofertaFinal']").eq(0);
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
            TipoOfertaSisID: tipoOfertaSisID,
            ConfiguracionOfertaID: configuracionOfertaID,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            MarcaID: marcaID,
            Cantidad: cantidad,
            PrecioUnidad: precioUnidad,
            CUV: cuv,
            Tipo: tipo,
            DescripcionProd: descripcionProd,
            Pagina: pagina,
            DescripcionCategoria: descripcionCategoria,
            DescripcionMarca: descripcionMarca,
            DescripcionEstrategia: descripcionEstrategia,
            EsSugerido: false,
            OrigenPedidoWeb: OrigenPedidoWeb
        };

        var add = new Object();
        if (tipoOrigen == "1") {
            var add = AgregarProducto('Insert', model, "", false, false);
        }
        else {
            var add = InsertarProducto(model, false);
        }

        if (!add.success) {
            //alert_msg("Vuelva a intentarlo.");
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_Log, gap_Log, 1);
        ActulizarValoresPopupOfertaFinal(add);
        $("#divCarruselOfertaFinal").find(".hdOfertaFinalCuv[value='" + cuv + "']").parents('[data-item="ofertaFinal"]').find('.agregado').show();
        $("#contenedor_popup_ofertaFinalVerDetalle").hide();
        if (tipoOrigen == "1") {
            CerrarSplash();
        }
        else {
            CloseLoading();
        }
    });
});

function PopupOfertaFinalCerrar() {

    if (agregoOfertaFinal == 1) {
        setTimeout(function () {
            $("#divOfertaFinal").hide();
            EjecutarServicioPROLSinOfertaFinal();
        }, 1000);
    }
    $("#divOfertaFinal").hide();
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

    var objOf = cumpleOferta.productosMostrar[0];
    objOf.MetaPorcentaje = objOf.TipoMeta;
    objOf.TipoMeta = objOf.TipoMeta == "MM" || objOf.TipoMeta == "GM" ? objOf.TipoMeta : "ME";
    objOf.Detalle = cumpleOferta.productosMostrar;
    objOf.TotalPedido = $("#hdfTotal").val();
    objOf.Simbolo = objOf.Simbolo || $("#hdSimbolo").val();

    //objOf.TipoMeta = "ME";
    //objOf.MontoMeta = "24040";
    //objOf.MetaMontoStr = "24.040";
    //objOf.MetaPorcentaje = "30";

    //SetHandlebars("#ofertaFinal-template", cumpleOferta.productosMostrar, "#divOfertaFinal");

    SetHandlebars("#ofertaFinal-template", objOf, "#divOfertaFinal");
    $("#divOfertaFinal").show();

    if (tipoOrigen == "2") {
        $('#divCarruselOfertaFinal').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p', // popup
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: 0.5%; top: 7%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png" style="width:100%; height:auto;" /></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right: 0.5%; top: 7%;"><img src="/Content/Images/mobile/Esika/next.png" style="width:100%; height:auto;" /></a>'
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
            tipo: 'p', // popup
            prevArrow: '<a class="previous_ofertas js-slick-prev-of" style="left:-5%;" ><img src="/Content/Images/Esika/previous_ofertas_home.png" style="width:100%; height:auto;" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas next js-slick-next-of" style="right:-5%; text-align:right;"><img src="/Content/Images/Esika/next.png" style="width:100%; height:auto;" alt="" /></a>'
        });
    }
    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
    
    agregoOfertaFinal = tipoPopupMostrar == 1 ? 1 : agregoOfertaFinal;
    
    //CargandoValoresPopupOfertaFinal(tipoPopupMostrar, cumpleOferta.muestraGanaMas, cumpleOferta.montoFaltante, cumpleOferta.porcentajeDescuento);
    
    //var contenedorMostrarInicial = $(".content_item_carrusel_ofertaFinal.slick-active")[0];
    //var cuvMostrado = $(contenedorMostrarInicial).find(".hdOfertaFinalCuv").val();
    AgregarOfertaFinalLog("", 0, cumpleOferta.tipoOfertaFinal_Log, cumpleOferta.gap_Log, 2);

    $(".nohely").on('mousemove', function (e) {
        var texto = $.trim($(e.target).attr('data-tooltip-text'));
        if (texto == "") {
            $('[data-toggle="tooltip"]').tooltip('hide');
            return false;
        }
        $("#img-tooltip").attr('data-original-title', texto);
        var p = $("#img-tooltip").attr('aria-describedby');
        $('#' + p).css("z-index",10000);
        $("#img-tooltip").css({ top: e.pageY - 50, left: e.pageX + 5});
        $('[data-toggle="tooltip"]').tooltip('show');
    });

    $(".nohely").on('mouseleave', function (e) {
        $('[data-toggle="tooltip"]').tooltip('hide');
    });

    return true;
}

function ActulizarValoresPopupOfertaFinal(data) {
    var tipoMeta = $("#divOfertaFinal div[data-meta]").attr("data-meta");

    var simbolo = $("#hdSimbolo").val();
    if (tipoMeta == "MM") {
        var faltante = $("#msjOfertaFinal").attr("data-meta-monto");
        var totalPedido = $("#divOfertaFinal > div").attr("data-meta-total");
        var montolimite = parseFloat(faltante) + parseFloat(totalPedido);

        if (parseFloat(data.total) >= montolimite) {
            var msj = tipoOrigen == "2" ? "Ganancia estimada total: " : "Ahora tu ganancia estimada total es ";
            $("#spnTituloOfertaFinal span").html("¡FELICITACIONES GUARDASTE TU <b>PEDIDO CON ÉXITO</b>!");
            if (tipoOrigen == "1") {
                $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
            }
            $("#msjOfertaFinal span").html("<b>" + msj + simbolo + " " + data.DataBarra.MontoGananciaStr + "</b><br />Monto total: " + simbolo + " " + data.formatoTotal);
            agregoOfertaFinal = 1;
        }
        else {
            $("#msjOfertaFinal span[data-monto]").html(DecimalToStringFormat(montolimite - parseFloat(data.total)));
        }

        $("#msjOfertaFinal").attr("data-meta-monto", totalPedido - parseFloat(data.total));
        $("#divOfertaFinal > div").attr("data-meta-total", data.total);
    }
    else if (tipoMeta == "GM") {
        $("#spnTituloOfertaFinal span").html("¡FELICITACIONES AHORA TU GANANCIA ESTIMADA ES <b>" + simbolo + " " + data.DataBarra.MontoGananciaStr + "</b>!");
        if (tipoOrigen == "1") {
            $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
        }
        $("#msjOfertaFinal span").html("Monto total: " + simbolo + " " + data.formatoTotal);
        agregoOfertaFinal = 1;
    }
    else if (tipoMeta == "ME") {
        var faltante = $("#msjOfertaFinal").attr("data-meta-monto");
        var totalPedido = $("#divOfertaFinal > div").attr("data-meta-total");
        var montolimite = parseFloat(faltante) + parseFloat(totalPedido);

        if (parseFloat(data.total) >= montolimite) {
            var msj = tipoOrigen == "2" ? "Ganancia estimada total: " : "Ahora tu ganancia estimada total es ";
            var porc = $("#msjOfertaFinal").attr("data-meta-porcentaje");
            $("#spnTituloOfertaFinal span").html("¡FELICITACIONES LLEGASTE AL <b>" + porc + "% DSCTO</b>!");
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
}

function CargandoValoresPopupOfertaFinal(tipoPopupMostrar, mostrarGanaMas, montoFaltante, porcentajeDescuento) {

    var formatoMontoFaltante = DecimalToStringFormat(montoFaltante);
    var montoMinimo = DecimalToStringFormat(parseFloat($("#hdMontoMinimo").val()));

    $('#spCabeceraMontominimo').hide();

    if (tipoPopupMostrar == 1) {

        /*EPD-991*/
        //var mostrarGanaMas = validarOfertaFinalGanMas();
        //if (mostrarGanaMas) {
        //    mostrarGanaMas = esParaOFGanaMas;
        //}
        /*EPD-991*/

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
    var cumpleOferta = CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
    if (cumpleOferta.resultado) {
        cumpleOferta.resultado = MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar);
    }
    return cumpleOferta;
}

//function CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
function CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var productosMostrar = new Array();
    var montoFaltante = 0;
    var porcentajeDescuento = 0;

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

        if (tipoPopupMostrar == 1) { // me
            resultado = codigoMensajeProl == "00";
        }
        else { // MM
            if (codigoMensajeProl == "01") {
                if (listaObservacionesProl.length == 1) {
                    var tipoError = listaObservacionesProl[0].Caso;
                    if (tipoError == 95)
                        resultado = listaObservacionesProl[0].CUV == "XXXXX";
                }
            }
        }

        if (resultado == true) {
            productoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);
        }
    }

    ///*EPD-991*/
    //var mostrarGanaMas = validarOfertaFinalGanMas();
    ///*EPD-991*/
    //if (resultado || mostrarGanaMas) {
    //    resultado = false;
    //    var cumpleParametria = CumpleParametriaOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
    //    if (cumpleParametria.resultado) {
    //        montoFaltante = cumpleParametria.montoFaltante;
    //        porcentajeDescuento = cumpleParametria.porcentajeDescuento;
    //        var productoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);
    //        var listaProductoOfertaFinal = productoOfertaFinal.lista;
    //        var limite = productoOfertaFinal.limite;
    //        if (listaProductoOfertaFinal != null) {
    //            var contador = 0;
    //            $.each(listaProductoOfertaFinal, function (index, value) {
    //                if (value.PrecioCatalogo >= montoFaltante && value.PrecioCatalogo > cumpleParametria.precioMinimoOfertaFinal) {
    //                    productosMostrar.push(value);
    //                    contador++;
    //                    if (contador >= limite)
    //                        return false;
    //                }
    //            });
    //            resultado = productosMostrar.length > 0;               
    //        }
    //    }
    //}

    return {
        resultado: resultado,
        productosMostrar: productoOfertaFinal.lista || new Array(),
        montoFaltante: montoFaltante, //REVISAR
        porcentajeDescuento: porcentajeDescuento, //REVISAR
        muestraGanaMas: 0, //REVISAR
        tipoOfertaFinal_Log: 0, //REVISAR
        gap_Log: 0 //REVISAR
    };
}

/*EPD-991*/
//function validarOfertaFinalGanMas() {
//    debugger
//    var ofertaFinal = $('#hdOfertaFinal').val();
//    var esOfertaFinalZonaValida = $("#hdEsOfertaFinalZonaValida").val();
//    var ofertaFinalGanaMas = $('#hdOfertaFinalGanaMas').val();
//    var esFacturacion = $("#hdEsFacturacion").val();
//    var mostrar = false;
//    if (esFacturacion == "True") {
//        if (ofertaFinal == "1" || ofertaFinal == "2") {
//            if (esOfertaFinalZonaValida == "True") {
//                if (ofertaFinalGanaMas == "1") {
//                    var esConsultoraNueva = $("#hdEsConsultoraNueva").val();
//                    if (esConsultoraNueva == "True") {
//                        var esOFGanaMasZonaValida = $("#hdEsOFGanaMasZonaValida").val();
//                        mostrar = (esOFGanaMasZonaValida == "True");
//                    }
//                    else {
//                        mostrar = true;
//                    }
//                }
//            }
//        }
//    }
//    return mostrar;
//}

/*EPD-991*/

//function CumpleParametriaOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
//    debugger
//    var resultado = false;
//    var montoFaltante = 0;
//    var porcentajeDescuento = 0;
//    var precioMinimoOfertaFinal = 0;
//    /*EPD-991*/
//    var mostrarGanaMas = validarOfertaFinalGanMas();
//    /*EPD-991*/
//    //Escala
//    if (tipoPopupMostrar == 1) {
//        var esConsultoraNueva = $("#hdEsConsultoraNueva").val();
//        //if (esConsultoraNueva == "False") {
//        if (esConsultoraNueva == "False" || mostrarGanaMas) {
//            if (codigoMensajeProl == "00") {
//                var escalaDescuento = null;
//                var escalaDescuentoSiguiente = null;
//                $.each(listaEscalaDescuento, function (index, value) {
//                    if (value.MontoHasta >= montoEscala) {
//                        escalaDescuento = value;
//                        if (index < listaEscalaDescuento.length - 1) {
//                            escalaDescuentoSiguiente = listaEscalaDescuento[index + 1];
//                        } else {
//                            escalaDescuentoSiguiente = null;
//                        }
//                        return false;
//                    }
//                });
//                if (!(escalaDescuento == null || escalaDescuentoSiguiente == null)) {                    
//                    escalaDescuento.MontoHasta = Math.ceil(escalaDescuento.MontoHasta);
//                    var diferenciaMontoEd = escalaDescuento.MontoHasta - montoEscala;
//                    var parametriaEd = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "E" + escalaDescuento.PorDescuento) : null;
//                    var parametrisGM = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "GM") : null;
//                    if (parametriaEd != null && parametriaEd.length != 0) {
//                        if (parametriaEd[0].MontoDesde <= diferenciaMontoEd && parametriaEd[0].MontoHasta >= diferenciaMontoEd) {
//                            montoFaltante = diferenciaMontoEd;
//                            porcentajeDescuento = escalaDescuentoSiguiente.PorDescuento;
//                            precioMinimoOfertaFinal = parametriaEd[0].PrecioMinimo;
//                            tipoOfertaFinal_Log = "E" + escalaDescuentoSiguiente.PorDescuento;
//                            gap_Log = montoFaltante;
//                            resultado = true;
//                        }
//                        else {
//                            /*EPD-991*/
//                            if (mostrarGanaMas) {
//                                montoFaltante = parametrisGM[0].PrecioMinimo;
//                                porcentajeDescuento = escalaDescuentoSiguiente.PorDescuento;
//                                precioMinimoOfertaFinal = montoFaltante;
//                                tipoOfertaFinal_Log = "GM";
//                                gap_Log = 0;    //
//                                resultado = true;
//                                esParaOFGanaMas = true;
//                            }
//                            /*EPD-991*/
//                        }
//                    }
//                    else {
//                        /*EPD-991*/
//                        if (mostrarGanaMas) {
//                            montoFaltante = parametrisGM[0].PrecioMinimo;
//                            porcentajeDescuento = escalaDescuentoSiguiente.PorDescuento;
//                            precioMinimoOfertaFinal = montoFaltante;
//                            tipoOfertaFinal_Log = "GM";
//                            gap_Log = 0;    //
//                            resultado = true;
//                            esParaOFGanaMas = true;
//                        }
//                        /*EPD-991*/
//                    }
//                }                
//            }
//        }
//    } else {
//        //Monto Minimo y Maximo
//        if (codigoMensajeProl == "01") {
//            if (listaObservacionesProl.length == 1) {
//                var tipoError = listaObservacionesProl[0].Caso;
//                if (tipoError == 95) {
//                    //var mensajePedido = listaObservacionesProl[0].Descripcion || "";
//                    var mensajeCUV = listaObservacionesProl[0].CUV;
//                    if (mensajeCUV == "XXXXX") {
//                        /*EPD-991*/
//                        esParaOFGanaMas = false;
//                        /*EPD-991*/
//                        var montoMinimo = parseFloat($("#hdMontoMinimo").val());
//                        var diferenciaMonto = montoMinimo - montoPedido;
//                        var parametria = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "MM") : null;
//                        if (parametria != null && parametria.length != 0) {
//                            if (parametria[0].MontoDesde <= diferenciaMonto && parametria[0].MontoHasta >= diferenciaMonto) {
//                                montoFaltante = diferenciaMonto;
//                                precioMinimoOfertaFinal = parametria[0].PrecioMinimo;
//                                tipoOfertaFinal_Log = "MM";
//                                gap_Log = montoFaltante;
//                                resultado = true;
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    return {
//        resultado: resultado,
//        montoFaltante: montoFaltante,
//        porcentajeDescuento: porcentajeDescuento,
//        precioMinimoOfertaFinal: precioMinimoOfertaFinal
//    };
//}

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
                if (response.success) {
                    lista = response.data;
                    console.log(lista);
                } else {
                    lista = null;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
                lista = null;
                //CerrarSplash();
            }
        }
    });

    return {
        lista: lista
    };
}

function AgregarOfertaFinalLog(cuv, cantidad, tipoOfertaFinal_log, gap_Log, tipoRegistro) {
    var param = {
        CUV: cuv,
        cantidad: cantidad,
        tipoOfertaFinal_Log: tipoOfertaFinal_log,
        gap_Log: gap_Log,
        tipoRegistro: tipoRegistro
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarOfertaFinalLog',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (response) {
            if (response.success == true) {
                //console.log(response.result);
            }
        },
        error: function (data, error) {
            AjaxError(data, error);
        }
    });
}

function CargarVerDetalleOF(objInput, e) {
    idProdOf = idProdOf + 1;
    $(objInput).parents('[data-item="ofertaFinal"]').attr("data-id", idProdOf);

    var divPadre = $(objInput).parents('[data-item="ofertaFinal"]').eq(0);

    var objEntidad = new Object();
    objEntidad.id = idProdOf;
    objEntidad.ImagenProductoSugerido = $(divPadre).find(".hdOfertaFinal" + "ImagenProductoSugerido").val();
    objEntidad.DescripcionComercial = $(divPadre).find(".hdOfertaFinal" + "DescripcionComercial").val();
    objEntidad.Volumen = $(divPadre).find(".hdOfertaFinal" + "Volumen").val();
    objEntidad.Descripcion = $(divPadre).find(".hdOfertaFinal" + "NombreComercial").val();
    objEntidad.Simbolo = $("#hdSimbolo").val();
    objEntidad.PrecioValorizadoString = $(divPadre).find(".hdOfertaFinal" + "PrecioValorizadoString").val();
    objEntidad.PrecioCatalogoString = $(divPadre).find(".hdOfertaFinal" + "PrecioCatalogoString").val();
    objEntidad.DescripcionRelacionado = $.trim($(divPadre).find(".hdOfertaFinal" + "DescripcionRelacionado").val());
    objEntidad.CUVPedidoImagen = $.trim($(divPadre).find(".hdOfertaFinal" + "CUVPedidoImagen").val());
    objEntidad.MarcaID = $(divPadre).find(".hdOfertaFinal" + "MarcaID").val();
    objEntidad.DescripcionMarca = $(divPadre).find(".hdOfertaFinal" + "DescripcionMarca").val();
    objEntidad.CUV = $(divPadre).find(".hdOfertaFinal" + "Cuv").val();
    objEntidad.UrlCompartirFB = $(divPadre).find(".hdOfertaFinal" + "UrlCompartirFB").val();
    objEntidad.NombreComercial = $(divPadre).find(".hdOfertaFinal" + "NombreComercial").val();

    SetHandlebars("#ofertaFinalVerDetalle-template", objEntidad, "#contenedor_popup_ofertaFinalVerDetalle");

    $('#contenedor_popup_ofertaFinalVerDetalle').show();
}
