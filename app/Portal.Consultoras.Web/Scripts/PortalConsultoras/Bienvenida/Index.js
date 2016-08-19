$(document).ready(function () {
    CargarBanners();
    CrearDialogs();
    CargarCarouselEstrategias("");
    CargarCarouselLiquidaciones();
    //NuevoCargarResumenCampania();

    $(document).on('click', '.js-agregar-liquidacion', function () {
        var contenedor = $(this).parents(".content_item_carrusel");
        AgregarProductoLiquidacion(contenedor);
    });
    $(document).on('click', '.js-agregar-liquidacion-tallacolor', function () {
        var contenedor = $(this).parents(".content_item_carrusel");

        var objProducto = {
            imagenProducto: $(contenedor).find(".producto_img_home img").attr("src"),
            tituloMarca: $(contenedor).find('#DescripcionMarca').val(),
            descripcion: $(contenedor).find('#DescripcionProd').val(),
            precio: $(contenedor).find('#PrecioOferta').val(),
            tonosTallas: $(this).attr('data-array-tonostallas'),
            tipoTonoTalla: $(this).attr('tipo-tonotalla')
        };
        var objHidden = {
            MarcaID: $(contenedor).find('#MarcaID').val(),
            PrecioOferta: $(contenedor).find('#PrecioOferta').val(),
            CUV: $(contenedor).find('#CUV').val(),
            ConfiguracionOfertaID: $(contenedor).find('#ConfiguracionOfertaID').val(),
            DescripcionProd: $(contenedor).find('#DescripcionProd').val(),
            DescripcionMarca: $(contenedor).find('#DescripcionMarca').val(),
            DescripcionCategoria: $(contenedor).find('#DescripcionCategoria').val(),
            DescripcionEstrategia: $(contenedor).find('#DescripcionEstrategia').val(),
            ImagenProducto: $(contenedor).find(".producto_img_home img").attr("src")
        };

        CargarProductoLiquidacionPopup(objProducto, objHidden);
    });
    $(document).on('click', '.js-agregar-popup-liquidacion', function () {
        var contenedor = $(this).parents('#divTonosTallas');
        AgregarProductoLiquidacion(contenedor);
    });
    $(document).on('click', '.btn_cerrar_escogerTono', function () {
        HidePopupTonosTallas();
    });
    $(document).on('change', '#ddlTallaColorLiq', function () {
        CambiarTonoTalla($(this));
    });

    //CrearPopupMensajeBanner();
    //CrearPopShow();
    //MostrarShowRoom();

    //Cargando custom helpers handlebars js
    Handlebars.registerHelper('if_eq', function (a, b, opts) {
        if (a == b) {
            return opts.fn(this);
        } else {
            return opts.inverse(this);
        }
    });
});

//Metodos para carouseles
function CargarCarouselLiquidaciones() {
    $('.js-slick-prev-liq').remove();
    $('.js-slick-next-liq').remove();
    $('#divCarruselLiquidaciones').unslick()
    $('#divCarruselLiquidaciones').html('<div style="text-align: center;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertaLiquidacion/JsonGetOfertasLiquidacion',
        data: { offset: 0, cantidadregistros: cantProdCarouselLiquidaciones },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselLiquidaciones(data);
        },
        error: function (error) {
            $('#divCarruselLiquidaciones').html('');
        }
    });
};
function ArmarCarouselLiquidaciones(data) {
    data = EstructurarDataCarouselLiquidaciones(data);

    var source = $("#liquidacion-template").html();
    var template = Handlebars.compile(source);
    var context = data;
    var htmlDiv = template(context);
    //Se agrega item VER MAS
    if (htmlDiv.length > 0) {
        htmlDiv += [
            '<div>',
                '<div class="content_item_carrusel background_vermas">',
                    '<div class="producto_img_home">',
                    '</div>',
                    '<div class="producto_nombre_descripcion">',
                        '<p class="nombre_producto">',
                        '</p>',
                        '<div class="producto_precio" style="margin-bottom: -8px;">',
                            '<span class="producto_precio_oferta"></span>',
                        '</div>',
                        '<a href="' + baseUrl + 'OfertaLiquidacion/OfertasLiquidacion" class="boton_Agregalo_home" style="width:100%;">',
                            'VER MAS',
                        '</a>',
                    '</div>',
                '</div>',
            '</div>'
        ].join("\n");
    };

    $('#divCarruselLiquidaciones').empty().html(htmlDiv);

    $('#divCarruselLiquidaciones').slick({
        infinite: false,
        vertical: false,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: false,
        prevArrow: '<a class="previous_ofertas js-slick-prev-liq"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
        nextArrow: '<a class="previous_ofertas js-slick-next-liq" style="right: 0;display: block;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
    });

    $(".js-slick-prev-liq").insertBefore('#divCarruselLiquidaciones');
    $(".js-slick-next-liq").insertAfter('#divCarruselLiquidaciones');
};
function EstructurarDataCarouselLiquidaciones(array) {
    $.each(array, function (i, item) {
        item.Descripcion = (item.Descripcion.length > 40 ? item.Descripcion.substring(0, 40) + "..." : item.Descripcion);
        //item.PrecioOferta = (viewBagPaisID == '4' ? Number(item.PrecioOferta.toString().replace(',', '.')).toFixed(2) : Number(item.PrecioOferta).toFixed(2));
        item.Simbolo = viewBagSimbolo;

        if (item.TallaColor.length > 1 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TallaColor = "";
            item.TieneTallaColor = false;
        };
    });

    return array;
};
function AgregarProductoLiquidacion(contenedor) {
    var inputCantidad = $(contenedor).find("#txtCantidad").val();
    if (!$.isNumeric(inputCantidad)) {
        alert_msg("Ingrese un valor numérico.");
        $(contenedor).find("#txtCantidad").val(1);
        return false;
    }
    if (parseInt(inputCantidad) <= 0) {
        alert_msg("La cantidad debe ser mayor a cero.");
        $(contenedor).find("#txtCantidad").val(1);
        return false;
    }

    waitingDialog({});

    _gaq.push(['_trackEvent', 'Liquidacion-Web', 'Agregar-Liquidacion']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Liquidacion-Web/Agregar-Liquidacion'
    });
    var item = {
        Cantidad: $(contenedor).find("#txtCantidad").val(),
        MarcaID: $(contenedor).find("#MarcaID").val(),
        PrecioUnidad: $(contenedor).find("#PrecioOferta").val(),
        CUV: $(contenedor).find("#CUV").val(),
        ConfiguracionOfertaID: $(contenedor).find("#ConfiguracionOfertaID").val(),
        descripcionProd: $(contenedor).find("#DescripcionProd").val(),
        descripcionCategoria: $(contenedor).find("#DescripcionCategoria").val(),
        descripcionMarca: $(contenedor).find("#DescripcionMarca").val(),
        descripcionEstrategia: $(contenedor).find("#DescripcionEstrategia").val(),
        imagenProducto: $(contenedor).find("#ImagenProducto").val()
    };
    $.ajaxSetup({
        cache: false
    });

    $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: item.CUV }, function (data) {
        if (parseInt(data.Saldo) < parseInt(item.Cantidad)) {
            var Saldo = data.Saldo;
            var UnidadesPermitidas = data.UnidadesPermitidas;
            $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: item.CUV }, function (data) {
                if (Saldo == UnidadesPermitidas)
                    alert_msg("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                else {
                    if (Saldo == "0")
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                    else
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                }
                HidePopupTonosTallas();
                closeWaitingDialog();
                return false;
            });
        } else {
            $.ajaxSetup({
                cache: false
            });
            $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: item.CUV }, function (data) {
                if (parseInt(data.Stock) < parseInt(item.Cantidad)) {
                    alert_msg("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.");
                    HidePopupTonosTallas();
                    closeWaitingDialog();
                    return false;
                }
                else {
                    jQuery.ajax({
                        type: 'POST',
                        url: baseUrl + 'OfertaLiquidacion/InsertOfertaWebPortal',
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify(item),
                        async: true,
                        success: function (data) {
                            if (data.success == true) {
                                InfoCommerceGoogle(parseFloat(item.Cantidad * item.PrecioUnidad).toFixed(2), item.CUV, item.descripcionProd, item.descripcionCategoria, item.PrecioUnidad, item.Cantidad, item.descripcionMarca, item.descripcionEstrategia);
                                CargarCantidadProductosPedidos();
                                CargarResumenCampaniaHeader();
                                MostrarProductoAgregado(item.imagenProducto, item.descripcionProd, item.Cantidad, parseFloat(item.Cantidad * item.PrecioUnidad).toFixed(2));
                            }
                            else {
                                alert_msg(data.message);
                            }
                            closeWaitingDialog();
                            HidePopupTonosTallas();
                        },
                        error: function (data, error) {
                            if (checkTimeout(data)) {
                                alert_msg(data.message);
                                closeWaitingDialog();
                                HidePopupTonosTallas();
                            }
                        }
                    });
                }
            });
        }
    });
};
function CargarCarouselEstrategias(cuv) {
    $('.js-slick-prev').remove();
    $('.js-slick-next').remove();
    $('#divCarruselHorizontal').unslick();
    $('#divCarruselHorizontal').html('<div style="text-align: center;">Cargando Productos Destacados<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/JsonConsultarEstrategias?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $('#divCarruselHorizontal').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
};
function ArmarCarouselEstrategias(data) {
    data = EstructurarDataCarousel(data);

    var source = $("#estrategia-template").html();
    var template = Handlebars.compile(source);
    var context = data;
    var htmlDiv = template(context);
    $('#divCarruselHorizontal').empty().html(htmlDiv);

    if ($.trim($('#divCarruselHorizontal').html()).length == 0) {
        $('.fondo_gris').hide();
    } else {
        $('#divCarruselHorizontal').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
            responsive: [
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3
                    }
                }
            ]
        });
    }
};
function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        //item.Precio2 = (viewBagPaisID == '4' ? Number(item.Precio2.toString().replace(',', '.')).toFixed(2) : Number(item.Precio2).toFixed(2));
    });

    return array;
};

//Metodos para popups carouseles
function CargarProductoLiquidacionPopup(objProducto, objHidden) {
    waitingDialog({});

    var divTonosTallas = $('#divTonosTallas');
    var arrayTonosTallas = objProducto.tonosTallas.split("@");
    var option = '';

    for (var i = 0; i < arrayTonosTallas.length - 1; i++) {
        var strOption = arrayTonosTallas[i].split("|");
        var strCuv = strOption[0];
        var strDescCuv = strOption[1];
        var strDescTalla = strOption[2];
        var strDescPrecio = Number(strOption[3]).toFixed(2);
        var strPrecioReal = strOption[3];

        option += '<option value="' + strCuv + '"' +
                  'desc-talla="' + strDescCuv + '"' +
                  'desc-precio="' + strDescPrecio + '"' +
                  'precio-real="' + strPrecioReal + '"' +
                  '>' + strDescTalla + '</option>';
    };

    $(divTonosTallas).find('#ddlTallaColorLiq').html(option);

    $(divTonosTallas).find('#imgPopupTonoTalla').attr('src', objProducto.imagenProducto);
    $(divTonosTallas).find('#marcaPopupTonoTalla').html(objProducto.tituloMarca);
    $(divTonosTallas).find('.nombre_producto').html('<b>' + objProducto.descripcion + '</b>');
    $(divTonosTallas).find('.producto_precio_oferta').html('<b>' + objProducto.precio + '</b>');

    //Seteo valores de inputs hidden
    $(divTonosTallas).find('#MarcaID').val(objHidden.MarcaID);
    $(divTonosTallas).find('#PrecioOferta').val(objHidden.PrecioOferta);
    $(divTonosTallas).find('#CUV').val(objHidden.CUV);
    $(divTonosTallas).find('#ConfiguracionOfertaID').val(objHidden.ConfiguracionOfertaID);
    $(divTonosTallas).find('#DescripcionProd').val(objHidden.DescripcionProd);
    $(divTonosTallas).find('#DescripcionMarca').val(objHidden.DescripcionMarca);
    $(divTonosTallas).find('#DescripcionCategoria').val(objHidden.DescripcionCategoria);
    $(divTonosTallas).find('#DescripcionEstrategia').val(objHidden.DescripcionEstrategia);
    $(divTonosTallas).find('#ImagenProducto').val(objHidden.ImagenProducto);

    $(divTonosTallas).find('#txtCantidad').val(1);

    closeWaitingDialog();
    ShowPopupTonosTallas();
};

//function ReservadoOEnHorarioRestringido(mostrarAlerta) {
//    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
//    var restringido = true;

//    $.ajaxSetup({ cache: false });
//    jQuery.ajax({
//        type: 'GET',
//        url: baseUrl + 'Pedido/ReservadoOEnHorarioRestringido',
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        async: false,
//        success: function (data) {
//            if (checkTimeout(data)) {
//                if (data.success == false) restringido = false;
//                else {
//                    if (data.pedidoReservado) {
//                        var fnRedireccionar = function () {
//                            waitingDialog({});
//                            location.href = baseUrl + 'Pedido/PedidoValidado'
//                        }
//                        if (mostrarAlerta == true) AbrirPopupMensajeContrato(data.message, fnRedireccionar);
//                        else fnRedireccionar();
//                    }
//                    else if (mostrarAlerta == true) AbrirPopupMensajeContrato(data.message);
//                }
//            }
//        },
//        error: function (error) {
//            console.log(error);
//            AbrirPopupMensajeContrato('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
//        }
//    });
//    return restringido;
//};
function RedirectTusDatosGoogleAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'Datos']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/Datos'
    });
    location.href = baseUrl + 'MisDatos/Index';
};
function RedirectIngresaTuPedidoAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'Pedido']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/Pedido'
    });
    location.href = baseUrl + 'Pedido/Index';
};
function RedirectPagaEnLineaAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'Paga-en-linea']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/Paga-en-linea'
    });

    if (ViewBagRutaChile != "") {
        window.open(ViewBagRutaChile + viewBagUrlChileEncriptada, "_blank");
    }
    else {
        window.open('https://www.belcorpchile.cl/BP_Servipag/PagoConsultora.aspx?c=' + viewBagUrlChileEncriptada, "_blank");
    }
};
function RedirectCatalogoAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'Catalogo']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/Catalogo'
    });
    location.href = baseUrl + 'Catalogo/Index';
};
function RedirectBotonBienvenida(url, etiquetaGa) {
    _gaq.push(['_trackEvent', 'Menu-Lateral', etiquetaGa]);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/' + etiquetaGa
    });
    location.href = url;
};
function RedirectPedidoFicAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'PedidoFIC']);
    location.href = baseUrl + 'PedidoFIC/Index';
};
function NuevoCargarResumenCampania() {
    if (viewBagPrimeraVez == 0 && viewBagPaisID == 4) { // Colombia
        AbrirAceptacionContrato();
    }
    else if (viewBagPrimeraVez == 0 || viewBagPrimeraVezSession == "0") {
        $("#divActualizarDatos").dialog('open');
    }
    else if (viewBagPrimeraVez == 1 && viewBagPaisID == 4) { // Colombia
        AbrirAceptacionContrato();
    };

    AbrirPopupFlexipago();
    AbrirComunicado();

    if (viewBagNombrePais == "Ecuador") {
        AbrirComunicadoVisualizacion();
    };

    MostrarDemandaAnticipada();
};

// Métodos Banners
function CargarBanners() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Banner/ObtenerBannerPaginaPrincipal',
        data: '',
        dataType: 'Json',
        success: function (dataResult) {
            if (checkTimeout(dataResult)) {
                if (dataResult.success) {
                    var delayPrincipal = 0, delaySBaja1 = 0;
                    var count = 0;
                    var Titulo = "";
                    var Posicion = "";
                    var Id = 0;
                    var TipoAccion = 0;
                    var Creative = "";
                    var fileName = "";
                    var vpromotions = new Array();

                    $('#bannerBajos').empty();
                    $('#sliderHomeLoading').empty();

                    while (dataResult.data.length > count) {
                        Titulo = dataResult.data[count].Titulo;
                        Id = dataResult.data[count].BannerID.toString();
                        Posicion = dataResult.data[count].Nombre;
                        fileName = dataResult.data[count].Archivo;
                        TipoAccion = dataResult.data[count].TipoAccion;

                        if (dataResult.data[count].GrupoBannerID.toString() == '150') {
                            Posicion = dataResult.data[count].Nombre + '-' + dataResult.data[count].Orden;
                        }

                        switch (dataResult.data[count].GrupoBannerID) {
                            case 150: // Seccion Principal SB2.0
                                var iniHtmlLink = ((dataResult.data[count].URL.length > 0 && dataResult.data[count].TipoAccion == 0) || dataResult.data[count].TipoAccion == 1 || dataResult.data[count].TipoAccion == 2) ? "<a href='javascript:;' onclick=\"return EnlaceBanner('" + dataResult.data[count].URL + "','" + dataResult.data[count].Titulo + "','" + dataResult.data[count].TipoAccion + "','" + dataResult.data[count].CuvPedido + "','" + dataResult.data[count].CantCuvPedido + "','" + dataResult.data[count].BannerID + "','" + Posicion + "','" + dataResult.data[count].Titulo + "');\" rel='marquesina' >" : "";
                                var finHtmlLink = ((dataResult.data[count].URL.length > 0 && dataResult.data[count].TipoAccion == 0) || dataResult.data[count].TipoAccion == 1 || dataResult.data[count].TipoAccion == 2) ? '</a>' : '';

                                $('.flexslider ul.slides').append('<li>' + iniHtmlLink + '<img src="' + fileName + '" />' + finHtmlLink + '</li>');
                                delayPrincipal = dataResult.data[count].TiempoRotacion;
                                break;
                            case -5: // Seccion Baja 1 SB2.0 
                                var trackingText = dataResult.data[count].TituloComentario;
                                var trackingDesc = dataResult.data[count].TextoComentario;
                                var htmlLink = dataResult.data[count].URL.length > 0 ? "onclick=\"return SetGoogleAnalyticsBannerInferiores('" + dataResult.data[count].URL + "','" + trackingText + "','0','" + dataResult.data[count].BannerID + "','" + Posicion + "','" + dataResult.data[count].Titulo + "');\" target='_blank' rel='banner-inferior' " : "";
                                        
                                $('#bannerBajos').append("<a class='enlaces_home' href='javascript:;' " + htmlLink + "><div class='div-img hidden'><img class='banner-img' src='" + fileName + "' /></div><div class='btn_enlaces'>" + trackingText + "</div></a>");
                                delaySBaja1 = dataResult.data[count].TiempoRotacion;
                                break;
                        }
                        count++;

                        if (TipoAccion == 0) {
                            Creative = "Banner";
                        }
                        else if (TipoAccion == 1) {
                            Creative = "Producto";
                        }

                        vpromotions.push({
                            'name': Titulo,
                            'id': Id,
                            'position': Posicion,
                            'creative': Creative
                        });
                    }

                    $('#bannerBajos').find("a.enlaces_home:last-child").addClass("no_margin_right");

                    if (count > 0) {
                        dataLayer.push({
                            'event': 'promotionView',
                            'ecommerce': {
                                'promoView': {
                                    'promotions': vpromotions
                                }
                            }
                        });
                    }

                    /* Slides para la seccion principal */
                    $('.flexslider').flexslider({
                        animation: "fade",
                        slideshowSpeed: (delayPrincipal * 1000),
                        start: function (slider) {
                            $('body').removeClass('loading');
                        }
                    });
                }
                else {
                    alert('Error al cargar el Banner.');
                }
            }
        }
    });
};
function EnlaceBanner(URL, TrackText, TipoAccion, CUVpedido, CantCUVpedido, Id, Posicion, Titulo) {
    if (TipoAccion == 0 || TipoAccion == 2) {
        SetGoogleAnalyticsBannerPrincipal(URL, TrackText, Id, Posicion, Titulo);
    }

    if (TipoAccion == 1) {
        if (ReservadoOEnHorarioRestringido())
            return;
        else
            InsertarPedidoCuvBanner(CUVpedido, CantCUVpedido);

        SetGoogleAnalyticsPromotionClick(Id, Posicion, Titulo);

        return false;
    }
};
function SetGoogleAnalyticsBannerPrincipal(URL, TrackText, Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion,
                     'creative': 'Banner'
                 }]
            }
        }
    });

    if (URL > 0) {
        var id = URL;
        var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
        window.open(url, '_blank');
    } else {
        window.open(URL, '_blank');
    }
    return false;
};
function InsertarPedidoCuvBanner(CUVpedido, CantCUVpedido) {
    var item = {
        CUV: CUVpedido,
        CantCUVpedido: CantCUVpedido
    };
    var categoriacad = "";
    var variantcad = "";

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/InsertarPedidoCuvBanner',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (result) {
            if (checkTimeout(result)) {
                if (result.success == true) {
                    alert_msg(result.message);
                    CargarCantidadProductosPedidos();

                    if (result.oPedidoDetalle.DescripcionEstrategia == null || result.oPedidoDetalle.DescripcionEstrategia == "") {
                        variantcad = "Estándar";
                    } else {
                        variantcad = result.oPedidoDetalle.DescripcionEstrategia;
                    }
                    if (result.oPedidoDetalle.Categoria == null || result.oPedidoDetalle.Categoria == "") {
                        categoriacad = "Sin Categoría";
                    } else {
                        categoriacad = result.oPedidoDetalle.Categoria;
                    }

                    dataLayer.push({
                        'event': 'addToCart',
                        'ecommerce': {
                            'add': {
                                'actionField': { 'list': 'Banner marquesina' },
                                'products': [
                                    {
                                        'name': result.oPedidoDetalle.DescripcionProd,
                                        'price': result.oPedidoDetalle.PrecioUnidad.toString(),
                                        'brand': result.oPedidoDetalle.DescripcionLarga,
                                        'id': CUVpedido,
                                        'category': categoriacad,
                                        'variant': variantcad,
                                        'quantity': parseInt(CantCUVpedido),
                                        'position': 1
                                    }
                                ]
                            }
                        }
                    });

                    closeWaitingDialog();
                } else {
                    alert_msg('Error al realizar proceso, inténtelo más tarde.');
                    CargarCantidadProductosPedidos();
                    closeWaitingDialog();
                }
            }
        }
    });
};
function SetGoogleAnalyticsBannerIntermedios(URL, TrackText, PaginaNueva, Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion
                 }]
            }
        }
    });
    if (PaginaNueva == "1") {
        var id = URL;

        if (URL > 0) {
            var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
            window.open(url, '_blank');
        } else {
            window.open(URL, '_blank');
        }
    } else {
        window.location.href = URL;
    }
    return false;
};
function CrearPopupMensajeBanner() {
    $('#DialogoMensajeBanner').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons: {
            "Salir": function () {
                $(this).dialog('close');
            }
        }
    });
};
function MostrarPopupMensajeBanner(Mensaje, TrackText) {
    _gaq.push(['_trackEvent', 'Banner-Intermedio', TrackText]);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Banner-Intermedio/' + TrackText
    });
    $('#TextoMensajeBanner').text(Mensaje);
    $('#DialogoMensajeBanner').dialog('option', 'title', 'Estimada Consultora: ');
    $('#DialogoMensajeBanner').dialog('open');
};
function SetGoogleAnalyticsBannerInferiores(URL, TrackText, Tipo, Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion
                 }]
            }
        }
    });
    if (Tipo == "1")
        window.location.href = URL;
    else
        var id = URL;
    if (URL > 0) {
        var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
        window.open(url, '_blank');
    } else {
        window.open(URL, '_blank');
    }
    return false;
};
function SetGoogleAnalyticsPromotionClick(Id, Posicion, Titulo) {
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                 {
                     'id': Id,
                     'name': Titulo,
                     'position': Posicion,
                     'creative': 'Producto'
                 }]
            }
        }
    });

    return false;
};

// Métodos ActualizacionDatos
function CrearPopupActualizacionDatos() {
    $('#divActualizarDatos').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 610,
        draggable: true,

        close: function (event, ui) { CerrarPopupActualizacionDatos(); },
    });
    $("#divActualizarDatos").parent().find(".ui-dialog-titlebar").hide();
    $("#divActualizarDatos").parent().css({ 'border-radius': 0, '-webkit-border-radius': 0 });
    $("#divActualizarDatos").parent().css("border-color", "rgb(206,202,197)");
    $("#btnCerrarActualizarDatos").click(function () {
        $("#divActualizarDatos").dialog('close');
    });
    $("#btnCerrarComunicado").click(function () {
        AceptarComunicadoVisualizacion();
    });
    $("#btnActualizarDatos").click(function () {
        ActualizarDatos();
        return false;
    });
    $('#hrefTerminos').click(function () {
        waitingDialog({});
        DownloadAttachPDFTerminos();
    });
    $("#lnkCambiarContrasena").click(function () {
        if ($("#divCambiarContrasena").is(":visible")) {
            $(".cambiarContrasena").css("padding-top", "0px");
            $("#divCambiarContrasena").hide();
        } else {
            $(".cambiarContrasena").css("padding-top", "15px");
            $("#divCambiarContrasena").show();
        }
    });
    $("#txtTelefono").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });
    $("#txtCelular").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });
};
function ActualizarDatos() {
    var Result = false;
    var ClaveSecreta = $('#txtActualizarClaveSecreta').val();
    var ConfirmarClaveSecreta = $('#txtConfirmarClaveSecreta').val();
    var telefono = $('#txtTelefono').val();
    var celular = $('#txtCelular').val();
    var correoElectronico = $('#txtEMail').val();
    var confirmacionCorreoElectronico = $('#txtConfirmarEMail').val();

    if ((telefono == '' || telefono == null) &&
        celular == '' || celular == null) {
        alert('Debe ingresar al menos un número de contacto: celular o teléfono.');
        return false;
    }
    if (correoElectronico == '') {
        alert('Debe ingresar el Correo Electrónico');
        return false;
    }

    if (confirmacionCorreoElectronico == '') {
        alert('Debe ingresar la Confirmación Correo Electrónico');
        return false;
    }

    if (correoElectronico != confirmacionCorreoElectronico) {
        alert('Los correos electrónicos ingresados no coinciden');
        return false;
    }

    if (!validateEmail(jQuery.trim($('#txtEMail').val()))) {
        $('#txtEMail').focus();
        alert('El formato del correo electrónico ingresado no es correcto.');
        return false;
    }

    if (ClaveSecreta.length > 0 && ClaveSecreta.length <= 6) {
        alert('Las clave debe tener mas de 6 caracteres.');
        return false;
    }
    if (ClaveSecreta != ConfirmarClaveSecreta) {
        alert('Las claves ingresadas no coinciden');
        return false;
    }

    if ($('#chkAceptoContrato').is(':checked') == false) {
        alert('Debe aceptar los términos y condiciones');
        return false;
    }

    var item = {
        Telefono: jQuery('#txtTelefono').val(),
        Celular: jQuery('#txtCelular').val(),
        Email: $.trim(jQuery('#txtEMail').val()),
        ActualizarClave: ClaveSecreta,
        ConfirmarClave: ConfirmarClaveSecreta,
        CorreoAnterior: jQuery('#hdn_Correo').val(),
        AceptoContrato: $('#chkAceptoContrato').is(':checked')
    };
    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/Registrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            $("#idMensajeActualizacionDatos").css({ "display": "none" });
            $("#idObservacionesActualizacionDatos").css({ "display": "none" });

            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    Result = true;
                    $("#idMensajeActualizacionDatos").css({ "display": "block" });
                }
                else {
                    Result = false;
                }

                if (data.message && data.message != "" && data.message != null) {
                    if (!Result) {
                        var aMensaje = data.message.split("-");
                        var mensajeHtml = "";
                        $.each(aMensaje, function (i, v) {
                            mensajeHtml += v + "<br/>"
                        });
                    }

                    $("#idObservacionesActualizacionDatos").css({ "display": "block" });
                    $("#idObservacionesActualizacionDatos").html(mensajeHtml);

                    $('#divActualizarDatos').dialog('close');
                    $("#divMensajeConfirmacion").dialog('open');
                }
            }
        },
        error: function (data, error) {
            $("#idMensajeActualizacionDatos").css({ "display": "none" });
            $("#idObservacionesActualizacionDatos").css({ "display": "none" });
            if (checkTimeout(data)) {
                Result = false;
                closeWaitingDialog();
                if (data.message && data.message != "" && data.message != null) {
                    var aMensaje = data.message.split("-");
                    var mensajeHtml = "";
                    $.each(aMensaje, function (i, v) {
                        mensajeHtml += v + "<br/>"
                    });

                    $("#idObservacionesActualizacionDatos").css({ "display": "block" });
                    $("#idObservacionesActualizacionDatos").html(mensajeHtml);
                }
                $('#divActualizarDatos').dialog('close');
            }
        }
    });

    return Result;
};
function DownloadAttachPDFTerminos() {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    var requestedFile = '/Content/FAQ/' + viewBagContratoActualizarDatos + '.pdf';
    iframe_.setAttribute("src", baseUrl + 'WebPages/DownloadPDF.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
        iframe_.onreadystatechange = function () {
            switch (this.readyState) {
                case "loading":
                    waitingDialog({});
                    break;
                case "complete":
                case "interactive":
                case "uninitialized":
                    closeWaitingDialog();
                    break;
                default:
                    closeWaitingDialog();
                    break;
            }
        };
    }
    else {
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
};
function CerrarPopupActualizacionDatos() {
    var ClaveSecreta = $('#txtActualizarClaveSecreta').val();
    var ConfirmarClaveSecreta = $('#txtConfirmarClaveSecreta').val();

    if (ClaveSecreta != ConfirmarClaveSecreta) {
        alert('Las claves ingresadas no coinciden');
        return false;
    }
    var item = {
        Telefono: jQuery('#txtTelefono').val(),
        Celular: jQuery('#txtCelular').val(),
        Email: jQuery('#txtEMail').val(),
        ActualizarClave: ClaveSecreta,
        ConfirmarClave: ConfirmarClaveSecreta,
        CorreoAnterior: jQuery('#hdn_Correo').val(),
    };
    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/Cancelar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert(data.message);
            }
        }
    });
};
function ValidateOnlyNums(id) {
    return $("#" + id).val($("#" + id).val().replace(/[^\d]/g, ""));
};

// Métodos MensajeConfirmacion
function CrearPopupMensajeConfirmacion() {
    $('#divMensajeConfirmacion').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 680,
        draggable: true
    });
    $("#divMensajeConfirmacion").parent().find(".ui-dialog-titlebar").hide();
    $("#divMensajeConfirmacion").parent().css({ 'border-radius': 0, '-webkit-border-radius': 0 });
    $("#divMensajeConfirmacion").parent().css("border-color", "rgb(206,202,197)");
    $("#btnCerrarMensajeConfirmacion").click(function () {
        $("#divMensajeConfirmacion").dialog('close');
    });
};

// Métodos Contrato
function CrearPopupContrato() {
    $('#divContrato').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 750,
        close: function (event, ui) {
            $('#divContrato').dialog('close');
            if (viewBagCambioClave == 0) {
                $("#divActualizarDatos").dialog('open');
            }
        }
    });
    $('#hrefContrato').click(function () {
        waitingDialog({});
        DownloadAttachPDF();
    });
};
function AceptarContrato() {
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarContrato",
        data: JSON.stringify({ checkAceptar: 1 }),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();

                if (data.success == true) {
                    $('#divContrato').dialog('close');
                    if (viewBagCambioClave == 0) {
                        $("#divActualizarDatos").dialog('open');
                    }
                }
                else {
                    alert(data.message);
                    if (data.extra == "nocorreo") {
                        $('#divContrato').dialog('close');
                        if (viewBagCambioClave == 0) {
                            $("#divActualizarDatos").dialog('open');
                        }
                    }
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error inesperado al momento de registrar los datos. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
};
function DownloadAttachPDF() {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    var requestedFile = urlContratoCOpdf;
    iframe_.setAttribute("src", baseUrl + 'WebPages/DownloadPDF.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
        iframe_.onreadystatechange = function () {
            switch (this.readyState) {
                case "loading":
                    waitingDialog({});
                    break;
                case "complete":
                case "interactive":
                case "uninitialized":
                    closeWaitingDialog();
                    break;
                default:
                    closeWaitingDialog();
                    break;
            }
        };
    }
    else {
        // Si es Firefox o Chrome
        $(iframe_).ready(function () {
            closeWaitingDialog();
        });
    }
    document.body.appendChild(iframe_);
};

// Métodos DemandaAnticipada
function CrearPopupDemandaAnticipada() {
    $('#divDemandaAnticipada').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
        title: ""
    });
    $('#divDemandaAnticipada').dialog("widget").find('.ui-dialog-titlebar-close').remove();
};
function MostrarDemandaAnticipada() {
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/ValidacionConsultoraDA",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $('.textFechaDA').each(function () {
                        $(this).before($('<span>').text(data.mensajeFechaDA));
                    });

                    $("#divDemandaAnticipada").dialog('open');
                }
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (tipo == 1) {
                    alert("Ocurrió un error al validar demanda anticipada.");
                } else {
                    alert("Ocurrió un error al validar la demanda anticipada.");
                }
            }
        }
    });
};
function AceptarDemandaAnticipada() {
    InsertarDemandaAnticipada(1);
};
function CancelarDemandaAnticipada() {
    InsertarDemandaAnticipada(0);
};
function InsertarDemandaAnticipada(tipo) {
    waitingDialog({});

    var params = { tipoConfiguracion: tipo };
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/InsConfiguracionConsultoraDA",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $('#divDemandaAnticipada').dialog('close');
                    location.href = baseUrl + 'Login/LoginCargarConfiguracion?paisID=' + data.paisID + '&codigoUsuario=' + data.codigoUsuario;
                }
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (tipo == 1) {
                    alert("Ocurrió un error al aceptar la demanda anticipada.");
                } else {
                    alert("Ocurrió un error al cancelar la demanda anticipada.");
                }
            }
        }
    });
};

// Métodos Comunicado
function CrearPopupComunicado() {
    $('#divComunicado').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 650,
        height: 600,
        draggable: true,

        buttons: {
            "Aceptar": function () {
                AceptarComunicado();
            }
        },
        close: function (event, ui) {
            $('#divComunicado').dialog('close');
        }
    });
};
function AbrirComunicado() {
    if (viewBagVisualizoComunicado == "0") {
        showDialog("divComunicado");
        $("#divComunicado").siblings(".ui-dialog-titlebar").hide();
    }
};
function AceptarComunicado() {
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarComunicado",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                $('#divComunicado').dialog('close');
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error al aceptar el comunicado.");
            }
        }
    });
};

// Métodos Flexipago
function CrearPopupFlexipago() {
    $('#divFlexipago').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 535,
        close: function (event, ui) {
            $('#divFlexipago').dialog('close');
        }
    });
    $("#divFlexipago").siblings('div.ui-dialog-titlebar').remove();
};
function AbrirPopupFlexipago() {
    if (viewBagPaisID == 4 || viewBagPaisID == 3) { // Colombia || Chile
        if (viewBagInvitacionRechazada == "False" || viewBagInvitacionRechazada == "0" || viewBagInvitacionRechazada == "") {
            if (viewBagInscritaFlexipago == "0") {
                if (viewBagIndicadorFlexiPago == "1" && viewBagCampanaInvitada != "0") {
                    if ((parseInt(viewBagCampaniaActual) - parseInt(viewBagCampanaInvitada)) >= parseInt(viewBagNroCampana)) {
                        showDialog("divFlexipago");
                    }
                }
            }
        }
    }
};
function RechazarInvitacionFlex() {
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/RechazarInvitacionFlexipago',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: null,
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert(data.message);
            }
        }
    });
    $('#divFlexipago').dialog('close');
    return false;
};
function InscribeteFlex() {
    var cc = (viewBagCodigoConsultora);
    var ca = (viewBagCampaniaActual);
    var pp = (viewBagPrefijoPais);
    var url = (viewBagUrlFlexipagoCL);
    if (pp.toString() == 'CL') {
        window.open(url + "/inscripcion.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    else {
        window.open("http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/inscripcion.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    return false;
};
function CerrarPopUpFlex() {
    $('#divFlexipago').dialog('close');
    return false;
};
function ConoceFlex() {
    var cc = (viewBagCodigoConsultora);
    var ca = (viewBagCampaniaActual);
    var pp = (viewBagPrefijoPais);
    var url = (viewBagUrlFlexipagoCL);
    if (pp.toString() == 'CL') {
        window.open(url + "/index.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    else {
        window.open("http://FLEXIPAGO.SOMOSBELCORP.COM/FlexipagoCO/index.html?PP=" + String(pp) + "&CC=" + String(cc) + "&CA=" + String(ca), "_blank");
    }
    return false;
};

// Métodos Comunicado Visualización
function CrearPopupComunicadoVisualizacion() {
    $('#divComunicadoVisualizacion').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 650,
        position: ['center', 22],
        draggable: true,
        close: function (event, ui) {
            $('#divComunicadoVisualizacion').dialog('close');
        }
    });
};
function AbrirComunicadoVisualizacion() {
    if (viewBagVisualizoComunicadoConfigurable == "0") {
        showDialog("divComunicadoVisualizacion");
        $("#divComunicadoVisualizacion").siblings(".ui-dialog-titlebar").hide();
    }
};
function AceptarComunicadoVisualizacion() {
    if ($('#chkMostrarComunicado').is(':checked')) {
        waitingDialog({});
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/AceptarComunicadoVisualizacion",
            contentType: 'application/json',
            success: function (data) {
                if (checkTimeout(data)) {
                    $('#divComunicadoVisualizacion').dialog('close');
                    closeWaitingDialog();
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("Ocurrió un error al aceptar el comunicado.");
                }
            }
        });
    }

    $("#divComunicadoVisualizacion").dialog('close');
};

// Métodos Mensaje Contrato
function CrearPopupMensajeContrato() {
    $('#divMensajeContrato').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 200,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });
};
function AbrirPopupMensajeContrato(message, fnClose) {
    $('#divMensajeContrato .message_text').html(message);
    if ($.isFunction(fnClose)) $('#divMensajeContrato').dialog({ close: fnClose });
    else $('#divMensajeContrato').dialog({ close: null });

    $('#divMensajeContrato').dialog('open');
}

// Métodos ShowRoom
function CrearPopShow() {
    $("body").on("click", "div.check_01 label.checkpop input", function (event) {
        event.preventDefault();
        if ($(this).parent().hasClass("c_on")) {
            $(this).parent().removeClass("c_on");
        } else {
            $(this).parent().addClass("c_on");
        }
    });

    $("body").on("click", "div.check_hoy label.checkpop input", function (event) {
        event.preventDefault();
        if ($(this).parent().hasClass("c_on")) {
            $(this).parent().removeClass("c_on");
        } else {
            $(this).parent().addClass("c_on");
        }
    });

    var noMostrarShowRoom = true;

    $('#DialogoMensajeBannerShowRoom').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 821,
        draggable: true,
    });
    $("#btnCerrarPopShowroom").click(function () {
        $("#DialogoMensajeBannerShowRoom").dialog('close');
    });

    $('#DialogoMensajeBannerShowRoomHoy').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 624,
        draggable: true,
    });
    $("#btnCerrarPopShowroomHoy").click(function () {
        $("#DialogoMensajeBannerShowRoomHoy").dialog('close');
    });

    $("#cbNoMostrarPopupShowRoom, #cbNoMostrarPopupShowRoomHoy").click(function () {
        var noMostrarPopup = noMostrarShowRoom;

        var item = {
            noMostrarPopup: noMostrarPopup
        };

        $.ajax({
            type: 'POST',
            url: baseUrl + 'ShowRoom/UpdatePopupShowRoom',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: false,
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        if (noMostrarShowRoom)
                            AgregarTagManagerShowRoomCheckBox();
                        noMostrarShowRoom = noMostrarShowRoom == true ? false : true;
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                    console.log("Ocurrió un error en ShowRoom");
                }
            }
        });
    });

    $("#lnkConoceMasShowRoomPopup").click(function () {
        AgregarTagManagerShowRoomPopupConocesMas(1);
    });

    $("#lnkConoceMasShowRoomPopupHoy").click(function () {
        AgregarTagManagerShowRoomPopupConocesMas(2);
    });
};
function MostrarShowRoom() {
    if (viewBagRolID == 1) { // Rol Consultora
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/MostrarShowRoomPopup",
            contentType: 'application/json',
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        var showroomConsultora = response.data;
                        var evento = response.evento;

                        if (showroomConsultora.EventoConsultoraID != 0) {
                            if (showroomConsultora.MostrarPopup) {
                                $("#hdEventoIDShowRoom").val(evento.EventoID);

                                if (response.mostrarShowRoomProductos) {
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().find(".ui-dialog-titlebar").hide();
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("overflow", "inherit");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("border", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("-webkit-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("-moz-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("-khtml-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("padding", "0");

                                    $('#DialogoMensajeBannerShowRoomHoy').dialog('open'); //llamar al pop up
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("top", "");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("top", "90px");
                                    $("#DialogoMensajeBannerShowRoomHoy").parent().css("height", "450px");

                                    $("#spnShowRoomEventoHoy").html(evento.Nombre);

                                    $("#lnkConoceMasShowRoomPopupHoy").attr("href", response.rutaShowRoomPopup);

                                    showDialog("DialogoMensajeBannerShowRoomHoy");

                                    AgregarTagManagerShowRoomPopup(evento.Nombre, true);
                                } else {
                                    $("#DialogoMensajeBannerShowRoom").parent().find(".ui-dialog-titlebar").hide();
                                    $("#DialogoMensajeBannerShowRoom").parent().css("overflow", "inherit");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("border", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("-webkit-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("-moz-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("-khtml-border-radius", "0");
                                    $("#DialogoMensajeBannerShowRoom").parent().css("padding", "0");
                                    $('#DialogoMensajeBannerShowRoom').dialog('open'); //llamar al pop up

                                    $("#spnShowRoomEvento").html(evento.Nombre);
                                    $("#spnShowRoomNombreConsultora").html(response.nombre);
                                    $("#spnShowRoomDiaInicio").html(response.diaFin - 2);
                                    $("#spnShowRoomDiaFin").html(response.diaFin);
                                    $("#spnShowRoomMes").html(response.mesFin);

                                    $("#lnkConoceMasShowRoomPopup").attr("href", response.rutaShowRoomPopup);

                                    showDialog("DialogoMensajeBannerShowRoom");

                                    AgregarTagManagerShowRoomPopup(evento.Nombre, false);
                                }
                            }
                        }
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                    console.log("Ocurrió un error en ShowRoom");
                }
            }
        });
    }
};
function AgregarTagManagerShowRoomPopup(nombreEvento, esHoy) {
    var name = 'showroom digital ' + nombreEvento;

    if (esHoy)
        name += " - fase 2";

    dataLayer.push({
        'event': 'promotionView',
        'ecommerce': {
            'promoView': {
                'promotions': [
                {
                    'id': $("#hdEventoIDShowRoom").val(),
                    'name': name,
                    'position': 'Home pop-up - 1',
                    'creative': 'Banner'
                }]
            }
        }
    });
};
function AgregarTagManagerShowRoomPopupConocesMas(opcion) {
    var nombre = opcion == 1 ? $("#spnShowRoomEvento").html() : $("#spnShowRoomEventoHoy").html();

    if (opcion != 1)
        nombre += " - fase 2";

    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                    {
                        'id': $("#hdEventoIDShowRoom").val(),
                        'name': 'showroom digital ' + nombre,
                        'position': 'Home pop-up - 1',
                        'creative': 'Banner'
                    }]
            }
        }
    });
};
function AgregarTagManagerShowRoomCheckBox() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom',
        'action': 'checkbox',
        'label': '(not available)'
    });
};
function CargarProductoDestacado(objParameter, objInput) {
    waitingDialog({});

    if (ReservadoOEnHorarioRestringido())
        return false;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;
    var cantidadIngresada = $(objInput).parent().find("input.liquidacion_rango_cantidad_pedido").val();

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

                        $("#OfertaTipoNuevo").val(OfertaTipoNuevo)
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

                closeWaitingDialog();
                AgregarProductoDestacado();
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
                    }
                }
                if (option == "") {
                    AgregarProductoDestacado();
                } else {
                    closeWaitingDialog();
                }
            }

            InfoCommerceGoogleDestacadoProductClick(datos.data.DescripcionCUV2, datos.data.CUV2, datos.data.DescripcionCategoria, datos.data.DescripcionEstrategia, posicionItem);

            //closeWaitingDialog();
            //showDialog('divVistaPrevia');
        },
        error: function (data, error) {
            alert(datos.data.message);
            closeWaitingDialog();
        }
    });
};
function AgregarProductoDestacado() {
    var cantidad = $("#txtCantidadZE").val();
    var cantidadLimite = $("#txtCantidadZE").attr("est-cantidad");
    var cuv = $("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $("#txtCantidadZE").attr("est-marcaID");
    var precio = $("#txtCantidadZE").attr("est-precio2");
    var descripcion = $("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $("#txtCantidadZE").attr("est-montominimo");
    var tipoOferta = $("#txtCantidadZE").attr("est-tipooferta");
    var categoria = $("#txtCantidadZE").attr("est-descripcionCategoria");
    var variant = $("#txtCantidadZE").attr("est-descripcionEstrategia");
    var marca = $("#txtCantidadZE").attr("est-descripcionMarca");
    var posicion = $("#txtCantidadZE").attr("est-posicion");
    var urlImagen = $("#imgZonaEstrategiaEdit").attr("src");

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            alert_msg("Por favor, seleccione la Talla/Color del producto.");
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        alert_msg("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        alert_msg("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        alert_msg("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        $("#loadingScreen").dialog('close');
        return false;
    }

    waitingDialog({});

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ElementoOfertaTipoNuevo: $("#OfertaTipoNuevo").val()
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
                alert_msg(datos.message);
                closeWaitingDialog();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'Pedido/AgregarProductoZE',
                    dataType: 'html',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (checkTimeout(data)) {
                            waitingDialog({});
                            InfoCommerceGoogle(parseFloat(cantidad * precio).toFixed(2), cuv, descripcion, categoria, precio, cantidad, marca, variant, "Productos destacados – Pedido", parseInt(posicion));
                            CargarCarouselEstrategias(cuv);
                            MostrarProductoAgregado(urlImagen, descripcion, cantidad, (cantidad * precio).toFixed(2));
                            CargarCantidadProductosPedidos();
                            CargarResumenCampaniaHeader();
                            closeWaitingDialog();
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            closeWaitingDialog();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
};
function MostrarProductoAgregado(imagen, descripcion, cantidad, total) {
    if (imagen == "") {
        $(".info_pop_liquidacion").addClass("info_pop_liquidacion_sinimagen");
        $("#contenedorProductoAgregado").hide();
    } else {
        $(".info_pop_liquidacion").removeClass("info_pop_liquidacion_sinimagen");
        $("#imgProductoAgregado").attr("src", imagen);
        $("#contenedorProductoAgregado").show();
    }
    $("#nombreProductoAgregado").text(descripcion);
    $("#cantidadProductoAgregado").text(cantidad);
    $("#totalProductoAgregado").text(total);
    $('#pop_liquidacion').show();

    setTimeout(CerrarProductoAgregado, 5000);
};
function CerrarProductoAgregado() {
    $('#pop_liquidacion').hide();
};

function alert_msg(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
};
function CrearDialogs() {
    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });

    //CrearPopupContrato();
    //CrearPopupActualizacionDatos();
    //CrearPopupFlexipago();
    //CrearPopupComunicado();
    //CrearPopupComunicadoVisualizacion();
    //CrearPopupDemandaAnticipada();
    //CrearPopupMensajeConfirmacion();
    //CrearPopupMensajeContrato();
};
function ShowPopupTonosTallas() {
    $('.js-contenedor-popup-tonotalla').show();
};
function HidePopupTonosTallas() {
    $('.js-contenedor-popup-tonotalla').hide()
};
function CambiarTonoTalla(ddlTonoTalla) {
    $(ddlTonoTalla).parents('#divTonosTallas').find('#CUV').attr("value", $("option:selected", ddlTonoTalla).attr("value"));
    $(ddlTonoTalla).parents('#divTonosTallas').find("#PrecioOferta").attr("value", $("option:selected", ddlTonoTalla).attr("precio-real")); //2024
    $(ddlTonoTalla).parents('#divTonosTallas').find("#DescripcionProd").attr("value", $("option:selected", ddlTonoTalla).attr("desc-talla")); //2024

    $(ddlTonoTalla).parents('#divTonosTallas').find('.nombre_producto').html('<b>' + $("option:selected", ddlTonoTalla).attr("desc-talla") + '</b>');
    $(ddlTonoTalla).parents('#divTonosTallas').find('.producto_precio_oferta').html('<b>' + viewBagSimbolo + " " + $("option:selected", ddlTonoTalla).attr("desc-precio") + '</b>'); //2024
};
function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    waitingDialog({});
                    location.href = location.href = baseUrl + 'Pedido/PedidoValidado'
                }
                if (mostrarAlerta == true) {
                    closeWaitingDialog();
                    //alert_msg(data.message, fnRedireccionar);
                    alert_msg(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) alert_msg(data.message);
        },
        error: function (error) {
            console.log(error);
            alert_msg('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}