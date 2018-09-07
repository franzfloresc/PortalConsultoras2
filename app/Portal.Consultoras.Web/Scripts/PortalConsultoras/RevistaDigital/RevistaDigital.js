
var campaniaId = campaniaId || 0;
var CantidadFilas = CantidadFilas || 15;
var lsListaRD = lsListaRD || "RDLista";
var listaLAN = listaLAN || "LANLista";
var indCampania = indCampania || 0;
var isDetalle = false;
var esPrimeraCarga = true;
var cantTotalMostrar = 0;
var clickedSlider = 0;
var revistaDigital = revistaDigital || {};
var sliderWay = 0;

var sProps = {
    UrlRevistaDigitalInformacion: baseUrl + 'revistadigital/Informacion',
    UrlRevistaDigitalComprar: baseUrl + 'revistadigital/Comprar',
    UrlRevistaDigitalRevisar: baseUrl + 'revistadigital/Revisar',
    UrlRevistaDigitalDetalle: baseUrl + 'revistadigital/detalle/',
    UrlContenedorComprar: baseUrl + 'Ofertas/',
    UrlContenedorRevisar: baseUrl + 'Ofertas/Revisar'
};

var windw = this;


$(document).ready(function () {
    "use strict";

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
                $(objTag).css('padding-top', '50px');
            }
        });
        // Registrar valores de analytics
        if (!esPrimeraCarga) {
            rdAnalyticsModule.Tabs($(this).attr("data-tab-index"), campaniaId);
        } else { esPrimeraCarga = false; }

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

    if ((window.location.pathname.toLowerCase() + "/").indexOf("/detalle/") >= 0) {
        $("footer").hide();
        var h = $("#idMensajeBloqueado").innerHeight();
        if (h != undefined) {
            h = h > 0 ? h : $("#idMensajeBloqueado > div").innerHeight();
            $("#divDetalleContenido").css("padding-bottom", h + "px");
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

    $('.flecha_scroll_mob').on('click', function (e) {

        e.preventDefault();
        if ($('#divTopFiltros').length > 0) {
            var topFiltros = ($('#divTopFiltros').position() || {}).top || 0;
            $('html, body').animate({
                scrollTop: topFiltros - 60
            }, 1000, 'swing');
        }
    });

    $('.tit_pregunta_ept').click(function (e) {
        e.preventDefault();

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
    
    //Este metodo será quitado porque la etiqueta verdetalle ya no existe.
    $("body").on("click", "[data-item-accion='verdetalle']", function (e) {
        var campania = $(this).parents("[data-tag-html]").attr("data-tag-html");
        var cuv = $(this).parents("[data-item]").attr("data-item-cuv");
        var obj = GetProductoStorage(cuv, campania);
        if (obj == undefined) {
            obj = $(this).parents("[data-item]").find("[data-estrategia]").attr("data-estrategia");
            if (obj != undefined) {
                obj = JSON.parse(obj);
            }
        }
        if (obj == undefined) {
            return;
        }

        var obj = JSON.parse($(this).parents("[data-item]").find("[data-estrategia]").attr("data-estrategia"));
        obj.CUV2 = $.trim(obj.CUV2);
        obj.Posicion = 1;
        if (obj.CUV2 != "") {
            rdAnalyticsModule.VerDetalleLan(obj);
            var guardo = EstrategiaGuardarTemporal(obj);
            if (guardo) {
                obj
                var url = urlOfertaDetalleProducto;
                
                if (obj.CodigoEstrategia) {
                    url = urlOfertaDetalleProductoLan;
                }

                url = url +
                    "?cuv=" + obj.CUV2 +
                    "&campaniaId=" + obj.CampaniaID;
                
                return window.location = url;
            }
        }
    });

    $("body").on("click", ".btn-volver-fix-detalle span", function (e) {
        window.location = urlRetorno;
    });

    $("body").on("click", ".div-carousel-rd-prev, .div-carousel-rd-next", function () {
        clickedSlider = 1;
        CallAnalitycsClickArrow();
    });
});

function FlechaScrollDown(idCamapania) {
    var topListado = $('[data-listado-campania=' + idCamapania + ']');
    if (topListado.length > 0) {
        topListado = (top.position() || {}).top || 0;

        $('html, body').animate({
            scrollTop: topListado - 70
        }, 1000, 'swing');
    }
}

function RDMostrarPosicion() {
    if ($('[data-tag-html]').length == 1) {
        $('[data-tag-html]').show();
        campaniaId = $('[data-tag-html]').attr('data-tag-html') || 0;
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
                setTimeout(function () {
                    $(window).scrollTop($(window).scrollTop() + $(document).height());
                }, 1000);
            }

        }
    }

    $(window).scroll();

}

function GetArrowNamePrev() {
    if (isMobile()) return "previous_mob.png";
    else return "previous.png";
}

function GetArrowNameNext() {
    if (isMobile()) return "next_mob.png";
    else return "next.png";
}

function OfertaArmarEstrategias(response, busquedaModel) {

    response.CampaniaID = response.CampaniaID || response.campaniaId || 0;
    if (response.CampaniaID <= 0) return false;

    var esContenedor = (window.location.pathname.toLowerCase() + "/").indexOf("/ofertas/") >= 0;
    if (esContenedor) {
        OfertaArmarEstrategiasContenedor(response, busquedaModel);
        return false;
    }

    response.Completo = response.Completo || 0;
    if (response.lista.Posicion != undefined) {
        var objDetalle = response.lista;
        response.lista = new Array();
        response.lista.push(objDetalle);
    }

    response.CodigoEstrategia = $("#hdCodigoEstrategia").val() || "";
    response.ClassEstrategia = 'revistadigital-landing';
    response.Consultora = usuarioNombre.toUpperCase();

    response.Mobile = isMobile();
    cantTotalMostrar = response.cantidadTotal;
    OfertaObtenerIndLocal(response.CampaniaID);
    if (filtroCampania[lsListaRD + indCampania] != undefined) {

        var cantListados = filtroCampania[lsListaRD + indCampania].CantMostrados;
        filtroCampania[lsListaRD + indCampania].CantTotal = response.cantidad;

        var listaAdd = new Array();

        var listado = RDFiltrarLista(response);

        cantTotalMostrar = listado.length;

        $.each(listado, function (ind, prod) {
            prod.Posicion = ind + 1;
            if (ind >= cantListados && ind < cantListados + CantidadFilas) {
                listaAdd.push(Clone(prod));
            }
        });

        filtroCampania[lsListaRD + indCampania].CantMostrados += listaAdd.length;

        filtroCampania[lsListaRD + indCampania].response.Completo = 1;
    }
    else {
        console.log('filtroCampania' + indCampania + ' - ' + response.CampaniaID);
    }
    // Listado de producto
    var modeloTemp = Clone(response);
    modeloTemp.lista = listaAdd || response.lista;
    var divProd = $("[data-listado-campania=" + response.CampaniaID + "]");
    divProd = divProd.length > 0 ? divProd : $("#divOfertaProductos").parent();

    $.each(modeloTemp.lista, function (ind, tem) {
        tem.EsBanner = false;
        tem.EsLanzamiento = false;
    });

    var modelHtml = Clone(modeloTemp);

    if (response.Mobile) {
        $.each(modelHtml.lista, function (ind, temh) {
            temh.TipoAccionAgregarBack = Clone(temh.TipoAccionAgregar);
            temh.TipoAccionAgregar = 0;
        });
    }
    
    var htmlDiv = SetHandlebars("#producto-landing-template", modelHtml);
    divProd.find('#divOfertaProductos').append(htmlDiv);
    if (response.cantidadTotal == 0) {
        divProd.find('#no-productos').show();
    }

    /*Logica para agregar atributos para el EfectoLazy*/
    EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

    divProd.find("#spnCantidadFiltro").html(cantTotalMostrar);
    divProd.find("#spnCantidadTotal").html(response.cantidadTotal);

    if (response.listaPerdio != undefined) {
        if (response.listaPerdio.length > 0) {
            var divPredio = $("#divOfertaProductosPerdio");
            if (divPredio.children('div').length < response.listaPerdio.length) {
                modeloTemp.lista = response.listaPerdio;

                $.each(modeloTemp.lista, function (ind, tem) {
                    tem.EsBanner = false;
                    tem.EsLanzamiento = false;
                });

                var htmlDivPerdio = SetHandlebars("#producto-landing-template", modeloTemp);
                divPredio.append(htmlDivPerdio);
            }
        } else {
            $("#block_inscribete").hide();
            $("#divOfertaProductosPerdio").remove();
        }
    }
    else {
        $("#divOfertaProductosPerdio").remove();
    }
   

    ResizeBoxContnet();
    if (response.guardaEnLocalStorage === false) {
        return true;
    }

    if (!isDetalle) {
        RDLocalStorageListado(lsListaRD + response.CampaniaID, filtroCampania[lsListaRD + indCampania]);
    }
}

function RDLocalStorageListado(key, valor, codigo) {
 
    var valLocalStorage = LocalStorageListado(key, null, 1);
    if (valLocalStorage != null) {
        valLocalStorage = JSON.parse(valLocalStorage);

        valLocalStorage.response = valLocalStorage.response || {};
        if (codigo == "LAN") {
            valLocalStorage.response.listaLan = valor.listaLan;
        }
        else if (valor) {
            valLocalStorage = Clone(valor);
        }
    }
    else {
        valLocalStorage = valor;
    }

    LocalStorageListado(key, valLocalStorage);
}

function OfertaArmarEstrategiasContenedor(responseData, busquedaModel) {
    if (busquedaModel.guardaEnLocalStorage === true) {
        RDLocalStorageListado(busquedaModel.VarListaStorage + responseData.CampaniaID, filtroCampania[busquedaModel.VarListaStorage + indCampania]);
    }

    var response = Clone(responseData);

    var listaSeccionesRD = ["HV"];

    if (busquedaModel.VarListaStorage === "RDLista") {
        listaSeccionesRD = ["RD", "RDR"];
    }

    if (busquedaModel.VarListaStorage === listaLAN) {
        listaSeccionesRD = ["LAN"];
    }


    $.each(listaSeccionesRD, function (ind, tipo) {
        response.Seccion = listaSeccion[tipo + "-" + response.CampaniaID];

        if (response.Seccion == undefined) {
            var seccHtml = $('[data-seccion][data-seccion="' + tipo + '"]');
            if (seccHtml.length == 1) {
                response.Seccion = SeccionObtenerSeccion(seccHtml);
                OfertaArmarEstrategiasContenedorSeccion(Clone(response));
            }
        }
        else {
            OfertaArmarEstrategiasContenedorSeccion(Clone(response));
        }

    });
}

function OfertaArmarEstrategiasContenedorSeccion(response) {
    if (response.codigo == "LAN") {
        response.CantidadProductos = response.listaLan.length;
        SeccionMostrarProductos(response);
        return false;
    }
    response.listaPerdio = response.listaPerdio || [];
    response.listaLan = response.listaLan || [];
    response.lista = response.lista || [];
    response.CantidadProductos = response.lista.length + response.listaPerdio.length;
    var cant = response.Seccion.CantidadProductos || 0;
    cant = cant == 0 ? (response.lista.length || response.listaLan.length) : cant;
    if (cant > 0) {
        var newLista = [];
        var listaItem = response.lista;
        listaItem = listaItem.concat(response.listaPerdio);
        $.each(listaItem, function (ind, item) {
            if (("," + response.Seccion.TipoEstrategia + ",").indexOf("," + item.CodigoEstrategia + ",") >= 0) {
                if (newLista.length < cant) {
                    newLista.push(item);
                }
            }
        });

        response.lista = newLista;
    }

    SeccionMostrarProductos(response);
}

function RDFiltrarLista(response, busquedaModel) {

    var listaFinal = Clone(response.lista);
    var universo = new Array();
    var cont = 0, contVal = 0;

    OfertaObtenerIndLocal(response.CampaniaID);
    var ListaFiltro = filtroCampania[lsListaRD + indCampania].ListaFiltro || new Array();

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

    var ordenar = filtroCampania[lsListaRD + indCampania].Ordenamiento || new Object();
    ordenar.Tipo = $.trim(ordenar.Tipo).toLowerCase();
    if (ordenar.Tipo != "" && listaFinal.length > 0) {
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
                    that.closest('.content_item_home_bpt').find('.producto_precio_bpt').css("minWidth", "100%");
                }
                else if (that.width() < 150) {
                    that.closest('.content_item_home_bpt').find('.nombre_producto_bpt').css("maxWidth", "140px");
                    that.closest('.content_item_home_bpt').find('.producto_precio_bpt').css("minWidth", "100%");
                }
                else if (that.width() < 200) {

                    that.closest('.content_item_home_bpt').find('.nombre_producto_bpt').css("maxWidth", "190px");
                    that.closest('.content_item_home_bpt').find('.producto_precio_bpt').css("minWidth", "100%");
                }
            });
        });
    } catch (e) {
        console.log(e);
    }
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
        RDDetalleVolver(campaniaCodigo);
        return false;
    }

    var prod = GetProductoStorage(cuv, campania);
    if (prod == null || prod == undefined) {
        RDDetalleVolver(campania || campaniaCodigo);
        return false;
    }
    if (prod.CUV2 == undefined) {
        RDDetalleVolver(campania || campaniaCodigo);
        return false;
    }

    var obj = new Object();
    obj.CampaniaID = prod.CampaniaID;
    obj.lista = new Array();
    obj.lista.push(prod);

    $.each(obj.lista, function (ind, tem) {
        tem.ClaseBloqueada = $.trim(tem.ClaseBloqueada);
        tem.Posicion = ind + 1;
    });

    SetHandlebars("#producto-landing-template", obj, "#divOfertaProductos");
    EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

    $("#divOfertaProductos").find('[data-item-accion="verdetalle"]').removeAttr("onclick");
    $("#divOfertaProductos").find('[data-item-accion="verdetalle"]').removeAttr("data-item-accion");

    $(".ver_detalle_carrusel").parent().parent().attr("onclick", "");
    $(".ver_detalle_carrusel").remove();
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
        autoplay: true,
        autoplaySpeed: 5000,
        prevArrow: '<a class="previous_ofertas_ept js-slick-prev"><img src="' + baseUrl + 'Content/Images/RevistaDigital/' + GetArrowNamePrev() + '" alt="" /></a>',
        nextArrow: '<a class="previous_ofertas_ept js-slick-next"><img src="' + baseUrl + 'Content/Images/RevistaDigital/' + GetArrowNameNext() + '" alt="" /></a>'
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
    CerrarPopup("#divMensajeBloqueada");
    $(window).scrollTop(0);
    $('ul[data-tab="tab"] li a[data-tag="0"]').click();

    window.location = (isMobile() ? "/Mobile/" : "") + sProps.UrlRevistaDigitalInformacion;
}

function RDDetalleVolver(campaniaId) {
    var urlVolver = (isMobile() ? "/Mobile/" : "");
    if (campaniaCodigo == campaniaId) {
        urlVolver = urlVolver + sProps.UrlContenedorComprar;
    }
    else {
        urlVolver = urlVolver + sProps.UrlContenedorRevisar;
    }
    window.location = urlVolver + "#LAN";
}

function CheckClickCarrousel(action, source) {
    if (action === "next") {
        sliderWay = 1;
    } else if (action === "prev") {
        sliderWay = 2;
    }

    if (source === "normal") {
        clickedSlider = 1;
    }
    CallAnalitycsClickArrow();
}

function CallAnalitycsClickArrow() {
    if (sliderWay !== 0 && clickedSlider !== 0) {
        if (typeof rdAnalyticsModule !== "undefined") {
            console.log("values of direction : " + sliderWay);
            rdAnalyticsModule.ClickArrowLan(sliderWay);
        }
        sliderWay = 0;
        clickedSlider = 0;
    }
}

$(window).on("scroll", function () {
    
    if (isMobile()) {
        var cabecera_mobil = $('header').outerHeight(true);
        var tabs_mobil = $('#seccion-menu-mobile').outerHeight(true);
        var cont_prod_mobil = $('#divOfertaProductos').outerHeight(true);
        var menu_para_ti = $('.bc_para_ti-menu-opciones').outerHeight(true);
        var total_head_sin = menu_para_ti + cabecera_mobil;
        var total_head_mobil = cabecera_mobil + cont_prod_mobil;
        var total_sin_head = $('.contenido_zona_dorada_contenedor_desktop').outerHeight(true);

        if ($(this).scrollTop() >= total_head_mobil) {
            $('.contenido_zona_dorada_contenedor_desktop .logo-dorado-desktop').addClass('dorado_esconde_imagen');
            $('.contenido_zona_dorada_contenedor_desktop').addClass('dorado_contenedor');
            $('#divOfertaProductosPerdio').addClass('dorado_contenedor_prods');
            $('#block_inscribete').css("top", cabecera_mobil > 0 ? 105 : 45);
        }
        else {
            $('.contenido_zona_dorada_contenedor_desktop .logo-dorado-desktop').removeClass('dorado_esconde_imagen');
            $('.contenido_zona_dorada_contenedor_desktop').removeClass('dorado_contenedor');
            $('#divOfertaProductosPerdio').removeClass('dorado_contenedor_prods');
            $('#block_inscribete').css("top", 0);
        }
    }
    else {
        var header_altura = $(".wrapper_header").outerHeight(true);
        var contenedor_ofertas = $("#divOfertaProductos").outerHeight(true);
        var total_altura_scroll = header_altura + contenedor_ofertas;

        if ($(this).scrollTop() >= total_altura_scroll) {
            $('.zona_dorada_contenedor_desktop').addClass('fixed_contenedor_head');
            $('.contenido_zona_dorada_contenedor_desktop').addClass('fixed_head');
            $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').addClass('fixed_head_cabecera');
            $('.divOfertaProductosPerdiofix').addClass('fixed_productos');
            $('footer').css("position", "relative");
            $('footer').css("z-index", "99");
        }
        else {
            $('.zona_dorada_contenedor_desktop').removeClass('fixed_contenedor_head');
            $('.contenido_zona_dorada_contenedor_desktop').removeClass('fixed_head');
            $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').removeClass('fixed_head_cabecera');
            $('.divOfertaProductosPerdiofix').removeClass('fixed_productos');
            $('footer').css("position", "initial");

        }
    }
});