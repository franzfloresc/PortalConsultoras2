
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
var TieneHV = TieneHV || false;
var revistaDigital = revistaDigital || {};

var belcorp = belcorp || {};
belcorp.estrategia = belcorp.estrategia || {};
belcorp.estrategia.initialize = function () {
    registerEvent.call(this, "onProductoAgregado");
};

var EstrategiaVerDetalleProvider = function () {
    "use strict";

    var estrategiaGuardarTemporalPromise = function (urlGuardarProductoTemporal, params) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: urlGuardarProductoTemporal,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var estrategiaConsultarEstrategiaCuvPromise = function (cuv) {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "GET",
            url: baseUrl + "Estrategia/ConsultarEstrategiaCuv?cuv=" + cuv,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
           // data: JSON.stringify(params),
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    return {
        estrategiaGuardarTemporalPromise: estrategiaGuardarTemporalPromise,
        estrategiaConsultarEstrategiaCuvPromise: estrategiaConsultarEstrategiaCuvPromise
    };
}();

var EstrategiaVerDetalle = function () {
    "use strict";
    return {

    };
}();

function VerDetalleEstrategia(e) {

    AbrirLoad();
    var objHtmlEvent = $(e.target);
    var estrategia = EstrategiaAgregarModule.EstrategiaObtenerObj(objHtmlEvent);
    if (objHtmlEvent.length == 0) objHtmlEvent = $(e);

    var origenPedido = $(objHtmlEvent).parents("[data-item]").find("input.OrigenPedidoWeb").val() || 
        $(objHtmlEvent).parents("[data-item]").attr("OrigenPedidoWeb") || 
        $(objHtmlEvent).parents("[data-item]").attr("data-OrigenPedidoWeb") || 
        $(objHtmlEvent).parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb") || 
        origenPedidoWebEstrategia;

    estrategia.OrigenPedidoWeb = origenPedido;

    _campania = $(objHtmlEvent).parents("[data-tag-html]").attr("data-tag-html");
    try {
        var contentIndex = $(objHtmlEvent).parents("[data-tab-index]").attr("data-tab-index");

        if (contentIndex !== undefined && contentIndex !== null && contentIndex.toString() === "2") {
            rdAnalyticsModule.VerDetalleBloqueada(campania, (estrategia.DescripcionResumen + " " + estrategia.DescripcionCortada).trim());
        } else if (origenPedido !== undefined && origenPedido !== null && origenPedido.indexOf("7") !== -1) {
            rdAnalyticsModule.VerDetalleComprar(origenPedido, estrategia);
        } else {
            dataLayer.push({
                'event': "productClick",
                'ecommerce': {
                    'click': {
                        'actionField': { 'list': "Ofertas para ti – " + origen },
                        'products': [{
                            'id': estrategia.CUV2,
                            'name': estrategia.DescripcionCompleta,
                            'price': $.trim(estrategia.Precio2),
                            'brand': estrategia.DescripcionMarca,
                            'category': "NO DISPONIBLE",
                            'variant': estrategia.DescripcionEstrategia,
                            'position': estrategia.Posicion
                        }]
                    }
                }
            });
        }


    } catch (ex) { 
        console.log(ex); 
    }

    if (isMobile()) {
        EstrategiaVerDetalleMobile(estrategia, origenPedido);
        return true;
    }

    var origen = tipoOrigenEstrategia == 1 ? "Home" : tipoOrigenEstrategia == 11 ? "Pedidos" : "";

    estrategia.ContentItem = $(e.target).parents("[data-content-item]").attr("data-content-item");

    estrategia.OrigenPedidoWeb = $(objHtmlEvent).parents("[data-OrigenPedidoWeb-popup]").attr("data-OrigenPedidoWeb-popup") || origenPedido;

    if (estrategia.TipoEstrategiaImagenMostrar == "2") {

        EstrategiaVerDetallePackNueva(estrategia);

    } else if (estrategia.TipoEstrategiaImagenMostrar == "5" || estrategia.TipoEstrategiaImagenMostrar == "3") {

        EstrategiaVerDetalleGeneral(estrategia);

    }

    CerrarLoad();
    return true;
}

function EstrategiaVerDetalleMobile(estrategia, origen) {
    if ($.trim(origen) == "") {
        origen = $("#divListadoEstrategia").attr("data-OrigenPedidoWeb") || origenPedidoWebEstrategia || 0;
    }
    origen = $.trim(origen) || 0;
    var id = estrategia.EstrategiaID;
    var route = "/OfertasParaTi/Detalle?id=";
    var url = getMobilePrefixUrl() + route + id + "&&origen=" + origen + "&&campaniaId=" + (estrategia.CampaniaID || campaniaCodigo);
    try {
        if (typeof EstrategiaGuardarTemporal == "function" && typeof GetProductoStorage == "function") {
            var campania = $("[data-item=" + id + "]").parents("[data-tag-html]").attr("data-tag-html");
            var cuv = $("[data-item=" + id + "]").attr("data-item-cuv");
            var obj = {};
            var objAux = "";
            if (typeof cuv == "undefined" || typeof campania == "undefined") {
                objAux = $.trim($("[data-item=" + id + "]").find("[data-estrategia]").attr("data-estrategia"));
            }

            if (objAux != "") {
                obj = JSON.parse(objAux);
            }
            else {
                obj = GetProductoStorage(cuv, campania) || {};
            }

            obj.CUV2 = $.trim(obj.CUV2);
            if (obj.CUV2 === "") {
                objAux = $.trim($("[data-item=" + id + "]").find("[data-estrategia]").attr("data-estrategia"));

                if (objAux != "") {
                    obj = JSON.parse(objAux);
                }
            }

            obj.CUV2 = $.trim(obj.CUV2);
            if (obj.CUV2 != "") {
                if (EstrategiaGuardarTemporal(obj))
                    window.location = url;
            }
        }
    } catch (e) {
        console.log(e);
        CerrarLoad();
    }
}

function EstrategiaVerDetallePackNueva(estrategia) {
    SetHandlebars("#pack-nuevas-template", estrategia, "#popupDetalleCarousel_packNuevas");
    $("#popupDetalleCarousel_packNuevas").show();
    TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
}

function EstrategiaVerDetalleGeneral(estrategia) {
    estrategia.Posicion = 1;
    estrategia.CodigoVariante = $.trim(estrategia.CodigoVariante);

    estrategia.Detalle = [];
    var btnDesabled = 0;
    if (estrategia.CodigoVariante != "") {

        EstrategiaGuardarTemporal(estrategia);

        estrategia.Detalle = EstrategiaCargarCuv(estrategia.CUV2);
        AbrirLoad();
        estrategia.Linea = "0px";
        if (estrategia.Detalle.length > 0) {
            $.each(estrategia.Detalle, function (i, item) {
                item.Hermanos = item.Hermanos || [];
                item.CUVSelect = "";
                item.ImagenBulkSelect = i == 0 ? item.ImagenBulk : "";
                item.NombreBulkSelect = i == 0 ? item.NombreBulk : "";

                if (estrategia.CodigoVariante == "2001")
                    btnDesabled = 1;

                if (item.Hermanos.length > 0) {
                    $.each(item.Hermanos, function (i, itemH) {
                        itemH.CUVSelect = "";
                    });
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
            estrategia.ImagenBulkSelect = estrategia.Detalle[0].ImagenBulkSelect;
            estrategia.NombreBulkSelect = estrategia.Detalle[0].NombreBulkSelect;
        }
        else {
            estrategia.CodigoVariante = "";
        }
    }

    var popupId = "#popupDetalleCarousel_lanzamiento";
    estrategia.PrecioNiveles = estrategia.PrecioNiveles || "";
    if (estrategia.PrecioNiveles != "") {
        estrategia.lstPrecioNiveles = estrategia.PrecioNiveles.split("|");
    }

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

    estrategiaComponenteModule.MostrarMasTonos(true);
    TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
}

function EstrategiaGuardarTemporal(obj) {
    AbrirLoad();

    var varReturn = false;
    var urlGuardarProductoTemporal = "";
    if (typeof urlOfertaDetalleProductoTem !== "undefined") {
        urlGuardarProductoTemporal = urlOfertaDetalleProductoTem || "/Estrategia/GuardarProductoTemporal";
    }
    else {
            urlGuardarProductoTemporal = "/Estrategia/GuardarProductoTemporal";
    }

    obj.TipoAccionAgregar = obj.TipoAccionAgregarBack || obj.TipoAccionAgregar;

    EstrategiaVerDetalleProvider
        .estrategiaGuardarTemporalPromise(urlGuardarProductoTemporal, obj)
        .done(function(data) {
            varReturn = data.success;
        })
        .fail(function(data, error) {
            CerrarLoad();
            localStorage.setItem(lsListaRD, "");
        });

    return varReturn;
}

function EstrategiaCargarCuv(cuv) {
    AbrirLoad();
    var detalle = [];

    EstrategiaVerDetalleProvider
        .estrategiaConsultarEstrategiaCuvPromise(cuv)
        .done(function(data) {
            detalle = data || [];
        }).fail(function(data, error) {

        });

    CerrarLoad();
    return detalle;
}

function VerPopupExpGanaMas() {

    var divMensaje = "";

    if (revistaDigital) {
        if (revistaDigital.TieneRDC) {
            if (!revistaDigital.EsSuscrita && !revistaDigital.EsActiva) {
                if (isMobile()) {
                    divMensaje = $("#divNSPopupBloqueadoMob");
                } else {
                    divMensaje = $("#divNSPopupBloqueadoDesk");
                }

            } else if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva) {
                if (isMobile()) {
                    divMensaje = $("#divSNAPopupBloqueadoMob");
                } else {
                    divMensaje = $("#divSNAPopupBloqueadoDesk");
                }
            }
        }
    }

    if (divMensaje != "") {
        divMensaje.show();
    }

}