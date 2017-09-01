﻿var arrayOfertasParaTi = [];

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

    if (tieneMasVendidos === 1) {
        masVendidosModule.readVariables({
            baseUrl: baseUrl,
            urlDetalleProducto: baseUrl + 'Mobile/EstrategiaProducto/DetalleProducto'
        });
        var rating = 1.6;
        $(".rateyo-readonly-widg").rateYo({
            rating: rating,
            numStars: 5,
            precision: 2,
            minValue: 1,
            maxValue: 5,
            starWidth: "17px"
        }).on("rateyo.change", function (e, data) {
        });
        CargarCarouselMasVendidos('mobile');
    }

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
   
    ObtenerComunicadosPopup();
});

function CrearPopShow() {
    /*
    if (typeof gTipoUsuario !== 'undefined') {
        if (gTipoUsuario == '2') {
            return false;
        }
    }
    */

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

                                $("#imgPestaniaShowRoom").attr("src", evento.ImagenPestaniaShowRoom);
                                $("#imgPreventaDigital").attr("src", evento.ImagenPreventaDigital);

                                AgregarTagManagerShowRoomPopup(evento.Tema, false);
                            }

                        }
                    }
                }
            }
        },
        error: function (response, error) {
            checkUserSession();
            if (checkTimeout(response)) messageInfo("Ocurri? un error al validar showroom.");
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

function stopVideo() {
    if (player) {
        if (player.stopVideo) {
            player.stopVideo();
        }
        else {

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
            if (checkTimeout(data)) {
            viewBagVioTutorial = data.result;
            }
        },
        error: function (data) {
            if (checkTimeout(data)) {
        }
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
                    //messageInfo(data.message);
                    AbrirPopupPedidoReservado(data.message,'2');
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) {
                messageInfo(data.message);
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
        }
    });
    return restringido;
};

function CargarPopupsConsultora() {
    
    MostrarDemandaAnticipada();
    if (viewBagVioTutorial != '0' && noMostrarPopUpRevistaDig == 'False') {
        //$("#PopRDSuscripcion").show();
        AbrirPopupFade("#PopRDSuscripcion");
        MostrarPopupRDAnalytics();
    }
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
                if (typeof tipo !== "undefined") {
                    if (tipo == 1) {
                        alert("Ocurrió un error al validar demanda anticipada.");
                    } else {
                        alert("Ocurrió un error al validar la demanda anticipada.");
                    }
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

$("#content_oferta_dia_mobile").click(function () {
    $('#PopOfertaDia').slideDown();
    odd_mobile_google_analytics_promotion_click();
});

function odd_mobile_google_analytics_promotion_click() {
    if ($('#BloqueMobileOfertaDia').length > 0) {
        var id = $('#BloqueMobileOfertaDia').find("#estrategia-id-odd").val();
        var name = "Oferta del día - " + $('#BloqueMobileOfertaDia').find("#nombre-odd").val();
        var creative = $('#BloqueMobileOfertaDia').find("#nombre-odd").val() + " - " + $('#BloqueMobileOfertaDia').find("#cuv2-odd").val()
        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                    {
                        'id': id,
                        'name': name,
                        'position': 'Banner Superior Home - 1',
                        'creative': creative
                    }]
                }
            }
        });
    }
}
function odd_mobile_google_analytics_addtocart() {    
    var element = $("#OfertasDiaMobile").find(".slick-current").attr("data-slick-index");
    var id = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".cuv2-odd").val();
    var name = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".nombre-odd").val();
    var price = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".precio-odd").val();
    var marca = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".MarcaNombre").val();
    var variant = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".DescripcionEstrategia").val();
    var quantity = $('#pop_oferta_mobile').find("#txtCantidad").val();
    if (variant == "")
        variant = "Estándar";
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Oferta del día' },
                'products': [{
                    'name': name,
                    'price': price,
                    'brand': marca,
                    'id': id,
                    'category': 'No disponible',
                    'variant': variant,
                    'quantity': quantity,
                    'dimension15': '100',
                    'dimension16': 'Oferta del día - Detalle'
                }]
            }
        }
    });
}
function odd_mobile_google_analytics_promotion_impresion(list, event, index) {
    var impressions = [];
    var position = 0;
    var elements = list.length;
    var item = null;
    var impresion = null;
    if (event === 'page_load') {//Ok
        
        position = 1;
        for (var i = 0; i <= elements - 1; i++) {
            item = list[i];
            item.Posicion = position;
            if (position <= 3) {
                impresion = odd_get_item_impresion(item);
                if (impresion != null)
                    impressions.push(impresion);
            }
            else
                break;
            position++;
        }
    }
    if (event === 'arrow_click') {
        
        item = list[index];
        item.Posicion = index + 1;
        impresion = odd_get_item_impresion(item);
        if (impresion != null)
            impressions.push(impresion);
    }
    if (impressions.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': impressions
            }
        });
    }
}
function odd_get_item_impresion(item) {
    var impresion = null;
    if (item != null) {
        impresion = {
            'name': item.NombreOferta,
            'id': item.CUV2,
            'price': item.PrecioOferta,
            'brand': item.DescripcionMarca,
            'category': 'No disponible',
            'variant': 'Lanzamiento',
            'list': 'Oferta del día',
            'position': item.Posicion
        }
    }
    return impresion;
}

function mostrarCatalogoPersonalizado() {
    document.location.href = urlCatalogoPersonalizado;
}

function ObtenerComunicadosPopup() {
    if (primeraVezSession == 0) return;


    $(".contenedor_popup_comunicado").click(function (e) {
        grabarComunicadoPopup();
    });

    $(".popup_comunicado .btn_cerrar a").click(function (e) {
        e.stopPropagation();
        grabarComunicadoPopup();
        $(".contenedor_popup_comunicado").modal("hide");
    });

    $(".popup_comunicado .pie_popup_comunicado input[type='checkbox']").click(function (e) {
        e.stopPropagation();
    });

    $('.contenedor_popup_comunicado').on('hidden.bs.modal', function () {
        //CERRAR
    });

    $(window).resize(function (e) {
        //var w_width = $(window).width() - 50;
        //var w_height = $(window).height() - 150;
        var w_width = 326;
        var w_height = 418;

        $(".popup_comunicado").css("width", w_width);
        $(".popup_comunicado").css("height", w_height);

        $(".detalle_popup_comunicado").css("width", w_width);
        $(".detalle_popup_comunicado").css("height", w_height);
    });

    $(".popup_comunicado .detalle_popup_comunicado").click(function (e) {
        if (userAgent.indexOf("iphone") > -1) {
            e.preventDefault();
            alert("La aplicación no se encuentra disponible para este dispositivo");
            return;
        }

        window.open($(this).attr("urlAccion"));

        //CLICK
    });

    $(".popup_comunicado .pie_popup_comunicado .check").click(function (e) {
        e.stopPropagation();

        var chk = $(".popup_comunicado .pie_popup_comunicado input[type='checkbox']");

        if (chk.is(':checked')) {
            $(this).html("");
            chk.prop('checked', false);
        }
        else {
            $(this).html("X");
            chk.prop('checked', true);
        }
    });

    ShowLoading();

    $.ajax({
        type: "GET",
        url: baseUrl + 'Mobile/Bienvenida/ObtenerComunicadosPopUps',
        contentType: 'application/json',
        success: function (response) {
            CloseLoading();

            if (checkTimeout(response)) {
                armarComunicadosPopup(response)
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) CloseLoading();
        }
    });
}

function armarComunicadosPopup(response){
    if (response == null) return;

    $(".popup_comunicado .pie_popup_comunicado input[type='checkbox']").val(response.ComunicadoId);
    $(".popup_comunicado .pie_popup_comunicado input[type='checkbox']").prop('checked', false);
    $(".popup_comunicado .detalle_popup_comunicado").attr("urlAccion", response.DescripcionAccion);

    $(".popup_comunicado .detalle_popup_comunicado").css("background-image", "url(" + response.UrlImagen + ")");
    $(".contenedor_popup_comunicado").modal("show");

    $(window).resize();

    //ABRIR
}

function grabarComunicadoPopup() {
    var checked = $(".popup_comunicado .pie_popup_comunicado input[type='checkbox']").is(':checked');
    if (!checked) return;

    var comunicadoID = $(".popup_comunicado .pie_popup_comunicado input[type='checkbox']").val();
    var params = { ComunicadoID: comunicadoID };

    ShowLoading();

    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarComunicadoVisualizacion",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                CloseLoading();
                if(!data.success) alert(data.message)
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                alert("Ocurrió un error al aceptar el comunicado.");
            }
        }
    });
}