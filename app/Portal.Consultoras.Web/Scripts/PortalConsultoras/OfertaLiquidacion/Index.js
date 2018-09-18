var cantidadRegistros = 12;
var offsetRegistros = 0;
var cargandoRegistros = false;
var modelLiquidacionOfertas;
var labelAgregadoLiquidacion;

$(document).ready(function () {
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
        $(this).parents('.Content_modal_ZE').find('.liquidacion_precio').html('<span>' + $("option:selected", this).attr("desc-precio") + '</span>');
        $(this).parents('.Content_modal_ZE').find(".DescripcionProd").attr("value", $("option:selected", this).attr("desc-talla"));
        $(this).parents('.Content_modal_ZE').find(".PrecioOferta").attr("value", $("option:selected", this).attr("precio-real"));

        var spanStock = $(this).parents('.Content_modal_ZE').find('.span_stock');
        var HiddenStock = $(this).parents('.Content_modal_ZE').find(".Stock");
        var CUV = $(this).parents('.Content_modal_ZE').find(".CUV").attr("value");

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
        if (ReservadoOEnHorarioRestringido())
            return false;

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
        if (ReservadoOEnHorarioRestringido())
            return false;
        var contenedor = $(this).parents('#divVistaPrevia');

        var txtCantidad = $(contenedor).find("#txtCantidadPopup");
        var Cantidad = $(contenedor).find("#txtCantidadPopup")[0].value;
        var div = "Agregado";
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

        if (Cantidad == "" || Cantidad == 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.", "LO SENTIMOS");
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

            $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV, Cantidad: Cantidad, PrecioUnidad: PrecioUnidad }, function (data) {
                if (data.message != "") { /*Validación Pedido Máximo*/
                    closeWaitingDialog();
                    AbrirMensaje(data.message);
                    return false;
                }
                if (parseInt(data.Saldo) < parseInt(Cantidad)) {
                    var Saldo = data.Saldo;
                    var UnidadesPermitidas = data.UnidadesPermitidas;
                    $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                        $(Stock).text(data.Stock);
                        $(Stock).val(data.Stock);
                        if (Saldo == UnidadesPermitidas)
                            AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.", "LO SENTIMOS");
                        else {
                            if (Saldo == "0")
                                AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.", "LO SENTIMOS");
                            else
                                AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.", "LO SENTIMOS");
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
                            AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.", "LO SENTIMOS");
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
                                    if (!checkTimeout(data)) {
                                        closeWaitingDialog();
                                        return false;
                                    }

                                    if (data.success != true) {
                                        messageInfoError(data.message);
                                        closeWaitingDialog();
                                        return false;
                                    }

                                    $(this).attr('disabled', true);

                                    $(this).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);
                                    $(div).css('display', 'block');

                                    $(lblStock).text(parseInt(Stock - Cantidad));
                                    $(HiddenStock).val(parseInt(Stock - Cantidad));
                                    $(txtCantidad).val(1);
                                    InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia, 1);
                                    CargarResumenCampaniaHeader(true);
                                    TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                                    $('#divVistaPrevia').dialog('close');

                                    closeWaitingDialog();
                                },
                                error: function (data, error) {
                                    closeWaitingDialog();
                                }
                            });

                        }
                    });
                }
            });
        }
    });

    $(document).on('click', ".js-boton_liquidacion", RegistrarProductoOferta);

    Inicializar();
});

function RegistrarProductoOferta(e) {
    e.preventDefault();

    var origenPedidoLiquidaciones;
    var Cantidad;
    var ConfiguracionOfertaID;
    var MarcaID;
    var CUV;
    var PrecioUnidad;
    var DescripcionProd;
    var DescripcionEstrategia;

    if (ReservadoOEnHorarioRestringido())
        return false;

    if (modelLiquidacionOfertas) {
        Cantidad = modelLiquidacionOfertas.Cantidad;
        ConfiguracionOfertaID = modelLiquidacionOfertas.ConfiguracionOfertaID;
        MarcaID = modelLiquidacionOfertas.MarcaID;
        CUV = modelLiquidacionOfertas.CUV;
        PrecioUnidad = modelLiquidacionOfertas.PrecioUnidad;
        DescripcionProd = modelLiquidacionOfertas.DescripcionProd;
        DescripcionEstrategia = modelLiquidacionOfertas.DescripcionEstrategia;
        origenPedidoLiquidaciones = modelLiquidacionOfertas.origenPedidoLiquidaciones;

    } else {
        agregarProductoAlCarrito(this);
        var txtCantidad = $(this).parents('.liquidacion_item').find(".txtCantidad");
        var div = "Agregado";
        var Stock = $(this).parents('.liquidacion_item').find(".Stock")[0].value;
        var lblStock = $(this).parent().find(".spStock");
        var HiddenStock = $(this).parent().find("input.Stock");
        var DescripcionMarca = $(this).parents('.liquidacion_item').find(".DescripcionMarca")[0].value;
        var DescripcionCategoria = $(this).parents('.liquidacion_item').find(".DescripcionCategoria")[0].value;
        var posicion = parseInt($(this).parents('.liquidacion_item').attr('data-idposicion'));
        Cantidad = $(this).parents('.liquidacion_item').find(".txtCantidad")[0].value;
        ConfiguracionOfertaID = $(this).parents('.liquidacion_item').find(".ConfiguracionOfertaID")[0].value;
        MarcaID = $(this).parents('.liquidacion_item').find(".MarcaID")[0].value;
        CUV = $(this).parents('.liquidacion_item').find(".CUV")[0].value;
        PrecioUnidad = $(this).parents('.liquidacion_item').find(".PrecioOferta")[0].value;
        DescripcionProd = $(this).parents('.liquidacion_item').find(".DescripcionProd")[0].value;
        DescripcionEstrategia = $(this).parents('.liquidacion_item').find(".DescripcionEstrategia")[0].value;
        origenPedidoLiquidaciones = DesktopLiquidacion;
    }

    console.log('origenPedidoLiquidaciones', origenPedidoLiquidaciones);

    if (Cantidad == "" || Cantidad == 0) {
        AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.", "LO SENTIMOS");
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
            ConfiguracionOfertaID: ConfiguracionOfertaID,
            OrigenPedidoWeb: origenPedidoLiquidaciones
        };

        AbrirLoad();
        $.ajaxSetup({
            cache: false
        });

        $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV, Cantidad: Cantidad, PrecioUnidad: PrecioUnidad }, function (data) {
            if (data.message != "") { /*Validación Pedido Máximo*/
                closeWaitingDialog();
                AbrirMensaje(data.message);
                modelLiquidacionOfertas = undefined;
                return false;
            }
            if (parseInt(data.Saldo) < parseInt(Cantidad)) {
                var Saldo = data.Saldo;
                var UnidadesPermitidas = data.UnidadesPermitidas;
                $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: CUV }, function (data) {
                    $(Stock).text(data.Stock);
                    $(Stock).val(data.Stock);
                    if (Saldo == UnidadesPermitidas)
                        AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.", "LO SENTIMOS");
                    else {
                        if (Saldo == "0")
                            AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.", "LO SENTIMOS");
                        else
                            AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.", "LO SENTIMOS");
                    }
                    CerrarLoad();   
                    modelLiquidacionOfertas = undefined;
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
                        AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.", "LO SENTIMOS");
                        CerrarLoad();   
                        modelLiquidacionOfertas = undefined;
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
                                if (!checkTimeout(data)) {
                                    CerrarLoad();   
                                    modelLiquidacionOfertas = undefined;
                                    return false;
                                }

                                if (data.success != true) {
                                    messageInfoError(data.message);
                                    CerrarLoad();   
                                    modelLiquidacionOfertas = undefined;
                                    return false;
                                }

                                $(this).attr('disabled', true);
                                $(this).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);
                                $(div).css('display', 'block');
                                $(lblStock).text(parseInt(Stock - Cantidad));
                                $(HiddenStock).val(parseInt(Stock - Cantidad));
                                $(txtCantidad).val(1);
                                InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia, posicion);

                                if (!isMobile()) {
                                    CargarResumenCampaniaHeader(true);
                                    TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);

                                    ActualizarGanancia(data.DataBarra);
                                }

                                if (modelLiquidacionOfertas) {
                                    labelAgregadoLiquidacion.html('Agregado');

                                    if (isPagina('pedido')) {
                                        CargarDetallePedido();
                                    }
                                }

                                CerrarLoad();

                                modelLiquidacionOfertas = undefined;
                                labelAgregadoLiquidacion = undefined;
                            },
                            error: function (data, error) {
                                CerrarLoad();
                            }
                        });

                    }
                });
            }
        });
    }
}

function Inicializar() {
    ValidarCargaOfertasLiquidacion();
    LinkCargarOfertasToScroll();
}

function LinkCargarOfertasToScroll() { $(window).scroll(CargarOfertasScroll); }

function UnlinkCargarOfertasToScroll() {
    $(window).off("scroll", CargarOfertasScroll);
    cargandoRegistros = false;
}

function CargarOfertasScroll() {
    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
        ValidarCargaOfertasLiquidacion();
    }
}

function ValidarCargaOfertasLiquidacion() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    waitingDialog();
    CargarOfertasLiquidacion();
}

function CargarOfertasLiquidacion() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertaLiquidacion/JsonGetOfertasLiquidacion',
        data: { offset: offsetRegistros, cantidadregistros: cantidadRegistros, origen: 'OfertaLiquidacion' },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.lista.length > 0) ArmarCarouselLiquidaciones(data.lista);
                if (!data.verMas) UnlinkCargarOfertasToScroll();
                offsetRegistros += cantidadRegistros;
            }
        },
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            cargandoRegistros = false;
        }
    });
}

function ArmarCarouselLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#OfertasLiquidacion-template", data);
    $('#htmlListado').append(htmlDiv);
    EstablecerAccionLazyImagen("img[data-lazy-seccion-liquidacion]");

    var arrayOfertas = [];
    $.each(data, function (i, item) {
        var itemOferta = {
            'name': item.Descripcion,
            'id': item.CUV,
            'price': item.PrecioString,
            'brand': item.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': item.DescripcionEstrategia,
            'list': 'Liquidación Web',
            'position': item.Posicion
        };
        arrayOfertas.push(itemOferta);
    });
}

function EstructurarDataCarouselLiquidaciones(array) {
    var contadorLq = 1;
    $.each(array, function (i, item) {
        item.Descripcion = (item.Descripcion.length > 159 ? item.Descripcion.substring(0, 159) + "..." : item.Descripcion);
        item.Posicion = contadorLq;

        item.TallaColor = $.trim(item.TallaColor);
        if (item.TallaColor.length > 2 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TieneTallaColor = false;
        }
        contadorLq++;
    });

    return array;
}

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

    }
    $(divVistaPrevia).find('#ddlTallaColor').html(option);

    $(divVistaPrevia).find('#imgZonaEstrategiaEdit').attr('src', objProducto.imagenProducto);
    $(divVistaPrevia).find('.pedidos_datos_titulo').text(objProducto.tituloMarca);
    $(divVistaPrevia).find('.pedidos_datos_info').text(objProducto.descripcion);
    $(divVistaPrevia).find('.liquidacion_precio').html('<span>' + objProducto.precio + '</span>');
    $(divVistaPrevia).find('.span_stock').html(objHidden.Stock);

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
}

function IniDialog() {
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
}

function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, posicion) {
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") { variant = "Estándar"; }
        if (Categoria == null || Categoria == "") { Categoria = "Sin Categoría"; }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': 'Liquidación Web' },
                    'products': [
                        {
                            'name': DescripcionProd,
                            'price': Precio,
                            'brand': Marca,
                            'id': CUV,
                            'category': Categoria,
                            'variant': variant,
                            'quantity': parseInt(Cantidad),
                            'position': posicion
                        }
                    ]
                }
            }
        });
    }
}

function CerrarProductoAgregado() {
    $('#pop_liquidacion').hide();
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        dataType: 'json',
        async: false,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    waitingDialog({});
                    location.href = location.href = baseUrl + 'Pedido/PedidoValidado'
                }
                if (mostrarAlerta == true) {
                    closeWaitingDialog();
                    AbrirPopupPedidoReservado(data.message, "1");
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true)
                AbrirMensaje(data.message, "LO SENTIMOS");
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.', "LO SENTIMOS");
            }
        }
    });
    return restringido;
}

function ReservadoOEnHorarioRestringidoAsync(mostrarAlerta, fnRestringido, fnNoRestringido) {
    if (!$.isFunction(fnRestringido)) return false;
    if (!$.isFunction(fnNoRestringido)) return false;
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        data: { tipoAccion: '2' },
        dataType: 'json',
        async: true,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (!data.success) {
                fnNoRestringido();
                return false;
            }

            if (data.pedidoReservado && !mostrarAlerta) {
                waitingDialog();
                location.href = location.href = baseUrl + 'Pedido/PedidoValidado';
                return false;
            }

            if (mostrarAlerta) {
                closeWaitingDialog();
                messageInfoError(data.message);
            }
            fnRestringido();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                AbrirMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.', "LO SENTIMOS");
            }
        }
    });
}

function agregarProductoAlCarrito(o) {

    var btnClickeado = $(o);
    var contenedorItem = btnClickeado.parent();
    var imagenProducto = $('.imagen_producto', contenedorItem);
    var carrito = $('.campana.cart_compras');

    $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

    $(".transicion").css({
        'height': imagenProducto.css("height"),
        'width': imagenProducto.css("width"),
        'top': imagenProducto.offset().top,
        'left': imagenProducto.offset().left,
    }).animate({
        'top': carrito.offset().top,
        'left': carrito.offset().left,
        'height': carrito.css("height"),
        'width': carrito.css("width"),
        'opacity': 0.5
    }, 450, 'swing', function () {
        $(this).animate({
            'top': carrito.offset().top,
            'opacity': 0
        }, 150, 'swing', function () {
            $(this).remove();
        });
    });
}