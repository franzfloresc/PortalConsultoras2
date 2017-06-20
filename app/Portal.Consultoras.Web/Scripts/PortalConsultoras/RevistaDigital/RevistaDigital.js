
var campaniaId = campaniaId || 0;
var CantidadFilas = CantidadFilas || 2;
var lsListaRD = "ListaRD";
var indCampania = indCampania || 0;

$(document).ready(function () {

    $('ul[data-tab="tab"] li a[data-tag]').click(function (e) {
        $("#barCursor").css("opacity", "0");
        // mostrar el tab correcto
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        campaniaId = parseInt(tag) || 0;
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
        $(window).scroll();
    });

    $('ul[data-tab="tab"] li a')
        .mouseover(function () {
            $("#barCursor").css("opacity", "1");
            var left = Math.abs($(this).parents("ul").position().left - $(this).position().left);
            $("#barCursor").css("margin-left", (left) + "px");
        })
        .mouseout(function () { $("#barCursor").css("opacity", "0"); });

    if ($('[data-tag-html]').length == 1) {
        $('[data-tag-html]').show(); 
        campaniaId = $('[data-tag-html]').attr("data-tag-html") || 0
        campaniaId = parseInt(campaniaId);
        $(window).scroll();
    }
    else {
        $('ul[data-tab="tab"] li a[data-tag="0"]').click();
    }

    if ((location.href.toLowerCase() + "/").indexOf("/detalle/") > 0) {
        RDDetalleObtener();
    }

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

    $(".flecha_scroll_mob").on('click', function (e) {

        e.preventDefault();
        $('html, body').animate({
            scrollTop: $('#divTopFiltros').position().top - 60
        }, 1000, 'swing');
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

    $("#divCarruselLan").on("click", "[data-item-tag='verdetalle']", function (e) {
        var obj = JSON.parse($(this).parents("[data-item]").attr("data-estrategia"));
        obj.CUV2 = $.trim(obj.CUV2);
        if (obj.CUV2 != "") {

            $.ajaxSetup({
                cache: false
            });
            
            AbrirLoad();

            localStorage.setItem(lsListaRD, JSON.stringify(obj));

            jQuery.ajax({
                type: 'POST',
                url: urlOfertaDetalleProductoTem,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(obj),
                async: true,
                success: function (response) {
                    if (response.success == true) {
                        window.location = urlOfertaDetalleProducto;
                    }
                },
                error: function (response, error) {
                    CerrarLoad();
                    localStorage.setItem(lsListaRD, '');
                    if (checkTimeout(response)) {
                        console.log(response);
                    }
                }
            });
        }
    })
   
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
    response.CampaniaID = response.CampaniaID || response.campaniaId || 0;
    if (response.CampaniaID <= 0) return false;

    response.Completo = response.Completo || 0;
    if (response.Completo == 0) {
        response.lista = EstructurarDataCarousel(response.lista);
    }

    if (response.lista.Posicion != undefined) {
        var objDetalle = response.lista;
        response.lista = new Array();
        response.lista.push(objDetalle);
    }

    response.CodigoEstrategia = $("#hdCodigoEstrategia").val() || "";
    response.ClassEstrategia = 'revistadigital-landing';
    response.Consultora = usuarioNombre.toUpperCase()
    //response.CodigoEstrategia = "101";

    // Listado Carrusel

    OfertaObtenerDataLocal(response.CampaniaID)
    if (filtroCampania[indCampania] != undefined) {

        if (response.Completo == 0) {
            var divProdLan = $("[data-tag-html=" + response.CampaniaID + "]");
            response.listaLan = response.listaLan || new Array();
            if (response.listaLan.length > 0) {
                var htmlLan = SetHandlebars("#lanzamiento-carrusel-template", response);
                divProdLan.find("#divCarruselLan").html(htmlLan);

                RenderCarrusel(divProdLan);
                // para renderizar las vistas previas
                divProdLan.find('#divCarruselLan').slick('slickGoTo', 0);
            }
            else {
                divProdLan.find("#divCarruselLan").remove();
            }
        }

        var cantListados = filtroCampania[indCampania].CantMostrados;
        filtroCampania[indCampania].CantTotal = response.cantidad;

        var listaAdd = new Array();

        var listado = RDFiltrarLista(response);

        $.each(listado, function (ind, prod) {
            if (ind >= cantListados && ind < cantListados + CantidadFilas) {
                listaAdd.push(Clone(prod));
            }
        });

        filtroCampania[indCampania].CantMostrados += listaAdd.length;

        filtroCampania[indCampania].response.Completo = 1;
    }
    // Listado de producto
    var modeloTemp = Clone(response);
    modeloTemp.Lista = listaAdd || response.lista;
    var divProd = $("[data-listado-campania=" + response.CampaniaID + "]");
    divProd = divProd.length > 0 ? divProd : $("#divOfertaProductos").parent();
    var htmlDiv = SetHandlebars("#estrategia-template", modeloTemp);
    divProd.find('#divOfertaProductos').append(htmlDiv);
    ResizeBoxContnet();
    divProd.find("#spnCantidadFiltro").html(response.cantidad);
    divProd.find("#spnCantidadTotal").html(response.cantidadTotal);
    
    //localStorage.setItem(lsListaRD, JSON.stringify(filtroCampania));
}

function RDFiltrarLista(response, busquedaModel) {

    var listaFinal = Clone(response.lista);
    var universo = new Array();
    var cont = 0, contVal = 0;

    OfertaObtenerDataLocal(response.CampaniaID)
    var ListaFiltro = filtroCampania[indCampania].ListaFiltro || new Array();

    if (ListaFiltro.length > 0) {
        listaFinal = new Array();
        $.each(ListaFiltro, function (indF, filtro) {
            universo = cont == 0 ? Clone(response.lista) : listaFinal;
            filtro.Tipo = $.trim(filtro.Tipo).toLowerCase();
            contVal = 0;

            var valores = filtro.Valores || new Array();
            $.each(valores, function (indV, valor) {

                var val = $.trim(valor).toLowerCase();
                if (val == "" || val == "-") {
                    listaFinal = contVal == 0 ? universo : listaFinal;
                }
                else {

                    if (filtro.Tipo == "marca") {
                        if (contVal <= 0) listaFinal = new Array();

                        $.each(universo, function (indU, p) {
                            if ($.trim(p.DescripcionMarca).toLowerCase()[0] == val[0]) {
                                listaFinal.push(p);
                            }
                        });
                    }
                    else if (filtro.Tipo == "precio") {
                        var listaValDet = val.split(',');
                        var valorDesde = parseFloat(listaValDet[0]);
                        var valorHasta = parseFloat(listaValDet[1]);

                        if (contVal <= 0) listaFinal = new Array();
                        $.each(universo, function (indU, p) {
                            if (p.Precio2 >= valorDesde && p.Precio2 <= valorHasta) {
                                listaFinal.push(p);
                            }
                        });
                    }
                    contVal++;

                }
            });

        });
    }

    var ordenar = filtroCampania[indCampania].Ordenamiento || new Object();
    ordenar.Tipo = $.trim(ordenar.Tipo).toLowerCase();
    if (ordenar.Tipo != "" && listaFinal.length > 0) {
        //var listaFinalx = new Array();
        if (ordenar.Tipo == "precio") {
            if (ordenar.Valor == mayormenor) {
                listaFinal = listaFinal.sort(function (a, b) { return b.Precio2 - a.Precio2 });
            }
            else if (ordenar.Valor == menormayor) {
                listaFinal = listaFinal.sort(function (a, b) { return a.Precio2 - b.Precio2 });
            }
        }
    }
    return listaFinal;
}

function ResizeBoxContnet() {
    try {
        var image = $('.flex-container').find('img');
        image.each(function () {
            var that = $(this);
            that.on('load', function () {
                if (that.width() < 115) {
                    that.closest('.content_item_home_bpt').find('.nombre_producto_bpt').css("maxWidth", "105px");
                    that.closest('.content_item_home_bpt').find('.producto_precio_bpt').css("minWidth", "105px");
                }
                else if (that.width() < 150) {
                    that.closest('.content_item_home_bpt').find('.nombre_producto_bpt').css("maxWidth", "140px");
                    that.closest('.content_item_home_bpt').find('.producto_precio_bpt').css("minWidth", "140px");
                }
                else if (that.width() < 200) {

                    that.closest('.content_item_home_bpt').find('.nombre_producto_bpt').css("maxWidth", "190px");
                    that.closest('.content_item_home_bpt').find('.producto_precio_bpt').css("minWidth", "190px");
                }
            });           
        });
    } catch (e) {
        console.log(e);
    }
}

function RDDetalleObtener() {

    var nro = location.href.toLowerCase().split('/');
    nro = nro[nro.length - 1];

    var sp = JSON.parse(localStorage.getItem(lsListaRD));
    var obj = new Object();
    obj.CampaniaID = sp.CampaniaID;
    obj.lista = sp;

    OfertaArmarEstrategias(obj);
    $(".ver_detalle_carrusel").parent().parent().attr("onclick", "");
    $(".ver_detalle_carrusel").remove();

    //$.ajaxSetup({
    //    cache: false
    //});
    //jQuery.ajax({
    //    type: 'POST',
    //    url: "/RevistaDigital/GetProductoDetalle/" + nro,
    //    dataType: 'json',
    //    contentType: 'application/json; charset=utf-8',
    //    //data: JSON.stringify(busquedaModel),
    //    async: true,
    //    success: function (response) {
    //        //CerrarLoad();
    //        if (response.success == true) {
    //            OfertaArmarEstrategias(response);
    //            $(".ver_detalle_carrusel").parent().parent().attr("onclick", "");
    //            $(".ver_detalle_carrusel").remove();
    //        } else {
    //            messageInfoError(response.message);
    //            if (busquedaModel.hidden == true) {
    //                $("#divOfertaProductos").hide();
    //            }
    //        }
    //    },
    //    error: function (response, error) {
    //        if (busquedaModel.hidden == true) {
    //            $("#divOfertaProductos").hide();
    //        }
    //        if (checkTimeout(response)) {
    //            CerrarLoad();
    //            console.log(response);
    //        }
    //    }
    //});
}

function RenderCarrusel(divProd) {
    divProd.find('#divCarruselLan.slick-initialized').slick('unslick');
    divProd.find('#divCarruselLan').not('.slick-initialized').slick({
        vertical: false,
        dots: false,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        autoplay: false,
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

function RDPageInformativa() {
    $('#popupDetalleCarousel_packNuevas').hide();
    $('#popupDetalleCarousel_lanzamiento').hide();
    $("#divMensajeBloqueada").hide();
    $(window).scrollTop(0);
    $('ul[data-tab="tab"] li a[data-tag="0"]').click();
}