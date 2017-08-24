
var sElementos = {
    seccion: '[data-seccion]',
    load: '[data-seccion-load]',
    listadoProductos: "[data-seccion-productos]"
};

var sProps = {
    UrlObtenerSeccion: baseUrl + 'Ofertas/ObtenerSeccion'
};

var CONS_TIPO_PRESENTACION = {
    CarruselSimple: 1,
    CarruselPrevisuales: 2,
    SimpleCentrado: 3,
    Banners: 4
};

var CONS_CODIGO_SECCION = {
    LAN: "LAN",
    RD: "RD",
    RDR: "RDR"
};

var listaSeccion = {};

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
        url: sProps.UrlObtenerSeccion,
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
    if (typeof objConsulta.UrlObtenerProductos === "undefined")
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
            data.Seccion = listaSeccion[data.Codigo + "-" + data.CampaniaID]; //objConsulta;
            SeccionMostrarProductos(data);
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });    
}

function SeccionMostrarProductos(data) {
    var htmlSeccion = $("[data-seccion=" + data.Seccion.Codigo + "]");
    if (htmlSeccion.length !== 1) 
        return false
    
    var divListadoProductos = htmlSeccion.find(sElementos.listadoProductos);
    if (divListadoProductos.length !== 1) 
        return false
    
    console.log(data.Seccion.TemplateProducto, data);
    SetHandlebars(data.Seccion.TemplateProducto, data, divListadoProductos);

    if (data.Seccion.TipoPresentacion == CONS_TIPO_PRESENTACION.CarruselPrevisuales) {
        RenderCarruselPrevisuales(htmlSeccion);
    }
}

function RenderCarruselPrevisuales(divProd) {
    if (typeof divProd == "undefined") {
        return false;
    }
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

function GetArrowNamePrev() {
    if (isMobile()) return "previous_mob.png";
    else return "previous.png";
}

function GetArrowNameNext() {
    if (isMobile()) return "next_mob.png";
    else return "next.png";
}
