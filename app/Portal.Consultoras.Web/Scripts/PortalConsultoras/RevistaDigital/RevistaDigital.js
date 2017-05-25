
$(document).ready(function () {

    $("#Vista1").hide();
    $("#Vista3").hide();
    if (estadoAccion == 0) {
        $("#Vista1").hide();
        $("#Vista3").show();
        return;
    }
    else {
        $("#Vista1").show();
        $("#Vista3").hide();
    }

    $('#divCarruselLan').slick({
        vertical: false,
        dots: false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 3000,
        prevArrow: '<div class="btn-set-previous" style="left:-14%;top: 35%;"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-prev"><img src="' + baseUrl + 'Content/Images/RevistaDigital/previous.png" alt="" /></a></div>',
        nextArrow: '<div class="btn-set-previous" style="right:-14%;top: 35%;"><img src="" alt="" data-prev="" /><a class="previous_ofertas_ept js-slick-next"><img src="' + baseUrl + 'Content/Images/RevistaDigital/next.png" alt="" /></a></div>'
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
        imgPrevia = $.trim($(slides[next]).attr("data-ImgPrevia"));
        slick.$nextArrow.find("img[data-prev]").attr("src", imgPrevia);
        if (imgPrevia == "") {
            slick.$nextArrow.find("img[data-prev]").hide();
        }

    });

    // para renderizar las vistas previas
    $('#divCarruselLan').slick('slickGoTo', 0);

    if (location.href.toLowerCase().indexOf("/detalle/") > 0) {
        RDDetalleObtener();
    }

});

function OfertaArmarEstrategias(response) {
    var lista = EstructurarDataCarousel(response.lista);

    if (lista.Posicion != undefined) {
        var objDetalle = lista;
        lista = new Array();
        lista.push(objDetalle);
    }

    $("#divOfertaProductos").html("");
    response.Lista = lista;
    response.CodigoEstrategia = $("#hdCodigoEstrategia").val() || "";
    response.ClassEstrategia = 'revistadigital-landing';
    response.Consultora = usuarioNombre.toUpperCase()
    response.CodigoEstrategia = "101";

    // Listado de producto
    var htmlDiv = SetHandlebars("#estrategia-template", response, '#divOfertaProductos');
    //$('#divOfertaProductos').append(htmlDiv);

    $("#spnCantidadFiltro").html(response.cantidad);
    $("#spnCantidadTotal").html(response.cantidadTotal);
}

function RDDetalleObtener() {
    $.ajaxSetup({
        cache: false
    });

    var nro = location.href.toLowerCase().split('/');
    nro = nro[nro.length - 1];

    jQuery.ajax({
        type: 'POST',
        url: "/RevistaDigital/GetProductoDetalle/" + nro,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        //data: JSON.stringify(busquedaModel),
        async: true,
        success: function (response) {
            //CerrarLoad();

            if (response.success == true) {
                OfertaArmarEstrategias(response);
                $(".ver_detalle_carrusel").parent().parent().attr("onclick", "");
                $(".ver_detalle_carrusel").remove();
            } else {
                messageInfoError(response.message);
                if (busquedaModel.hidden == true) {
                    $("#divOfertaProductos").hide();
                }
            }
        },
        error: function (response, error) {
            if (busquedaModel.hidden == true) {
                $("#divOfertaProductos").hide();
            }
            if (checkTimeout(response)) {
                CerrarLoad();
                console.log(response);
            }
        }
    });
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

            //y = index > 0 ? index + 1 == lista.length ? index : index - 1 : 0;
            //$(lista[y]).css("margin-right", (x - 1 + parseFloat($(item).css("margin-right").replace("px", ""))) + "px");

            y = index - 1;
            wi = $(item).width() + parseFloat($(item).css("margin-left").replace("px", "")) + parseFloat($(item).css("margin-right").replace("px", ""));
        }
    });
}
