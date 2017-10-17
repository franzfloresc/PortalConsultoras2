﻿var tipoOrigen = tipoOrigen || "";// 1: escritorio      2: mobile
var agregoOfertaFinal = 0;
var idProdOf = 0;

var esParaOFGanaMas = false;
var cuvOfertaProl = cuvOfertaProl || "";
var oRegaloPN = null;
var ofertaFinalRegalo = null;
var esOfertaFinalRegalo = false;

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
            esOfertaFinalRegalo = true;
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

    //$('div.popup_ofertaFinal').removeClass('fondo_gris_OF');
    $('#divOfertaFinal').html('<div style="text-align: center;">Actualizando Productos de Oferta Final<br><img src="' + urlLoad + '" /></div>');

    var objOf = cumpleOferta.productosMostrar[0];
    objOf.MetaPorcentaje = $.trim(objOf.TipoMeta);
    objOf.Detalle = cumpleOferta.productosMostrar;
    objOf.TotalPedido = $("#hdfTotal").val();
    objOf.Simbolo = objOf.Simbolo || $("#hdSimbolo").val();

    objOf.Cross = objOf.TipoMeta == "GM" ? objOf.Detalle.Find("TipoCross", true).length > 0 ? "1" : "0" : "0";
    objOf.ofIconoSuperior = objOf.TipoMeta == "MM" ? tipoOrigen == 1 ? "icono_exclamacion" : "exclamacion_icono_mobile" : tipoOrigen == 1 ? "icono_check_alerta" : "check_icono_mobile";
    
    SetHandlebars("#ofertaFinal-template", objOf, "#divOfertaFinal");
    $("#btnGuardarPedido").hide();

    $("#linkRegaloSorpresa").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        $('#ContentSorpresaMobile').toggle(effect, options, duration);
    });

    $("#btnRegresoOF").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        $('#ContentSorpresaMobile').toggle(effect, options, duration);
    });

    $("#btn_sigue_comprando_gana").click(function () {
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        $('#ContentSorpresaMobile').toggle(effect, options, duration);
    });    

    if (cumpleOferta.regaloOF != null) {
        ofertaFinalRegalo = cumpleOferta.regaloOF;
    }

    if (objOf.TipoMeta != 'MM') {
        if (esOfertaFinalRegalo) {
            if (ofertaFinalRegalo != null) {
                MostrarOfertaFinalRegalo(objOf.TotalPedido);
            GanoOfertaFinalRegalo(objOf.TotalPedido);
            }
        }
    }

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
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: 0%; top: 7%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png"/></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right:0%; top: 7%;"><img src="/Content/Images/mobile/Esika/next.png"/></a>'
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
            prevArrow: '<a class="previous_ofertas js-slick-prev-of" style="left:-5%;" ><img src="/Content/Images/Esika/previous_ofertas_home.png" style="width:100%; height:80px;" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas next js-slick-next-of" style="right:-5%; text-align:right;"><img src="/Content/Images/Esika/next.png" style="width:100%; height:80px;" alt="" /></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            of_google_analytics_producto_impresion_arrows(event, slick, currentSlide, nextSlide, tipoOrigen, objOf.TipoMeta, objOf.Detalle);
        });
    }
    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));    
    of_google_analytics_producto_impresion(tipoOrigen, objOf.TipoMeta,objOf.Detalle);
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
        if($("#id_btn_noGracias_agregarProductos").length > 0){
            $("#id_btn_noGracias_agregarProductos").css({ 'margen': "auto" });
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
            $('.popup_ofertaFinal').css({"padding-top":"0px"});
        }
        var gano = (totalPedido >= ofertaFinalRegalo.MontoMeta);
        $(container).find('#of-regalo-descripcion').text(ofertaFinalRegalo.Descripcion);
        $(container).find('#of-regalo-imagen').attr('src',ofertaFinalRegalo.RegaloImagenUrl);
        $(container).find('#of-regalo-descripcion-larga').text(ofertaFinalRegalo.RegaloDescripcion);

        if (gano) {
            $(container).find('#of-regalo-msg1').hide();
            $(container).find('#of-regalo-msg2').hide();
            $(container).find('#of-regalo-montos').hide();

            if (tipoOrigen == '1') {
                $('div.icono_regalo_sorpresa').css("background", "url(/Content/Images/gif-regalo-gano.gif)");
                $(container).find('#of-regalo-msg3').show();
            }
            else if (tipoOrigen == '2') {
                $('#ofIconoSuperior').removeClass("icono_alerta check_icono_mobile");
                $('#ofIconoSuperior').addClass("icono_alerta check_icono_mobile_gano");
                $('#linkRegaloSorpresa').removeClass("btn_regalo_sorpresa");
                $('#linkRegaloSorpresa').addClass("btn_regalo_sorpresa_gano");
                $('#linkRegaloSorpresa').html('MIRA <ins>AQUÍ</ins> TU PREMIO');                
            }
        }
        else {
            var saldo = (ofertaFinalRegalo.MontoMeta - totalPedido).toFixed(2);
            var simbolo = $("#hdSimbolo").val();
            var montoSaldo = simbolo + ' ' + DecimalToStringFormat(saldo);
            var montoMeta = simbolo + ' ' + ofertaFinalRegalo.FormatoMontoMeta;
            $(container).find('#of-regalo-montometa').text(montoMeta);
            $(container).find('#of-regalo-montosaldo').text(montoSaldo);
            $(container).find('#of-regalo-montos').show();
            $(container).find('#of-regalo-msg1').show();
            if (tipoOrigen == '2') {
                $('#ofIconoSuperior').removeClass("icono_alerta check_icono_mobile_gano");
                $('#ofIconoSuperior').addClass("icono_alerta check_icono_mobile");                
                $('#linkRegaloSorpresa').removeClass("btn_regalo_sorpresa_gano");
                $('#linkRegaloSorpresa').addClass("btn_regalo_sorpresa");
            }
        }
        if (tipoOrigen == '1') {
            $(container).show();
            //$('div.popup_ofertaFinal').addClass('fondo_gris_OF');
        }
    }
}

function GanoOfertaFinalRegalo(totalPedido) {
    var container = (tipoOrigen == '1') ? $('#container-of-regalo') : $('#ContentSorpresaMobile');
    if (container.length > 0) {
        var gano = (totalPedido >= ofertaFinalRegalo.MontoMeta);
        if (gano) {
            $(container).find('#of-regalo-msg1').hide();
            $(container).find('#of-regalo-montos').hide();
            $(container).find('#of-regalo-msg2').show();
            if (tipoOrigen == '1') {
                $('div.icono_regalo_sorpresa').css("background", "url(https://s3.amazonaws.com/uploads.hipchat.com/583104/4950260/B53SkTLWMCi37tU/gif-regalo-blanco.gif)");
                $("#spnTituloOfertaFinal span").html("SIGUE APROVECHANDO <b>LAS MEJORES OFERTAS</b><br />QUE TENEMOS PARA TI Y GANA MÁS");
                $("#msjOfertaFinal span").html("");
                $(container).find('#of-regalo-msg3').hide();
            }
            else if (tipoOrigen == '2') {
                $('#ofIconoSuperior').removeClass("icono_alerta check_icono_mobile");
                $('#ofIconoSuperior').addClass("icono_alerta check_icono_mobile_gano");
                
                $('#linkRegaloSorpresa').removeClass("btn_regalo_sorpresa");
                $('#linkRegaloSorpresa').addClass("btn_regalo_sorpresa_gano");
                $('#linkRegaloSorpresa').html('MIRA <ins>AQUÍ</ins> TU PREMIO');                
                $('div.icono_regalo_sorpresa').css("background", "url(https://s3.amazonaws.com/uploads.hipchat.com/583104/4950260/B53SkTLWMCi37tU/gif-regalo-blanco.gif)");
            }
        }
        else {
            var saldo = (ofertaFinalRegalo.MontoMeta - totalPedido).toFixed(2);
            var simbolo = $("#hdSimbolo").val();
            var montoSaldo = simbolo + ' ' + DecimalToStringFormat(saldo);
            $(container).find('#of-regalo-montosaldo').text(montoSaldo);
            $(container).find('#of-regalo-montos').show();
            $(container).find('#of-regalo-msg1').show();
        }
        if (tipoOrigen == '1') (container).show();
    } 
}

function ActulizarValoresPopupOfertaFinal(data, popup) {
    var tipoMeta = $("#divOfertaFinal div[data-meta]").attr("data-meta") || data.TipoMeta;
    var simbolo = $("#hdSimbolo").val();

    var metaMonto = $("#msjOfertaFinal").attr("data-meta-monto");
    if (isNaN(metaMonto)) metaMonto = 0;
    var metaTotal = $("#divOfertaFinal div[data-meta-total]").attr("data-meta-total");

    var ValoresOFR = GetValoresOfertaFinalRegalo(data);
    var minimo = 0;
    if (ValoresOFR != null) 
        minimo = ValoresOFR.minimo;

    if (consultoraRegaloPN == 'True') {
        var montoMeta = parseFloat(metaMonto) + parseFloat(metaTotal);
        mostrarMensajeRegaloPN(tipoMeta, data.total, montoMeta, simbolo, 2)
    }

    if (tipoMeta == "MM") {
        //var faltante = $("#msjOfertaFinal").attr("data-meta-monto");
        //var totalPedido = $("#divOfertaFinal div[data-meta-total]").attr("data-meta-total")
        //var montolimite = parseFloat(faltante) + parseFloat(totalPedido);
        var montolimite = parseFloat(metaMonto) + parseFloat(metaTotal);

        if (ValoresOFR != null)
            montolimite = minimo;
        
        if (parseFloat(data.total) >= montolimite) {
            var msj = tipoOrigen == "2" ? "Ahora tu ganancia estimada total es " : "Ahora tu ganancia estimada total es ";

            if (consultoraRegaloPN != 'True')
                $("#spnTituloOfertaFinal span").html("¡LLEGASTE AL <b>MONTO MÍNIMO!</b>");

            if (ValoresOFR != null) {
                if (ValoresOFR.meta > 0 && ValoresOFR.total > 0 && ValoresOFR.total >= ValoresOFR.meta) {
                    if (consultoraRegaloPN != 'True')
                        $("#spnTituloOfertaFinal span").html("FELICIDADES " + nombreConsultora + "</br><b>!GANASTE EL PREMIO!</b>");
                }
            }

            if (tipoOrigen == "1") {
                $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
            }

            //debugger;
            if (consultoraRegaloPN == 'True') {  // CASE 3,4,5
                var nivel = oRegaloPN.CodigoNivel;
                var sep = (tipoOrigen == 1) ? ' | ' : '<br />';
                if (nivel == '01' || nivel == '02' || nivel == '03') {
                    $("#msjOfertaFinal span").html('Monto Total de Pedido: ' + simbolo + ' ' + data.formatoTotal + sep + 'Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);
                }
                else {
                    if (tipoOrigen == 1)
                        $("#msjOfertaFinal span").html('Monto Total de Pedido: ' + simbolo + ' ' + data.formatoTotal + sep + 'Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);
                    else
                        $("#msjOfertaFinal span").html('Monto Total de Pedido: ' + simbolo + ' ' + data.formatoTotal);
                }
                $('#msjOfertaFinal span').css('display', 'inline-block');
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

            if (esOfertaFinalRegalo) {
                if (ofertaFinalRegalo != null) {
                    MostrarOfertaFinalRegalo(data.total);
                    GanoOfertaFinalRegalo(data.total);
                }
                else {
                    if (InsertarOfertaFinalRegalo()) {
                        ofertaFinalRegalo = ObtenerOfertaFinalRegalo();
                        if (ofertaFinalRegalo != null)
                            MostrarOfertaFinalRegalo(data.total);
                    }
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
        if (esOfertaFinalRegalo) {
            if (ValoresOFR != null) {
                if (ValoresOFR.total >= ValoresOFR.meta
                    && ValoresOFR.meta > 0
                    && ValoresOFR.total > 0)
                    $("#spnTituloOfertaFinal span").html("FELICIDADES " + nombreConsultora + "</br><b>!GANASTE EL PREMIO!</b>");
            }
            if (ofertaFinalRegalo != null) {
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
            var stp = (oRegaloPN.TippingPoint > 0) ? (parseFloat(oRegaloPN.TippingPoint) - parseFloat(data.total)) : 0;
            var disclaimer = '*En caso tu pedido no tenga observaciones y supere el monto mínimo.';

            if (nivel == '01' || nivel == '02' || nivel == '03') {
                // CASE 9
                var xmsg = '<b>AHORA TU MONTO TOTAL DE PEDIDO ES ' + simbolo + ' ' + data.formatoTotal + '</b>';
                $('#spnTituloOfertaFinal span').html(xmsg);
                $('#msjOfertaFinal span').html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);

                $('#msg-regalo-pn').css('display', 'none');
                $('#msg-regalo-pn2').css('display', 'none');
            }
            else {
                disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo, **Encuéntralos en la seccion de Oferta para Ti.';
                if (data.total >= oRegaloPN.TippingPoint) {
                    // CASE 11
                    var xmsg = '<b>AHORA TU MONTO TOTAL DE PEDIDO ES DE ' + simbolo + ' ' + data.formatoTotal + '</b>';
                    xmsg += '<br /><span style="font-weight: normal;font-size:16px;"><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    xmsg += ',AHORA PUEDES ACCEDER A PACKS EXCLUSIVOS NUEVAS**</span>';

                    $('#spnTituloOfertaFinal span').html(xmsg);
                    if (tipoOrigen == 1) $('#msjOfertaFinal span').html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);

                    $('#msg-regalo-pn').css('display', 'none');
                    $('#msg-regalo-pn2').css('display', 'none');
                }
                else {
                    // CASE 10
                    var xmsg = '<b>AHORA TU MONTO TOTAL DE PEDIDO ES DE ' + simbolo + ' ' + data.formatoTotal + '</b>';
                    $('#spnTituloOfertaFinal span').html(xmsg);
                    if (tipoOrigen == 1) ("#msjOfertaFinal span").html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);

                    xmsg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    xmsg2 += 'Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';

                    $('#msg-regalo-pn').html(xmsg2);
                    $('#msg-regalo-pn2').html(xmsg2);                    
                }
            }
            $('#txt-disclaimer-pn').html(disclaimer);
        }
        else
            $("#spnTituloOfertaFinal span").html("¡AHORA TU <b>GANANCIA ESTIMADA ES " + simbolo + " " + data.DataBarra.MontoGananciaStr + "!</b>");

        if (tipoOrigen == "1") {
            $("#msjOfertaFinal").attr("class", "ganancia_total_pop");
        }
        //if (consultoraRegaloPN == 'True')
        //    $("#msjOfertaFinal span").html('Ganancia Estimada Total: ' + simbolo + ' ' + data.DataBarra.MontoGananciaStr);
        //else
        //    $("#msjOfertaFinal span").html("Monto total: " + simbolo + " " + data.formatoTotal);
        agregoOfertaFinal = 1;
    }
    else {
        var faltante = $("#msjOfertaFinal").attr("data-meta-monto");
        //var totalPedido = $("#divOfertaFinal > div").attr("data-meta-total");
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
    //debugger;
    if (oRegaloPN == null)
        oRegaloPN = GetRegaloProgramaNuevas();

    if (oRegaloPN != null) {
        var msg = '', msg2 = '';
        var nivel = oRegaloPN.CodigoNivel;
        var montoMeta = (flag == 1) ? parseFloat(montoTotal) + parseFloat(montoSaldo) : montoSaldo;
        var disclaimer = '*En caso tu pedido no tenga observaciones y supere el monto mínimo.';
        var stp = (oRegaloPN.TippingPoint > 0) ? (parseFloat(oRegaloPN.TippingPoint) - parseFloat(montoTotal)) : 0;
        var sep = (tipoOrigen == 1) ? ' ' : '<br />';
        var showDiv = true;
        $('#msjOfertaFinal span').css('display', 'none');
        $('#msjOfertaFinal span').css('margin-top', '0');
        $('#msg-regalo-pn').css('display', 'none');
        $('#msg-regalo-pn2').css('display', 'none');
        $('#div-regalo-pn').css('display', 'none');
        //$('#div-regalo-pn').css('margin-top', '0px;');

        if (tipoMeta == 'MM') {
            if (montoTotal >= montoMeta) {
                if (nivel == '01' || nivel == '02' || nivel == '03') {
                    // CASE 3
                    msg = '<b>¡LLEGASTE AL MONTO MÍNIMO</b>';
                    msg += '<br /><span><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*!</b></span>';

                    $('#spnTituloOfertaFinal span').html(msg);
                    showDiv = false;
                }
                else {
                    disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep + '**Encuéntralos en la seccion de Oferta para Ti.';
                    if (montoTotal >= oRegaloPN.TippingPoint) {
                        // CASE 5
                        msg = '<b>¡LLEGASTE AL MONTO MÍNIMO!</b>';
                        msg += '<br /><span style="font-weight: normal;font-size:16px;"><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                        msg += ',AHORA PUEDES ACCEDER A PACKS EXCLUSIVOS NUEVAS**</span>';

                        $('#spnTituloOfertaFinal span').html(msg);
                        $('#msjOfertaFinal span').css('margin-top', '20px');
                        showDiv = false;
                    }
                    else {
                        // CASE 4
                        msg = '<b>¡LLEGASTE AL MONTO MÍNIMO!</b>';
                        msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                        msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';

                        $('#spnTituloOfertaFinal span').html(msg);
                        $('#msg-regalo-pn').html(msg2);
                        $('#msg-regalo-pn2').html(msg2);

                        $('#msg-regalo-pn').css('display', 'inline-block');
                        $('#msg-regalo-pn2').css('display', 'inline-block');
                        $('#msg-regalo-pn2').css('margin-top', '20px');
                    }
                }
            }
            else {
                if (nivel == '01' || nivel == '02' || nivel == '03') {
                    // CASE 1
                    msg2 = 'ALCÁNZALO CON ESTAS OFERTAS Y <b>GANA UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    if (oRegaloPN.Valorizado > 0)
                        msg2 += ',PUEDES VENDERLO A ' + simbolo + ' ' + oRegaloPN.PrecioValorizadoFormat;

                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);
                }
                else {
                    // CASE 2
                    disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep + '**Encuéntralos en la seccion de Oferta para Ti.';
                    msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS**';

                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);
                }

                $('#msg-regalo-pn').css('display', 'inline-block');
                $('#msg-regalo-pn2').css('display', 'inline-block');
            }
        }
        else if (tipoMeta == 'GM') {
            if (nivel == '01' || nivel == '02' || nivel == '03') {
                // CASE 6
                msg = '<b>¡GUARDASTE TU PEDIDO CON ÉXITO</b>';
                msg += '<br /><span><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*!</b></span>';
                msg2 = (tipoOrigen == 1) ? 'APROVECHA ESTAS OFERTAS Y <b>GANA MÁS</b> ESTA CAMPAÑA' : 'APROVECHA ESTAS OFERTAS';

                $('#spnTituloOfertaFinal span').html(msg);
                $('#msg-regalo-pn').html(msg2);
                $('#msg-regalo-pn2').html(msg2);

                $('#msg-regalo-pn').css('display', 'inline-block');
                $('#msg-regalo-pn2').css('display', 'inline-block');
                showDiv = false;
            }
            else {
                disclaimer = '*En caso tu pedido no tenga observaciones y supere monto mínimo.' + sep + '**Encuéntralos en la seccion de Oferta para Ti.';
                if (montoTotal >= oRegaloPN.TippingPoint) {
                    // CASE 8
                    msg = '<b>¡GUARDASTE TU PEDIDO CON ÉXITO!</b>';
                    msg += '<br /><span style="font-weight: normal;font-size:16px;"><b>Y GANASTE UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg += ',AHORA PUEDES ACCEDER A PACKS EXCLUSIVOS NUEVAS**</span>';

                    $('#spnTituloOfertaFinal span').html(msg);
                    
                    if (tipoOrigen == 1)
                        $('#msjOfertaFinal span').html('Monto Total de Pedido: ' + simbolo + ' ' + dataBarra.TotalPedidoStr + ' | ' + 'Ganancia Estimada Total: ' + simbolo + ' ' + dataBarra.MontoGananciaStr);
                    else
                        $('#msjOfertaFinal span').html('Monto Total de Pedido: ' + simbolo + ' ' + montoTotal);

                    $('#msjOfertaFinal span').css('display', 'inline-block');
                    $('#msjOfertaFinal span').css('margin-top', '20px');
                    showDiv = false;
                }
                else {
                   // CASE 7
                    msg = '<b>¡GUARDASTE TU PEDIDO CON ÉXITO!</b>';
                    msg2 = 'AGREGA ' + simbolo + ' ' + DecimalToStringFormat(stp) + ' PARA <b>GANAR UN ' + oRegaloPN.DescripcionPremio + '*</b>';
                    msg2 += ' Y ACCEDER A PACKS EXCLUSIVOS NUEVAS** ¡APROVECHA ESTAS OFERTAS!';

                    $('#spnTituloOfertaFinal span').html(msg);
                    $('#msg-regalo-pn').html(msg2);
                    $('#msg-regalo-pn2').html(msg2);

                    $('#msg-regalo-pn').css('display', 'inline-block');
                    $('#msg-regalo-pn2').css('display', 'inline-block');
                }
            }
        }

        //$('#msjOfertaFinal').html('');
        $('#numero-pd').text(parseInt(nivel));
        $('#posicion-pd').text(getAbrevNumPedido(parseInt(nivel)));

        //$('#img-regalo-pn').hide();
        if (oRegaloPN.UrlImagenRegalo !== null && oRegaloPN.UrlImagenRegalo !== "") {
            $('#img-regalo-pn').attr('src', oRegaloPN.UrlImagenRegalo);
            //$('#img-regalo-pn').show();
        }
        //else {
        //    $('#msg-regalo-pn').css('padding-top', '15px');
        //}

        //$('#msg-regalo-pn').html(mensaje);
        //$('#msg-regalo-pn2').html(mensaje);   // mobile

        if (disclaimer !== "")
            $('#txt-disclaimer-pn').html(disclaimer);

        if (showDiv) $('#div-regalo-pn').show();
        $('#txt-disclaimer-pn').show();
        //$('div.popup_ofertaFinal').addClass('fondo_gris_OF');
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
    var productosMostrar = new Array();
    var montoFaltante = 0;
    var porcentajeDescuento = 0;
    var tipoMeta = 0;
    var regaloOF = null;

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
            //resultado = codigoMensajeProl == "00";
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
            //bug EPD-2365
            if (productoOfertaFinal.lista.length != 0) {
                tipoMeta = productoOfertaFinal.lista[0].TipoMeta;
                if (esOfertaFinalRegalo) {
                    regaloOF = ObtenerOfertaFinalRegalo();
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
        regaloOF: regaloOF
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

function ObtenerOfertaFinalRegalo() {
    var regalo = null;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerOfertaFinalRegalo',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        //data: '',
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    regalo = response.data;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.log(error);
            }
        }
    });

    return regalo;
}

function InsertarOfertaFinalRegalo() {
    var isOk = false;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarOfertaFinalRegalo',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        //data: '',
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    isOk = true;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.log(error);
            }
        }
    });

    return isOk;
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
            if (!checkTimeout(response)) {
                return false;
            }
            if (response.success) {
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

function GetValoresOfertaFinalRegalo(data) {
    var total = parseFloat(data.total);
    var minimo = parseFloat($("#hdMontoMinimo").val());    
    var tipo = "MM";
    var meta = 0;

    if (ofertaFinalRegalo != null)
        meta = ofertaFinalRegalo.MontoMeta;
   
    if (ofertaFinalAlgoritmo === "OFR" && tipoOrigen === "2") {
        if (total >= minimo && minimo > 0 && total > 0)
        {
            tipo = "RG";
            if (total >= meta && meta > 0 && total > 0)
                tipo = "GM";
        }
        else
            tipo = "MM";

        return  {
            tipo: tipo,
            minimo: minimo,
            total: total,
            meta: meta
            };
    }
    else
        return null;
}