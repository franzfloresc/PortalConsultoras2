
var sElementos = {
    seccion: '[data-seccion]',
    load: '[data-seccion-load]',
    listadoProductos: "[data-seccion-productos]"
};

var cUrl = {
    UrlObtenerSeccion: baseUrl + 'Ofertas/ObtenerSeccion'
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
};

var listaSeccion = {};

var timer;

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

}

function SeccionObtenerSeccion(seccion) {
    var codigo = $.trim($(seccion).data("seccion"));
    var campania = $.trim($(seccion).data("campania"));
    var detalle = {};

    if (codigo === "" || campania === "")
        return detalle;

    $.ajaxSetup({
        cache: false
    });

    var param = {
        codigo: codigo,
        campaniaId: campania
    }

    $.ajax({
        type: 'POST',
        url: cUrl.UrlObtenerSeccion,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: false,
        success: function (data) {
            detalle = data.seccion || {};
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });

    return detalle;
}

function SeccionCargarProductos(objConsulta) {
    
    objConsulta = objConsulta || {};
    if (typeof objConsulta.UrlObtenerProductos === "undefined" || objConsulta.UrlObtenerProductos == null)
        return false;

    listaSeccion[objConsulta.Codigo + "-" + objConsulta.CampaniaID] = objConsulta;

    if (objConsulta.Codigo == CONS_CODIGO_SECCION.LAN
        || objConsulta.Codigo == CONS_CODIGO_SECCION.RDS
        || objConsulta.Codigo == CONS_CODIGO_SECCION.RD) {
        OfertaCargarProductos(null, false, objConsulta);
        return false;
    }

    var param = {
        codigo: objConsulta.Codigo,
        campaniaId: objConsulta.CampaniaID
    }

    if (objConsulta.Codigo == CONS_CODIGO_SECCION.SR) {
        param.Limite = 3;
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
            data.Seccion = listaSeccion[objConsulta.Codigo + "-" + objConsulta.CampaniaID];
            SeccionMostrarProductos(data);
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });    
}

function SeccionMostrarProductos(data) {
    var htmlSeccion = $("[data-seccion=" + data.Seccion.Codigo + "]");
    if (htmlSeccion.length !== 1) {
        console.log(data.Seccion);
        return false
    }
    
    var divListadoProductos = htmlSeccion.find(sElementos.listadoProductos);
    if (divListadoProductos.length !== 1) {
        console.log(data.Seccion);
        return false
    }
    
    data.Seccion.TemplateProducto = $.trim(data.Seccion.TemplateProducto);
    if (data.Seccion.TemplateProducto === "") {
        console.log(data.Seccion);
        return false
    }

    SetHandlebars(data.Seccion.TemplateProducto, data, divListadoProductos);

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
    
    divProd.find(sElementos.listadoProductos + '.slick-initialized').slick('unslick');
    divProd.find(sElementos.listadoProductos).not('.slick-initialized').slick({
        vertical: false,
        dots: false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        prevArrow: '<div class="btn-set-previous div-carousel-rd-prev"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-prev"><img src="' + baseUrl + 'Content/Images/RevistaDigital/' + GetArrowNamePrev() + '" alt="" /></a></div>',
        nextArrow: '<div class="btn-set-previous div-carousel-rd-next"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-next"><img src="' + baseUrl + 'Content/Images/RevistaDigital/' + GetArrowNameNext() + '" alt="" /></a></div>'
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

    divProd.find(sElementos.listadoProductos + '.slick-initialized').slick('unslick');
    divProd.find(sElementos.listadoProductos).not('.slick-initialized').slick({
        infinite: true,
        vertical: false,
        slidesToShow: isMobile() ? 1 : 3,
        slidesToScroll: 1,
        autoplay: false,
        speed: 260,
        prevArrow: '<a class="div-carousel-rd-prev js-slick-prev" style="display: block;left: 0;margin-left: -10%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
        nextArrow: '<a class="div-carousel-rd-next js-slick-next" style="display: block;right: 0;margin-right: -10%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
    //})
    //.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
    //    EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
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
