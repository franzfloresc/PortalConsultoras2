$(document).ready(function () {

    $(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
        var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
        AgregarProductoCatalogoPersonalizado(contenedor);
    });

    CargarCatalogoPersonalizado();
});

function CargarCatalogoPersonalizado() {
    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
    if (cataPer != "1" && cataPer != "2") {
        return false;
    }

    $('#divCatalogoPersonalizado').html('<div style="text-align: center;">Cargando Catalogo Personalizado<br><img src="' + urlLoad + '" /></div>');
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'CatalogoPersonalizado/ObtenerProductosCatalogoPersonalizado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            $("#divCatalogoPersonalizado").html("");
            if (data.success) {
                SetHandlebars("#template-catalogopersonalizado", data.data, "#divCatalogoPersonalizado");
            }
        },
        error: function (data, error) {
            CerrarSplash();
        }
    });
}

function AgregarProductoCatalogoPersonalizado(item) {
    waitingDialog();

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
        closeWaitingDialog();
        return false;
    }

    if (cantidad <= 0) {
        alert_msg_com("La cantidad ingresada debe ser mayor que cero, verifique");
        closeWaitingDialog();
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
    waitingDialog();

    tieneMicroefecto = true;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/' + url,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (data.success == true) {
                ActualizarGanancia(data.DataBarra);
                CargarResumenCampaniaHeader(true);
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
            closeWaitingDialog();
        },
        error: function (data, error) {
            tieneMicroefecto = false;
            AjaxError(data, error);
        }
    });
}