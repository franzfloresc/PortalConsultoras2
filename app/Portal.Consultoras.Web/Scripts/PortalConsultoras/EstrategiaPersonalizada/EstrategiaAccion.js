﻿
// 1: escritorio Home    11 : escritorio Pedido 
// 2: mobile  Home       21 : mobile pedido
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";

// Cuarto Dígito
// 0. Sin popUp         1. Con popUp
var conPopup = conPopup || "";

var tieneOPT = false;
var origenRetorno = $.trim(origenRetorno);
var origenPedidoWebEstrategia = origenPedidoWebEstrategia || "";
var divAgregado = null;
var _campania = "";

// Copiar el $(document).ready de Estrategia.js, en caso no hacer caso al archivo Estrategia.JS
//$(document).ready(function () {});

function EstrategiaObtenerObj(e) {
    var objHtmlEvent = $(e.target);
    if (objHtmlEvent.length == 0) objHtmlEvent = $(e);
    var objHtml = objHtmlEvent.parents("[data-item]");
    var estrategia = JSON.parse($(objHtml).find("[data-estrategia]").attr("data-estrategia"));
    return estrategia;
}

function EstrategiaObtenerObjHtmlLanding(objInput) {
    var itemClone = $(objInput).parents("[data-item]");
    var cuvClone = $.trim(itemClone.attr("data-clone-item"));
    if (cuvClone != "") {
        itemClone = $("body").find("[data-content-item='" + $.trim(itemClone.attr("data-clone-content")) + "']").find("[data-item='" + cuvClone + "']");
    }
    if (itemClone.length === 0 && cuvClone != "") {
        itemClone = $("body").find("[data-item='" + cuvClone + "']");
    }
    if (itemClone.length > 1) {
        itemClone = $(itemClone.get(0));
    }

    return itemClone;
}

function VerDetalleEstrategia(e) {

    AbrirLoad();

    var estrategia = EstrategiaObtenerObj(e);
    var objHtmlEvent = $(e.target);
    if (objHtmlEvent.length == 0) objHtmlEvent = $(e);
    var origenPedido = $(objHtmlEvent).parents("[data-item]").find("input.OrigenPedidoWeb").val()
        || $(objHtmlEvent).parents("[data-item]").attr("OrigenPedidoWeb")
        || $(objHtmlEvent).parents("[data-item]").attr("data-OrigenPedidoWeb")
        || $(objHtmlEvent).parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb")
        || origenPedidoWebEstrategia;
    estrategia.OrigenPedidoWeb = origenPedido;

    _campania = $(objHtmlEvent).parents("[data-tag-html]").attr("data-tag-html");
    try {
        var contentIndex = $(objHtmlEvent).parents("[data-tab-index]").attr("data-tab-index");
        
        if (contentIndex !== undefined && contentIndex !== null && contentIndex.toString() === "2") {
            VerDetalleBloqueadaRDAnalytics(campania, (estrategia.DescripcionResumen + " " + estrategia.DescripcionCortada).trim());
        } else if (origenPedido !== undefined && origenPedido !== null && origenPedido.indexOf("7") !== -1) {
            VerDetalleComprarRDAnalytics(origenPedido, estrategia);
        } else {
            dataLayer.push({
                'event': 'productClick',
                'ecommerce': {
                    'click': {
                        'actionField': { 'list': 'Ofertas para ti – ' + origen },
                        'products': [{
                            'id': estrategia.CUV2,
                            'name': estrategia.DescripcionCompleta,
                            'price': $.trim(estrategia.Precio2),
                            'brand': estrategia.DescripcionMarca,
                            'category': 'NO DISPONIBLE',
                            'variant': estrategia.DescripcionEstrategia,
                            'position': estrategia.Posicion
                        }]
                    }
                }
            });
        }

        
    } catch (e) {console.log(e)}

    

    if (isMobile()) {
        EstrategiaVerDetalleMobile(estrategia.EstrategiaID, origenPedido);
        return true;
    }

    var origen = tipoOrigenEstrategia == 1 ? "Home" : tipoOrigenEstrategia == 11 ? "Pedidos" : "";

    estrategia.ContentItem = $(e.target).parents("[data-content-item]").attr("data-content-item");

    if (estrategia.TipoEstrategiaImagenMostrar == '2') {

        EstrategiaVerDetallePackNueva(estrategia);

    } else if (estrategia.TipoEstrategiaImagenMostrar == '5' || estrategia.TipoEstrategiaImagenMostrar == '3') {

        EstrategiaVerDetalleGeneral(estrategia);

    };

    CerrarLoad();
    return true;
}

function EstrategiaVerDetalleMobile(id, origen) {
    if ($.trim(origen) == "") {
        origen = $("#divListadoEstrategia").attr("data-OrigenPedidoWeb") || origenPedidoWebEstrategia || 0;
    }
    origen = $.trim(origen) || 0;
    var url = "/Mobile/OfertasParaTi/Detalle?id=" + id + "&&origen=" + origen;
    try {
        if (typeof EstrategiaGuardarTemporal == "function" && typeof GetProductoStorage == "function") {
            var campania = $("[data-item=" + id + "]").parents("[data-tag-html]").attr("data-tag-html");
            var cuv = $("[data-item=" + id + "]").attr("data-item-cuv");
            var obj  = {};
            if (typeof cuv == "undefined" || typeof campania == "undefined") {
                obj = JSON.parse($("[data-item=" + id + "]").find("[data-estrategia]").attr("data-estrategia"));
            }
            else {
                obj = GetProductoStorage(cuv, campania);
            }
            obj.CUV2 = $.trim(obj.CUV2);
            if (obj.CUV2 === "") {
                obj = JSON.parse($("[data-item=" + id + "]").find("[data-estrategia]").attr("data-estrategia"));
                obj.CUV2 = $.trim(obj.CUV2);
            }
            if (obj.CUV2 != "") {
                if (EstrategiaGuardarTemporal(obj))
                    window.location = url;
            }
        }
    } catch (e) {
        console.log(e);
        CerrarLoad();
    }
    //window.location = url;
}

function EstrategiaVerDetallePackNueva(estrategia) {
    SetHandlebars("#pack-nuevas-template", estrategia, '#popupDetalleCarousel_packNuevas');
    $('#popupDetalleCarousel_packNuevas').show();
    TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
}

function EstrategiaVerDetalleGeneral(estrategia) {

    estrategia.Posicion = 1;
    estrategia.CodigoVariante = $.trim(estrategia.CodigoVariante);

    estrategia.Detalle = new Array();
    var btnDesabled = 0;
    if (estrategia.CodigoVariante != "") {

        EstrategiaGuardarTemporal(estrategia);

        estrategia.Detalle = EstrategiaVerDetalleSet(estrategia.CUV2);
        AbrirLoad();
        estrategia.Linea = "0px";
        if (estrategia.Detalle.length > 0) {
            $.each(estrategia.Detalle, function (i, item) {
                item.Hermanos = item.Hermanos || new Array();
                //item.CUVSelect = i == 0 ? item.CUV : "";
                item.CUVSelect = "";
                item.ImagenBulkSelect = i == 0 ? item.ImagenBulk : "";
                item.NombreBulkSelect = i == 0 ? item.NombreBulk : "";

                if (estrategia.CodigoVariante == "2001")
                    btnDesabled = 1;

                if (item.Hermanos.length > 0) {
                    $.each(item.Hermanos, function (i, itemH) {
                        itemH.CUVSelect = "";
                    });
                    //item.CUVSelect = item.Hermanos[0].CUV;
                    item.ImagenBulkSelect = item.Hermanos[0].ImagenBulk;
                    item.NombreBulkSelect = item.Hermanos[0].NombreBulk;

                    item.Hermanos[0].CUVSelect = item.Hermanos[0].CUV;
                    item.Hermanos[0].ImagenBulkSelect = item.Hermanos[0].ImagenBulk;
                    item.Hermanos[0].NombreBulkSelect = item.Hermanos[0].NombreBulk;

                    item.NombreComercial = item.Hermanos[0].NombreComercial;

                    estrategia.Linea = "1px solid #ccc";
                    btnDesabled = 1;
                }
            });
            //estrategia.CUVSelect = estrategia.Detalle[0].CUVSelect;
            estrategia.ImagenBulkSelect = estrategia.Detalle[0].ImagenBulkSelect;
            estrategia.NombreBulkSelect = estrategia.Detalle[0].NombreBulkSelect;
        }
        else {
            estrategia.CodigoVariante = "";
        }
    }

    var popupId = '#popupDetalleCarousel_lanzamiento';

    SetHandlebars("#verdetalle-template", estrategia, popupId);

    if (btnDesabled == 0) {
        btnDesabled = $(popupId).find("#tbnAgregarProducto").attr("data-bloqueada") || "";
        if (btnDesabled == "") {
            $(popupId).find("#tbnAgregarProducto").removeClass("btn_desactivado_general");
        }
    }
    else {
        $(popupId).find("#tbnAgregarProducto").addClass("btn_desactivado_general");
    }

    AbrirPopup(popupId);
    $(".indicador_tono").click();
    $(".indicador_tono").click();

    EstrategiaMostrarMasTonos(true);
    TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());

}

function EstrategiaVerDetalleSet(cuv) {
    AbrirLoad();
    var detalle = new Array();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertasParaTi/ConsultarEstrategiaSet?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            detalle = data || new Array();
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });
    CerrarLoad();
    return detalle;
}

function EstrategiaMostrarMasTonos(menos) {
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
    }
    else {
        $("#popupDetalleCarousel_lanzamiento [data-tono-div]").css("height", "auto");
    }
    
}

function EstrategiaGuardarTemporal(obj) {

    $.ajaxSetup({
        cache: false
    });

    AbrirLoad();

    var varReturn = false;

    var ruta = "";

    if (typeof urlOfertaDetalleProductoTem == "undefined") {
        ruta = "/RevistaDigital/GuardarProductoTemporal";
    }
    else {
        ruta = urlOfertaDetalleProductoTem;
    }

    jQuery.ajax({
        type: 'POST',
        url: ruta,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: false,
        success: function (response) {
            varReturn = response.success;
        },
        error: function (response, error) {
            CerrarLoad();
            localStorage.setItem(lsListaRD, '');
            if (checkTimeout(response)) {
                console.log(response);
            }
        }
    });

    return varReturn;
}

function EstrategiaCargarCuv(cuv) {
    AbrirLoad();
    var detalle = new Array();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertasParaTi/ConsultarEstrategiaCuv?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            detalle = data || new Array();
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });
    CerrarLoad();
    return detalle;
}

function EstrategiaAgregar(event, popup, limite) {

    var estrategia = EstrategiaObtenerObj(event);

    var objInput = $(event.target);

    origenPedidoWebEstrategia =
        $(objInput).parents("[data-item]").find("input.OrigenPedidoWeb").val()
        || $(objInput).parents("[data-item]").attr("OrigenPedidoWeb")
        || $(objInput).parents("[data-item]").attr("data-OrigenPedidoWeb")
        || $(objInput).parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb")
        || origenPedidoWebEstrategia;

    var campania = $(objInput).parents("[data-tag-html]").attr("data-tag-html") || _campania;
    popup = popup || false;

    if (EstrategiaValidarBloqueada(objInput, estrategia)) {
        try {
            AgregarProductoDeshabilitadoRDAnalytics(
                origenPedidoWebEstrategia, campania, (estrategia.DescripcionResumen +
                    " " +
                    estrategia.DescripcionCortada).trim(), popup);
        } catch (e) {console.log(e)} 
        return false;
    }

    if (EstrategiaValidarSeleccionTono(objInput)) {
        return false;
    }

   
    limite = limite || 0;
    var cantidad = (limite > 0) ? limite
        :(
            $(".btn_agregar_ficha_producto ").parents("[data-item]").find("input.liquidacion_rango_cantidad_pedido").val()
            || $(objInput).parents("[data-item]").find("input.rango_cantidad_pedido").val()
            || $(objInput).parents("[data-item]").find("[data-input='cantidad']").val()
        );

    if (!$.isNumeric(cantidad)) {
        AbrirMensajeEstrategia("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CerrarLoad();
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        AbrirMensajeEstrategia("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CerrarLoad();
        return false;
    }
    estrategia.Cantidad = cantidad;

    var agregoAlCarro = false;
    if (!isMobile()) {
        //agregarProductoAlCarrito(objInput);
        //agregoAlCarro = true;
        estrategia.FlagNueva = estrategia.FlagNueva == "1" ? estrategia.FlagNueva : "";
        $('#OfertaTipoNuevo').val(estrategia.FlagNueva);
    }

    AbrirLoad();

    var itemClone = EstrategiaObtenerObjHtmlLanding(objInput);
    divAgregado = $(itemClone).find(".agregado.product-add");

    var cuvs = "";
    var CodigoVariante = estrategia.CodigoVariante;
    if ((CodigoVariante == "2001" || CodigoVariante == "2003") && popup) {
        var listaCuvs = $(objInput).parents("[data-item]").find("[data-tono][data-tono-select]");
        if (listaCuvs.length > 0) {
            $.each(listaCuvs, function (i, item) {
                var cuv = $(item).attr("data-tono-select");
                if (cuv != "") {
                    cuvs = cuvs + (cuvs == "" ? "" : "|") + cuv;
                    if (CodigoVariante == "2003") {
                        cuvs = cuvs + ";" + $(item).find("#Estrategia_hd_MarcaID").val();
                        cuvs = cuvs + ";" + $(item).find("#Estrategia_hd_PrecioCatalogo").val();
                    }
                }
            });
        }
    }

    if (!origenPedidoWebEstrategia) {
        origenPedidoWebEstrategia =
            $(objInput).parents("[data-item]").find("input.OrigenPedidoWeb").val()
            || $(objInput).parents("[data-item]").attr("OrigenPedidoWeb")
            || $(objInput).parents("[data-item]").attr("data-OrigenPedidoWeb")
            || $(objInput).parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb")
            || origenPedidoWebEstrategia;
    }
    var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

    var params = ({
        listaCuvTonos: $.trim(cuvs),
        cuv: $.trim(estrategia.CUV2),
        EstrategiaID: $.trim(estrategia.EstrategiaID),
        FlagNueva: $.trim(estrategia.FlagNueva),
        Cantidad: $.trim(cantidad),
        OrigenPedidoWeb: $.trim(origenPedidoWebEstrategia),
        ClienteID_: '-1',
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0
    });

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/AgregarProducto',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (data) {
            if (!checkTimeout(data)) {
                CerrarLoad();
                return false;
            }

            if (data.success === false) {
                AbrirMensajeEstrategia(data.message);
                CerrarLoad();
                return false;
            }
            
            if (!isMobile() && !agregoAlCarro) {
                agregarProductoAlCarrito(objInput);
                agregoAlCarro = true;
            }

            AbrirLoad();

            if (divAgregado != null) {
                $(divAgregado).show();
            }
            if (isMobile()) {
                ActualizarGanancia(data.DataBarra);
            }
            else {
                if (tipoOrigenEstrategia == 1) {
                    CargarResumenCampaniaHeader(true);
                }
                else {
                    CargarResumenCampaniaHeader();
                }
            }

            var cuv = estrategia.CUV2;

            if (tipoOrigenEstrategia == 1) {
                MostrarBarra(data, '1');
                ActualizarGanancia(data.DataBarra);
                CargarCarouselEstrategias(cuv);
                if (tieneMasVendidos === 1) {
                    CargarCarouselMasVendidos('desktop');
                }
            }
            else if (tipoOrigenEstrategia == 11) {

                $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

                cierreCarouselEstrategias();
                CargarCarouselEstrategias(cuv);
                HideDialog("divVistaPrevia");

                tieneMicroefecto = true;

                CargarDetallePedido();
                MostrarBarra(data);
            }
            else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21 || tipoOrigenEstrategia == 27 || tipoOrigenEstrategia == 262 || tipoOrigenEstrategia == 272) {
                if (tipoOrigenEstrategia == 262) {
                    origenRetorno = $.trim(origenRetorno);
                    if (origenRetorno != "") {
                        window.location = origenRetorno;
                    }
                }
                else if (tipoOrigenEstrategia != 272) {
                    CargarCarouselEstrategias(cuv);

                    if (tieneMasVendidos === 1) {
                        CargarCarouselMasVendidos('mobile');
                    }
                }
            }

            try {
                if (origenPedidoWebEstrategia !== undefined && origenPedidoWebEstrategia.indexOf("7") !== -1) {
                    AgregarProductoRDAnalytics(origenPedidoWebEstrategia, estrategia, popup);
                } else {
                    TagManagerClickAgregarProductoOfertaParaTI(estrategia);  
                }
                TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);

                CerrarLoad();
                if (popup) {
                    CerrarPopup('#popupDetalleCarousel_lanzamiento');
                    $('#popupDetalleCarousel_packNuevas').hide();
                }

                ActualizarLocalStorageAgregado("rd", params.listaCuvTonos || params.cuv, true);

                ProcesarActualizacionMostrarContenedorCupon();
                
            } catch (e) { console.log(e); }

        },
        error: function (data, error) {
            console.log(data);
            CerrarLoad();
        }
    });

}

function EstrategiaValidarBloqueada(objInput, estrategia) {
    if ($.trim($(objInput).attr("data-bloqueada")) == "") {
        return false;
    }

    if (isMobile()) {
        EstrategiaVerDetalleMobile(estrategia.EstrategiaID);
        return true;
    }

    var divMensaje = $("#divMensajeBloqueada");
    if (divMensaje.length > 0) {
        var itemClone = EstrategiaObtenerObjHtmlLanding(objInput);
        if (itemClone.length > 0) {
            divMensaje.find("[data-item-html]").html(itemClone.html());
            divMensaje = divMensaje.find("[data-item-html]");
            divMensaje.find('[data-item-tag="body"]').removeAttr("data-estrategia");
            divMensaje.find('[data-item-tag="body"]').css("min-height", "auto");
            divMensaje.find('[data-item-tag="body"]').css("float", "none");
            divMensaje.find('[data-item-tag="body"]').css("margin", "0 auto");
            divMensaje.find('[data-item-tag="body"]').css("background-color", "#fff");
            divMensaje.find('[data-item-tag="body"]').attr("class", "");
            divMensaje.find('[data-item-tag="agregar"]').remove();
            divMensaje.find('[data-item-tag="fotofondo"]').remove();
            divMensaje.find('[data-item-tag="verdetalle"]').remove();
            divMensaje.find('[data-item-accion="verdetalle"]').remove();
            divMensaje.find('[data-item-tag="contenido"]').removeAttr("onclick");
            divMensaje.find('[data-item-tag="contenido"]').css("position", "initial");
            divMensaje.find('[data-item-tag="contenido"]').attr("class", "");
        }
        $(".contenedor_popup_detalleCarousel").hide();
        $("#divMensajeBloqueada").show();
    }
    return true;
}

function EstrategiaValidarSeleccionTono(objInput) {
    var attrClass = $.trim($(objInput).attr("class"));
    if ((" " + attrClass + " ").indexOf(" btn_desactivado_general ") >= 0) {
        $(objInput).parents("[data-item]").find("[data-tono-select='']").find("[data-tono-change='1']").parent().addClass("tono_no_seleccionado");
        setTimeout(function () {
            $(objInput).parents("[data-item]").find("[data-tono-change='1']").parent().removeClass("tono_no_seleccionado");
        }, 500);
        return true;
    }
    return false;
}

function AbrirMensajeEstrategia(txt) {
    if (tipoOrigenEstrategia == 1) {
        alert_msg_pedido(txt)
    }
    else if (tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
        alert_msg(txt);
    }
    else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21 || tipoOrigenEstrategia == 262) {
        messageInfo(txt);
    }
}
