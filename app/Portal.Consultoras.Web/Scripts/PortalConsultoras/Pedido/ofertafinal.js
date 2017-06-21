var tipoOrigen = tipoOrigen || "";// 1: escritorio      2: mobile
var agregoOfertaFinal = 0;
var idProdOf = 0;

var esParaOFGanaMas = false;
var cuvOfertaProl = cuvOfertaProl || "";
var oRegaloPN = null;

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
        tipoOfertaFinal_Log = $(divPadre).find(".hdTipoMeta").val();

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
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        //if (tieneMasVendidos == 1)
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
            if (tipoOrigen == "1") {
                CerrarSplash();
            }
            else {
                CloseLoading();
            }
            return false;
        }

        //if (tieneMasVendidos == 1)
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

    $('div.popup_ofertaFinal').removeClass('fondo_gris_OF');
    $('#divOfertaFinal').html('<div style="text-align: center;">Actualizando Productos de Oferta Final<br><img src="' + urlLoad + '" /></div>');

    var objOf = cumpleOferta.productosMostrar[0];
    objOf.MetaPorcentaje = $.trim(objOf.TipoMeta);
    objOf.TipoMeta = objOf.TipoMeta == "MM" || objOf.TipoMeta == "GM" ? objOf.TipoMeta : objOf.MetaPorcentaje != "" ? "ME" : "";
    objOf.Detalle = cumpleOferta.productosMostrar;
    objOf.TotalPedido = $("#hdfTotal").val();
    objOf.Simbolo = objOf.Simbolo || $("#hdSimbolo").val();;

    objOf.Cross = objOf.TipoMeta == "GM" ? objOf.Detalle.Find("TipoCross", true).length > 0 ? "1" : "0" : "0";
    objOf.ofIconoSuperior = objOf.TipoMeta == "MM" ? tipoOrigen == 1 ? "icono_exclamacion" : "exclamacion_icono_mobile" : tipoOrigen == 1 ? "icono_check_alerta" : "check_icono_mobile";
    SetHandlebars("#ofertaFinal-template", objOf, "#divOfertaFinal");
    $("#btnGuardarPedido").hide();

    //debugger;
    if (consultoraRegaloPN == 'True') {
        //var montoMeta = parseFloat(objOf.TotalPedido) + parseFloat(objOf.MetaMontoStr);
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
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: -4%; top: 7%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png"/></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right:-4%; top: 7%;"><img src="/Content/Images/mobile/Esika/next.png"/></a>'
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
            prevArrow: '<a class="previous_ofertas js-slick-prev-of" style="left:-5%;" ><img src="/Content/Images/Esika/previous_ofertas_home.png" style="width:100%; height:auto;" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas next js-slick-next-of" style="right:-5%; text-align:right;"><img src="/Content/Images/Esika/next.png" style="width:100%; height:auto;" alt="" /></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            of_google_analytics_producto_impresion_arrows(event, slick, currentSlide, nextSlide, tipoOrigen, objOf.TipoMeta, objOf.Detalle);
        });
    }
    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));    
    of_google_analytics_producto_impresion(tipoOrigen, objOf.TipoMeta,objOf.Detalle);
    agregoOfertaFinal = tipoPopupMostrar == 1 ? 1 : agregoOfertaFinal;
    
    //if (tieneMasVendidos == 1) {
        //debugger;
        AgregarOfertaFinalLog("", 0, cumpleOferta.tipoOfertaFinal_Log, cumpleOferta.gap_Log, 2, 'Popup Mostrado');

        AgregarOfertaFinalLogBulk(cumpleOferta.tipoOfertaFinal_Log, cumpleOferta.gap_Log, cumpleOferta.productosMostrar);
    //}

    $(".nohely").on('mousemove', function (e) {
        var texto = $.trim($(e.target).attr('data-tooltip-text'));
        if (texto == "") {
            $('[data-toggle="tooltip"]').tooltip('hide');
            return false;
        }
        texto = "Porque compraste " + texto;
        $("#img-tooltip").attr('data-original-title', texto);
        var p = $("#img-tooltip").attr('aria-describedby');
        $('#' + p).css("z-index",10000);
        $("#img-tooltip").css({ top: e.pageY - 50, left: e.pageX + 5});
        $('[data-toggle="tooltip"]').tooltip('show');
    });

    $(".nohely").on('mouseleave', function (e) {
        $('[data-toggle="tooltip"]').tooltip('hide');
    });

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
    return true;
}

function ActulizarValoresPopupOfertaFinal(data, popup) {
    var tipoMeta = $("#divOfertaFinal div[data-meta]").attr("data-meta") || data.TipoMeta;
    var simbolo = $("#hdSimbolo").val();

    //debugger;
    if (consultoraRegaloPN == 'True') {
        var aa = $("#msjOfertaFinal").attr("data-meta-monto");
        var bb = $("#divOfertaFinal > div").attr("data-meta-total");
        var montoMeta = parseFloat(aa) + parseFloat(bb);
        mostrarMensajeRegaloPN(tipoMeta, data.total, montoMeta, simbolo, 2)
    }

    if (tipoMeta == "MM") {
        var faltante = $("#msjOfertaFinal").attr("data-meta-monto");
        var totalPedido = $("#divOfertaFinal > div").attr("data-meta-total");
        var montolimite = parseFloat(faltante) + parseFloat(totalPedido);

        if (parseFloat(data.total) >= montolimite) {
            var msj = tipoOrigen == "2" ? "Ganancia estimada total: " : "Ahora tu ganancia estimada total es ";
            $("#spnTituloOfertaFinal span").html("¡LLEGASTE AL <b>MONTO MÍNIMO!</b>");
            if (tipoOrigen == "1") {
                $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
            }
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
        }
        else {
            $("#msjOfertaFinal").parent().find("span[data-monto]").html(DecimalToStringFormat(montolimite - parseFloat(data.total)));
            $("#btnNoGraciasOfertaFinal").hide();
        }

        $("#msjOfertaFinal").attr("data-meta-monto", totalPedido - parseFloat(data.total));
        $("#divOfertaFinal > div").attr("data-meta-total", data.total);
    }
    else if (tipoMeta == "GM") {
        $("#spnTituloOfertaFinal span").html("¡AHORA TU <b>GANANCIA ESTIMADA ES " + simbolo + " " + data.DataBarra.MontoGananciaStr + "!</b>");
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

function mostrarMensajeRegaloPN(tipoMeta, montoTotal, montoSaldo, simbolo, flag) {
    if (oRegaloPN == null)
        oRegaloPN = GetRegaloProgramaNuevas();

    if (oRegaloPN != null) {
        var msgRegalo = "";
        var txtAyuda1 = "";
        var nivel = oRegaloPN.CodigoNivel;

        //debugger;
        var montoMeta = 0;
        if (flag == 1) montoMeta = parseFloat(montoTotal) + parseFloat(montoSaldo);
        else montoMeta = montoSaldo;

        if (nivel == '01' || nivel == '02' || nivel == '03') {
            txtAyuda1 = '*En caso tu pedido no tenga observaciones y se mantenga en el monto mínimo';
            if (tipoMeta == 'MM') {
                if (montoTotal >= montoMeta) {
                    msgRegalo = '<b>¡GANASTE UN ' + oRegaloPN.DescripcionPremio + '!</b>';
                }
                else {
                    msgRegalo = 'LLEGA AL MONTO MINIMO Y <b>GANA UN ' + oRegaloPN.DescripcionPremio + '.'
                    if (oRegaloPN.PrecioCatalogo > 0)
                        msgRegalo += ' PUEDES VENDERLO A ' + simbolo + ' ' + oRegaloPN.PrecioCatalogoFormat + '</b>';
                }
            }
            else {
                msgRegalo = '<b>¡GANASTE UN ' + oRegaloPN.DescripcionPremio + '!</b>';
            }
        }
        else if (nivel == '04' || nivel == '05' || nivel == '06') {
            txtAyuda1 = '*En caso tu pedido no tenga observaciones y mantenga en un monto mínimo de ' + simbolo + ' ' + oRegaloPN.TippingPointFormat;
            if (tipoMeta == 'MM') {
                if (montoTotal >= montoMeta) {
                    msgRegalo = '<b>¡GANASTE UN ' + oRegaloPN.DescripcionPremio + '!</b>';
                }
                else {
                    msgRegalo = 'AGREGA ' + simbolo + ' ' + montoSaldo.toString() + ' PARA <b>GANARTE UN ' + oRegaloPN.DescripcionPremio + ' Y ACCEDER A OFERTAS EXCLUSIVAS</b>';
                }
            }
            else {
                if (oRegaloPN.TippingPoint > 0) {
                    if (montoTotal >= oRegaloPN.TippingPoint) {
                        msgRegalo = '<b>¡GANASTE UN ' + oRegaloPN.DescripcionPremio + '!</b>';
                    }
                    else {
                        var stp = (oRegaloPN.TippingPoint - parseFloat(montoTotal)).toFixed(2);
                        msgRegalo = '<b>AGREGA ' + simbolo + ' ' + stp.toString() + ' PARA GANARTE UN ' + oRegaloPN.DescripcionPremio + ' Y ACCEDER A OFERTAS EXCLUSIVAS</b>';
                    }
                }
                else {
                    msgRegalo = '<b>¡GANASTE UN ' + oRegaloPN.DescripcionPremio + '!</b>';
                }
            }
        }

        if (oRegaloPN.UrlImagenRegalo != null && oRegaloPN.UrlImagenRegalo != "")
            $('#img-regalo-pn').attr('src', oRegaloPN.UrlImagenRegalo);
        $('#msg-regalo-pn').html(msgRegalo);
        $('#txt-ayuda1-pn').html(txtAyuda1);
        $('#div-regalo-pn').show();
        $('#txt-ayuda1-pn').show();
        $('div.popup_ofertaFinal').addClass('fondo_gris_OF');
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
    var cumpleOferta = CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
    if (cumpleOferta.resultado) {
        cumpleOferta.resultado = MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar);
    }
    return cumpleOferta;
}

function CumpleOfertaFinal(montoPedido, montoEscala, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var productosMostrar = new Array();
    var montoFaltante = 0;
    var porcentajeDescuento = 0;
    var tipoMeta = 0;

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
                    if (listaObservacionesProl[0].Caso == 95)
                        resultado = listaObservacionesProl[0].CUV == "XXXXX";
                }
            }
        }

        if (resultado == true) {
            productoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);
            if (productoOfertaFinal.lista.length != 0) //bug EPD-2365
                tipoMeta = productoOfertaFinal.lista[0].TipoMeta;
        }
    }

    return {
        resultado: resultado,
        productosMostrar: productoOfertaFinal.lista || new Array(),
        montoFaltante: montoFaltante, //REVISAR
        porcentajeDescuento: porcentajeDescuento, //REVISAR
        muestraGanaMas: 0, //REVISAR
        tipoOfertaFinal_Log: tipoMeta, //REVISAR
        gap_Log: 0 //REVISAR
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
                if (response.success) {
                    lista = response.data;
                } else {
                    lista = null;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                lista = null;
            }
        }
    });

    return {
        lista: lista
    };
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

    //debugger;

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
        //producto['CampaniaID'] = viewBagCampaniaActual;
        //producto['CodigoConsultora'] = viewBagCondigoConsultora;
        producto['CUV'] = value.CUV;
        producto['Cantidad'] = 0;
        producto['TipoOfertaFinal'] = value.TipoMeta;
        producto['GAP'] = value.MontoMeta;
        producto['TipoRegistro'] = 3;
        producto['DesTipoRegistro'] = 'Producto Expuesto';
        params.push(producto);
    });

    //debugger;

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
    objEntidad.ImagenProductoSugerido = $(divPadre).find(".hdOfertaFinal" + "ImagenProductoSugerido").val();
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
            if (!checkTimeout(response))
                return false;

            if (response.success) {
                //console.log(response);
                obj = response.data;
            }
            else {
                console.log(response.message);
            }
        },
        error: function (data, error) {
            console.log(error);
        }
    });

    return obj;
}

function of_google_analytics_cargar_productos(origen, meta) {
    var pageUrl = "";
    if (origen == 1) { pageUrl = "/desktop/ofertafinal/"; }
    if (origen == 2) { pageUrl = "/mobile/ofertafinal/"; }

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
                if (item.DescripcionEstrategia == "")
                {
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
                        position: i+1
                    };
                impresions.push(impresion);
            }            
        }
    }

    if (origen == 2) {
        var impresion;
        var item;
        //item 1
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

        if (nextSlide == 0 && currentSlide + 1 == lista.letgh) {
            accion = 'next';
        } else if (currentSlide == 0 && nextSlide + 1 == lista.letgh) {
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
        if (index >= lista.letgh) {
            index = index - lista.letgh;
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

function of_google_analytics_addtocar(entorno, ubic, element, meta)
{
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
    if (meta == "")   { list = list + "Descuento Adicional"; }       

    if (entorno == "desktop"){
        if (ubic == "list") {
            origen   = "Popup Oferta Final - Listado";
            name     = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalNombreComercial").val();
            price    = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioCatalogo").val();
            brand    = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionMarca").val();
            id       = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalCuv").val();
            variant  = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionEstrategia").val();
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
            //*****************logica de la pagina para el precio***************************
            var precio_valorizado = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizado").val();
            var precio_valorizado_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizadoString").val();
            var precio_catalogo_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioCatalogoString").val();
            if (precio_valorizado > 0) {
                price = precio_valorizado_string
            }
            else {
                price = precio_catalogo_string
            }
            //******************************
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
            //*****************logica de la pagina para el precio***************************
            var precio_valorizado = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizado").val();
            var precio_valorizado_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizadoString").val();
            var precio_catalogo_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioCatalogoString").val();
            if (precio_valorizado > 0) {
                price = precio_valorizado_string
            }
            else {
                price = precio_catalogo_string
            }
            //******************************
            brand = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionMarca").val();
            id = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalCuv").val();
            variant = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionEstrategia").val();
            quantity = $("#divOfertaFinal").find("[data-id = " + element + "]").find("[data-input='cantidad']").val();
            //quantity = $("#divOfertaFinal").find("[data-input='cantidad']").val();
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
            //*****************logica de la pagina para el precio***************************
            var precio_valorizado = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizado").val();
            var precio_valorizado_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioValorizadoString").val();
            var precio_catalogo_string = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-item = " + element + "]").find(".PrecioCatalogoString").val();
            if (precio_valorizado > 0) {
                price = precio_valorizado_string
            }
            else {
                price = precio_catalogo_string
            }
            //******************************
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
    var name, price, brand, id, variant, quantity, position;

    list = "Oferta Final - ";
    if (meta == "MM") { list = list + "Pedido Mínimo"; }
    if (meta == "GM") { list = list + "Gana más"; }
    if (meta == "") { list = list + "Descuento Adicional"; }

    position = element + 1;

    origen = "Popup Oferta Final - Listado";
    name = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalNombreComercial").val();
    //*****************logica de la pagina para el precio***************************
    var precio_valorizado = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizado").val();
    var precio_valorizado_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioValorizadoString").val();
    var precio_catalogo_string = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalPrecioCatalogoString").val();
    if (precio_valorizado > 0) {
        price = precio_valorizado_string
    }
    else {
        price = precio_catalogo_string
    }
    //******************************
    brand = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionMarca").val();
    id = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalCuv").val();
    variant = $("#divOfertaFinal").find("[data-id = " + element + "]").find(".hdOfertaFinalDescripcionEstrategia").val();
    quantity = $("#divOfertaFinal").find("[data-id = " + element + "]").find("[data-input='cantidad']").val();
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