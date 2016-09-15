var cantidadRegistros = 4;
var offsetRegistros = 0;

$(document).ready(function () {
    $(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

        var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
        AgregarProductoCatalogoPersonalizado(contenedor);
    });
    $(document).on('click', '#boton_vermas', function () {
        CargarCatalogoPersonalizado();
    });

    if (!ReservadoOEnHorarioRestringido(false)) {
        CargarCatalogoPersonalizado();
    }
    $(document).on('click', '.pop-ofertarevista', function () {
        waitingDialog({});
        var cuv = $(this).parents('.contiene-productos').find('.hdItemCuv').val();
        jQuery.ajax({
            type: 'POST',
            url: urlObtenerOfertaRevista,
            dataType: 'json',
            data: JSON.stringify({ cuv: cuv }),
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                console.log(response);
                if (response.success) {
                    DecimalToStringFormat(response.data.precio_catalogo);
                    DecimalToStringFormat(response.data.precio_revista);
                    DecimalToStringFormat(response.data.ganancia);
                    response.data.Simbolo = viewBagSimbolo;
                    switch (response.data.tipo_oferta) {
                        case '003':
                            var html = SetHandlebars("#template-mod-ofer1", response.data);
                            $('.mod-ofer1').html(html).show();
                            break;
                        case '048':
                            var html = SetHandlebars("#template-mod-ofer2", response.data);
                            $('.mod-ofer2').html(html).show();
                            break;
                        case '049':
                            var html = SetHandlebars("#template-mod-ofer3", response.data);
                            $('.mod-ofer3').html(html).show();
                            break;
                    }
                } else {
                    console.log(response.message);
                }
                CloseLoading();
            },
            error: function (response, error) {
                console.log(error);
                CloseLoading();
            }
        });
    });
});

function CargarCatalogoPersonalizado() {
    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
    if (cataPer != "1" && cataPer != "2") {
        $('#boton_vermas').hide();
        return false;
    }

    //$('#divCatalogoPersonalizado').html('<div style="text-align: center;"><br>Cargando Catalogo Personalizado<br><img src="' + urlLoad + '" /></div>');
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerProductosCatalogoPersonalizado,
        dataType: 'json',
        data: JSON.stringify({ cantidad: cantidadRegistros, offset: offsetRegistros }),
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (data.success) {
                if (data.data.length > 0) {
                    var htmlDiv = SetHandlebars("#template-catalogopersonalizado", data.data);
                    $('#divCatalogoPersonalizado').append(htmlDiv);
                }

                if (data.data.length < cantidadRegistros) $('#boton_vermas').hide();
                offsetRegistros += cantidadRegistros;
            }
        },
        error: function (data, error) {
            console.log(error);
        },
        complete: CloseLoading
    });
}

function AgregarProductoCatalogoPersonalizado(item) {
    ShowLoading();

    var divPadre = item;
    var attItem = $(item).attr("data-item") || "";
    if (attItem == "") {
        divPadre = $(item).parents("[data-item]").eq(0);
    }

    var cuv = $(divPadre).find(".hdItemCuv").val();
    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
    var tipoOfertaSisID = $(divPadre).find(".hdItemTipoOfertaSisID").val();
    var configuracionOfertaID = $(divPadre).find(".hdItemConfiguracionOfertaID").val();
    var indicadorMontoMinimo = $(divPadre).find(".hdItemIndicadorMontoMinimo").val();
    var tipo = $(divPadre).find(".hdItemTipo").val();
    var marcaID = $(divPadre).find(".hdItemMarcaID").val();
    var precioUnidad = $(divPadre).find(".hdItemPrecioUnidad").val();
    var descripcionProd = $(divPadre).find(".hdItemDescripcionProd").val();
    var pagina = $(divPadre).find(".hdItemPagina").val();
    var descripcionCategoria = $(divPadre).find(".hdItemDescripcionCategoria").val();
    var descripcionMarca = $(divPadre).find(".hdItemDescripcionMarca").val();
    var descripcionEstrategia = $(divPadre).find(".hdItemDescripcionEstrategia").val();

    if (!isInt(cantidad)) {
        messageInfo("La cantidad ingresada debe ser un número mayor que cero, verifique");
        CloseLoading();
        return false;
    }

    if (cantidad <= 0) {
        messageInfo("La cantidad ingresada debe ser mayor que cero, verifique");
        CloseLoading();
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
        EsSugerido: false
    };

    AgregarProducto(urlAgregarProducto, model, function () { $(divPadre).find(".product-add").show(); });
}

function AgregarProducto(url, item, otraFunct) {
    ShowLoading();

    tieneMicroefecto = true;

    jQuery.ajax({
        type: 'POST',
        url: url,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (data.success == true) {
                ActualizarGanancia(data.DataBarra);
                CargarCantidadProductosPedidos();
                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);

                if (typeof (otraFunct) == 'function') {
                    setTimeout(otraFunct, 50);
                }
                else if (typeof (otraFunct) == 'string') {
                    setTimeout(otraFunct, 50);
                }
            }
            else {
                messageInfo(data.message);
            }
            CloseLoading();
        },
        error: function (data, error) {
            tieneMicroefecto = false;
            AjaxError(data, error);
        }
    });
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
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
                    ShowLoading();
                    location.href = urlReservadoOEnHorarioRestringido;
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    alert_msg_pedido(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true)
                alert_msg_pedido(data.message);
        },
        error: function (error) {
            console.log(error);
            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}

function alert_msg_pedido(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}