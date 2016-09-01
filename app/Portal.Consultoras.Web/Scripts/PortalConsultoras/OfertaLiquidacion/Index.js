var cantidadItemPagina = 12;
var cantidadItemMostrarInicio = 12;
var posicionFinalMostrada = 0;
var cantidadRegistros = 12;
var offset = 0;
var puedeCargar = true;

$(document).ready(function () {
    HorarioRestringido();
    IniDialog();

    $(document).on('click', '#boton_vermas', function () {
        puedeCargar = false;
        CargarOfertasLiquidacion();
    });
    $(window).scroll(function () {
        if ($(this).scrollTop() > 70) {
            $('.productos_fixed').addClass("fixed");
        } else {
            $('.productos_fixed').removeClass("fixed");
        }
    });
    $(document).on('change', '.js-select_tallacolor', function () {

        $(this).parents('.Content_modal_ZE').find('.CUV').attr("value", $("option:selected", this).attr("value"));
        $(this).parents('.Content_modal_ZE').find('.pedidos_datos_info').html($("option:selected", this).attr("desc-talla"));
        $(this).parents('.Content_modal_ZE').find('.liquidacion_precio').html('<span>' + $("option:selected", this).attr("desc-precio") + '</span>'); //2024
        $(this).parents('.Content_modal_ZE').find(".DescripcionProd").attr("value", $("option:selected", this).attr("desc-talla")); //2024
        $(this).parents('.Content_modal_ZE').find(".PrecioOferta").attr("value", $("option:selected", this).attr("precio-real")); //2024

        var spanStock = $(this).parents('.Content_modal_ZE').find('.span_stock');
        var HiddenStock = $(this).parents('.Content_modal_ZE').find(".Stock");
        var CUV = $(this).parents('.Content_modal_ZE').find(".CUV").attr("value");
        //r20160216
        //var Orden = $(this).parent().parent().parent().parent().find(".Oden").attr("value"); ???
        $.ajaxSetup({
            cache: false
        });
        waitingDialog({});
        $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
            $(spanStock).text(data.Stock);
            $(HiddenStock).val(data.Stock);
            closeWaitingDialog();
        });

    });

    $('.ValidaNumeralOferta').live('keyup', function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });

    $('.ValidaNumeralOferta').live('keypress', function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $("#btnVerPedido").click(function () {
        _gaq.push(['_trackEvent', 'Liquidacion-Web', 'Ver-Pedido']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Liquidacion-Web/Ver-Pedido'
        });
        location.href = baseUrl + 'Pedido/Index';
    });

    $('.ValidaNumeralOferta').keypress(function (e) {
        if (e.which == 13) {
            var object = $(this).parent().find(".boton_liquidacion");
            var estado = $(this).parent().find(".boton_liquidacion")[0].disabled;
            if (!estado)
                AgregarOfertaProducto(object, 0);
        }
    });

    $(document).on('click', '.js-boton_tonotalla', function () {
        var contenedor = $(this).parent().parent();
        var objProducto = {
            imagenProducto: $(contenedor).find('.imagenpop').attr('src'),
            tituloMarca: $(contenedor).find('.liquidacion_titulo_item').text(),
            descripcion: $(contenedor).find('.liquidacion_descripcion').text(),
            precio: $(contenedor).find('.liquidacion_precio').text(),
            tonosTallas: $(contenedor).find('#tonostallas').attr('data-array-tonostallas')
        };
        var objHidden = {
            TipoOfertaSisID: $(contenedor).find('.TipoOfertaSisID').val(),
            OfertaProductoID: $(contenedor).find('.OfertaProductoID').val(),
            ConfiguracionOfertaID: $(contenedor).find('.ConfiguracionOfertaID').val(),
            MarcaID: $(contenedor).find('.MarcaID').val(),
            CUV: $(contenedor).find('.CUV').val(),
            PrecioOferta: $(contenedor).find('.PrecioOferta').val(),
            Stock: $(contenedor).find('.Stock').val(),
            DescripcionProd: $(contenedor).find('.DescripcionProd').val(),
            DescripcionMarca: $(contenedor).find('.DescripcionMarca').val(),
            DescripcionCategoria: $(contenedor).find('.DescripcionCategoria').val(),
            DescripcionEstrategia: $(contenedor).find('.DescripcionEstrategia').val()
        };

        cargarProductoPopup(objProducto, objHidden);
    });

    $(document).on('click', ".js-boton_agregar_popup", function () {
        _gaq.push(['_trackEvent', 'Liquidacion-Web', 'Agregar-Liquidacion']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Liquidacion-Web/Agregar-Liquidacion'
        });
        var contenedor = $(this).parents('#divVistaPrevia');

        var txtCantidad = $(contenedor).find("#txtCantidadPopup");
        var Cantidad = $(contenedor).find("#txtCantidadPopup")[0].value;
        var OfertaProductoID = $(contenedor).find(".OfertaProductoID")[0].value;
        var div = "Agregado";
        var TipoOfertaID = $(contenedor).find(".TipoOfertaSisID")[0].value;
        var ConfiguracionOfertaID = $(contenedor).find(".ConfiguracionOfertaID")[0].value;
        var MarcaID = $(contenedor).find(".MarcaID")[0].value;
        var CUV = $(contenedor).find(".CUV")[0].value;
        var PrecioUnidad = $(contenedor).find(".PrecioOferta")[0].value;
        var Stock = $(contenedor).find(".Stock")[0].value;
        var lblStock = $(contenedor).find(".spStock");
        var HiddenStock = $(contenedor).find("input.Stock");
        var DescripcionProd = $(contenedor).find(".DescripcionProd")[0].value;
        var DescripcionMarca = $(contenedor).find(".DescripcionMarca")[0].value;
        var DescripcionCategoria = $(contenedor).find(".DescripcionCategoria")[0].value;
        var DescripcionEstrategia = $(contenedor).find(".DescripcionEstrategia")[0].value;
        var imagenProducto = $(contenedor).find(".Content_modal_ZE img").attr("src");

        if (Cantidad == "" || Cantidad == 0) {
            alert_msg("La cantidad ingresada debe ser mayor que 0, verifique.");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            return false;
        } else {
            $($(this).parent().parent().find(".ValidaNumeralOfertaAnterior")).val(Cantidad);
            var Item = {
                MarcaID: MarcaID,
                Cantidad: Cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID
            };
            waitingDialog({});
            $.ajaxSetup({
                cache: false
            });

            $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
                if (parseInt(data.Saldo) < parseInt(Cantidad)) {
                    var Saldo = data.Saldo;
                    var UnidadesPermitidas = data.UnidadesPermitidas;
                    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                        $(Stock).text(data.Stock);
                        $(Stock).val(data.Stock);
                        if (Saldo == UnidadesPermitidas)
                            alert_msg("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                        else {
                            if (Saldo == "0")
                                alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                            else
                                alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                        }
                        closeWaitingDialog();
                        return false;
                    });
                } else {
                    $.ajaxSetup({
                        cache: false
                    });
                    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                        $(Stock).text(data.Stock);
                        $(Stock).val(data.Stock);
                        if (parseInt(data.Stock) < parseInt(Cantidad)) {
                            alert_msg("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.");
                            closeWaitingDialog();
                            return false;
                        }
                        else {

                            jQuery.ajax({
                                type: 'POST',
                                url: baseUrl + 'OfertaLiquidacion/InsertOfertaWebPortal',
                                dataType: 'json',
                                contentType: 'application/json; charset=utf-8',
                                data: JSON.stringify(Item),
                                async: true,
                                success: function (data) {
                                    if (data.success == true) {
                                        $(this).attr('disabled', true);
                                        //$(this).parent().parent().parent().parent().find(".ddlTallaColor").attr('disabled', true);
                                        $(this).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);
                                        $(div).css('display', 'block');
                                        //$("#hdFlagOferta").val("1");
                                        //$("#hdFlagOfertaLiquidacion").val("1");
                                        $(lblStock).text(parseInt(Stock - Cantidad));
                                        $(HiddenStock).val(parseInt(Stock - Cantidad));
                                        $(txtCantidad).val(1);
                                        InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia);
                                        CargarResumenCampaniaHeader(true);
                                        TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                                        $('#divVistaPrevia').dialog('close');
                                    }
                                    else {
                                        alert_msg(data.message);
                                    }
                                    closeWaitingDialog();
                                },
                                error: function (data, error) {
                                    if (checkTimeout(data)) {
                                        alert_msg(data.message);
                                        closeWaitingDialog();
                                    }
                                }
                            });

                        }
                    });
                }
            });
        }
    });

    $(document).on('click', ".js-boton_liquidacion", function () {
        _gaq.push(['_trackEvent', 'Liquidacion-Web', 'Agregar-Liquidacion']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Liquidacion-Web/Agregar-Liquidacion'
        });
        var txtCantidad = $(this).parents('.liquidacion_item').find(".txtCantidad");
        var Cantidad = $(this).parents('.liquidacion_item').find(".txtCantidad")[0].value;
        var OfertaProductoID = $(this).parents('.liquidacion_item').find(".OfertaProductoID")[0].value;
        var div = "Agregado";
        var TipoOfertaID = $(this).parents('.liquidacion_item').find(".TipoOfertaSisID")[0].value;
        var ConfiguracionOfertaID = $(this).parents('.liquidacion_item').find(".ConfiguracionOfertaID")[0].value;
        var MarcaID = $(this).parents('.liquidacion_item').find(".MarcaID")[0].value;
        var CUV = $(this).parents('.liquidacion_item').find(".CUV")[0].value;
        var PrecioUnidad = $(this).parents('.liquidacion_item').find(".PrecioOferta")[0].value;
        var Stock = $(this).parents('.liquidacion_item').find(".Stock")[0].value;
        var lblStock = $(this).parent().find(".spStock");
        var HiddenStock = $(this).parent().find("input.Stock");
        var DescripcionProd = $(this).parents('.liquidacion_item').find(".DescripcionProd")[0].value;
        var DescripcionMarca = $(this).parents('.liquidacion_item').find(".DescripcionMarca")[0].value;
        var DescripcionCategoria = $(this).parents('.liquidacion_item').find(".DescripcionCategoria")[0].value;
        var DescripcionEstrategia = $(this).parents('.liquidacion_item').find(".DescripcionEstrategia")[0].value;
        var imagenProducto = $(this).parents('.liquidacion_item').find(".liquidacion_imagen img").attr("src");

        if (Cantidad == "" || Cantidad == 0) {
            alert_msg("La cantidad ingresada debe ser mayor que 0, verifique.");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            return false;
        }
        else {
            $($(this).parent().parent().find(".ValidaNumeralOfertaAnterior")).val(Cantidad);
            var Item = {
                MarcaID: MarcaID,
                Cantidad: Cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID
            };
            waitingDialog({});
            $.ajaxSetup({
                cache: false
            });

            $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
                if (parseInt(data.Saldo) < parseInt(Cantidad)) {
                    var Saldo = data.Saldo;
                    var UnidadesPermitidas = data.UnidadesPermitidas;
                    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                        $(Stock).text(data.Stock);
                        $(Stock).val(data.Stock);
                        if (Saldo == UnidadesPermitidas)
                            alert_msg("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                        else {
                            if (Saldo == "0")
                                alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                            else
                                alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                        }
                        closeWaitingDialog();
                        return false;
                    });
                } else {
                    $.ajaxSetup({
                        cache: false
                    });
                    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                        $(Stock).text(data.Stock);
                        $(Stock).val(data.Stock);
                        if (parseInt(data.Stock) < parseInt(Cantidad)) {
                            alert_msg("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.");
                            closeWaitingDialog();
                            return false;
                        }
                        else {

                            jQuery.ajax({
                                type: 'POST',
                                url: baseUrl + 'OfertaLiquidacion/InsertOfertaWebPortal',
                                dataType: 'json',
                                contentType: 'application/json; charset=utf-8',
                                data: JSON.stringify(Item),
                                async: true,
                                success: function (data) {
                                    if (data.success == true) {
                                        $(this).attr('disabled', true);
                                        $(this).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);
                                        $(div).css('display', 'block');
                                        $(lblStock).text(parseInt(Stock - Cantidad));
                                        $(HiddenStock).val(parseInt(Stock - Cantidad));
                                        $(txtCantidad).val(1);
                                        InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia);
                                        CargarResumenCampaniaHeader(true);
                                        TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                                        ActualizarGanancia(data.DataBarra);
                                    }
                                    else {
                                        alert_msg(data.message);
                                    }
                                    closeWaitingDialog();
                                },
                                error: function (data, error) {
                                    if (checkTimeout(data)) {
                                        alert_msg(data.message);
                                        closeWaitingDialog();
                                    }
                                }
                            });

                        }
                    });
                }
            });
        }
    });
    
});

function CargarOfertasLiquidacion() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertaLiquidacion/JsonGetOfertasLiquidacion',
        data: { offset: offset, cantidadregistros: cantidadRegistros, origen: 'OfertaLiquidacion' },
        dataType: 'json',
        beforeSend: function () {
            $('#loader').show();
            $('#boton_vermas').hide();
        },
        contentType: 'application/json; charset=utf-8',
        success: function (data) {                    
            ArmarCarouselLiquidaciones(data.lista);
            if (data.verMas == true) {
                $('#boton_vermas').show();
            }           
            offset += cantidadRegistros;
        },
        complete: function (data) {
            $('#loader').hide();           
            puedeCargar = true;
        },
        error: function () {
            puedeCargar = true;
            $('#boton_vermas').show();
            $('#loader').hide();
        }
    });
};
function ArmarCarouselLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#OfertasLiquidacion-template", data);
    $('#htmlListado').append(htmlDiv);
};
function EstructurarDataCarouselLiquidaciones(array) {
    var contadorLq = 1;
    $.each(array, function (i, item) {
        item.Descripcion = (item.Descripcion.length > 159 ? item.Descripcion.substring(0,159) + "..." : item.Descripcion);
        item.Posicion = contadorLq;
               
        if (item.TallaColor.length > 2 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TallaColor = "";
            item.TieneTallaColor = false;
        };
        contadorLq++;
    });

    return array;
};

function cargarProductoPopup(objProducto, objHidden) {
    waitingDialog({});

    var divVistaPrevia = $("#divVistaPrevia");
    var arrayTonosTallas = objProducto.tonosTallas.split("@");
    var option = '';

    for (var i = 0; i < arrayTonosTallas.length - 1; i++) {

        var strOption = arrayTonosTallas[i].split("|");
        var strCuv = strOption[0];
        var strDescCuv = strOption[1];
        var strDescTalla = strOption[2];
        var strDescPrecio = Number(strOption[3]).toFixed(2);
        var strPrecioReal = strOption[3];

        option += '<option value="' + strCuv + '"' +
                  'desc-talla="' + strDescCuv + '"' +
                  'desc-precio="' + strDescPrecio + '"' +
                  'precio-real="' + strPrecioReal + '"' +
                  '>' + strDescTalla + '</option>';

    };
    $(divVistaPrevia).find('#ddlTallaColor').html(option);

    $(divVistaPrevia).find('#imgZonaEstrategiaEdit').attr('src', objProducto.imagenProducto);
    $(divVistaPrevia).find('.pedidos_datos_titulo').text(objProducto.tituloMarca);
    $(divVistaPrevia).find('.pedidos_datos_info').text(objProducto.descripcion);
    $(divVistaPrevia).find('.liquidacion_precio').html('<span>' + objProducto.precio + '</span>');
    $(divVistaPrevia).find('.span_stock').html(objHidden.Stock);

    //Seteo valores de inputs hidden
    $(divVistaPrevia).find('.TipoOfertaSisID').val(objHidden.TipoOfertaSisID);
    $(divVistaPrevia).find('.OfertaProductoID').val(objHidden.OfertaProductoID);
    $(divVistaPrevia).find('.ConfiguracionOfertaID').val(objHidden.ConfiguracionOfertaID);
    $(divVistaPrevia).find('.MarcaID').val(objHidden.MarcaID);
    $(divVistaPrevia).find('.CUV').val(objHidden.CUV);
    $(divVistaPrevia).find('.PrecioOferta').val(objHidden.PrecioOferta);
    $(divVistaPrevia).find('.Stock').val(objHidden.Stock);
    $(divVistaPrevia).find('.DescripcionProd').val(objHidden.DescripcionProd);
    $(divVistaPrevia).find('.DescripcionMarca').val(objHidden.DescripcionMarca);
    $(divVistaPrevia).find('.DescripcionCategoria').val(objHidden.DescripcionCategoria);
    $(divVistaPrevia).find('.DescripcionEstrategia').val(objHidden.DescripcionEstrategia);

    $(divVistaPrevia).find('#txtCantidadPopup').val(1);
    $(divVistaPrevia).css({ "background-color": "#FFF" });

    var spanStock = $(divVistaPrevia).find('.span_stock');
    var HiddenStock = $(divVistaPrevia).find(".Stock");
    var CUV = $(divVistaPrevia).find(".CUV").attr("value");

    $.ajaxSetup({
        cache: false
    });

    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
        $(spanStock).text(data.Stock);
        $(HiddenStock).val(data.Stock);
        closeWaitingDialog();
        showDialog('divVistaPrevia');
        $(divVistaPrevia).find('#txtCantidadPopup').blur();
    });
};
function HorarioRestringido() {
    waitingDialog({});
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/EnHorarioRestringido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    alert_msgHorario(data.message);
                    horarioRestringido = true;
                    setTimeout(function () { location.href = baseUrl + 'Bienvenida/Index'; }, 2500);
                } else {
                    $('#loader').show();
                    CargarOfertasLiquidacion();
                }
            }
            closeWaitingDialog();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                alert(data.message);
            };
            closeWaitingDialog();
        }
    });
};
function IniDialog() {
    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    $('#DialogMensajeProducto').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true
    });

    $('#DialogMensajesBanner').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        title: ":: Mensaje ::",
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    $('#DialogMensajeHorario').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
        title: ":: Mensaje ::",
        open: function (event, ui) { $(".ui-dialog-titlebar-close").hide(); },
        buttons:
        {
            "Aceptar": function () {
                location.href = baseUrl + 'Bienvenida/Index';
            }
        }
    });

    $('#divVistaPrevia').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 350,
        draggable: false,
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        }
    });
};
function alert_msg(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}
function alert_msgHorario(message) {
    $('#DialogMensajeHorario .message_text').html(message);
    $('#DialogMensajeHorario').dialog('open');
};
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant) {
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") { variant = "Estándar"; }
        if (Categoria == null || Categoria == "") { Categoria = "Sin Categoría"; }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': 'Liquidación Web' },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': 1
                    }]
                }
            }
        })
    }
};
function CerrarProductoAgregado() {
    $('#pop_liquidacion').hide();
};