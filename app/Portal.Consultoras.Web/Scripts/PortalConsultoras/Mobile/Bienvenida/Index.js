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

    $("#imgProductoMobile").click(function () {

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
    if (sesionEsShowRoom == '0') {
        return;
    }
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
    var cantidadRecomendados = $('#divListadoEstrategia').find(".slick-active").length;

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
//PL20-1265

$("#content_oferta_dia_mobile").click(function () {
    $('#PopOfertaDia').slideDown();
});

function CompartirWsp(UrlBase, objParameter) {
    var _id = InsertarProductoCompartido(objParameter, 'W');
    if (_id == 0)
        return false;

    UrlBase = UrlBase.replace("[valor]", _id);

    UrlBase = UrlBase.ReplaceAll('/', '%2F');
    UrlBase = UrlBase.ReplaceAll(":", "%3A");
    UrlBase = UrlBase.ReplaceAll("?", "%3F");
    UrlBase = UrlBase.ReplaceAll("=", "%3D");

    return "whatsapp://send?text=" + UrlBase;
}

//function CompartirFacebook(urlBase, objParameter) {
//    var _id = InsertarProductoCompartido(objParameter,'F');
//    urlBase = urlBase.replace('[valor]', _id);
//    var popWwidth = 570;
//    var popHeight = 420;
//    var left = (screen.width / 2) - (popWwidth / 2);
//    var top = (screen.height / 2) - (popHeight / 2);
//    var url = "http://www.facebook.com/sharer/sharer.php?u=" + urlBase;
//    window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
//}

//function InsertarProductoCompartido(objParameter, app) {
//    //Capturando valores
//    var _rutaImagen = objParameter.RutaImagen;
//    var _marcaID = objParameter.MarcaID;
//    var _marcaDesc = objParameter.MarcaDesc;
//    var _nombre = objParameter.NombrePro;
//    var pcCuv = objParameter.Cuv;
//    var pcPalanca = "OPT";
//    var pcDetalle = _rutaImagen + "|" + _marcaID + "|" + _marcaDesc + "|" + _nombre;
//    var pcApp = app;
//    var ID = 0;
//    var Item = {
//        mCUV: pcCuv,
//        mPalanca: pcPalanca,
//        mDetalle: pcDetalle,
//        mApplicacion: pcApp
//    };
//    jQuery.ajax({
//        type: 'POST',
//        url: urlInsertarProductoCompartido,
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(Item),
//        async: false,
//        success: function (response) {
//            if (checkTimeout(response)) {
//                if (response.success) {
//                    var datos = response.data;
//                    ID = datos.id;
//                } else {
//                    window.messageInfo(response.message);
//                }
//            }
//        },
//        error: function (response, error) {
//            if (checkTimeout(response)) {
//                console.log(response);
//            }
//        }
//    });
//    return ID;
//}

function mostrarCatalogoPersonalizado() {
    document.location.href = urlCatalogoPersonalizado;
}