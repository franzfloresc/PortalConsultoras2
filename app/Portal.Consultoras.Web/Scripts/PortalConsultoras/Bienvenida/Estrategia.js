
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

var revistaDigital = revistaDigital || {};

function CargarCarouselEstrategias() {
    $.ajax({
        type: "GET",
        url: baseUrl + "Estrategia/HomePedidoObtenerProductos",
        data: {
            tipoOrigenEstrategia: tipoOrigenEstrategia
        },
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            data.Lista = Clone(data.ListaModelo);
            data.ListaModelo = [];
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {

        }
    });
}

var CargarCarouselMasVendidos = function (origen) {
    var model = obtenerModelMasVendidos();
    if (model != null) {
        $("#divCarrouselMasVendidos.slick-initialized").slick("unslick");
        ArmarCarouselMasVendidos(model);
        inicializarDivMasVendidos(origen);
        _validarDivTituloMasVendidos();
    }
};

var obtenerModelMasVendidos = function () {
    var model = get_local_storage("data_mas_vendidos");
    if (typeof model === "undefined" || model === null) {
        var promesa = _obtenerModelMasVendidosPromise();
        $.when(promesa)
            .then(function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        model = response.data;
                        set_local_storage(model, "data_mas_vendidos");
                    }
                }
            });
    }
    return model;
};

var _obtenerModelMasVendidosPromise = function () {
    var d = $.Deferred();
    var promise = $.ajax({
        type: "GET",
        url: baseUrl + "Estrategia/BSObtenerOfertas",
        data: "",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: false
    });

    promise.done(function (response) {
        d.resolve(response);
    });
    promise.fail(d.reject);

    return d.promise();
};

function inicializarDivMasVendidos(origen) {
    $("#divCarrouselMasVendidos.slick-initialized").slick("unslick");

    var slickArrows = {
        'mobile': {
            prev: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-left:-12%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
            next: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-right:-12%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
        },
        'desktop': {
            prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
        }
    };

    $("#divCarrouselMasVendidos").not(".slick-initialized").slick({
        infinite: true,
        vertical: false,
        centerMode: false,
        centerPadding: "0px",
        slidesToShow: 4,
        slidesToScroll: 1,
        autoplay: false,
        speed: 270,
        pantallaPedido: false,
        prevArrow: slickArrows[origen].prev,
        nextArrow: slickArrows[origen].next,
        responsive: [
            {
                breakpoint: 1200,
                settings: { slidesToShow: 3, slidesToScroll: 1 }
            },
            {
                breakpoint: 900,
                settings: { slidesToShow: 2, slidesToScroll: 1 }
            },
            {
                breakpoint: 600,
                settings: { slidesToShow: 1, slidesToScroll: 1 }
            }
        ]
    });
}

function ArmarCarouselMasVendidos(data) {
    data.Lista = EstructurarDataCarousel(data.Lista);
    $("#divCarrouselMasVendidos").empty();

    var promesa = _actualizarModelMasVendidosPromise(data);
    $.when(promesa)
        .then(function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    data = response.data;
                    SetHandlebars("#mas-vendidos-template", data, "#divCarrouselMasVendidos");
                    if (data.Lista == null) data.Lista = [];
                    PintarEstrellas(data.Lista);
                    PintarRecomendaciones(data.Lista);
                    PintarPrecioTachado(data.Lista);
                }
            }
        });
}

function PintarPrecioTachado(listaMasVendidos) {
    for (var i = 0; i < listaMasVendidos.length; i++) {
        _pintarPrecioTachado(listaMasVendidos[i]);
    }
}

function _pintarPrecioTachado(item) {
    var xdiv = "#precio-tachado-" + item.EstrategiaID.toString();
    if (item.Ganancia > 0) {
        $(xdiv).show();
    }
    else {
        $(xdiv).hide();
    }
}

function PintarRecomendaciones(listaMasVendidos) {
    for (var i = 0; i < listaMasVendidos.length; i++) {
        _pintarRecomendaciones(listaMasVendidos[i]);
    }
}

function _pintarRecomendaciones(item) {
    var xdiv = "#recommedation-" + item.EstrategiaID.toString();
    var recommendation = "(" + item.CantComenAprob.toString() + ")";
    $(xdiv).html(recommendation);
    $(xdiv).show();
}

function PintarEstrellas(listaMasVendidos) {
    for (var i = 0; i < listaMasVendidos.length; i++) {
        _pintarEstrellas(listaMasVendidos[i]);
    }
}

function _pintarEstrellas(item) {
    if (item != null && item != undefined) {
        item.EstrategiaID = item.EstrategiaID || 0;
        item.PromValorizado = item.PromValorizado || 0;

        var xdiv = "#star-" + item.EstrategiaID.toString();
        var rating = "";
        rating = item.PromValorizado.toString() + "%";

        if ($(xdiv).length) {
            $(xdiv).rateYo({
                rating: rating,
                numStars: 5,
                precision: 2,
                minValue: 1,
                maxValue: 5,
                starWidth: "17px",
                readOnly: true
            });
            $(xdiv).show();
        }
    }

}

function EstructurarDataCarousel(array) {
    array = array || [];
    var isList = array.length != undefined;
    var lista = [];
    if (typeof array == "object") {
        lista = isList ? array : [];
        if (!isList)
            lista.push(array);
    }

    var urlOfertaDetalle = $.trim(urlOfertaDetalle);
    $.each(lista, function (i, item) {
        item.DescripcionCUV2 = $.trim(item.DescripcionCUV2);
        item.DescripcionCompleta = item.DescripcionCUV2.split("|")[0];
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split("|")[0];
            item.ArrayContenidoSet = item.DescripcionCUV2.split("|").slice(1);
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        }

        item.Posicion = i + 1;
        item.MostrarTextoLibre = (item.TextoLibre ? $.trim(item.TextoLibre).length > 0 : false);
        item.UrlDetalle = urlOfertaDetalle + "/" + (item.ID || item.Id) || "";
        item.PrecioVenta = item.PrecioString;
    });
    return isList ? lista : lista[0];
}

function EstrategiaVerDetalle(id, origen) {
    if ($.trim(origen) == "") {
        origen = $("#divListadoEstrategia").attr("data-OrigenPedidoWeb") || origenPedidoWebEstrategia || 0;
    }
    origen = $.trim(origen) || 0;
    var url = getMobilePrefixUrl() + "/OfertasParaTi/Detalle?id=" + id + "&&origen=" + origen;
    try {
        if (typeof GuardarProductoTemporal == "function" && typeof GetProductoStorage == "function") {
            var campania = $("[data-item=" + id + "]").parents("[data-tag-html]").attr("data-tag-html");
            var cuv = $("[data-item=" + id + "]").attr("data-item-cuv");
            var obj = {};
            if (typeof cuv == "undefined" || typeof campania == "undefined") {
                obj = JSON.parse($("[data-item=" + id + "]").attr("data-estrategia"));
            }
            if (obj.length == 0) {
                obj = GetProductoStorage(cuv, campania);
            }

            obj.CUV2 = $.trim(obj.CUV2);
            if (obj.CUV2 != "") {
                if (GuardarProductoTemporal(obj)){
                    window.location = url;
                    return true;
                }
            }
        }
    } catch (e) {
        console.log(e);
    }
    window.location = url;
}

function HidePopupEstrategiasEspeciales() {
}

function AbrirLoad() {
    if (tipoOrigenEstrategia == 1 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
        waitingDialog();
    }
    else if (tipoOrigenEstrategia == 11) {
        AbrirSplash();
    }
    else if ($.trim(tipoOrigenEstrategia)[0] == 2) {
        ShowLoading();
    }
    else if (isMobile()) {
        ShowLoading();
    }
    else {
        waitingDialog();
    }
}

function AbrirMensajeEstrategia(txt) {
    if (tipoOrigenEstrategia == 1) {
        alert_msg_pedido(txt);
    }
    else if (tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
        alert_msg(txt);
    }
    else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21 || tipoOrigenEstrategia == 262) {
        messageInfo(txt);
    }

    else if (isMobile()) {
        messageInfo(txt);
    }
    else {
        alert_msg(txt);
    }
}

function ProcesarActualizacionMostrarContenedorCupon() {
    if (typeof paginaOrigenCupon !== "undefined" && paginaOrigenCupon) {
        if (cuponModule) {
            cuponModule.actualizarContenedorCupon();
        }
    }
}

function RevisarMostrarContenedorCupon() {
   
    if (typeof finishLoadCuponContenedorInfo !== "undefined" && finishLoadCuponContenedorInfo) {
        if (cuponModule) {
            cuponModule.revisarMostrarContenedorCupon();
        }
    }
}

function _validarDivTituloMasVendidos() {
    var tieneMasVendidosFlag = _validartieneMasVendidos();
    var xmodel = get_local_storage("data_mas_vendidos");
    var xlista = [];

    if (xmodel !== "undefined" && xmodel !== null) {
        xlista = xmodel.Lista;
    }

    if (tieneMasVendidosFlag === 0) {
        $(".content_mas_vendidos").hide();
        return;
    }

    if (tieneMasVendidosFlag === 1) {
        if (xlista.length === 0) {
            $(".content_mas_vendidos").hide();
        }
        else {
            $(".content_mas_vendidos").show();
        }
    }
}

function GuardarProductoTemporal(obj) {

    $.ajaxSetup({
        cache: false
    });

    AbrirLoad();

    var varReturn = false;

    obj.TipoAccionAgregar = obj.TipoAccionAgregarBack || obj.TipoAccionAgregar;

    jQuery.ajax({
        type: "POST",
        url: urlOfertaDetalleProductoTem,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        async: false,
        success: function (response) {
            varReturn = response.success;
        },
        error: function (response, error) {
            CerrarLoad();
            localStorage.setItem(lsListaRD, "");
        }
    });

    return varReturn;
}
