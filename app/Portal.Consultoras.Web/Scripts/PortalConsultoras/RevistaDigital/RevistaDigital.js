
var campaniaId = campaniaId || 0;
var CantidadFilas = CantidadFilas || 10;
var lsListaRD = lsListaRD || "ListaRD";
var indCampania = indCampania || 0;
var isDetalle = false;

$(document).ready(function () {
    "use strict";

    isDetalle = (window.location.pathname.toLowerCase() + "/").indexOf("/revistadigital/detalle/") >= 0;

    var estador = $("[data-estadoregistro]").attr("data-estadoregistro");
    estador = estador == 1 ? estador : 0;
    $("[data-estadoregistro" + estador + "]").show();

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

    RDMostrarPosicion();

    if ((window.location.pathname.toLowerCase() + "/").indexOf("/revistadigital/") >= 0) {
        $("footer").hide();
    }

    if (isDetalle) {
        RDDetalleObtener();
        $("footer").hide();
        var h = $("#idMensajeBloqueado").innerHeight();
        if (h != undefined) {
            h = h > 0 ? h : $("#idMensajeBloqueado > div").innerHeight();
            $("#divDetalleContenido").css("padding-bottom", h + "px");
        }
    }
    else {
        if ((window.location.pathname.toLowerCase() + "/").indexOf("/detalle/") >= 0) {
            $("footer").hide();
            var h = $("#idMensajeBloqueado").innerHeight();
            if (h != undefined) {
                h = h > 0 ? h: $("#idMensajeBloqueado > div").innerHeight();
                $("#divDetalleContenido").css("padding-bottom", h + "px");
            }
        }
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

    $("body").on("click", "[data-item-accion='verdetalle']", function (e) {
        //var obj = JSON.parse($(this).parents("[data-item]").attr("data-estrategia"));
        var campania = $(this).parents("[data-tag-html]").attr("data-tag-html");
        var cuv = $(this).parents("[data-item]").attr("data-item-cuv");
        var obj = GetProductoStorage(cuv, campania);
        if (obj == undefined) {
            return;
        }
        obj.CUV2 = $.trim(obj.CUV2);
        if (obj.CUV2 != "") {            
            var guardo = GuardarProductoTemporal(obj);
            if (guardo)
                return window.location = urlOfertaDetalleProducto + "?cuv=" + obj.CUV2 + "&campaniaId=" + obj.CampaniaID;
        }
    })
   
});

function RDMostrarPosicion() {
    if ($('[data-tag-html]').length == 1) {
        $('[data-tag-html]').show();
        campaniaId = $('[data-tag-html]').attr("data-tag-html") || 0
        campaniaId = parseInt(campaniaId);
    }
    else {
        $('ul[data-tab="tab"] li a[data-tag="' + campaniaCodigo + '"]').click();

        var varPosicion = window.location.hash.split("#");
        if (varPosicion.length > 1) {
            varPosicion = varPosicion[1];
    
            if (isInt(varPosicion)) {
                $('ul[data-tab="tab"] li a[data-tag="' + varPosicion + '"]').click();
            }
            else {
                $('ul[data-tab="tab"] li a[data-tag="0"]').click();
                // poner el scroll en el div
            }

        }
    }

    $(window).scroll();

}

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

    response.Mobile = isMobile();
    var cantProdFiltros = response.cantidadTotal;
    OfertaObtenerDataLocal(response.CampaniaID)
    if (filtroCampania[indCampania] != undefined) {

        if (response.Completo == 0) {
            var divProdLan = $("[data-tag-html=" + response.CampaniaID + "]");
            response.listaLan = response.listaLan || new Array();
            if (response.listaLan.length > 0) {
                $.each(response.listaLan, function (ind, tem) {
                    tem.PuedeAgregar = response.Mobile ? 0 : 1;
                    tem.EstrategiaDetalle = tem.EstrategiaDetalle || new Object();
                    tem.EstrategiaDetalle.ImgPrev = response.Mobile ? "" : tem.EstrategiaDetalle.ImgPrevDesktop;
                    tem.EstrategiaDetalle.ImgEtiqueta = response.Mobile ? tem.EstrategiaDetalle.ImgFichaMobile : tem.EstrategiaDetalle.ImgFichaDesktop;
                    tem.EstrategiaDetalle.ImgFondo = response.Mobile ? "" : tem.EstrategiaDetalle.ImgFondoDesktop;
                });
                
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

        cantProdFiltros = listado.length;

        $.each(listado, function (ind, prod) {
            if (ind >= cantListados && ind < cantListados + CantidadFilas) {
                listaAdd.push(Clone(prod));
            }
        });

        filtroCampania[indCampania].CantMostrados += listaAdd.length;

        filtroCampania[indCampania].response.Completo = 1;
    }
    else {
        console.log('filtroCampania' + indCampania + " - " + response.CampaniaID);
    }
    // Listado de producto
    var modeloTemp = Clone(response);
    modeloTemp.Lista = listaAdd || response.lista;
    var divProd = $("[data-listado-campania=" + response.CampaniaID + "]");
    divProd = divProd.length > 0 ? divProd : $("#divOfertaProductos").parent();
    if (response.Mobile) {
        $.each(modeloTemp.Lista, function (ind, tem) {
            tem.PuedeAgregar = 0;
        });

    }
    var htmlDiv = SetHandlebars("#estrategia-template", modeloTemp);
    divProd.find('#divOfertaProductos').append(htmlDiv);
    ResizeBoxContnet();
    divProd.find("#spnCantidadFiltro").html(cantProdFiltros);
    divProd.find("#spnCantidadTotal").html(response.cantidadTotal);
    
    if (!isDetalle) {
        LocalStorageListado(lsListaRD + response.CampaniaID, JSON.stringify(filtroCampania[indCampania]));
    }
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

function GuardarProductoTemporal(obj) {

    $.ajaxSetup({
        cache: false
    });

    AbrirLoad();

    var varReturn = false;

    jQuery.ajax({
        type: 'POST',
        url: urlOfertaDetalleProductoTem,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: false,
        success: function (response) {
            varReturn = response.success;
        },
        error: function (response, error) {
            CerrarLoad();
            localStorage.setItem(lsListaRD, '');
            if (checkTimeout(response)) {
                console.log(response);
            }
        }
    });

    return varReturn;
}

function RDDetalleObtener() {

    var param = location.href.toLowerCase().split('?');
    var cuv = "", campania = "";
    if (param.length > 1) {
        param = param[1].split('&');
        $.each(param, function (ind, pa) {
            var paramD = pa.split('=');
            if (paramD[0] == "cuv") {
                cuv = $.trim(paramD[1]);
            }
            else if ($.trim(paramD[0]) == "campaniaid") {
                campania = $.trim(paramD[1]);
            }
        });
    }

    if (cuv == "" || campania == "") {
        window.location = (mobile ? "/Mobile/" : "") + "/RevistaDigital/Index";
    }
    
    var prod = GetProductoStorage(cuv, campania);
    var mobile = isMobile();
    if (prod == undefined) {
        window.location = (mobile ? "/Mobile/" : "") + "/RevistaDigital/Index";
    }
    if (prod.CUV2 == undefined) {
        window.location = (mobile ? "/Mobile/" : "") + "/RevistaDigital/Index";
    }

    var obj = new Object();
    obj.CampaniaID = prod.CampaniaID;
    obj.Lista = new Array();
    obj.Lista.push(prod);
    if (mobile) {
        $.each(obj.Lista, function (ind, tem) {
            tem.ClaseBloqueada = $.trim(tem.ClaseBloqueada);
            tem.PuedeAgregar = 1;
            if (tem.ClaseBloqueada != "") {
                tem.PuedeAgregar = 0;
            }
        });
    }

    SetHandlebars("#estrategia-template", obj, "#divOfertaProductos");
    $("#divOfertaProductos").find('[data-item-accion="verdetalle"]').removeAttr("onclick");
    $("#divOfertaProductos").find('[data-item-accion="verdetalle"]').removeAttr("data-item-accion");
    //divProd.find('#divOfertaProductos').append(htmlDiv);

    //OfertaArmarEstrategias(obj);
    $(".ver_detalle_carrusel").parent().parent().attr("onclick", "");
    $(".ver_detalle_carrusel").remove();
}

function GetProductoStorage(cuv, campania) {
    var sl = LocalStorageListado(lsListaRD + campania, '', 1);
    if (sl == undefined) {
        return undefined;
    }

    sl = JSON.parse(sl);
    var listaProd = sl.response.listaLan.Find("CUV2", cuv) || new Array();
    if (listaProd.length == 0) {
        listaProd = sl.response.lista.Find("CUV2", cuv) || new Array();
    }
    if (listaProd.length > 0) {
        listaProd[0].Posicion = 0;
        return listaProd[0]
    }

    return new Object();
}

function RenderCarrusel(divProd) {
    if (divProd == undefined) {
        return false;
    }
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
    isDetalle = isDetalle || (window.location.pathname.toLowerCase() + "/").indexOf("/detalle/") >= 0;
    if (isDetalle) {
        window.location = (isMobile() ? "/Mobile/" : "") + "/RevistaDigital#0";
    }
}