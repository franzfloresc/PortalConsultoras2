
var campaniaId = campaniaId || 0;
var CantidadFilas = CantidadFilas || 10;
var lsListaRD = lsListaRD || "ListaRD";
var indCampania = indCampania || 0;
var isDetalle = false;
var esPrimeraCarga = true;
var cantTotalMostrar = 0;
var revistaDigital = revistaDigital || null;

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

    isDetalle = (window.location.pathname.toLowerCase() + "/").indexOf(sProps.UrlRevistaDigitalDetalle) >= 0;

    if (revistaDigital) {
        if (!revistaDigital.EsActiva) {
            if (tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 27) {
                if (isMobile()) {
                    $('#seccion-menu-mobile').fixedTo('#divOfertaProductos');
                } else {
                    $('header').fixedTo('#divOfertaProductos');
                }
            }
        }
    }
    

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
                h = h > 0 ? h : $("#idMensajeBloqueado > div").innerHeight();
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
            if (guardo)
                return window.location = urlOfertaDetalleProducto +
                    "?cuv=" + obj.CUV2 +
                    "&campaniaId=" + obj.CampaniaID;
        }
    });

    $("body").on("click", ".btn-volver-fix-detalle span", function (e) {
        window.location = urlRetorno;
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
        campaniaId = $('[data-tag-html]').attr("data-tag-html") || 0;
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
        console.log('filtroCampania' + indCampania + " - " + response.CampaniaID);
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

    if (response.Mobile) {
        $.each(modeloTemp.lista, function (ind, tem) {
            tem.TipoAccionAgregar = 0;
        });
    }

    if (revistaDigital) {
        if (revistaDigital.TieneRDC) {
            if (!revistaDigital.EsActiva) {
                var ExperienciaGanaMas = new Object();
                ExperienciaGanaMas.OcultarAgregar = true;
                ExperienciaGanaMas.OcultarVerDetalle = true;
                ExperienciaGanaMas.MostrarLoQuieres = !revistaDigital.EsSuscrita && !revistaDigital.EsActiva ? true : false;

                $.each(modeloTemp.lista, function (ind, tem) {
                    if (tem.ClaseBloqueada != '') {
                        tem.ExperienciaGanaMas = ExperienciaGanaMas;
                        tem.TieneVerDetalle = !ExperienciaGanaMas.OcultarVerDetalle;
                    }
                });
            }
        }
    }

    var htmlDiv = SetHandlebars("#producto-landing-template", modeloTemp);
    divProd.find('#divOfertaProductos').append(htmlDiv);
    if (response.cantidadTotal == 0) {
        divProd.find('#no-productos').show();
    }

    /*Logica para agregar atributos para el EfectoLazy*/
    EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

    divProd.find("#spnCantidadFiltro").html(cantTotalMostrar);
    divProd.find("#spnCantidadTotal").html(response.cantidadTotal);

    if (response.listaPerdio != undefined) {
        var divPredio = $("#divOfertaProductosPerdio");
        if (response.listaPerdio.length > 0 && divPredio.children('div').length < response.listaPerdio.length) {
            modeloTemp.lista = response.listaPerdio;

            $.each(modeloTemp.lista, function (ind, tem) {
                tem.EsBanner = false;
                tem.EsLanzamiento = false;
            });

            if (revistaDigital) {
                if (revistaDigital.TieneRDC) {
                    if (!revistaDigital.EsActiva) {
                        var ExperienciaGanaMas = new Object();
                        ExperienciaGanaMas.OcultarAgregar = true;
                        ExperienciaGanaMas.OcultarVerDetalle = true;
                        ExperienciaGanaMas.MostrarLoQuieres = !revistaDigital.EsSuscrita && !revistaDigital.EsActiva ? true : false;

                        $.each(modeloTemp.lista, function (ind, tem) {
                            if (tem.ClaseBloqueada != '') {
                                tem.ExperienciaGanaMas = ExperienciaGanaMas;
                                tem.TieneVerDetalle = !ExperienciaGanaMas.OcultarVerDetalle;
                            }
                        });
                    }
                }
            }
            

            var htmlDivPerdio = SetHandlebars("#producto-landing-template", modeloTemp);
            divPredio.append(htmlDivPerdio);
        }
    }

    ResizeBoxContnet();

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
            valor.response.listaLan = valLocalStorage.listaLan || (valLocalStorage.response || {}).listaLan || {};
            valLocalStorage = Clone(valor);
        }
    }
    else {
        valLocalStorage = valor;
    }

    LocalStorageListado(key, valLocalStorage);
}


function OfertaArmarEstrategiasContenedor(responseData, busquedaModel) {

    RDLocalStorageListado(busquedaModel.VarListaStorage + responseData.CampaniaID, filtroCampania[busquedaModel.VarListaStorage + indCampania]);

    var response = Clone(responseData);

    var listaSeccionesRD = ["HV"]

    if (busquedaModel.VarListaStorage === "ListaRD") {
        listaSeccionesRD = ["RD", "RDR"]
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
    response.listaPerdio = response.listaPerdio || [];
    response.CantidadProductos = response.lista.length + response.listaPerdio.length;
    var cant = response.Seccion.CantidadProductos || 0;
    cant = cant == 0 ? response.lista.length : cant;
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
        //tem.TipoAccionAgregar = 2; Comentado por KC. para activar la experiencia de tonos en el detalle
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

//Prueba Subida
$.fn.fixedTo = function (elem) {
    var $this = this,
        $window = $(windw),
        $bumper = $(elem),
        bumperPos = $bumper.outerHeight(true),
        thisHeight = $this.outerHeight(true),
        topAltura = 0,
        setPosition = function () {
            bumperPos = $bumper.outerHeight(true);
            if ($window.scrollTop() >= (bumperPos + thisHeight)) {
                var alturaH = $('header').outerHeight(true);
                if (isMobile()) {
                    var seccionMenuMobileHeight = $('.slick-slider-fixed-mobile').outerHeight(true);
                    topAltura = alturaH + seccionMenuMobileHeight + 'px';
                    $('.contenido_zona_dorada_contenedor_desktop').addClass('scroll_posicionar_zona_dorada_cabecera');
                    $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').addClass('scroll_posicionar_fix-zona-dorada');
                    $('.contenido_zona_dorada_contenedor_desktop .logo-dorado-desktop').css('display', 'none');
                    $('#seccion-fixed-menu').css('top', '29px');
                    $('#divOfertaProductosPerdio').css('padding-top', '170px');
                } else {
                    topAltura = alturaH + 'px';
                    $('.zona_dorada_contenedor_desktop').css('position', 'fixed');
                    $('.zona_dorada_contenedor_desktop').css('top', topAltura);
                    $('.contenido_zona_dorada_contenedor_desktop').css('margin-top', '317px');
                    $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').css('padding', '25px 0px');
                    $('.contenido_zona_dorada_contenedor_desktop').css('position', 'fixed');
                    $('.contenido_zona_dorada_contenedor_desktop').css('width', '100%');
                    $('.contenido_zona_dorada_contenedor_desktop').css('z-index', '99');
                    $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').css('margin', 'auto');
                }
            } else {
                if (isMobile()) {
                    $('.contenido_zona_dorada_contenedor_desktop').removeClass('scroll_posicionar_zona_dorada_cabecera');
                    $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').removeClass('scroll_posicionar_fix-zona-dorada');
                    $('.contenido_zona_dorada_contenedor_desktop .logo-dorado-desktop').css('display', 'block');
                    $('#seccion-fixed-menu').css('top', '29px');
                    $('#divOfertaProductosPerdio').css('padding-top', '');
                    if ($window.scrollTop() <= 29) {
                        $('#seccion-fixed-menu').css('top', '');
                    }

                } else {
                    $('#divOfertaProductosPerdio').css('top', '-230px');
                    $('.contenido_zona_dorada_contenedor_desktop').css('position', 'initial');
                    $('.contenido_zona_dorada_contenedor_desktop').css('margin-top', '-255px');
                    $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').css('padding', '0px 0px');
                    $('.contenido_zona_dorada_contenedor_desktop').css('z-index', 'initial');
                    $('.zona_dorada_contenedor_desktop').css('position', 'initial');
                    $('#divOfertaProductosPerdio').css('top', '25px');
                    $('#divOfertaProductosPerdio').css('z-index', 'initial');
                    $('footer').css('z-index', '100');
                    $('footer').css('position', 'absolute');
                }
            }
        };
    $window.resize(function () {
        bumperPos = pos.offset().top;
        thisHeight = $this.outerHeight();
        setPosition();
    });
    $window.scroll(setPosition);
    setPosition();
};
