﻿
var sElementos = {
    seccion: '[data-seccion]',
    load: '[data-seccion-load]',
    listadoProductos: "[data-seccion-productos]"
};

var CONS_TIPO_PRESENTACION = {
    CarruselSimple: 1,
    CarruselPrevisuales: 2,
    SimpleCentrado: 3,
    Banners: 4,
    ShowRoom: 5,
    OfertaDelDia: 6,
};

var CONS_CODIGO_SECCION = {
    LAN: "LAN",
    RD: "RD",
    RDR: "RDR",
    SR: "SR",
    ODD: "ODD",
    OPT: "OPT",
    DES: "DES-NAV",
    HV: "HV"
};

var listaSeccion = {};

var timer;

var varContenedor = {
    CargoRevista: false
}

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
    }
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

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.DES) {
        $("#" + objConsulta.Codigo).find(".seccion-loading-contenedor").fadeOut();
        $("#" + objConsulta.Codigo).find(".seccion-content-contenedor").fadeIn();
    }

    if (objConsulta.TipoPresentacion == CONS_TIPO_PRESENTACION.Banners) {
        $("#" + objConsulta.Codigo).find(".seccion-loading-contenedor").fadeOut();
        $("#" + objConsulta.Codigo).find(".seccion-content-contenedor").fadeIn();
    }

    if (objConsulta.UrlObtenerProductos === "")
        return false;

    listaSeccion[objConsulta.Codigo + "-" + objConsulta.CampaniaId] = objConsulta;

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.RDR
        || objConsulta.Codigo === CONS_CODIGO_SECCION.RD) {
        if (!varContenedor.CargoRevista) {
            varContenedor.CargoRevista = true;
            OfertaCargarProductos(null, false, objConsulta);
        }
        return false;
    }

    var param = {
        codigo: objConsulta.Codigo,
        campaniaId: objConsulta.CampaniaId,
    }

    if (objConsulta.Codigo == CONS_CODIGO_SECCION.SR) {
        param.Limite = 3;
    }

    if (objConsulta.Codigo == CONS_CODIGO_SECCION.HV) {
        param.Limite = $("#" + objConsulta.Codigo).attr("data-cantidadProductos");
    }

    $.ajaxSetup({
        cache: false
    });

    $.ajax({
        type: 'POST',
        url: baseUrl + objConsulta.UrlObtenerProductos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            if (data.success === true) {
                data.codigo = $.trim(data.codigo);
                if (data.codigo !== "") {
                    data.campaniaId = $.trim(data.campaniaId) || campaniaCodigo;
                    data.Seccion = listaSeccion[data.codigo + "-" + data.campaniaId];
                    SeccionMostrarProductos(data);
                }
            }
        },
        error: function (error, x) {
        }
    });
}

function SeccionMostrarProductos(data) {
    var htmlSeccion = $("[data-seccion=" + data.Seccion.Codigo + "]");
    if (htmlSeccion.length !== 1) {
        return false;
    }

    var divListadoProductos = htmlSeccion.find(sElementos.listadoProductos);
    if (divListadoProductos.length !== 1) {
        if (data.Seccion !== undefined &&
            (data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.Banners.toString() ||            
            data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.ShowRoom.toString() ||
            data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.OfertaDelDia.toString())) {
            $("#" + data.Seccion.Codigo).find(".seccion-loading-contenedor").fadeOut();
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        }
        return false;
    }

    data.Seccion.TemplateProducto = $.trim(data.Seccion.TemplateProducto);
    if (data.Seccion.TemplateProducto === "") {
        return false;
    }

    if (data.Seccion === undefined)
        return false;

    if (data.Seccion.Codigo != undefined) {
        $("#" + data.Seccion.Codigo).find(".seccion-loading-contenedor").fadeOut();
    }

    if (data.Seccion.Codigo === CONS_CODIGO_SECCION.LAN) {
        if (data.listaLan !== undefined && data.listaLan.length > 0) {
            RDLocalStorageListado(lsListaRD + data.campaniaId, data, CONS_CODIGO_SECCION.LAN);
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        } else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    } else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.OPT) {
        if (data.lista !== undefined && data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        } else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    } else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.RD || data.Seccion.Codigo === CONS_CODIGO_SECCION.RDR) {
        if (data.lista !== undefined && data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeIn();

            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-total]").html(data.CantidadProductos);
            $("#" + data.Seccion.Codigo).find("[data-productos-info]").fadeIn();

        } else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    } else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.SR) {
        if (data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.ShowRoom.toString()) {
            data.data = data.data || [];
            if (data.data.length == 0) {
                $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor .bloque-titulo .cantidad > span").hide();
            }
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        } else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
        }
    } else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.HV) {
        if (data.lista !== undefined && data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-total]").html(data.cantidadTotal);
            $("#" + data.Seccion.Codigo).find("[data-productos-info]").fadeIn();
        } else {
            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
            UpdateSessionState(data.Seccion.Codigo, data.campaniaId);
        }
    }

    data.Mobile = isMobile();

    SetHandlebars(data.Seccion.TemplateProducto, data, divListadoProductos);

    if (data.Seccion.TemplateProducto == "#producto-landing-template") {
        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");
    }

    if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.CarruselPrevisuales) {
        if (isMobile()) {
            RenderCarruselSimple(htmlSeccion);
        }
        else {
            RenderCarruselPrevisuales(htmlSeccion);
        }
    }
    else if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.CarruselSimple) {
        RenderCarruselSimple(htmlSeccion);
    }
}

function RenderCarruselPrevisuales(divProd) {
    if (typeof divProd == "undefined")
        return false;

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));

    divProd.find(sElementos.listadoProductos + '.slick-initialized').slick('unslick');
    divProd.find(sElementos.listadoProductos).not('.slick-initialized').slick({
        lazyLoad: 'ondemand',
        vertical: false,
        dots: false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        prevArrow: '<div class="btn-set-previous div-carousel-rd-prev-fix-carousel div-carousel-rd-prev"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-prev"><img src="' + baseUrl + 'Content/Images/RevistaDigital/' + GetArrowNamePrev() + '" alt="" /></a></div>',
        nextArrow: '<div class="btn-set-previous div-carousel-rd-next-fix-carousel div-carousel-rd-next"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-next"><img src="' + baseUrl + 'Content/Images/RevistaDigital/' + GetArrowNameNext() + '" alt="" /></a></div>'
    }).on('afterChange', function (event, slick, currentSlide) {

        var slides = (slick || new Object()).$slides || new Array();
        if (slides.length == 0) {
            return false;
        }

        var prev = -1, next = slides.length;
        $.each(slides, function (ind, item) {
            var itemSel = $(item);
            if ($(itemSel).hasClass("slick-active")) {
                prev = prev < 0 ? ind : prev;
                next = prev < 0 ? next : ind;
            }
        });

        prev = prev == 0 ? slides.length - 1 : (prev - 1);
        next = next == slides.length - 1 ? 0 : (next + 1);

        var imgPrevia = $.trim($(slides[prev]).attr("data-ImgPrevia"));
        slick.$prevArrow.find("img[data-prev]").attr("src", imgPrevia);
        if (imgPrevia == "") {
            slick.$prevArrow.find("img[data-prev]").hide();
        }
        else {
            slick.$prevArrow.find("img[data-prev]").show();
        }
        imgPrevia = $.trim($(slides[next]).attr("data-ImgPrevia"));
        slick.$nextArrow.find("img[data-prev]").attr("src", imgPrevia);
        if (imgPrevia == "") {
            slick.$nextArrow.find("img[data-prev]").hide();
        }
        else {
            slick.$nextArrow.find("img[data-prev]").show();
        }
    });
}

function RenderCarruselSimple(divProd) {
    if (typeof divProd == "undefined")
        return false;

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));

    divProd.find(sElementos.listadoProductos + '.slick-initialized').slick('unslick');
    divProd.find(sElementos.listadoProductos).not('.slick-initialized').slick({
        lazyLoad: 'ondemand',
        infinite: true,
        vertical: false,
        slidesToShow: isMobile() ? 1 : 3,
        slidesToScroll: 1,
        autoplay: false,
        speed: 260,
        prevArrow: '<a class="" style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" /></a>',
        nextArrow: '<a class="" style="display: block;right: 0;margin-right: -5%; text-align: right; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" /></a>'
    });

    divProd.find(sElementos.listadoProductos).css("overflow-y", "visible");
}

function GetArrowNamePrev() {
    if (isMobile()) return "previous_mob.png";
    else return "previous.png";
}

function GetArrowNameNext() {
    if (isMobile()) return "next_mob.png";
    else return "next.png";
}

function UpdateSessionState(codigo, campaniaId) {
    var param = {
        codigo: codigo,
        campaniaId: campaniaId,
    }

    $.ajax({
        type: 'POST',
        url: baseUrl + "Ofertas/ActualizarSession",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        success: function (data) { },
        error: function (error, x) { }
    });
}

function VerificarSecciones() {
    var visibles = $(".seccion-estrategia-contenido").children(":visible").length;
    if (visibles == 0) {
        $("#no-productos").fadeIn();
    }
}