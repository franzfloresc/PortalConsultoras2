var sElementos = {
    seccion: "[data-seccion]",
    load: "[data-seccion-load]",
    listadoProductos: "[data-seccion-productos]",
    verMas: "[data-seccion-vermas]",
    contadorProductos: "[data-productos-info]"
};

var listaLAN = listaLAN || "LANLista";

var CONS_TIPO_PRESENTACION = {
    CarruselSimple: 1,
    CarruselPrevisuales: 2,
    SimpleCentrado: 3,
    Banners: 4,
    ShowRoom: 5,
    OfertaDelDia: 6,
    CarruselIndividuales: 8,
    carruselIndividualesv2: 9
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
    MG: 'MG'
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

    if (objConsulta.UrlObtenerProductos === "")
        return false;

    listaSeccion[objConsulta.Codigo + "-" + objConsulta.CampaniaId] = objConsulta;

    var paisHabilitado = typeof variableEstrategia.PaisHabilitado == "string" && variableEstrategia.PaisHabilitado.indexOf(IsoPais) > -1

    var guardaEnLS = true;

    if (objConsulta.Codigo === CONS_CODIGO_SECCION.RDR || objConsulta.Codigo === CONS_CODIGO_SECCION.RD) {
        if (!varContenedor.CargoRevista) {
            varContenedor.CargoRevista = true;

            var tipoEstrategiaHabilitado = typeof variableEstrategia.TipoEstrategiaHabilitado == "string" && variableEstrategia.TipoEstrategiaHabilitado.indexOf('101') > -1
            if (paisHabilitado && tipoEstrategiaHabilitado) {
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
            }
        },
        error: function (error, x) {
        }
    });
}

function SeccionMostrarProductos(data) {
    console.log(data.Seccion.Codigo, data);
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

    ////Marcación Analytics
    //if (data.Seccion.Codigo === CONS_CODIGO_SECCION.LAN) {
    //    if (varContenedor.CargoLan) {
    //        $.each(data.listaLan, function (key, value) {
    //            if (value.TipoEstrategiaDetalle.FlagIndividual) {
    //                var dateItem = new Array(value);
    //                AnalyticsPortalModule.MarcaGenericaLista(data.Seccion.Codigo, dateItem, 0);
    //                return false;
    //            }
    //        });
    //    }
    //    //get the first
    //}
    //Marcación Analytics Más GANADORAS
    if (data.Seccion.Codigo === CONS_CODIGO_SECCION.MG) {
        if (varContenedor.CargoMg) {
            //$.each(data.lista, function (key, value) {
            //        var dateItem = new Array(value);
            //        AnalyticsPortalModule.MarcaGenericaLista(data.Seccion.Codigo, dateItem);
            //        return false;
            //});
            //var dateItem = new Array(value);
            AnalyticsPortalModule.MarcaGenericaLista(data.Seccion.Codigo, data);
        }
        //get the first
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
            RDLocalStorageListado(listaLAN + data.campaniaId, data, CONS_CODIGO_SECCION.LAN);
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
    else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.RDR)
        //else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.RD || data.Seccion.Codigo === CONS_CODIGO_SECCION.RDR)
    {
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
        //else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.SR)
        //{
        //    // esta logica es para Intriga
        //    if (data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.ShowRoom.toString()) {
        //        if (data.lista.length == 0) {
        //            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor .bloque-titulo .cantidad > span").hide();
        //        }
        //        else {
        //            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-mostrar]").html(data.cantidadAMostrar);
        //            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-total]").html(data.cantidadTotal0);
        //            $("#" + data.Seccion.Codigo).find("[data-productos-info]").fadeIn();
        //        }
        //        $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        //    }
        //    else
        //    {
        //        $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
        //    }

        //    if (data.Seccion.TipoPresentacion === CONS_TIPO_PRESENTACION.SimpleCentrado.toString()) {
        //        if (data.lista.length > 0) {
        //            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
        //            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeIn();
        //            $("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-total]").html(data.cantidadTotal);
        //            $("#" + data.Seccion.Codigo).find("[data-productos-info]").fadeIn();
        //        }
        //        else
        //        {
        //            $(".subnavegador").find("[data-codigo=" + data.Seccion.Codigo + "]").fadeOut();
        //        }
        //    }
        //}
    else if (data.Seccion.Codigo === CONS_CODIGO_SECCION.HV
        || data.Seccion.Codigo === CONS_CODIGO_SECCION.MG
        || data.Seccion.Codigo === CONS_CODIGO_SECCION.SR
        || data.Seccion.Codigo === CONS_CODIGO_SECCION.RD) {
        if (data.Seccion.Codigo === CONS_CODIGO_SECCION.MG
            || data.Seccion.Codigo === CONS_CODIGO_SECCION.SR
            || data.Seccion.Codigo === CONS_CODIGO_SECCION.RD) {
            CarruselCiclico = false;
        }

        if (data.lista.length > 0) {
            $("#" + data.Seccion.Codigo).find(".seccion-content-contenedor").fadeIn();
            var cantidadTotal = 0;
            var cantidadAMostrar = parseInt($("#" + data.Seccion.Codigo).find("[data-productos-info] [data-productos-mostrar]").html());

            console.log('cantidadTotal-0', cantidadAMostrar, data);

            if (data.Seccion.Codigo === CONS_CODIGO_SECCION.SR) {
                cantidadTotal = data.cantidadTotal0;
            }
            else {
                cantidadTotal = data.cantidadTotal;
            }

            if (cantidadTotal <= cantidadAMostrar) {
                //if (data.cantidadTotal <= cantidadAMostrar) {
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
        });
    }

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
        RenderCarruselSimple(htmlSeccion, CarruselCiclico);
    }
    else if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.CarruselIndividuales) {
        RenderCarruselIndividuales(htmlSeccion, data);
    }
    else if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.carruselIndividualesv2) {
        RenderCarruselSimpleV2(htmlSeccion, CarruselCiclico, true);
    }
}

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
        console.log('RenderCarruselIndividuales', event, slick, currentSlide, nextSlide);
        var data = $(slick.$slides.find("[data-estrategia]")[currentSlide]).data("estrategia");
        var dateItem = new Array(data);
        console.log('RenderCarruselIndividuales', dateItem);
        indexPosCarruselLan = currentSlide;
        //Analytics
        AnalyticsPortalModule.MarcaGenericaLista(data.CodigoPalanca, dateItem, currentSlide);

        EstablecerLazyCarruselAfterChange(divProd.find(sElementos.listadoProductos));
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] p").removeClass("Acortar2Renglones3puntos");
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] p").addClass("Acortar2Renglones3puntos");
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] span").removeClass("Acortar3Renglones3puntos");
        $(sElementos.listadoProductos + " .slick-active [data-acortartxt] span").addClass("Acortar3Renglones3puntos");
    });

    //Marcación Analytics
    $.each(data.lista, function (key, value) {
        if (value.TipoEstrategiaDetalle.FlagIndividual) {
            var dateItem = new Array(value);
            AnalyticsPortalModule.MarcaGenericaLista(data.Seccion.Codigo, dateItem, 0);
            return false;
        }
    });

}

function RenderCarruselPrevisuales(divProd) {
    if (typeof divProd == "undefined")
        return false;

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));

    divProd.find(sElementos.listadoProductos + ".slick-initialized").slick("unslick");
    divProd.find(sElementos.listadoProductos).not(".slick-initialized").slick({
        lazyLoad: "ondemand",
        vertical: false,
        dots: false,
        infinite: true,
        speed: 500,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        prevArrow: '<div class="btn-set-previous div-carousel-rd-prev-fix-carousel div-carousel-rd-prev"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-prev"><img src="' + baseUrl + "Content/Images/RevistaDigital/" + GetArrowNamePrev() + '" alt="" /></a></div>',
        nextArrow: '<div class="btn-set-previous div-carousel-rd-next-fix-carousel div-carousel-rd-next"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-next"><img src="' + baseUrl + "Content/Images/RevistaDigital/" + GetArrowNameNext() + '" alt="" /></a></div>'
    }).on("afterChange", function (event, slick, currentSlide) {
        EstablecerLazyCarruselAfterChange(divProd.find(sElementos.listadoProductos));

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
    }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
        VerificarClick(slick, currentSlide, nextSlide, "previsuales");
    });
}

function RenderCarruselSimple(divProd, cc) {


    if (typeof divProd == "undefined")
        return false;


    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));

    divProd.find(sElementos.listadoProductos + ".slick-initialized").slick("unslick");
    divProd.find(sElementos.listadoProductos).not(".slick-initialized").slick({
        lazyLoad: "ondemand",
        infinite: cc == undefined ? true : cc,
        vertical: false,
        slidesToShow: isMobile() ? 1 : 3,
        slidesToScroll: 1,
        autoplay: false,
        variableWidth: !isMobile(),
        speed: 260,
        prevArrow: '<a  class="prevArrow" style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" /></a>',
        nextArrow: '<a  class="nextArrow" style="display: block;right: 0;margin-right: -5%; text-align: right; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" /></a>'
    }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
        VerificarClick(slick, currentSlide, nextSlide, "normal");
    }).on("afterChange", function (event, slick, currentSlide, nextSlide) {

        EstablecerLazyCarruselAfterChange(divProd.find(sElementos.listadoProductos));

    });

    divProd.find(sElementos.listadoProductos).css("overflow-y", "visible");

}

function ShowOrHide_Arrows(event, slick, currentSlide) {
    console.log('ShowOrHide_Arrows', event, slick, currentSlide);
    var objPrevArrow = $(event.target).find('.prevArrow')[0];
    var objNextArrow = $(event.target).find('.nextArrow')[0];
    var objVisorSlick = $(event.target).find('.slick-list')[0];
    var lastSlick = $(event.target).find('[data-slick-index]')[slick.slideCount - 1];

    if (currentSlide === 0) {
        $(objPrevArrow).hide();
        $(objNextArrow).show();
    }
    else {

        var item = currentSlide;
        var anchoFalta = 0;
        do {
            anchoFalta += $(slick.$slides[item]).innerWidth();
            item++;
        } while (item < slick.slideCount);

        if (anchoFalta > $(slick.$list).width()) {
            var currentSlideback = $(slick.$list).attr('data-currentSlide') || $(slick.$list).attr('data-currentslide') || "";
            if (currentSlideback == currentSlide) {
                slick.options.slidesToShow = isMobile() ? 1 : 2;
                slick.setPosition();
                slick.slickGoTo(currentSlide + 1);
                currentSlide = currentSlide + 1;

                $(objPrevArrow).show();
                $(objNextArrow).hide();
                marcaAnalyticsViewVerMas();
            }
            else {
                $(objPrevArrow).show();
                $(objNextArrow).show();
            }
        }
        else {
            var cantFinal = slick.slideCount - slick.options.slidesToShow;
            if (cantFinal === currentSlide) {
                $(objPrevArrow).show();
                $(objNextArrow).hide();
                marcaAnalyticsViewVerMas();
            }
        }
    }

    $(slick.$list).attr('data-currentSlide', currentSlide);

}
//Función para marcar los productos en el carrusel de una palanca (en este caso Mas Ganadoras - MG)

function MarcarProductos_Arrows(event, slick, currentSlide, seccionName) {

    if (seccionName === ConstantesModule.TipoEstrategia.MG) {
        var pos = isMobile() ? 1 : 2;
        var slideToMark = currentSlide + pos;
        var item = $(event.target).find('[data-slick-index]')[slideToMark];
        var data = $($(item).find("[data-estrategia]")[0]).data("estrategia");
        data = data || "";
        if (data !== "") {
            data.lista = Array(data);
            if (typeof AnalyticsPortalModule !== "undefined") {
                AnalyticsPortalModule.MarcaGenericaLista(seccionName, data);
            }
        }
    }


    //if (anchoFalta > $(slick.$list).width()) {
    //var currentSlideback = $(slick.$list).attr('data-currentSlide') || $(slick.$list).attr('data-currentslide') || "";  
    //$(slick.$list).attr('data-currentSlide', currentSlide);

}
//Función que llama la la funcion de marcacion analytics cuando se visualiza el ultimo botón dorado de "ver más"
function marcaAnalyticsViewVerMas() {
    if (typeof AnalyticsPortalModule !== "undefined") {
        AnalyticsPortalModule.MarcaPromotionViewCarrusel();
    }
}

function RenderCarruselSimpleV2(divProd, cc, vw) {
    var seccionName = divProd.data("seccion") || "";
    if (typeof divProd == "undefined")
        return false;

    vw = vw || true;

    divProd.find(sElementos.listadoProductos).attr("class", "contenedor_carrusel");

    EstablecerLazyCarrusel(divProd.find(sElementos.listadoProductos));
    var esMobile = isMobile();
    divProd.find(sElementos.listadoProductos + ".slick-initialized").slick("unslick");
    divProd.find(sElementos.listadoProductos).not(".slick-initialized").slick({
        lazyLoad: "ondemand",
        infinite: cc == undefined ? true : cc,
        vertical: false,
        slidesToShow: esMobile ? 2 : 3,
        slidesToScroll: 1,
        autoplay: false,
        variableWidth: vw,
        speed: 300,
        arrows: !esMobile,
        prevArrow: '<a  class="prevArrow" style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_black_compra.png")" alt="" /></a>',
        nextArrow: '<a  class="nextArrow" style="display: block;right: 0;margin-right: -5%; text-align: right; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_black_compra.png")" alt="" /></a>'
    }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
        //VerificarClick(slick, currentSlide, nextSlide, "normal");

        VerificarClick(slick, currentSlide, nextSlide, "normal", seccionName);
    }).on("afterChange", function (event, slick, currentSlide, nextSlide) {
        console.log(cc);
        if (!cc) {
            ShowOrHide_Arrows(event, slick, currentSlide);
            MarcarProductos_Arrows(event, slick, currentSlide, seccionName);
        }
        EstablecerLazyCarruselAfterChange(divProd.find(sElementos.listadoProductos));
    });

    divProd.find(sElementos.listadoProductos).css("overflow-y", "visible");


    if (!cc) {
        $('.prevArrow').hide();
    }
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
        type: "POST",
        url: baseUrl + "Ofertas/ActualizarSession",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
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

function VerificarClick(slick, currentSlide, nextSlide, source, seccionName) {

    if (typeof CheckClickCarrousel !== "undefined" && typeof CheckClickCarrousel === "function") {
        if ((currentSlide > nextSlide && (nextSlide !== 0 || currentSlide === 1)) || (currentSlide === 0 && nextSlide === slick.slideCount - 1)) {
            CheckClickCarrousel("prev", source, seccionName);
        }
        else {
            CheckClickCarrousel("next", source, seccionName);
        }
    }
}