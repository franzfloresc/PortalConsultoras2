var arrayOfertasParaTi = [];

$(document).ready(function () {

    $('.flexsliderTutorialMobile').flexslider({
        animation: "slide"
    });
    $(".contenedor-tutorial-lbel .otromomento").click(function () {
        $('#tutorialesMobile').hide();
        $('.btn_agregarPedido').show();
    });
    $(".contenedor-tutorial-esika .otromomento").click(function () {
        $('#tutorialesMobile').hide();
        $('.btn_agregarPedido').show();
    });
    $(".footer-page").css({ "margin-bottom": "54px" });
    mostrarTutorialMobile();
    $(".cerrar").click(function () {
        UpdateUsuarioTutorialMobile();
        $('#tutorialesMobile').hide();
        $('.btn_agregarPedido').show();
    });
    $("#tutorialFooterMobile").click(function () {
        $('.btn_agregarPedido').hide();
        $('#tutorialesMobile').show();
        setTimeout(function (){ $(window).resize(); }, 50);
    });
    $(".ver_video_introductorio").click(function () {
        $('#VideoIntroductorio').show();
        setTimeout(function () { playVideo(); }, 500);
    });
    $("#cerrarVideoIntroductorio").click(function () {
        stopVideo();
        $('#VideoIntroductorio').hide();
    });

    CargarCarouselEstrategias("");
    CargarPopupsConsultora();
    TagManagerCatalogosPersonalizados();
    $(document).on('click', '.banner_inferior_mobile', function () {
        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                    {
                        'id': '1',
                        'name': 'Favoritos',
                        'position': 'Home-inferior-1'
                    }]
                }
            }
        });
    });

    CrearPopShow();
    MostrarShowRoom();    
});

function CrearPopShow() {
    $("#btnCerrarPopShowroom").click(function () {        
        $("#PopShowroom").modal("hide");
    });

    $("#btnCerrarPopShowroomHoy").click(function () {
        $("#PopShowroomHoy").modal("hide");
    });

    $("#lnkNoMostrarPopup, #lnkNoMostrarPopupHoy").click(function () {
        var params = { noMostrarPopup: true };

        $.ajax({
            type: "POST",
            url: urlUpdatePopupShowRoom,
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function (data) {
                if (checkTimeout(data)) {
                    $("#PopShowroom").modal("hide");
                    $("#PopShowroomHoy").modal("hide");
                    AgregarTagManagerShowRoomCheckBox();
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    messageInfo("Ocurrió un error al intentar no mostrar el popup de showroom.");
                }
            }
        });
    });

    $("#lnkConoceMasShowRoomPopup").click(function () {
        AgregarTagManagerShowRoomPopupConocesMas(false);
    });

    $("#lnkConoceMasShowRoomPopupHoy").click(function () {
        AgregarTagManagerShowRoomPopupConocesMas(true);
    });
}

function MostrarShowRoom() {
    $.ajax({
        type: "POST",
        url: urlMostrarShowRoomPopup,
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
                                $("#spnShowRoomEventoHoy").html(evento.Tema);
                                $("#spnShowRoomDiaInicioHoy").html(response.diaFin - 2);
                                $("#spnShowRoomDiaFinHoy").html(response.diaFin);
                                $("#spnShowRoomMesHoy").html(response.mesFin);
                                
                                $("#PopShowroomHoy").modal("show");
                                $("#lnkConoceMasShowRoomPopupHoy").attr("href", urlShowRoomBienvenida);

                                //Carga de Imagenes
                                $("#imgPestaniaShowRoomHoy").attr("src", evento.ImagenPestaniaShowRoom);
                                $("#imgPreventaDigitalHoy").attr("src", evento.ImagenPreventaDigital);
                                $("#imgVentaSetPopupHoy").attr("src", evento.ImagenVentaSetPopup);

                                AgregarTagManagerShowRoomPopup(evento.Tema, true);
                            } else {
                                $("#spnShowRoomNombreConsultora").html(response.nombre);
                                $("#spnShowRoomEvento").html(evento.Tema);
                                $("#spnShowRoomDiaInicio").html(response.diaInicio);
                                $("#spnShowRoomDiaFin").html(response.diaFin);
                                $("#spnShowRoomMes").html(response.mesFin);
                                if (response.mesFin.length > 6) {
                                    $(".fecha_promocion_m").css("font-size", "10.5pt");
                                }
                                
                                $("#PopShowroom").modal("show");
                                $("#lnkConoceMasShowRoomPopup").attr("href", response.rutaShowRoomPopup);

                                //Carga de Imagenes
                                $("#imgPestaniaShowRoom").attr("src", evento.ImagenPestaniaShowRoom);
                                $("#imgPreventaDigital").attr("src", evento.ImagenPreventaDigital);

                                AgregarTagManagerShowRoomPopup(evento.Tema, false);
                            }

                            //$("#imgShowRoomGif").attr("src", evento.Imagen1);
                        }
                    }
                }
            }
        },
        error: function (response, error) {
            /* PCABRERA EPD-180 - INICIO */
            checkUserSession();
            /* PCABRERA EPD-180 - FIN */
            if (checkTimeout(response)) messageInfo("Ocurrió un error al validar showroom.");
        }
    });
}

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
}

function AgregarTagManagerShowRoomPopupConocesMas(esHoy) {
    var name = 'showroom digital ' + (esHoy ? $("#spnShowRoomEventoHoy").html() : $("#spnShowRoomEvento").html());

    if (esHoy)
        name += " - fase 2";

    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
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
}

function AgregarTagManagerShowRoomCheckBox() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom',
        'action': 'checkbox',
        'label': '(not available)'
    });
}

function mostrarTutorialMobile() {
    if (viewBagVioTutorial == "0") {
        $('#tutorialesMobile').show();
        $('.btn_agregarPedido').hide();
        setTimeout(function () {
            $(window).resize();
        }, 300);
    }
};

//Video youtube
function stopVideo() {
    if (player) {
        if (player.stopVideo) {
            player.stopVideo();
        }
        else {
            //document.getElementById("divPlayer").contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}','*');
            var urlVideo = $("#divPlayer").attr("src");
            $("#divPlayer").attr("src", "");
            $("#divPlayer").attr("src", urlVideo);
        }
    }
};
function playVideo() {
    if (player) {
        if (player.playVideo) {
            player.playVideo();
        }
        else {
            document.getElementById("divPlayer").contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
        }
    }
};

function UpdateUsuarioTutorialMobile() {
    $.ajax({
        type: 'GET',
        url: urlJSONSetUsuarioTutorial,
        data: '',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            viewBagVioTutorial = data.result;
        },
        error: function (data) {
        }
    });
};

function RedirectPagaEnLineaAnalytics() {

    if (ViewBagRutaChile != "") {
        window.open(ViewBagRutaChile + ViewBagUrlChileEncriptada, "_blank");
    }
    else {
        window.open('https://www.belcorpchile.cl/BP_Servipag/PagoConsultora.aspx?c=' + ViewBagUrlChileEncriptada, "_blank");
    }
};
function CargarCarouselEstrategias(cuv) {
    $('.js-slick-prev').remove();
    $('.js-slick-next').remove();
    $('#divCarouseHorizontalMobile.slick-initialized').slick('unslick');
   
    $('#divCarouseHorizontalMobile').html('<div style="text-align: center;">Cargando Productos Destacados<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: urlGetEstrategiasCarousel + '?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $('#divCarouseHorizontalMobile').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
};
function ArmarCarouselEstrategias(data) {
    data = EstructurarDataCarousel(data);
    arrayOfertasParaTi = data;

    SetHandlebars("#estrategia-template", data, '#divCarouseHorizontalMobile');

    if ($.trim($('#divCarouseHorizontalMobile').html()).length == 0) {
        $('.fondo_gris').hide();
    } else {
        $('#divCarouseHorizontalMobile').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev" style="margin-left:-13%"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next" style="margin-right:-13%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>',
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
                var posicionPrimerActivo = $($('#divCarouseHorizontalMobile').find(".slick-active")[0]).find('.PosicionEstrategia').val();
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
                    'list': 'Ofertas para ti – Home',
                    'position': recomendado.Posicion
                };

                arrayEstrategia.push(impresionRecomendado);
                                
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Ofertas para ti',
                    'label': 'Ver anterior'
                });
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });
            } else if (accion == 'next') {
                //TagManager
                var posicionUltimoActivo = $($('#divCarouseHorizontalMobile').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
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
                    'list': 'Ofertas para ti – Home',
                    'position': recomendado.Posicion
                };

                arrayEstrategia.push(impresionRecomendado);
                                
                dataLayer.push({
                    'event': 'virtualEvent',
                    'category': 'Home',
                    'action': 'Ofertas para ti',
                    'label': 'Ver siguiente'
                });
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'impressions': arrayEstrategia
                    }
                });
            };

        });
        TagManagerCarruselInicio(data);
    }
};
function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        item.DescripcionCompleta = item.DescripcionCUV2;
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        };
        item.Posicion = i + 1;
    });

    return array;
};
function CargarProductoDestacado(objParameter, objInput) {
    ShowLoading();

    if (ReservadoOEnHorarioRestringido())
        return false;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;
    var cantidadIngresada = $(objInput).parent().find("input.rango_cantidad_pedido").val();
    var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: urlFiltrarEstrategiasPedido ,
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

                CloseLoading();
                AgregarProductoDestacado(tipoEstrategiaImagen);
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
                    AgregarProductoDestacado(tipoEstrategiaImagen);
                } else {
                    CloseLoading();
                }
            }

            //CloseLoading();
        },
        error: function (data, error) {
            alert(datos.data.message);
            CloseLoading();
        }
    });
};
function AgregarProductoDestacado(tipoEstrategiaImagen) {
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
    var OrigenPedidoWeb = MobileHomeOfertasParaTi;

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            messageInfo("Por favor, seleccione la Talla/Color del producto.");
            CloseLoading();
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        messageInfo("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CloseLoading();
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        messageInfo("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CloseLoading();
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        messageInfo("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        CloseLoading();
        return false;
    }

    ShowLoading();

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        tipoEstrategiaImagen: tipoEstrategiaImagen || 0,
        OrigenPedidoWeb: OrigenPedidoWeb
    });

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                messageInfo(datos.message);
                CloseLoading();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: urlAgregarProducto,
                    dataType: 'html',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (checkTimeout(data)) {
                            ShowLoading();
                            ActualizarGanancia(JSON.parse(data).DataBarra);
                            CargarCarouselEstrategias(cuv);
                            TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                            TagManagerClickAgregarProducto();
                            CloseLoading();
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CloseLoading();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
            }
        }
    });
};
function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
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
                    ShowLoading();
                    location.href = urlValidadoPedido;
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    messageInfo(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) {
                messageInfo(data.message);
            }
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
};

// CARGAR POPUPS HOME MOBILE
function CargarPopupsConsultora() {
    //if (viewBagPrimeraVez == "0" && viewBagPaisID == 4) { //Colombia
    //    AbrirAceptacionContrato();
    //}
    //else {
    //    if (viewBagPaisID == 9 && viewBagValidaDatosActualizados == '1' && viewBagValidaTiempoVentana == '1' && viewBagValidaSegmento == '1') { //Mexico
    //        if (contadorFondoPopUp == 0) {
    //            $("#fondoComunPopUp").show();
    //        }
    //        $("#popupActualizarMisDatosMexico").show();
    //        contadorFondoPopUp++;
    //    } else {
    //        if (viewBagPrimeraVez == "0" || viewBagPrimeraVezSession == "0") {
    //            if (viewBagPaisID == 11) { //Peru
    //                $('#tituloActualizarDatos').html('<b>ACTUALIZACIÓN Y AUTORIZACIÓN</b> DE USO DE DATOS PERSONALES');
    //            } else {
    //                $('#tituloActualizarDatos').html('<b>ACTUALIZAR</b> DATOS');
    //            }
    //            if (contadorFondoPopUp == 0) {
    //                $("#fondoComunPopUp").show();
    //            }
    //            $("#popupActualizarMisDatos").show();
    //            contadorFondoPopUp++;
    //        }
    //        else {
    //            if (viewBagPrimeraVez == "1" && viewBagPaisID == 4) { //Colombia
    //                AbrirAceptacionContrato();
    //            }
    //        }
    //    }
    //}

    //AbrirPopupFlexipago();
    //AbrirComunicado();

    //if (viewBagPrefijoPais == "EC") {
    //    AbrirComunicadoVisualizacion();
    //};

    MostrarDemandaAnticipada();

    //MostrarShowRoom();

    //if (viewBagValidaSuenioNavidad == 0) {
    //    showDialog('idSueniosNavidad');
    //}
};

function MostrarDemandaAnticipada() {
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/ValidacionConsultoraDA",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $('#fechaHasta').text(data.mensajeFechaDA);
                    $('#fechaLuego').text(data.mensajeFechaDA);
                    if (contadorFondoPopUp == 0) {
                        $("#fondoComunPopUp").show();
                    }
                    $("#popupDemandaAnticipada").show();
                    contadorFondoPopUp++;
                }
                
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
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
    var params = { tipoConfiguracion: tipo };
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/InsConfiguracionConsultoraDA",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $("#popupDemandaAnticipada").hide();
                    if (contadorFondoPopUp == 1) {
                        $("#fondoComunPopUp").hide();
                    }
                    contadorFondoPopUp--;
                    location.href = baseUrl + 'Login/LoginCargarConfiguracion?paisID=' + data.paisID + '&codigoUsuario=' + data.codigoUsuario;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                if (tipo == 1) {
                    alert("Ocurrió un error al aceptar la demanda anticipada.");
                } else {
                    alert("Ocurrió un error al cancelar la demanda anticipada.");
                }
            }
        }
    });
};
function TagManagerCatalogosPersonalizados() {
    if (!!document.getElementById("flagCatalogoPersonalizado")) {
        dataLayer.push({
            'event': 'promotionView',
            'ecommerce': {
                'promoView': {
                    'promotions': [
                    {
                        'id': '1',
                        'name': 'Favoritos',
                        'position': 'Home-inferior-1'
                    }]
                }
            }
        });
    }
};

//Google Analytics
function TagManagerCarruselInicio(arrayItems) {
    var cantidadRecomendados = $('#divCarouseHorizontalMobile').find(".slick-active").length;

    var arrayEstrategia = [];
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = arrayItems[i];
        var impresionRecomendado = {
            'name': recomendado.DescripcionCompleta,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Ofertas para ti – Home',
            'position': recomendado.Posicion
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}
function TagManagerClickAgregarProducto() {
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Ofertas para ti – Home' },
                'products': [
                    {
                        'name': $("#txtCantidadZE").attr("est-descripcion"),
                        'price': $("#txtCantidadZE").attr("est-precio2"),
                        'brand': $("#txtCantidadZE").attr("est-descripcionMarca"),
                        'id': $("#txtCantidadZE").attr("est-cuv2"),
                        'category': 'NO DISPONIBLE',
                        'variant': $("#txtCantidadZE").attr("est-descripcionEstrategia"),
                        'quantity': parseInt($("#txtCantidadZE").val()),
                        'position': parseInt($("#txtCantidadZE").attr("est-posicion"))
                    }
                ]
            }
        }
    });
}
function TagManagerCarruselPrevia() {
    var posicionPrimerActivo = $($('#divCarouseHorizontalMobile').find(".slick-active")[0]).find('.PosicionEstrategia').val();
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
        'list': 'Ofertas para ti – Home',
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
        'category': 'Home',
        'action': 'Ofertas para ti',
        'label': 'Ver anterior'
    });

}
function TagManagerCarruselSiguiente() {
    var posicionUltimoActivo = $($('#divCarouseHorizontalMobile').find(".slick-active").slice(-1)[0]).find('.PosicionEstrategia').val();
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
        'list': 'Ofertas para ti – Home',
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
        'category': 'Home',
        'action': 'Ofertas para ti',
        'label': 'Ver siguiente'
    });

}
