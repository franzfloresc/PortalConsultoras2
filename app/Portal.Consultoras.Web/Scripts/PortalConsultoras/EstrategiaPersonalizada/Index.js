﻿var sElementos = {
    seccion: "[data-seccion]",
    load: "[data-seccion-load]",
    listadoProductos: "[data-seccion-productos]",
    verMas: "[data-seccion-vermas]",
    contadorProductos: "[data-productos-info]"
};

var listaLAN = listaLAN || "LANLista";

var CONS_TIPO_PRESENTACION = {
    CarruselSimple: 1,
    SimpleCentrado: 3,
    Banners: 4,
    ShowRoom: 5,
    OfertaDelDia: 6,
    CarruselIndividuales: 8,
    carruselIndividualesv2: 9,
    BannerInteractivo: 10
};

var CONS_CODIGO_SECCION = {
    LAN: "LAN",
    RD: "RD",
    RDR: "RDR",
    SR: "SR",
    ODD: "ODD",
    OPT: "OPT",
    DES: "DES-NAV",
    HV: "HV",
    MG: 'MG',
    ATP: 'ATP',
    DP: 'DP'
};

var listaSeccion = {};

var timer;
var indexPosCarruselLan = 0;

var varContenedor = {
    CargoRevista: false,
    CargoHv: false,
    CargoMg: false,
    CargoLan: false
}

var _constantesPalanca = ConstantesModule.TipoEstrategia;

$(document).ready(function () {
    SeccionRender();
});

function SeccionRender() {
    var listaSecciones = $(sElementos.seccion);
    if (listaSecciones.length === 0)
        return false;

    $.each(listaSecciones, function (ind, seccion) {
        $(seccion).find(sElementos.load).show();
        var objSeccion = SeccionObtenerSeccion(seccion);
        objSeccion.Codigo = $.trim(objSeccion.Codigo);
        if (objSeccion.Codigo !== "") {
            SeccionCargarProductos(objSeccion);
        }
        else {
            $(seccion).remove();
        }
    });
    $(document).ajaxStop(function () {
        VerificarSecciones();
    });
}

function VerificarSecciones() {
    var visibles = $(".seccion-estrategia-contenido").children(":visible").length;
    if (visibles == 0) {
        $("#no-productos").fadeIn();
    }
}

function SeccionObtenerSeccion(seccion) {

    var codigo = $.trim($(seccion).attr("data-seccion"));
    var campania = $.trim($(seccion).attr("data-campania"));
    var detalle = {};

    if (codigo === "" || campania === "")
        return detalle;

    var param = {
        Codigo: codigo,
        CampaniaId: campania,
        UrlObtenerProductos: $.trim($(seccion).attr("data-url")),
        TemplateProducto: $.trim($(seccion).attr("data-templateProducto")),
        TipoPresentacion: $.trim($(seccion).attr("data-tipoPresentacion")),
        TipoEstrategia: $.trim($(seccion).attr("data-tipoEstrategia")),
        CantidadProductos: $.trim($(seccion).attr("data-cantidadProductos"))
    };
    return param;

}

function SeccionCargarProductos(objConsulta) {
    objConsulta = objConsulta || {};
    objConsulta.UrlObtenerProductos = $.trim(objConsulta.UrlObtenerProductos);
    var mob = isMobile();
    if (mob && objConsulta.Codigo === CONS_CODIGO_SECCION.ODD) {
        $("#ODD").find(".seccion-loading-contenedor").fadeOut();
        $("#ODD").find(".seccion-content-contenedor").fadeIn();
    }
    else if (mob && objConsulta.Codigo === CONS_CODIGO_SECCION.SR) {

        $("#SR").find(".seccion-loading-contenedor").fadeOut();
        $("#SR").find(".seccion-content-contenedor").fadeIn();

    }

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.DES) {
        $("#" + objConsulta.Codigo).find(".seccion-loading-contenedor").fadeOut();
        $("#" + objConsulta.Codigo).find(".seccion-content-contenedor").fadeIn();
    }

    if (objConsulta.TipoPresentacion == CONS_TIPO_PRESENTACION.Banners) {
        $("#" + objConsulta.Codigo).find(".seccion-loading-contenedor").fadeOut();
        $("#" + objConsulta.Codigo).find(".seccion-content-contenedor").fadeIn();
    }

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.DP) {
        AnalyticsPortalModule.MarcaPromotionViewBanner('Contenedor - Inicio');
    }
    if (objConsulta.UrlObtenerProductos === "")
        return false;

    listaSeccion[objConsulta.Codigo + "-" + objConsulta.CampaniaId] = objConsulta;

    var guardaEnLS = true;

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.RDR || objConsulta.Codigo === CONS_CODIGO_SECCION.RD) {
        if (!varContenedor.CargoRevista) {
            varContenedor.CargoRevista = true;

            if (!GetTipoEstrategiaHabilitado(_constantesPalanca.RevistaDigital)) {
                guardaEnLS = false;
            }
            
            OfertaCargarProductos({
                VarListaStorage: "RDLista",
                UrlCargarProductos: baseUrl + objConsulta.UrlObtenerProductos,
                guardaEnLocalStorage: guardaEnLS,
                Palanca: objConsulta.Codigo
            }, false, objConsulta);
        }

        return false;
    }

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.HV) {
        if (!varContenedor.CargoHv) {
            varContenedor.CargoHv = true;

            if (!GetTipoEstrategiaHabilitado(_constantesPalanca.HerramientasVenta)) {
                guardaEnLS = false;
            }

            OfertaCargarProductos({
                VarListaStorage: "HVLista",
                UrlCargarProductos: baseUrl + objConsulta.UrlObtenerProductos,
                guardaEnLocalStorage: guardaEnLS,
                Palanca: objConsulta.Codigo
            }, false, objConsulta);
        }
        return false;
    }

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.MG) {
        if (!varContenedor.CargoMg) {
            varContenedor.CargoMg = true;
            guardaEnLS = false;
            OfertaCargarProductos({
                VarListaStorage: "MGLista",
                UrlCargarProductos: baseUrl + objConsulta.UrlObtenerProductos,
                guardaEnLocalStorage: guardaEnLS,
                Palanca: objConsulta.Codigo
            }, false, objConsulta);
        }
        return false;
    }

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.LAN) {
        if (!varContenedor.CargoLan) {
            varContenedor.CargoLan = true;

            if (!GetTipoEstrategiaHabilitado(_constantesPalanca.Lanzamiento)) {
                guardaEnLS = false;
            }

            OfertaCargarProductos({
                VarListaStorage: listaLAN,
                UrlCargarProductos: baseUrl + objConsulta.UrlObtenerProductos,
                guardaEnLocalStorage: guardaEnLS,
                Palanca: objConsulta.Codigo
            }, false, objConsulta);
        }
        return false;
    }

    var param = {
        codigo: objConsulta.Codigo,
        campaniaId: objConsulta.CampaniaId,
    }

    if (objConsulta.Codigo == CONS_CODIGO_SECCION.SR) {
        param.Limite = objConsulta.CantidadProductos;
    }

    if (objConsulta.Codigo == CONS_CODIGO_SECCION.HV || objConsulta.Codigo == CONS_CODIGO_SECCION.MG) {
        param.Limite = $("#" + objConsulta.Codigo).attr("data-cantidadProductos");
    }

    $.ajaxSetup({
        cache: false
    });


    $.ajax({
        type: 'post',
        url: baseUrl + objConsulta.UrlObtenerProductos,
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            if (data.success === true) {

                data.codigo = $.trim(data.codigo);
                if (data.codigo !== "") {
                    data.campaniaId = $.trim(data.campaniaId) || campaniaCodigo;
                    data.Seccion = listaSeccion[data.codigo + "-" + data.campaniaId]
                        || listaSeccion[data.codigoOrigen + "-" + data.campaniaId];
                    if (data.Seccion != undefined) {
                        SeccionMostrarProductos(data);
                    }
                    else {
                        console.error(data);
                    }
                }
            } else {
                if (objConsulta.Codigo == CONS_CODIGO_SECCION.ATP) {
                    MostrarBannerAtp();
                }
            }
        },
        error: function (error, x) {
        }
    });
}

function MostrarBannerAtp() {
    var htmlSeccion = $("[data-seccion=" + CONS_CODIGO_SECCION.ATP + "]");
    htmlSeccion.find('.atp_main').hide();
    htmlSeccion.find(".seccion-loading-contenedor").fadeOut();
    var imageUrl = "../Content/Images/arma_tu_pack/banner-arma-tu-pack-error.jpg";
    htmlSeccion.find(".container-flex.atp_container").css("background", "url(" + imageUrl + ")");
    htmlSeccion.find('.atp_alerta').fadeIn();
    $('#' + CONS_CODIGO_SECCION.ATP).find('.seccion-content-contenedor').fadeIn();
}

function GetTipoEstrategiaHabilitado(tipoEstrategia) {
    var tipoEstrategiaHabilitado = typeof variableEstrategia.TipoEstrategiaHabilitado == "string" && variableEstrategia.TipoEstrategiaHabilitado.indexOf(tipoEstrategia) > -1;
    return tipoEstrategiaHabilitado;
}

function SeccionMostrarProductos(data) {

    var CarruselCiclico = true;

    if (isMobile()) {
        if (data.Seccion.Codigo === CONS_CODIGO_SECCION.HV) {
            if (data.cantidadTotal == 0) {
                $("#" + data.Seccion.Codigo).find(".seccion-loading-contenedor").fadeOut();
                $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeOut();
                $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
                UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
                return false;
            }
        }
    }
    var htmlSeccion = $("[data-seccion=" + data.Seccion.Codigo + "]");
    if (htmlSeccion.length !== 1) {
        return false;
    }

    var divListadoProductos = htmlSeccion.find(sElementos.listadoProductos);
    if (data.Seccion.TipoPresentacion !== CONS_TIPO_PRESENTACION.BannerInteractivo.toString() && divListadoProductos.length !== 1) {
        if (data.Seccion !== undefined &&
            (data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.Banners.toString() ||
                data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.ShowRoom.toString() ||
                data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.OfertaDelDia.toString())) {

            $("#" + data.Seccion.Codigo).find(".seccion-loading-contenedor").fadeOut();
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        }
        return false;
    }

    if (data.Seccion === undefined)
        return false;

    data.Seccion.TemplateProducto = $.trim(data.Seccion.TemplateProducto);
    if ((data.Seccion.TemplateProducto === "" ||
        data.Seccion.Codigo === undefined) &&
        data.Seccion.Codigo != CONS_CODIGO_SECCION.ATP) {
        return false;
    }

    if (data.Seccion.Codigo != undefined) {
        $("#" + data.Seccion.Codigo).find(".seccion-loading-contenedor").fadeOut();
    }

    data.lista = data.lista || [];

    if (data.Seccion.Codigo === CONS_CODIGO_SECCION.LAN) {
        var tieneIndividual = false;
        $.each(data.listaLan, function (key, value) {
            if (value.TipoEstrategiaDetalle.FlagIndividual) {
                tieneIndividual = true;
            }
        });
        data.lista = new Array();
        data.lista = data.listaLan;
        if (data.listaLan !== undefined && data.listaLan.length > 0 && tieneIndividual) {
            if (data.guardaEnLocalStorage) {
                RDLocalStorageListado(listaLAN + data.campaniaId, data, CONS_CODIGO_SECCION.LAN);
            }
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        }
        else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    }
    else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.OPT) {
        if (data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        }
        else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    }
    else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.RDR) {
        if (data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeIn();

            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-total]").html(data.CantidadProductos);
            $("#" + data.Seccion.Codigo).find(sElementos.contadorProductos).fadeIn();

        } else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    }
    else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.ATP) {

        if (data.lista.length > 0) {
            var btnRedirect = htmlSeccion.find('button.atp_button'),
                pSubtitulo = htmlSeccion.find('p[data-subtitulo]');

            var subTitulo = pSubtitulo.data('subtitulo')
                .replace('#Cantidad', data.lista[0].CantidadPack)
                .replace('#PrecioTotal', variablesPortal.SimboloMoneda + " " + data.lista[0].PrecioVenta);

            pSubtitulo.html(subTitulo);

            if (data.estaEnPedido) {
                btnRedirect.attr('data-popup', true);
                btnRedirect.html(btnRedirect.data('modifica'));
            }
            else {
                btnRedirect.attr('data-popup', false);
                btnRedirect.html(btnRedirect.data('crea'));
            }
            $('#' + data.Seccion.Codigo).find('.seccion-content-contenedor').fadeIn();

            if (!(typeof AnalyticsPortalModule === 'undefined'))
            {
                var codigoubigeoportal = $('#' + data.Seccion.Codigo).attr('data-codigoubigeoportal');
                AnalyticsPortalModule.MarcaPromotionViewArmaTuPack(codigoubigeoportal, data.lista[0], data.estaEnPedido);
            }
        }
        else {
            $('.subnavegador').find('[data-codigo=' + data.Seccion.Codigo + ']').fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    }
    else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.HV
        || data.Seccion.Codigo === CONS_CODIGO_SECCION.MG
        || data.Seccion.Codigo === CONS_CODIGO_SECCION.SR
        || data.Seccion.Codigo === CONS_CODIGO_SECCION.RD) {

        if (data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
            var cantidadTotal = 0;
            var cantidadAMostrar = parseInt($("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-mostrar]").html());

            if (data.Seccion.Codigo === CONS_CODIGO_SECCION.SR) {
                cantidadTotal = data.cantidadTotal0;
            }
            else {
                cantidadTotal = data.cantidadTotal;
            }

            if (cantidadTotal <= cantidadAMostrar) {
                $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-mostrar]").html(cantidadTotal);
                if (data.Seccion.Codigo === CONS_CODIGO_SECCION.MG
                    || data.Seccion.Codigo === CONS_CODIGO_SECCION.SR
                    || data.Seccion.Codigo === CONS_CODIGO_SECCION.RD) {
                    $("#" + data.Seccion.Codigo).find(sElementos.verMas).remove();
                    $("#" + data.Seccion.Codigo).find(sElementos.contadorProductos).remove();
                }
            }
            else {
                if (data.Seccion.Codigo === CONS_CODIGO_SECCION.MG
                    || data.Seccion.Codigo === CONS_CODIGO_SECCION.SR
                    || data.Seccion.Codigo === CONS_CODIGO_SECCION.HV
                    || data.Seccion.Codigo === CONS_CODIGO_SECCION.RD) {
                    $("#" + data.Seccion.Codigo).find(sElementos.verMas).show();
                    if (data.objBannerCajaProducto != undefined) {
                        data.lista.push(data.objBannerCajaProducto);
                    }
                }
            }
            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-total]").html(cantidadTotal);
            $("#" + data.Seccion.Codigo).find(sElementos.contadorProductos).fadeIn();
        }
        else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    }

    data.Mobile = isMobile();

    if (data.lista) {
        $.each(data.lista, function (i, item) {
            item.EsBanner = false;
            item.EsLanzamiento = false;
            item.Posicion = i + 1;
        });
    }

    SetHandlebars(data.Seccion.TemplateProducto, data, divListadoProductos);

    if (data.Seccion.TemplateProducto == "#producto-landing-template") {
        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");
    }
    CarruselCiclico = data.Seccion.TipoPresentacion != CONS_TIPO_PRESENTACION.carruselIndividualesv2;

    CarruselCiclico = data.Seccion.TipoPresentacion != CONS_TIPO_PRESENTACION.carruselIndividualesv2;
    if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.CarruselSimple) {
        RenderCarruselSimple(htmlSeccion, data, CarruselCiclico);
    }
    else if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.CarruselIndividuales) {
        RenderCarruselIndividuales(htmlSeccion, data);
    }
    else if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.carruselIndividualesv2) {
        RenderCarruselSimpleV2(htmlSeccion, data, CarruselCiclico);
    }
    else if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.SimpleCentrado) {
        var origen = {
            Pagina: CodigoOrigenPedidoWeb.CodigoEstructura.Pagina.Contenedor,
            CodigoPalanca: data.Seccion.Codigo
        };
        var obj = {
            lista: data.lista,
            CantidadMostrar: data.lista.length,
            Origen: origen
        };

        AnalyticsPortalModule.MarcaGenericaLista("", obj);
    }
}

function UpdateSessionState(codigo, campaniaId) {
    var param = {
        codigo: codigo,
        campaniaId: campaniaId,
    }

    $.ajax({
        type: "POST",
        url: baseUrl + "Ofertas/ActualizarSession",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        success: function (data) { },
        error: function (error, x) { }
    });
}

// Ini - Render Carrusel
function RenderCarruselIndividuales(divProd, data) {

    if (typeof divProd == "undefined")
        return false;

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));

    divProd.find(sElementos.listadoProductos + '.slick-initialized').slick('unslick');
    divProd.find(sElementos.listadoProductos).not('.slick-initialized').slick({
        lazyLoad: 'ondemand',
        infinite: true,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        speed: 500,
        autoplay: true,
        autoplaySpeed: 6000,
        prevArrow: '<a class="arrow-prev" data-direccionflecha="Anterior" onclick="AnalyticsPortalModule.MarcaClicFlechaBanner(this)"><img src="' + baseUrl + 'Content/Images/sliders/previous_ofertas.svg")" alt="" /></a>',
        nextArrow: '<a class="arrow-next" data-direccionflecha="Siguiente" onclick="AnalyticsPortalModule.MarcaClicFlechaBanner(this)"><img src="' + baseUrl + 'Content/Images/sliders/next_ofertas.svg")" alt="" /></a>'
    }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
        VerificarClick(slick, currentSlide, nextSlide, "previsuales");
    }).on("afterChange", function (event, slick, currentSlide, nextSlide) {

        var data = $(slick.$slides.find("[data-estrategia]")[currentSlide]).data("estrategia");
        var dateItem = new Array(data);

        indexPosCarruselLan = currentSlide;

        if (data.CodigoPalanca == ConstantesModule.CodigoPalanca.LAN) {
            AnalyticsPortalModule.MarcaPromotionView(data.CodigoPalanca, dateItem, currentSlide);
        }
        else {
            AnalyticsPortalModule.MarcaGenericaLista(data.CodigoPalanca, dateItem, currentSlide);
        }

        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] p").removeClass("Acortar2Renglones3puntos");
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] p").addClass("Acortar2Renglones3puntos");
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] span").removeClass("Acortar3Renglones3puntos");
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] span").addClass("Acortar3Renglones3puntos");
    });

    $.each(data.lista, function (key, value) {
        if (value.TipoEstrategiaDetalle.FlagIndividual) {
            var dateItem = new Array(value);

            if (data.Seccion.Codigo == ConstantesModule.CodigoPalanca.LAN) {
                AnalyticsPortalModule.MarcaPromotionView(data.Seccion.Codigo, dateItem, 0);
            }
            else {
                AnalyticsPortalModule.MarcaGenericaLista(data.Seccion.Codigo, dateItem, 0);
            }

            return false;
        }
    });

}

function RenderCarruselSimple(divProd, data, cc) {

    if (typeof divProd == "undefined")
        return false;

    var seccionName = data.Seccion.Codigo;

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));
    var esMobile = isMobile();
    var slidesToShow = esMobile ? 1 : 3;
    divProd.find(sElementos.listadoProductos + ".slick-initialized").slick("unslick");
    divProd.find(sElementos.listadoProductos).not(".slick-initialized").slick({
        lazyLoad: "ondemand",
        infinite: cc == undefined ? true : cc,
        vertical: false,
        slidesToShow: slidesToShow,
        slidesToScroll: 1,
        autoplay: false,
        variableWidth: !esMobile,
        speed: 260,
        prevArrow: '<a  class="prevArrow" style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" /></a>',
        nextArrow: '<a  class="nextArrow" style="display: block;right: 0;margin-right: -5%; text-align: right; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" /></a>'
    }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
        CarruselAyuda.MarcarAnalyticsContenedor(2, null, seccionName, slick, currentSlide, nextSlide);
    });

    divProd.find(sElementos.listadoProductos).css("overflow-y", "visible");

    CarruselAyuda.MarcarAnalyticsContenedor(1, data, seccionName, null, slidesToShow);
}

function RenderCarruselSimpleV2(divProd, data, cc) {
    if (typeof divProd == "undefined")
        return false;

    var seccionName = data.Seccion.Codigo;

    divProd.find(sElementos.listadoProductos).attr("class", "contenedor_carrusel");

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));
    var esMobile = isMobile();
    var slidesToShow = esMobile ? 2 : 3;
    divProd.find(sElementos.listadoProductos + ".slick-initialized").slick("unslick");
    divProd.find(sElementos.listadoProductos).not(".slick-initialized").slick({
        lazyLoad: "ondemand",
        infinite: cc == undefined ? true : cc,
        vertical: false,
        slidesToShow: slidesToShow,
        slidesToScroll: 1,
        autoplay: false,
        variableWidth: true,
        speed: 260,
        arrows: !esMobile,
        prevArrow: '<a class="prevArrow" style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" /></a>',
        nextArrow: '<a class="nextArrow" style="display: block;right: 0;margin-right: -5%; text-align: right; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" /></a>'
    }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
        CarruselAyuda.MarcarAnalyticsContenedor(2, null, seccionName, slick, currentSlide, nextSlide);
    }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
        CarruselAyuda.MarcarAnalyticsContenedor(3, event, seccionName, slick, currentSlide);
    });

    divProd.find(sElementos.listadoProductos).css("overflow-y", "visible");

    if (!cc) {
        $('.prevArrow').hide();
    }

    CarruselAyuda.MarcarAnalyticsContenedor(1, data, seccionName, null, slidesToShow);
}

// Fin - Render Carrusel

// Ini - Metodo para virtualEvent 
function VerificarClick(slick, currentSlide, nextSlide, source, seccionName) {
    if ((currentSlide > nextSlide && (nextSlide !== 0 || currentSlide === 1))
        || (currentSlide === 0 && nextSlide === slick.slideCount - 1)) {
        CheckClickCarrousel("prev", source, seccionName);
    }
    else {
        CheckClickCarrousel("next", source, seccionName);
    }
}

function CheckClickCarrousel(action, source, seccionName) {
    var sliderWay = 0;
    if (action === "next") {
        sliderWay = 1;
    } else {
        sliderWay = 2;
    }

    var clickedSlider = 0;
    if (source === "normal") {
        clickedSlider = 1;
    }

    CallAnalitycsClickArrow(seccionName, sliderWay, clickedSlider);
}

function CallAnalitycsClickArrow(seccionName, sliderWay, clickedSlider) {

    if (sliderWay !== 0 && clickedSlider !== 0) {
        if (seccionName === "MG") {
            if (typeof AnalyticsPortalModule !== "undefined") {
                AnalyticsPortalModule.ClickArrowMG(sliderWay);
            }
        } else {
            if (typeof rdAnalyticsModule !== "undefined") {
                rdAnalyticsModule.ClickArrowLan(sliderWay);
            }
        }
    }
}

// Fin - Metodo para virtualEvent
