
$(document).ready(function () {
    $('#divCarruselLan').slick({
        vertical: false,
        dots: false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 3000,
        prevArrow: '<div class="btn-set-previous" style="left:-14%;"><img src="' + baseUrl + 'Content/Images/RevistaDigital/Kadiavisual2.png")" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-prev"><img src="' + baseUrl + 'Content/Images/RevistaDigital/previous.png")" alt="" /></a></div>',
        nextArrow: '<div class="btn-set-previous" style="right:-14%;"><img src="' + baseUrl + 'Content/Images/RevistaDigital/Kadiavisual2.png")" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-next"><img src="' + baseUrl + 'Content/Images/RevistaDigital/next.png")" alt="" /></a></div>'
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

        slick.$prevArrow.find("img[data-prev]").attr("src", $.trim($(slides[prev]).attr("data-ImgPrevDesktop")));
        slick.$nextArrow.find("img[data-prev]").attr("src", $.trim($(slides[next]).attr("data-ImgPrevDesktop")));

    });
});

function OfertaArmarEstrategias(response) {
    var lista = EstructurarDataCarousel(response.lista);

    $.each(lista, function (index, value) {
        value.Posicion = index + 1;
        value.UrlDetalle = urlOfertaDetalle + '/' + (value.ID || value.Id);
    });

    $("#divOfertaProductos").html("");
    response.Lista = lista;
    response.CodigoEstrategia = $("#hdCodigoEstrategia").val() || "";
    response.ClassEstrategia = 'revistadigital-landing';
    response.Consultora = usuarioNombre.toUpperCase()
    response.CodigoEstrategia = "101";

    // Listado de producto
    var urlTemplate = "#estrategia-template";

    var htmlDiv = SetHandlebars(urlTemplate, response, '#divOfertaProductos');
    //$('#divOfertaProductos').append(htmlDiv);

    $("#spnCantidadFiltro").html(response.cantidad);
    $("#spnCantidadTotal").html(response.cantidadTotal);

    LayoutProductos();
}

function LayoutProductos() {
    var w = $("#divOfertaProductos").width();
    var lista = $("#divOfertaProductos [data-item]");
    var wi = 0;
    var x, y = 0;
    $.each(lista, function (index, item) {
        wi += $(item).width() + parseFloat($(item).css("margin-left").replace("px", "")) + parseFloat($(item).css("margin-right").replace("px", ""));
        if (wi > w || index + 1 == lista.length) {
            x = index + 1 == lista.length ? Math.abs(wi - w) : Math.abs(wi - w - $(item).width());
            x = x / 2;

            y = y > 0 ? y + 1 : 0;
            $(lista[y]).css("margin-left", (x + parseFloat($(item).css("margin-left").replace("px", ""))) + "px");

            y = index > 0 ? index + 1 == lista.length ? index : index - 1 : 0;
            $(lista[y]).css("margin-right", (x - 1 + parseFloat($(item).css("margin-right").replace("px", ""))) + "px");

            //wi = 0;
            //y = y > 0 ? y + 1 : y;
            //$.each(lista, function (ind, itemP) {
            //    if (ind >= y && ind < index) {
            //        if (wi == 0) {
            //            $(itemP).css("margin-left", 0 + "px");
            //            $(itemP).css("margin-right", x + "px");
            //        }
            //        else if (ind == index - 1) {
            //            $(itemP).css("margin-left", x + "px");
            //            $(itemP).css("margin-right", 0 + "px");
            //        }
            //        else {
            //            $(itemP).css("margin-left", x + "px");
            //            $(itemP).css("margin-right", x + "px");
            //        }
            //        wi = wi + 1;
            //    }
            //});
            y = index - 1;
            wi = $(item).width() + parseFloat($(item).css("margin-left").replace("px", "")) + parseFloat($(item).css("margin-right").replace("px", ""));
        }
    });
}
