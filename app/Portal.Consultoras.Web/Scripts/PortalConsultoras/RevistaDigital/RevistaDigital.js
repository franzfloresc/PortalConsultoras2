
$(document).ready(function () {

    $('ul[data-tab="tab"] li a[data-tag]').click(function (e) {
        $("#barCursor").css("opacity", "0");
        // mostrar el tab correcto
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        tag = tag != "" && tag != "0" ? "1" : tag;
        var obj = $("[data-tag-html='" + tag + "']");
        $.each(obj, function (ind, objTag) {
            $(objTag).fadeIn(300).show();
            if (tag == 0 && !isMobile()) {
                $(objTag).css('padding-top', '105px');
            }
        });        

        var funt = $.trim($(this).attr("data-tag-funt"));
        if (funt != "") {
            setTimeout(funt, 100);
        }

        //mantener seleccionado
        $('ul[data-tab="tab"] li a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    });

    $('ul[data-tab="tab"] li a')
        .mouseover(function () {
            //console.log($(this).position());
            $("#barCursor").css("opacity", "1");
            var left = Math.abs($(this).parents("ul").position().left - $(this).position().left);
            $("#barCursor").css("margin-left", (left) + "px");
        })
        .mouseout(function () { $("#barCursor").css("opacity", "0"); });

    if ($('ul[data-tab="tab"] li a').length == 0) {
        if (estadoAccion == 0) {
            $('[data-tag-html="0"]').show();
        }
        else {
            $('[data-tag-html="1"]').show();
        }
    }
    else {
        $('ul[data-tab="tab"] li a[data-tag="' + (0) + '"]').click();
    }
    
    RenderCarrusel();

    // para renderizar las vistas previas
    $('#divCarruselLan').slick('slickGoTo', 0);

    if (location.href.toLowerCase().indexOf("/detalle/") > 0) {
        RDDetalleObtener();
    }

    $(window).scroll(function () {

        if ($(window).scrollTop() + $(window).height() == $(document).height()) {

            $(".flecha_scroll").animate({
                opacity: 0
            }, 100, 'swing', function () {
                $(".flecha_scroll a").addClass("flecha_scroll_arriba");
                $(".flecha_scroll").delay(100);
                $(".flecha_scroll").animate({
                    opacity: 1
                }, 100, 'swing');
            });


        } else {

            $(".flecha_scroll a").removeClass("flecha_scroll_arriba");

        }

    });

    $(".flecha_scroll").on('click', function (e) {

        e.preventDefault();
        var posicion = $(window).scrollTop();
        if (posicion + $(window).height() == $(document).height()) {

            $('html, body').animate({
                scrollTop: $('html, body').offset().top
            }, 1000, 'swing');

        } else {

            $('html, body').animate({
                scrollTop: posicion + 700
            }, 1000, 'swing');

        }

    });

   
    $('.tit_pregunta_ept').click(function (e) {
        e.preventDefault();
        //debugger;
        var $this = $(this);
        if ($this.next().hasClass('show1')) {
            $this.next().removeClass('show1');
            $this.next().slideUp(350);
        } else {
            $this.parent().parent().find('.text_respuesta_ept').removeClass('show1');
            $this.parent().parent().find('.text_respuesta_ept').slideUp(350);
            $this.next().toggleClass('show1');
            $this.next().slideToggle(350);
        }
        return false;
    });

    $('.tit_pregunta_ept2').click(function (e) {
        e.preventDefault();
        var $this = $(this);
        if ($this.next().hasClass('show')) {
            $this.next().removeClass('show');
            $this.next().slideUp(350);
        } else {
            $this.parent().parent().find('.text_respuesta_ept2').removeClass('show');
            $this.parent().parent().find('.text_respuesta_ept2').slideUp(350);
            $this.next().toggleClass('show');
            $this.next().slideToggle(350);
        }
        return false;
    });
   
});

function GetArrowNamePrev() {
    if (window.location.href.indexOf("Mobile") > -1) return "previous_mob.png";
    else return "previous.png";
}
function GetArrowNameNext() {
    if (window.location.href.indexOf("Mobile") > -1) return "next_mob.png";
    else return "next.png";
}
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
    ResizeBoxContnet();
    $("#spnCantidadFiltro").html(response.cantidad);
    $("#spnCantidadTotal").html(response.cantidadTotal);
}
function ResizeBoxContnet() {
    try {
        //debugger;
        var image = $('.flex-container').find('img');
        image.each(function () {
            var that = $(this);
            if (that.width() < 200) {
                console.log(that.attr('src'));
                that.closest('.content_item_home').find('.nombre_producto').css("maxWidth", "175px");
                that.closest('.content_item_home').find('.producto_precio').css("minWidth", "125px");
            }
        });
    } catch (e) {
        console.log(e);
    }
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

function RenderCarrusel() {
    $('#divCarruselLan.slick-initialized').slick('unslick');
    $('#divCarruselLan').not('.slick-initialized').slick({
        vertical: false,
        dots: false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 3000,
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

