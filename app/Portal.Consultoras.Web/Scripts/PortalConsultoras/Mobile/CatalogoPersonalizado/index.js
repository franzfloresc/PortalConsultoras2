var cantidadRegistros = 12;
var offsetRegistros = 0;
var cargandoRegistros = false;

$(document).ready(function () {
    $(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
        if (ReservadoOEnHorarioRestringido()) return false;

        var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
        AgregarProductoCatalogoPersonalizado(contenedor);
    });
    Inicializar();
});

function Inicializar() {
    IniDialog();
    ValidarCargaCatalogoPersonalizado();
    LinkCargarCatalogoToScroll();
}
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
}

function LinkCargarCatalogoToScroll() {
    $(window).scroll(CargarCatalogoScroll);
}
function UnlinkCargarCatalogoToScroll() {
    $(window).off("scroll", CargarCatalogoScroll);
    cargandoRegistros = false;
}
function CargarCatalogoScroll() {
    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
        ValidarCargaCatalogoPersonalizado();
    }
}

function ValidarCargaCatalogoPersonalizado() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    ShowLoading();
    ReservadoOEnHorarioRestringidoAsync(true, UnlinkCargarCatalogoToScroll, CargarCatalogoPersonalizado);
}

function ObtenerOfertaRevista(cuv) {
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerOfertaRevista,
        dataType: 'json',
        data: JSON.stringify({ cuv: cuv }),
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (data.success) {
                console.log(data.data);
            }
        },
        error: function (data, error) {
            console.log(error);
        },
        complete: function () {
            CloseLoading();
        }
    });
}
function CargarCatalogoPersonalizado() {
    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
    if (cataPer != "1" && cataPer != "2") {
        UnlinkCargarCatalogoToScroll();
        return false;
    }

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

                if (data.data.length < cantidadRegistros) UnlinkCargarCatalogoToScroll();
                offsetRegistros += cantidadRegistros;
            }
        },
        error: function (data, error) {
            console.log(error);
        },
        complete: function () {
            CloseLoading();
            cargandoRegistros = false;
        }
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
        alert_msg_com("La cantidad ingresada debe ser un número mayor que cero, verifique");
        CloseLoading();
        return false;
    }

    if (cantidad <= 0) {
        alert_msg_com("La cantidad ingresada debe ser mayor que cero, verifique");
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

    AgregarProducto('Insert', model, function () { $(divPadre).find(".product-add").show(); });
}

function AgregarProducto(url, item, otraFunct) {
    ShowLoading();

    jQuery.ajax({
        type: 'POST',
        url: urlAgregarProducto,
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
                alert_msg_com(data.message);
            }
            CloseLoading();
        },
        error: function (data, error) {
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
                    waitingDialog({});
                    location.href = urlPedidoValidado;
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    alert_msg_pedido(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) alert_msg_pedido(data.message);
        },
        error: function (error) {
            console.log(error);
            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
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
        url: urlReservadoOEnHorarioRestringido,
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
                ShowLoading();
                location.href = urlPedidoValidado;
                return false;
            }

            if (mostrarAlerta) {
                CloseLoading();
                alert_msg_pedido(data.message);
            }
            fnRestringido();
        },
        error: function (error) {
            console.log(error);
            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
}

function alert_msg_pedido(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}