
// 1: escritorio Home    11 : escritorio Pedido 
// 2: mobile  Home       21 : mobile pedido
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";

$(document).ready(function () {
    $(document).on('click', '.combo_select_tono', function (e) {
        var AbrirTono = $(this).attr("data-tono-show") || "0";
        var signo = "";
        if (AbrirTono == 0) {
            $(this).parents("[data-tono]").find(".content_tonos_ficha").slideUp();
            $(this).parents("[data-tono]").find(".combo_select_tono").attr("data-tono-show", 0);
            $(this).parents("[data-tono]").find(".combo_select_tono span.mas_info_tono").html("+");

            $(this).parent().find(".content_tonos_ficha").slideDown(); //muestro mediante id 
            signo = "-";
            AbrirTono = 1;
        }
        else {
            $(this).parent().find(".content_tonos_ficha").slideUp(); //muestro mediante id
            signo = "+";
            AbrirTono = 0;
        }
        $(this).find("span[class='mas_info_tono']").html(signo);
        $(this).attr("data-tono-show", AbrirTono);
    });

    $(document).on('click', 'div[data-tono-change]', function (e) {
        var cuv = $(this).attr("data-tono-cuv");
        $("select[data-tono-change]").val(cuv);
        $(this).parents("[data-tono]").attr("data-tono-select", cuv);
        $(this).parents("[data-tono]").find("[data-tono-div] [data-tono-change]")
            .removeClass("borde_seleccion_tono")
            .parent().find("[data-tono-cuv='" + cuv + "']")
            .addClass("borde_seleccion_tono");

        $(this).parents("[data-tono]").find(".content_tono_principal img").attr("src", $(this).find("img").attr("src"));
        var estrategia = $(this).parents("[data-estrategia]").attr("data-estrategia");
        if (estrategia == "2003" || estrategia == "2001") {
            var nombre = $(this).parents("[data-tono]").find("select").find("[value='" + cuv + "']").attr("data-tono-nombre");
            var descripcionComercial = $(this).parents("[data-tono]").find("select").find("[value='" + cuv + "']").attr("data-tono-descripcionComercial");
            nombre = nombre || $(this).find("img").attr("data-tono-nombre");
            descripcionComercial = descripcionComercial || $(this).find("img").attr("data-tono-descripcionComercial");
            $(this).parents("[data-tono]").find("[data-tono-visible]").find("[data-tono-nombre]").html(descripcionComercial);
            $(this).parents("[data-tono]").find("[data-tono-select-html]").html(nombre);
        }

    });
    $(document).on('change', 'select[data-tono-change]', function (e) {
        var cuv = $(this).val();
        $("select[data-tono-change]").val(cuv);
        $(this).parents("[data-tono]").attr("data-tono-select", cuv);
        $(this).parents("[data-tono]").find("[data-tono-div] [data-tono-change]")
            .removeClass("borde_seleccion_tono")
            .parent().find("[data-tono-cuv='" + cuv + "']")
            .addClass("borde_seleccion_tono");

        var estrategia = $(this).parents("[data-estrategia]").attr("data-estrategia");
        if (estrategia == "2003" && (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21)) {
            var nombre = $(this).find("img").attr("data-tono-nombre");
            var descripcionComercial = $(this).find("img").attr("data-tono-descripcionComercial");
            nombre = nombre || $(this).find("[value='" + cuv + "']").attr("data-tono-nombre");
            descripcionComercial = descripcionComercial || $(this).find("[value='" + cuv + "']").attr("data-tono-descripcionComercial");
            $(this).parents("[data-tono]").find("[data-tono-visible]").find("[data-tono-nombre]").html(descripcionComercial);
            $(this).parents("[data-tono]").find("[data-tono-select-html]").html(nombre);
        }
    });
    
    $(document).on('click', '.indicador_tono', function (e) {
        var AbrirTono = $(this).attr("data-tono-show") || "0";
        var signo = "";
        if (AbrirTono == 0) {
            EstrategiaMostrarMasTonos(false);
            signo = "-";
            AbrirTono = 1;
        }
        else {
            EstrategiaMostrarMasTonos(true);
            signo = "+";
            AbrirTono = 0;
        }
        $(this).find("p").html(" " + signo + " TONOS");
        $(this).attr("data-tono-show", AbrirTono);
    });

});

function CargarCarouselEstrategias(cuv) {
    $('#divListaEstrategias').hide();
    $('.js-slick-prev').remove();
    $('.js-slick-next').remove();
    $('#divListadoEstrategia.slick-initialized').slick('unslick');

    // if tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21
    //$('#divListadoEstrategia').html('<div style="text-align: center;">Cargando Productos Destacados<br><img src="' + urlLoad + '" /></div>');
    // if tipoOrigenEstrategia == 1
    //$('#divListadoEstrategia').html(
    //    '<div class="precarga"><svg class="circular" viewBox="25 25 50 50"><circle class="path-' + (isEsika ? 'esika' : 'lbel') + '" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"/></svg></div><span class="texto_precarga">Dános unos segundos </br>Las mejores ofertas <b>PARA TI</b> están por aparecer</span>'
    //);

    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/JsonConsultarEstrategias?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $('#divListadoEstrategia').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
};

function ArmarCarouselEstrategias(data) {
    $('#divListaEstrategias').hide();

    data = EstructurarDataCarousel(data);
    arrayOfertasParaTi = data;

    SetHandlebars("#estrategia-template", data, '#divListadoEstrategia');
    
    if (tipoOrigenEstrategia == 11) {
        $('#cierreCarousel').hide();
        $("[data-barra-width]").css("width", indicadorFlexiPago == 1 ? "68%" : "100%");

        $('#divListaEstrategias').hide();
        $('.caja_pedidos').addClass('sinOfertasParaTi');
        $('.tooltip_infoCopy').addClass('tooltip_infoCopy_expand');
    }

    if ($.trim($('#divListadoEstrategia').html()).length == 0) {
        return false;
    }

    //var data1 = $('#divListadoEstrategia').find('.nombre_producto');
    //var nbData = data1.length;
    //for (var iData = 0; iData < nbData; iData++) {
    //    if (data1[iData].children[0].innerHTML.length > 40) {
    //        data1[iData].children[0].innerHTML = data1[iData].children[0].innerHTML.substring(0, 40) + "...";
    //    }
    //}

    if (tipoOrigenEstrategia == 1) {

        $('#divListaEstrategias').show();
        $('#divListadoEstrategia').not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
            responsive: [
                {
                    breakpoint: 1025,
                    settings: {
                        slidesToShow: 3
                    }
                }
            ]
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        });
    }
    else if (tipoOrigenEstrategia == 11) {
        
        $("[data-barra-width]").css("width", "100%");
        $('#divListaEstrategias').show();
        if (indicadorFlexiPago == 1) {
            $('#divListaEstrategias').css("margin-top", ($(".flexiPago_belcorp").outerHeight() + 50) + "px");
        }
        $('.caja_pedidos').removeClass('sinOfertasParaTi');
        $('.tooltip_infoCopy').removeClass('tooltip_infoCopy_expand');
        var hCar = $($("#divListadoEstrategia").find("[data-item]").get(0)).height();
        var heightReference = $("#divListadoPedido").find("[data-tag='table']").height();
        var cant = parseInt(heightReference / hCar);
        cant = cant < 3 ? 3 : cant > 5 ? 5 : cant;

        $('#divListadoEstrategia').slick({
            infinite: true,
            vertical: true,
            centerMode: false,
            centerPadding: '0px',
            slidesToShow: cant,
            slidesToScroll: 1,
            autoplay: false,
            speed: 270,
            pantallaPedido: false,
            prevArrow: '<button type="button" data-role="none" class="slick-next"></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-prev"></button>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);        
        });

        if (data.length > cant) {
            $('#cierreCarousel').show();
        }
        MostrarBarra();
    }
    else if (tipoOrigenEstrategia == 2) {
        $('#div-linea-OPT').show();
        $("#divListaEstrategias").show();
        $('#divListadoEstrategia').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev" style="margin-left:-12%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next" style="margin-right:-12%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>',
            responsive: [
                {
                    breakpoint: 1200,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 900,
                    settings: { slidesToShow: 2, slidesToScroll: 1 }
                },
                {
                    breakpoint: 600,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        });
    }
    else if (tipoOrigenEstrategia == 21) {
        $("#divListaEstrategias").show();
        $('#divListadoEstrategia').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            dots: false,
            prevArrow: '<span class="previous_ofertas_mobile" id="slick-prev" style="margin-left:-13%;"><img src="' + urlCarruselPrev + '")" alt="-"/></span>',
            nextArrow: '<span class="previous_ofertas_mobile" id="slick-next" style="margin-right:-13%; text-align:right; right:0;"><img src="' + urlCarruselNext + '" alt="-"/></span>',
            infinite: true,
            speed: 300,
            responsive: [
                {
                    breakpoint: 960,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 680,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                },
                {
                    breakpoint: 380,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            EstrategiaCarouselOn(event, slick, currentSlide, nextSlide);
        });
    }
    TagManagerCarruselInicio(data);

};

function EstrategiaCarouselOn(event, slick, currentSlide, nextSlide) {
    var origen = tipoOrigenEstrategia == 1 ? "Home" : tipoOrigenEstrategia == 11 ? "Pedido" :
        tipoOrigenEstrategia == 2 ? "MobileHome" : tipoOrigenEstrategia == 21 ? "MobilePedido" : "";
    var accion;
    if (nextSlide == 0 && currentSlide + 1 == arrayOfertasParaTi.length) {
        accion = 'next';
    } else if (currentSlide == 0 && nextSlide + 1 == arrayOfertasParaTi.length) {
        accion = 'prev';
    } else if (nextSlide > currentSlide) {
        accion = 'next';
    } else {
        accion = 'prev';
    };

    if (accion == 'prev') {
        //TagManager
        var posicionPrimerActivo = $($('#divListadoEstrategia').find(".slick-active")[0]).find('.PosicionEstrategia').val();
        var posicionEstrategia = posicionPrimerActivo == 1 ? arrayOfertasParaTi.length - 1 : posicionPrimerActivo - 2;
        var recomendado = arrayOfertasParaTi[posicionEstrategia];
        var arrayEstrategia = new Array();

        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – ' + origen,
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);

        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
        dataLayer.push({
            'event': 'virtualEvent',
            'category': origen,
            'action': 'Ofertas para ti',
            'label': 'Ver anterior'
        });
    } else if (accion == 'next') {
        //TagManager
        var posicionUltimoActivo = $($('#divListadoEstrategia').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
        var posicionEstrategia = arrayOfertasParaTi.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
        var recomendado = arrayOfertasParaTi[posicionEstrategia];
        var arrayEstrategia = new Array();

        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – ' + origen,
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);

        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
        dataLayer.push({
            'event': 'virtualEvent',
            'category': origen,
            'action': 'Ofertas para ti',
            'label': 'Ver siguiente'
        });
    }
}

function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        item.DescripcionCUV2 = $.trim(item.DescripcionCUV2);
        item.DescripcionCompleta = item.DescripcionCUV2;
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
            item.ArrayContenidoSet = item.DescripcionCUV2.split('|').slice(1);
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        };

        item.Posicion = i + 1;
        item.MostrarTextoLibre = item.TextoLibre.length > 0;
    });
    return array;
};

function CargarEstrategiasEspeciales(objInput, e) {
    if (!($(e.target).attr('class') === undefined || $(e.target).attr('class').indexOf('js-no-popup') == -1)) {
        return false;
    }
    AbrirLoad();
    var origen = tipoOrigenEstrategia == 1 ? "Home" : tipoOrigenEstrategia == 11 ? "Pedidos" : "";

    var estrategia = JSON.parse($(e.target).parents("[data-estrategia]").attr("data-estrategia"));

    if (estrategia.TipoEstrategiaImagenMostrar == '2' && $.trim(tipoOrigenEstrategia)[0] == "1") {
        var html = ArmarPopupPackNuevas(estrategia);
        $('#popupDetalleCarousel_packNuevas').html(html);
        $('#popupDetalleCarousel_packNuevas').show();
        TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
    } else if (estrategia.TipoEstrategiaImagenMostrar == '5' || estrategia.TipoEstrategiaImagenMostrar == '3') {
        estrategia.CodigoEstrategia = $.trim(estrategia.CodigoEstrategia) || "";
        estrategia.Detalle = new Array();
        if (estrategia.CodigoEstrategia != "") {
            estrategia.Detalle = CargarEstrategiaSet(estrategia.CUV2);
            AbrirLoad();
            if (estrategia.Detalle.length > 0) {
                $.each(estrategia.Detalle, function (i, item) {
                    item.Hermanos = item.Hermanos || new Array();
                    item.CUVSelect = i == 0 ? item.CUV : "";
                    if (item.Hermanos.length > 0) {
                        $.each(item.Hermanos, function (i, itemH) {
                            itemH.CUVSelect = "";
                        });
                        item.CUVSelect = item.Hermanos[0].CUV;
                        item.ImagenBulkSelect = item.Hermanos[0].ImagenBulk;
                        item.NombreBulkSelect = item.Hermanos[0].NombreBulk;

                        item.Hermanos[0].CUVSelect = item.Hermanos[0].CUV;
                        item.Hermanos[0].ImagenBulkSelect = item.Hermanos[0].ImagenBulk;
                        item.Hermanos[0].NombreBulkSelect = item.Hermanos[0].NombreBulk;

                    }
                });
                estrategia.CUVSelect = estrategia.Detalle[0].CUVSelect;
            }
            else {
                estrategia.CodigoEstrategia = "";
            }
            console.log(estrategia.Detalle);
        }
        var html = ArmarPopupLanzamiento(estrategia);
        $('#popupDetalleCarousel_lanzamiento').html(html);

        //if ($('#popupDetalleCarousel_lanzamiento').find('[data-prod-descripcion]').html().length > 40) {
        //    $('#popupDetalleCarousel_lanzamiento').find('[data-prod-descripcion]').addClass('nombre_producto22');
        //    $('#popupDetalleCarousel_lanzamiento').find('[data-prod-descripcion]').removeClass('nombre_producto');
        //    //$('#popupDetalleCarousel_lanzamiento').find('.nombre_producto22').children()[0].innerHTML = "LBel Mithyka Eau Parfum 50ml+Cyzone Love Bomb Eau de Parfum 30ml+Esika Labial Color HD Tono Pimienta Caliente+Esika Agu Shampoo Manzanilla 1L";
        //}

        $('#popupDetalleCarousel_lanzamiento').show();
        $('body').css({ 'overflow-x': 'hidden' });
        $('body').css({ 'overflow-y': 'hidden' });
        $(".indicador_tono").click();
        $(".indicador_tono").click();
        EstrategiaMostrarMasTonos(true);
        TrackingJetloreView(estrategia.CUV2, $("#hdCampaniaCodigo").val());
    };
    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': 'Ofertas para ti – ' + origen },
                'products': [{
                    'id': estrategia.CUV2,
                    'name': (estrategia.DescripcionCUVSplit == undefined || estrategia.DescripcionCUVSplit == '') ? estrategia.DescripcionCompleta : estrategia.DescripcionCUVSplit,
                    'price': estrategia.Precio2.toString(),
                    'brand': estrategia.DescripcionMarca,
                    'category': 'NO DISPONIBLE',
                    'variant': estrategia.DescripcionEstrategia,
                    'position': estrategia.Posicion
                }]
            }
        }
    });
    CerrarLoad();
    return true;
};
function EstrategiaMostrarMasTonos(menos) {
    if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21) {
        if (menos) {
            var h = $($("#popupDetalleCarousel_lanzamiento [data-tono-div] [data-tono-change]")[0]).height();
            var w = $($("#popupDetalleCarousel_lanzamiento [data-tono-div] [data-tono-change]")[0]).width();
            $("#popupDetalleCarousel_lanzamiento [data-tono-div]").css("height", Math.max(h, w) + 5);
        }
        else {
            $("#popupDetalleCarousel_lanzamiento [data-tono-div]").css("height", "auto");
        }
    }
}
function CargarEstrategiaSet(cuv) {
    AbrirLoad();
    var detalle = new Array();
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/ConsultarEstrategiaSet?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            detalle = data || new Array();
        },
        error: function (error, x) {
            console.log(error, x);
            //$('#divListadoEstrategia').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
    CerrarLoad();
    return detalle;
}

function ArmarPopupPackNuevas(obj) {
    return SetHandlebars("#packnuevas-template", obj);
};

function ArmarPopupLanzamiento(obj) {
    return SetHandlebars("#lanzamiento-template", obj);
};

function CargarProductoDestacado(objParameter, objInput, popup, limite) {

    if (ReservadoOEnHorarioRestringido())
        return false;

    if (tipoOrigenEstrategia == 1) {

        agregarProductoAlCarrito(objInput);

        if (objParameter.FlagNueva == "1")
            $('#OfertaTipoNuevo').val(objParameter.FlagNueva);
        else
            $('#OfertaTipoNuevo').val("");
    }

    AbrirLoad();

    popup = popup || false;
    limite = limite || 0;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;

    var cantidadIngresada = (limite > 0) ? limite : $(objInput).parents("[data-item]").find("input.liquidacion_rango_cantidad_pedido").val() || $(objInput).parents("[data-item]").find("[data-input='cantidad']").val();
    //origenPedidoWebEstrategia = $(objInput).parents("[data-item]").find("input.OrigenPedidoWeb").val();
    var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'AdministrarEstrategia/FiltrarEstrategiaPedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {
            //EstrategiaTallaColor(datos);
            //CerrarLoad();
            datos.data.cantidadIngresada = cantidadIngresada;
            datos.data.posicionItem = posicionItem;

            var estrategiaCarrusel = popup ? new Object() : JSON.parse($(objInput).parents("[data-estrategia]").attr("data-estrategia"));

            var codigoEstrategia = popup ? $(objInput).parents("[data-item]").find("[data-estrategia]").attr("data-estrategia") : estrategiaCarrusel.CodigoEstrategia;
            if ((codigoEstrategia == "2001" || codigoEstrategia == "2003") && popup) {
                var listaCuv = new Array();
                var cuvs = $("[data-tono][data-tono-select]");

                $.each(cuvs, function (i, item) {
                    var cuv = $(item).attr("data-tono-select") 
                    if ( cuv != "") {
                        datos.data.CUV2 = cuv;
                        if (codigoEstrategia == "2003") {
                            datos.data.MarcaID = $(item).find("#Estrategia_hd_MarcaID").val();
                            datos.data.Precio2 = $(item).find("#Estrategia_hd_PrecioCatalogo").val();
                        }

                        EstrategiaAgregarProducto(datos.data, popup, tipoEstrategiaImagen);
                    }
                });
            }
            else {
                EstrategiaAgregarProducto(datos.data, popup, tipoEstrategiaImagen);
            }

           
        },
        error: function (data, error) {
            alert(datos.data.message);
            CerrarLoad();
        }
    });
};

function EstrategiaTallaColor(datos) {

    var flagEstrella = (datos.data.FlagEstrella == 0) ? "hidden" : "visible";
    $("#imgTipoOfertaEdit").attr("src", datos.data.ImagenURL);
    $("#imgEstrellaEdit").css({ "visibility": flagEstrella });
    $("#imgZonaEstrategiaEdit").attr("src", datos.data.FotoProducto01);

    if (datos.data.Precio != "0") {
        $(".zona2Edit").html(datos.data.EtiquetaDescripcion + ' ' + datos.data.Simbolo + '' + datos.precio);
    } else {
        $(".zona2Edit").html("");
    }

    if (datos.data.Precio2 != "0") {
        $(".zona3Edit_1").html(datos.data.EtiquetaDescripcion2);
        $(".zona3Edit_2").html('<span>' + datos.data.Simbolo + '' + datos.precio2 + '</span>');
    } else {
        $(".zona3Edit_1").html("");
        $(".zona3Edit_2").html("");
    }

    if (datos.data.TextoLibre != "") {
        $(".zona4Edit").html(datos.data.TextoLibre);
    } else {
        $(".zona4Edit").html("");
    }

    if (datos.data.ColorFondo != "") {
        $("#divVistaPrevia").css({ "background-color": datos.data.ColorFondo });
    } else {
        $("#divVistaPrevia").css({ "background-color": "#FFF" });
    }

    $("#txtCantidadZE").val(cantidadIngresada);
    $("#txtCantidadZE").attr("est-cantidad", datos.data.LimiteVenta);
    $("#txtCantidadZE").attr("est-cuv2", datos.data.CUV2);
    $("#txtCantidadZE").attr("est-marcaID", datos.data.MarcaID);
    $("#txtCantidadZE").attr("est-precio2", datos.data.Precio2);
    $("#txtCantidadZE").attr("est-montominimo", datos.data.IndicadorMontoMinimo);
    $("#txtCantidadZE").attr("est-tipooferta", datos.data.TipoOferta);
    $("#txtCantidadZE").attr("est-descripcionMarca", datos.data.DescripcionMarca);
    $("#txtCantidadZE").attr("est-descripcionEstrategia", datos.data.DescripcionEstrategia);
    $("#txtCantidadZE").attr("est-descripcionCategoria", datos.data.DescripcionCategoria);
    $("#txtCantidadZE").attr("est-posicion", posicionItem);

    $("#ddlTallaColor").empty();
    $(".zona0Edit").html(datos.data.DescripcionMarca);

    /*Validar Programa Ofertas Nuevas*/
    $("#hdnProgramaOfertaNuevo").val(false);
    $("#OfertasResultados li").hide();
    $("#OfertaTipoNuevo").val("");

    if (datos.data.FlagNueva == 1) {
        $(".zona4Edit").hide();
        $(".zonaCantidad").hide();
        $("#hdnProgramaOfertaNuevo").val(true);
        var nroPedidos = false;
        var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

        pedidosData.each(function (indice, valor) {
            if (valor.value == 1) {
                nroPedidos = true;
                var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                    $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                    $('#hdnPagina').val(), ";",
                    $('#hdnClienteID2_').val());

                $("#OfertaTipoNuevo").val(OfertaTipoNuevo);
                return;
            }
        });

        if (nroPedidos) {
            $(".zona4Edit").text(datos.data.TextoLibre);
            $(".zona4Edit").show();
        }

        var ofertas = datos.data.DescripcionCUV2.split('|');
        $(".zona1Edit").html(ofertas[0]);
        $("#txtCantidadZE").attr("est-descripcion", ofertas[0]);
        $("#OfertasResultados li").remove(); // Limpiar la lista.

        $.each(ofertas, function (i) {
            if (i != 0 && $.trim(ofertas[i]) != "") {
                $("#OfertasResultados").append("<li>" + ofertas[i] + "</li>");
            }
        });

        CerrarLoad();
        EstrategiaAgregarProducto(popup, tipoEstrategiaImagen);
    } else {
        $(".zona4Edit").show();
        $(".zonaCantidad").show();
        $(".zona1Edit").html(datos.data.DescripcionCUV2);
        $("#txtCantidadZE").attr("est-descripcion", datos.data.DescripcionCUV2);
        var option = "";
        $(".tallaColor").hide();
        if (datos.data.TallaColor != "") {
            var arrOption = datos.data.TallaColor.split('</>');
            if (arrOption.length > 2) {
                for (var i = 0; i < arrOption.length; i++) {
                    if (arrOption[i] != "") {
                        option = "<option ";
                        var strOption = arrOption[i].split('|');
                        var strCuv = strOption[0];
                        var strDescCuv = strOption[1];
                        var strDescTalla = strOption[2];
                        option += " value='" + strCuv + "' desc-talla='" + strDescCuv + "' >" + strDescTalla + "</option>";
                        $("#ddlTallaColor").append(option);
                    }
                }

                $(".tallaColor").show();
                if (tipoOrigenEstrategia == 11) {
                    showDialog('divVistaPrevia');
                }
            }
        }
        if (option == "") {
            EstrategiaAgregarProducto(popup, tipoEstrategiaImagen);
        } else {
            CerrarLoad();
        }
    }

    //closeWaitingDialog();
    //showDialog('divVistaPrevia');
}

function EstrategiaAgregarProducto(datosEst, popup, tipoEstrategiaImagen) {
    AbrirLoad();

    var marcaID = datosEst.MarcaID; // $("#txtCantidadZE").attr("est-marcaID");
    var cuv = datosEst.CUV2; // $("#txtCantidadZE").attr("est-cuv2");
    var precio = datosEst.Precio2;// $("#txtCantidadZE").attr("est-precio2");
    var ofertas = datosEst.DescripcionCUV2.split('|');
    var descripcion = ofertas[0]; //$("#txtCantidadZE").attr("est-descripcion");
    var cantidad = datosEst.cantidadIngresada; // $("#txtCantidadZE").val();
    var cantidadLimite = datosEst.LimiteVenta; // $("#txtCantidadZE").attr("est-cantidad");
    var indicadorMontoMinimo = datosEst.IndicadorMontoMinimo; // $("#txtCantidadZE").attr("est-montominimo");
    var OrigenPedidoWeb = origenPedidoWebEstrategia;

    //var tipoOferta = datosEst.TipoOferta; // $("#txtCantidadZE").attr("est-tipooferta");
    //var categoria = datosEst.DescripcionCategoria; // $("#txtCantidadZE").attr("est-descripcionCategoria");
    //var variant = datosEst.DescripcionEstrategia;// $("#txtCantidadZE").attr("est-descripcionEstrategia");
    //var posicion = datosEst.posicionItem; // $("#txtCantidadZE").attr("est-posicion");
    //var urlImagen = datosEst.FotoProducto01; // $("#imgZonaEstrategiaEdit").attr("src");
    // validar que se existan tallas
    //if ($.trim($("#ddlTallaColor").html()) != "") {
    //    if ($.trim($("#ddlTallaColor").val()) == "") {
    //        AbrirMensaje("Por favor, seleccione la Talla/Color del producto.");
    //        CerrarLoad();
    //        return false;
    //    }
    //}
    //Quitar estas validaciones cuando exista Programa de Ofertas nuevas 
    //if ($("#hdnProgramaOfertaNuevo").val() == "true") {
    //    cantidad = cantidadLimite;
    //}

    if (datosEst.FlagNueva == 1) {
        cantidad = cantidadLimite;
    }
    else {
        descripcion = datosEst.DescripcionCUV2;
    }
    
    if (!$.isNumeric(cantidad)) {
        AbrirMensaje("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CerrarLoad();
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        AbrirMensaje("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CerrarLoad();
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        AbrirMensaje("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        CerrarLoad();
        return false;
    }

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ClienteID_: '-1',
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0,
        OrigenPedidoWeb: OrigenPedidoWeb
    });

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                AbrirMensaje(datos.message);
                CerrarLoad();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'Pedido/AgregarProductoZE',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            CerrarLoad();
                            return false;
                        }

                        if (data.success != true) {
                            messageInfoError(data.message);
                            CerrarLoad();
                            return false;
                        }

                        AbrirLoad();
                        if (tipoOrigenEstrategia == 1) {
                            MostrarBarra(data, '1');
                            ActualizarGanancia(data.DataBarra);
                            CargarCarouselEstrategias(cuv);
                            CargarResumenCampaniaHeader(true);
                        }
                        else if (tipoOrigenEstrategia == 11) {

                            $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

                            cierreCarouselEstrategias();
                            CargarCarouselEstrategias(cuv);
                            CargarResumenCampaniaHeader();
                            HideDialog("divVistaPrevia");

                            tieneMicroefecto = true;

                            CargarDetallePedido();
                            MostrarBarra(data);
                        }
                        else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21) {
                            ActualizarGanancia(data.DataBarra);
                            CargarCarouselEstrategias(cuv);
                        }

                        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                        TagManagerClickAgregarProducto();

                        CerrarLoad();
                        if (popup) {
                            HidePopupEstrategiasEspeciales();
                            $('body').css({ 'overflow-y': 'scroll' });
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CerrarLoad();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarLoad();
            }
        }
    });
};

function HidePopupEstrategiasEspeciales() {
    $('#popupDetalleCarousel_lanzamiento').hide();
    $('#popupDetalleCarousel_packNuevas').hide();
};

function CerrarLoad() {
    if (tipoOrigenEstrategia == 1) {
        closeWaitingDialog()
    }
    else if (tipoOrigenEstrategia == 11) {
        CerrarSplash();
    }
    else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21) {
        CloseLoading();
    }
}

function AbrirLoad() {
    if (tipoOrigenEstrategia == 1) {
        waitingDialog()
    }
    else if (tipoOrigenEstrategia == 11) {
        AbrirSplash();
    }
    else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21) {
        ShowLoading();
    }
}

function AbrirMensaje(txt) {
    if (tipoOrigenEstrategia == 1) {
        alert_msg_pedido(txt)
    }
    else if (tipoOrigenEstrategia == 11) {
        alert_msg(txt);
    }
    else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21) {
        messageInfo(txt);
    }
}

