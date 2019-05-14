﻿var vpromotions = [];
var vpromotionsTagged = [];
var arrayOfertasParaTi = [];
var arrayLiquidaciones = [];
var numImagen = 1;
var fnMovimientoTutorial;
var origenPedidoWebEstrategia = origenPedidoWebEstrategia || 0;
var showViewVideo = viewBagVioVideo;
var closeComunicadosPopup = false;
var fotoCroppie;
var tipoOrigen = '3';
var timeoutTooltipTutorial;
var popupCantidadInicial = popupCantidadInicial || 1;
var popupListaPrioridad = popupListaPrioridad || new Array();
var showRoomMostrarLista = showRoomMostrarLista || 0;
var dataBarra = dataBarra || {};

//youtube
var tag = null;
var firstScriptTag = null;

// oYTPlayers in scripts/_implements/youtube.js
var $divPlayer = $("#ytBienvenidaIndex");

$(document).ready(function () {
    var hdDataBarra = $("#hdDataBarra").val();
    if ($.trim(hdDataBarra) != "") {
        dataBarra = JSON.parse(hdDataBarra);
    }

    $("#hdDataBarra").val("");

    if (vbFotoPerfil != null && vbFotoPerfil != "") {
        $('div.content_datos').css('max-width', '100%');
        $('div.resumen_belcorp_cam').css('margin-left', '1.5%');
        $('div.resumen_belcorp_cam').css('margin-right', '0%');
        if (window.matchMedia('(min-width:1221px)').matches) {
            $('div.socia_negocio_home').css('margin-left', '4.8%');
        } else {
            $('div.socia_negocio_home').css('margin-left', '4%');
        }
        $('div.contenedor_img_perfil').show();
    } else {
        $('div.resumen_belcorp_cam').css('margin-left', '2%');
        $('div.resumen_belcorp_cam').css('margin-right', '3%');
        $('div.resumen_belcorp_cam').css('width', '27.65%');
        $('div.pedido_resumen_home').css('width', '30.4%');
        $('div.fecha_cierre_campania').css('width', '214px');
    }

    $(".termino_condiciones_intriga").click(function () {
        $(this).toggleClass('check_intriga');
    });

    $('#salvavidaTutorial').show();

    $("#salvavidaTutorial").click(function () {
        abrir_popup_tutorial(true);
        ocultarUbicacionTutorial();
    });

    $("#salvavidaTutorial .tooltip_tutorial").click(function (e) {
        e.stopPropagation();
    });

    $(".cerrar_tutorial").click(function () {
        cerrar_popup_tutorial();
        if (ObtenerEstadoContrato()) PopupMostrar('popupAceptacionContrato');
    });

    $(".ver_video_introductorio").click(function () {
        $('#fondoComunPopUp').show();
        contadorFondoPopUp++;
        $('#videoIntroductorio').fadeIn(function () {
            $("#videoIntroductorio").delay(200);
            $("#videoIntroductorio").fadeIn(function () {
                var player = oYTPlayers['ytBienvenidaIndex'].instance;
                playVideo();

                setTimeout(function () { if (player.playVideo) { player.playVideo(); } }, 2000);
            });
        });
    });

    $('.contenedor_fondo_popup').click(function (e) {
        if (!$(e.target).closest('.popup_actualizarMisDatos').length) {
            if ($('#popupActualizarMisDatos').is(':visible')) {
                CerrarPopupActualizacionDatos();
                $('#fondoComunPopUp').hide();
            }
            if ($('#popupMisDatos').is(':visible')) {
                if (showPopupMisDatos == '1') {
                    dataLayerVC("Banner Actualizar Datos", "Cerrar popup");
                    showPopupMisDatos = '0';
                }
                $('#fondoComunPopUp').hide();
            }
        }
        if (!$(e.target).closest('#virtual-coach-dialog').length) {
            if ($('#virtual-coach-dialog').is(':visible')) asesoraOnlineObj.hidePopup();
        }
    });

    $('.contenedor_popup_agregarUnidades').click(function (e) {
        if (!$(e.target).closest('.popup_agregarUnidades').length) {
            if ($('#popupConfirmacionDatos').is(':visible')) {
                $('#dialog_AgregasteUnidades').hide();
            }
        }
    });

    $('.cerrarTooltip').click(function () {
        document.getElementsByClassName('tooltip_info_revision_correo')[0].style.display = 'none';
    });

    $('.cam-exito a').click(function () {
        BotonAbrirCaminoBrillante();
    });

    document.onkeydown = function (evt) {
        evt = evt || window.event;
        if (evt.keyCode == 27) {
            if ($('#popup_tutorial_home').is(':visible')) {
                cerrar_popup_tutorial();
                if (ObtenerEstadoContrato())
                    PopupMostrar('popupAceptacionContrato');
            }
            if ($('#videoIntroductorio').is(':visible')) {
                if (primeraVezVideo) {
                    abrir_popup_tutorial();
                }
                stopVideo();
                PopupCerrar('videoIntroductorio');
                return false;
            }
            if ($('#popupComunicados').is(':visible')) {
                PopupCerrar('popupComunicados');
                closeComunicadosPopup = true;
            }

            if ($('#popupActualizarMisDatos').is(':visible')) {
                CerrarPopupActualizacionDatos();
                PopupCerrar('popupActualizarMisDatos');
            }

            if ($('#popupMisDatos').is(':visible')) {
                if (showPopupMisDatos == '1') {
                    dataLayerVC("Banner Actualizar Datos", "Cerrar popup");
                    showPopupMisDatos = '0';
                }
                PopupCerrar('popupMisDatos');
            }

            if ($('#popupConfirmacionDatos').is(':visible')) {
                $('#dialog_AgregasteUnidades').hide();
            }
            if ($('#popupActualizarMisDatosMexico').is(':visible')) {
                PopupCerrar('popupActualizarMisDatosMexico');
            }
            if ($('#popupInvitaionFlexipago').is(':visible')) {
                PopupCerrar('popupInvitaionFlexipago');
            }
            if ($('#popupDemandaAnticipada').is(':visible')) {
                PopupCerrar('popupDemandaAnticipada');
            }
            if ($('#PopShowroomIntriga').is(':visible')) {
                SRPopupCerrar('I');
            }
            if ($('#PopShowroomVenta').is(':visible')) {
                SRPopupCerrar('V');
            }

            if ($('#PopRDSuscripcion').is(':visible')) {
                PopupCerrar('PopRDSuscripcion');
            }
        }
    };

    setInterval(animacionFlechaScroll, 1000);
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

    CrearDialogs();
    CargarCarouselEstrategias();
    if (_validartieneMasVendidos() === 1) {
        masVendidosModule.readVariables({
            baseUrl: baseUrl,
            urlDetalleProducto: baseUrl + 'EstrategiaProducto/DetalleProducto'
        });
        $('.titulo_estrellas').rateYo({
            rating: "100%",
            spacing: "14px",
            numStars: 5,
            starWidth: "18.5px",
            readOnly: true,
            ratedFill: "#cca11e"
        });
        CargarCarouselMasVendidos('desktop');
    }

    CargarCarouselLiquidaciones();
    CargarMisCursos();
    CargarBanners();

    if (showRoomMostrarLista == 1) {
        CargarProductosShowRoom({ Limite: 6, hidden: true });
    }

    MostrarPopupInicial();

    $("#btnCambiarContrasenaMD").click(function () { CambiarContrasenia(); });

    $("#btnActualizarMD2").click(function () {
        ActualizarMD();
    });
    $("#btnActualizarMD").click(function () {
        ActualizarMD();
    });

    $("#btnActualizarDatos").click(function () {
        ActualizarDatos();
        return false;
    });

    $("#btnCerrarActualizarDatos").click(function () {
        CerrarPopupActualizacionDatos();
        return false;
    });
    $("#btnActualizarDatosMexico").click(function () {
        ActualizarDatosMexico();
        return false;
    });
    $("#btnCerrarActualizarDatosMexico").click(function () {
        CerrarPopupActualizacionDatosMexico();
        return false;
    });

    $("#cerrarVideoIntroductorio").click(function () {
        if (primeraVezVideo) {
            mostrarUbicacionTutorial(true, true);
            primeraVezVideo = false;
        }
        stopVideo();
        PopupCerrar('videoIntroductorio');
        viewBagVioVideo = 1;
        return false;
    });

    $("#cerrarAceptacionContrato").click(function () {
        PopupCerrar('popupAceptacionContrato');
        return false;
    });

    $("#cerrarInvitacionFlexipago").click(function () {
        PopupCerrar('popupInvitaionFlexipago');
        return false;
    });
    $("#abrirPopupMisDatos").click(function () {
        waitingDialog();
        CargarMisDatos();
        return false;
    });
    $("#cerrarPopupMisDatos").click(function () {

        if (showPopupMisDatos == '1') {
            dataLayerVC("Banner Actualizar Datos", "Cerrar popup");
            showPopupMisDatos = '0';
        }
        PopupCerrar('popupMisDatos');
        return false;
    });
    $("#cerrarPopupActualizacionEmail").click(function () {
        PopupCerrar('popupVerificacionCorreoElectronicoPendiente');
        return false;
    });

    $('#hrefTerminos').click(function () {
        DownloadAttachPDFTerminos();
    });
    $('#hrefTerminosMD').click(function () {
        DownloadAttachContratoActualizarDatos();
    });
    $('#hrefContratoMD').click(function () {
        waitingDialog({});
        DownloadAttachContratoCO();
    });
    $("#btnCancelarMD").click(function () {
        $(".campos_cambiarContrasenia").fadeOut(200);
        $(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
        $(".campos_actualizarDatos").delay(200);
        $(".campos_actualizarDatos").fadeIn(200);
    });

    $("#lnkCambiarContrasena").click(function () {
        if ($("#divCambiarContrasena").is(":visible")) {
            $(".grupo_input_password").slideUp(200);
            $(".popup_actualizarMisDatos").removeClass("incremento_altura");

        } else {
            $(".popup_actualizarMisDatos").addClass("incremento_altura");
            $(".grupo_input_password").slideDown(200);

        }
    });
    $(".misDatosContraseniaEnlace").click(function () {
        if ($(".campos_cambiarContrasenia").is(":visible")) {
            $(".campos_cambiarContrasenia").fadeOut(200);
            $(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
            $(".campos_actualizarDatos").delay(200);
            $(".campos_actualizarDatos").fadeIn(200);

        } else {
            $(".campos_actualizarDatos").fadeOut(200);
            $(".popup_actualizarMisDatos").addClass("incremento_altura_misDatos");
            $(".campos_cambiarContrasenia").delay(200);
            $(".campos_cambiarContrasenia").fadeIn(200);
        }
    });
    $("#txtTelefono, #txtTelefonoMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
        if (!charCode) return false;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9+ *#-]/;
            return re.test(keyChar);
        }
    });
    $("#txtTelefonoTrabajo, #txtTelefonoTrabajoMD").keypress(function (evt) {
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
    $("#txtCelular, #txtCelularMD").keypress(function (evt) {
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
    $("#txtEMailMD, #txtConfirmarEMail").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /^[a-zA-Z@._0-9\-]*$/;
            return re.test(keyChar);
        }
    });
    $("#txtSobrenombreMD").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ _.-]/;
            return re.test(keyChar);
        }
    });

    $("#divCarruselLiquidaciones").on('click', '.js-agregar-liquidacion', function (e) {

        if (!$(this).hasClass("no_accionar")) {
            agregarProductoAlCarrito(this);
        }

        var contenedor = $(this).parents(".content_item_carrusel");
        PedidoRegistroModule.AgregarProductoLiquidacionBienvenida(contenedor);
    });
    $("#divCarruselLiquidaciones").on('click', '.js-agregar-liquidacion-tallacolor', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

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
            ImagenProducto: $(contenedor).find(".producto_img_home img").attr("src"),
            Posicion: $(contenedor).find("#Posicion").val()
        };

        CargarProductoLiquidacionPopup(objProducto, objHidden);
    });
    $(document).on('click', '.js-agregar-popup-liquidacion', function () {

        var contenedor = $(this).parents('#divTonosTallas');
        PedidoRegistroModule.AgregarProductoLiquidacionBienvenida(contenedor);
    });
    $(document).on('click', '.btn_cerrar_escogerTono', function () {
        HidePopupTonosTallas();
    });
    $(document).on('change', '#ddlTallaColorLiq', function () {
        CambiarTonoTalla($(this));
    });

    $(document).on('click', '.miCurso', function () {
        var id = $(this)[0].id;
        GetCursoMarquesina(id)
    });

    MostrarBarra(null, '1');

    LayoutMenu();
    ConsultarEmailPendiente();
    RegistrarInicioSession();
});

$(window).load(function () {
    VerSeccionBienvenida(verSeccion);
});

function RegistrarInicioSession() {
    if (viewBagPrimeraVezSession == '0') {
        dataLayer.push({
            'event': 'writeCookie',
            'consultora': viewBagCodigoConsultora
        });
    }
}

function limitarMaximo(e, contenido, caracteres, id) {
    var unicode = e.keyCode ? e.keyCode : e.charCode;
    if (unicode == 8 || unicode == 46 || unicode == 13 || unicode == 9 || unicode == 37 ||
        unicode == 39 || unicode == 38 || unicode == 40 || unicode == 17 || unicode == 67 || unicode == 86)
        return true;

    if (contenido.length >= caracteres) {
        var selectedText = document.getSelection();
        if (selectedText == contenido) {
            $("#" + id).val("");
            return true;
        } else if (selectedText != "") {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

function limitarMinimo(contenido, caracteres, a) {
    if (contenido.length < caracteres && contenido.trim() != "") {
        var texto = a == 1 ? "teléfono" : a == 2 ? "celular" : "otro teléfono";
        alert('El número de ' + texto + ' debe tener como mínimo ' + caracteres + ' números.');
        return false;
    }
    return true;
}

function animacionFlechaScroll() {

    $(".flecha_scroll").animate({
        'top': '87%'
    }, 400, 'swing', function () {
        $(this).animate({
            'top': '90%'
        }, 400, 'swing');
    });

}

function mostrarUbicacionTutorial(tieneFondoNegro, mostrarPopupTutorial) {
    tieneFondoNegro = tieneFondoNegro == undefined ? false : tieneFondoNegro;
    mostrarPopupTutorial = mostrarPopupTutorial == undefined ? false : mostrarPopupTutorial;

    if (EfectoTutorialSalvavidas == '0') {
        if (!(viewBagVioTutorial == 0 || viewBagVioVideo == 0)) {
            tieneFondoNegro = false;
        }
    }

    $("#fondoComunPopUp").hide();
    $("#fondoComunPopUp").attr("data-activo-salvavidas", '1');

    if (EfectoTutorialSalvavidas != '0') {
        if (tieneFondoNegro) {
            $(".fondo_oscuro").fadeIn(300, function () {
                $(".tooltip_tutorial").fadeIn();
                $(".contenedor_circulosTutorial").fadeIn();
                mostrarIconoTutorial();
            });
        } else {
            $(".tooltip_tutorial").fadeIn();
            $(".contenedor_circulosTutorial").fadeIn();
            mostrarIconoTutorial();
        }
    }

    viewBagVioTutorialSalvavidas = 1;

    var time = EfectoTutorialSalvavidas == '0' ? 0 : 4000;
    timeoutTooltipTutorial = setTimeout(function () {
        ocultarUbicacionTutorial();
        if (mostrarPopupTutorial)
            abrir_popup_tutorial();
    }, time);
}

function mostrarIconoTutorial() {
    if (EfectoTutorialSalvavidas == '0') {
        return false;
    }

    $(".tooltip_tutorial").animate({
        'opacity': 1,
        'top': 47
    }, 500, 'swing').animate({
        'top': 41
    }, 400, 'swing', mostrarIconoTutorial);
}

function ocultarUbicacionTutorial() {
    if (EfectoTutorialSalvavidas == '0') {
        $("#fondoComunPopUp").attr("data-activo-salvavidas", '0');
        clearTimeout(timeoutTooltipTutorial);
        return false;
    }

    $(".contenedor_circulosTutorial").fadeOut();
    $(".tooltip_tutorial").fadeOut();
    $(".tooltip_tutorial").stop();
    $(".fondo_oscuro").delay(500);
    $(".fondo_oscuro").fadeOut(300);

    clearTimeout(timeoutTooltipTutorial);

    $("#fondoComunPopUp").attr("data-activo-salvavidas", '0');
}

function mostrarVideoIntroductorio() {
    var oYTPlayer = oYTPlayers['ytBienvenidaIndex'];
    try {
        if (viewBagVioVideo == "0") {
            PopupMostrar('videoIntroductorio');

            oYTPlayer.on('ready', function (player) {
                if (player.playVideo) { player.playVideo(); }
            });

            return true;
        }

        if (viewBagMostrarUbicacionTutorial == '0') {
            mostrarUbicacionTutorial(false, true);
        } else {
            abrir_popup_tutorial();
        }
        primeraVezVideo = false;
        return true;

        //if (viewBagVioTutorialSalvavidas == '0') {
        //    mostrarUbicacionTutorial(false, false);
        //}
    } catch (e) {

    }
}

function UpdateUsuarioTutoriales(tipo) {
    //tipo ===> 1: Video, 2: TutorialDesktop, 3: TutorialSalvavidas, 4: TutorialMobile

    var item = {
        tipo: tipo
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/JSONUpdateUsuarioTutoriales',
        data: JSON.stringify(item),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
        },
        error: function (data) { }
    });
}

function CrearDialogs() {

    $('#divConfirmarCUVBanner').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
        title: "",
        close: function (event, ui) {
            HideDialog("divConfirmarCUVBanner");
        }
    });
}

function CargarPopupsConsultora() {

    if (viewBagPaisID == 9 && viewBagValidaDatosActualizados == '1' && viewBagValidaTiempoVentana == '1' && viewBagValidaSegmento == '1') { //Mexico
        PopupMostrar('popupActualizarMisDatosMexico');
    } else {
        if (viewBagPrimeraVez == "0" || viewBagPrimeraVezSession == "0") {
            if (viewBagPaisID == 11) { //Peru
                $('#tituloActualizarDatos').html('<b>ACTUALIZACIÓN Y AUTORIZACIÓN</b> DE USO DE DATOS PERSONALES');
            } else {
                $('#tituloActualizarDatos').html('<b>ACTUALIZAR</b> DATOS');
            }
            PopupMostrar('popupActualizarMisDatos');
        }
    }
};

function ShowPopupTonosTallas() {
    $('.js-contenedor-popup-tonotalla').show();
}
function HidePopupTonosTallas() {
    $('.js-contenedor-popup-tonotalla').hide();
}
function CambiarTonoTalla(ddlTonoTalla) {
    $(ddlTonoTalla).parents('#divTonosTallas').find('#CUV').attr("value", $("option:selected", ddlTonoTalla).attr("value"));
    $(ddlTonoTalla).parents('#divTonosTallas').find("#PrecioOferta").attr("value", $("option:selected", ddlTonoTalla).attr("precio-real"));
    $(ddlTonoTalla).parents('#divTonosTallas').find("#DescripcionProd").attr("value", $("option:selected", ddlTonoTalla).attr("desc-talla"));

    $(ddlTonoTalla).parents('#divTonosTallas').find('.nombre_producto').html('<b>' + $("option:selected", ddlTonoTalla).attr("desc-talla") + '</b>');
    $(ddlTonoTalla).parents('#divTonosTallas').find('.producto_precio_oferta').html('<b>' + variablesPortal.SimboloMoneda + " " + $("option:selected", ddlTonoTalla).attr("desc-precio") + '</b>');
}

function alert_unidadesAgregadas(message, exito) {
    if (exito == 1) {
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .titulo_agregarUnidades').html("<b>¡FELICIDADES!</b>");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .mensaje_agregarUnidades').html(message);
    } else {
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp #apro_o_excla').removeClass("icono_aprobacion");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp #apro_o_excla').addClass("icono_exclamacion");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .titulo_agregarUnidades').html("LO <b>SENTIMOS</b>");
        $('#dialog_AgregasteUnidades .popup_agregarUnidades .contenido_popUp .mensaje_agregarUnidades').html(message);
    }
    $('#dialog_AgregasteUnidades').show();
}

function CargarCarouselLiquidaciones() {

    $('.js-slick-prev-liq').remove();
    $('.js-slick-next-liq').remove();
    $('#divCarruselLiquidaciones.slick-initialized').slick('unslick');

    $('#divCarruselLiquidaciones').html('<div style="text-align: center;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: baseUrl + 'OfertaLiquidacion/JsonGetOfertasLiquidacion',
        data: { offset: 0, cantidadregistros: cantProdCarouselLiquidaciones, origen: 'Home' },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                data.lista = EstructurarDataCarouselLiquidaciones(data.lista);
                ArmarCarouselLiquidaciones(data.lista);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $('#divCarruselLiquidaciones').html('');
            }
        }
    });
}

function EstructurarDataCarouselLiquidaciones(array) {
    $.each(array, function (i, item) {
        item.DescripcionCompleta = item.Descripcion;
        item.Descripcion = (item.Descripcion.length > 40 ? item.Descripcion.substring(0, 40) + "..." : item.Descripcion);

        item.Simbolo = variablesPortal.SimboloMoneda;
        item.Posicion = i + 1;
        item.TallaColor = $.trim(item.TallaColor);
        if (item.TallaColor.length > 1 && item.TallaColor.indexOf('^') > -1) {
            item.TipoTallaColor = item.TallaColor.split("^")[0];
            item.TextoBotonTallaColor = (item.TipoTallaColor == "C" ? "ELEGIR TONO" : "ELEGIR COLOR");
            item.TallaColor = item.TallaColor.split("^")[1].split("</>").join("@");
            item.TieneTallaColor = true;
        } else {
            item.TipoTallaColor = "";
            item.TextoBotonTallaColor = "";
            item.TieneTallaColor = false;
        }
    });

    return array;
}

function ProcesarActualizacionMostrarContenedorCupon() {
    if (paginaOrigenCupon) {
        if (cuponModule) {
            cuponModule.actualizarContenedorCupon();
        }
    }
}

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
    }

    $(divTonosTallas).find('#ddlTallaColorLiq').html(option);

    $(divTonosTallas).find('#imgPopupTonoTalla').attr('src', objProducto.imagenProducto);
    $(divTonosTallas).find('#marcaPopupTonoTalla').html(objProducto.tituloMarca);
    $(divTonosTallas).find('.nombre_producto').html('<b>' + objProducto.descripcion + '</b>');
    $(divTonosTallas).find('.producto_precio_oferta').html('<b>' + objProducto.precio + '</b>');

    $(divTonosTallas).find('#MarcaID').val(objHidden.MarcaID);
    $(divTonosTallas).find('#PrecioOferta').val(objHidden.PrecioOferta);
    $(divTonosTallas).find('#CUV').val(objHidden.CUV);
    $(divTonosTallas).find('#ConfiguracionOfertaID').val(objHidden.ConfiguracionOfertaID);
    $(divTonosTallas).find('#DescripcionProd').val(objHidden.DescripcionProd);
    $(divTonosTallas).find('#DescripcionMarca').val(objHidden.DescripcionMarca);
    $(divTonosTallas).find('#DescripcionCategoria').val(objHidden.DescripcionCategoria);
    $(divTonosTallas).find('#DescripcionEstrategia').val(objHidden.DescripcionEstrategia);
    $(divTonosTallas).find('#ImagenProducto').val(objHidden.ImagenProducto);
    $(divTonosTallas).find('#Posicion').val(objHidden.Posicion);

    $(divTonosTallas).find('#txtCantidad').val(1);

    closeWaitingDialog();
    ShowPopupTonosTallas();
}

function CargarBanners() {
    $('.flexslider').html('<ul class="slides"></ul>');
    $('.flexslider').removeData("flexslider");

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Banner/ObtenerBannerPaginaPrincipal',
        data: '',
        dataType: 'Json',
        success: function (dataResult) {
            if (checkTimeout(dataResult)) {
                if (!dataResult.success) {
                    alert('Error al cargar el Banner.');
                    return false;
                }

                var delayPrincipal = 0;
                var count = 0;
                var Titulo = "";
                var Posicion = "";
                var Id = 0;
                var TipoAccion = 0;
                var Creative = "";
                var fileName = "";
                var countBajos = 1;
                var promotionsBajos = [];

                $('#bannerBajos').empty();
                $('#sliderHomeLoading').empty();

                while (dataResult.data.length > count) {
                    var objData = dataResult.data[count];
                    Titulo = objData.Titulo;
                    Id = objData.BannerID.toString();
                    fileName = objData.Archivo;
                    TipoAccion = objData.TipoAccion;

                    if (objData.GrupoBannerID.toString() == '150') {
                        Posicion = 'Home Slider – ' + objData.Orden;
                    }

                    switch (objData.GrupoBannerID) {
                        case 150: // Seccion Principal SB2.0
                            var iniHtmlLink = ((objData.URL.length > 0 && objData.TipoAccion == 0) || objData.TipoAccion == 1 || objData.TipoAccion == 2) ? "<a id='bannerMicroefecto" + objData.BannerID + "' href='javascript:;' onclick=\"return EnlaceBanner('" + objData.URL + "','" + objData.Titulo + "','" + objData.TipoAccion + "','" + objData.CuvPedido + "','" + objData.CantCuvPedido + "','" + objData.BannerID + "','" + Posicion + "','" + objData.Titulo + "', this);\" rel='marquesina' >" : "";
                            var finHtmlLink = ((objData.URL.length > 0 && objData.TipoAccion == 0) || objData.TipoAccion == 1 || objData.TipoAccion == 2) ? '</a>' : '';

                            $('.flexslider ul.slides').append('<li><div><div>' + iniHtmlLink + '<img class="imagen_producto" data-src="' + fileName + '"data-object-fit="none" data-lazy-seccion-banner-home="">' + finHtmlLink + '</div></div></li>');
                            delayPrincipal = objData.TiempoRotacion;
                            break;
                        case -5: case -6: case -7: // Seccion Baja 1 SB2.0 
                            var trackingText = objData.TituloComentario;

                            var attibutes = '';
                            if (objData.URL.length > 0) {
                                var tipoBanner = '0'
                                if ($.inArray(objData.GrupoBannerID, [-6, -7]) > -1) {
                                    var codigoCampania = 'C' + viewBagCampaniaActual.substr(4, 2);
                                    if ($.inArray(objData.Titulo.toUpperCase(), [codigoCampania + '_EXPOFERTAS_' + paisISO, codigoCampania + '_EXPOFERTA_' + paisISO]) > -1) {
                                        attibutes += "target=\"_self\"";
                                        tipoBanner = '1'
                                    }
                                    else attibutes += "target=\"_blank\"";
                                }

                                if (viewBagTieneHV && objData.GrupoBannerID == -5) {
                                    attibutes += " onclick=\"SetGoogleAnalyticsBannerInferiores('" + 'HerramientasVenta/Comprar' + "','" + trackingText + "','1','" + objData.BannerID + "','" + countBajos + "','" + objData.Titulo + "',false);\"";
                                } else {
                                    attibutes += " onclick=\"return SetGoogleAnalyticsBannerInferiores('" + objData.URL + "','" + trackingText + "','" + tipoBanner + "','" + objData.BannerID + "','" + countBajos + "','" + objData.Titulo + "');\"";
                                }

                                attibutes += " rel=\"banner-inferior=\"";
                            }

                            $('#bannerBajos').append("<a class='enlaces_home' href='javascript:void(0);' " + attibutes + "><div class='div-img hidden' style='margin-bottom: 10px;'><img class='banner-img' data-src='" + fileName + "' data-lazy-seccion-banner-home=''/></div><div class='btn_enlaces'>" + trackingText + "</div></a>");
                            promotionsBajos.push({
                                id: objData.BannerID,
                                name: objData.Titulo,
                                position: 'home-inferior-' + countBajos
                            });
                            countBajos++;
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

                EstablecerAccionLazyImagen("img[data-lazy-seccion-banner-home]");

                if (promotionsBajos.length > 0) {
                    dataLayer.push({
                        'event': 'promotionView',
                        'ecommerce': {
                            'promoView': {
                                'promotions': promotionsBajos
                            }
                        }
                    });

                }

                $('#bannerBajos').find("a.enlaces_home:last-child").addClass("no_margin_right");

                if (count <= 0) {
                    return false;
                }


                $('.flexslider').flexslider({
                    animation: "fade",
                    slideshowSpeed: (delayPrincipal * 1000),
                    after: function (slider) {
                        if (FuncionesGenerales.containsObject(vpromotions[slider.currentSlide], vpromotionsTagged) == false) {
                            var arrProm = [];
                            arrProm.push(vpromotions[slider.currentSlide]);
                            dataLayer.push({
                                'event': 'promotionView',
                                'ecommerce': {
                                    'promoView': {
                                        'promotions': arrProm
                                    }
                                }
                            });
                            vpromotionsTagged.push(vpromotions[slider.currentSlide]);
                        }
                    },
                    start: function (slider) {
                        $('body').removeClass('loading');
                        var arrProm = [];
                        arrProm.push(vpromotions[slider.currentSlide]);
                        dataLayer.push({
                            'event': 'promotionView',
                            'ecommerce': {
                                'promoView': {
                                    'promotions': arrProm
                                }
                            }
                        });
                        vpromotionsTagged.push(vpromotions[slider.currentSlide]);
                    }
                });
            }
        }
    });
}
function EnlaceBanner(URL, TrackText, TipoAccion, CUVpedido, CantCUVpedido, Id, Posicion, Titulo, link) {
    if (TipoAccion == 0 || TipoAccion == 2) {
        SetGoogleAnalyticsBannerPrincipal(URL, TrackText, Id, Posicion, Titulo);
    }

    if (TipoAccion == 1) {
        if (ReservadoOEnHorarioRestringido())
            return false;

        $("#divConfirmarCUVBanner p").text("Se agregarán " + CantCUVpedido + " unidad(es) del producto a tu pedido. ¿Deseas continuar?");

        $("#divConfirmarCUVBanner").data({
            'cuvPedido': CUVpedido,
            'cantidadCUVPedido': CantCUVpedido,
            'link': link,
            'Id': Id,
            'posicion': Posicion,
            'titulo': Titulo
        }).dialog("open");

        return false;
    }
}

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
}
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
}
function SetGoogleAnalyticsBannerInferiores(URL, TrackText, Tipo, Id, Posicion, Titulo, OpenTab) {
    var id;
    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                    {
                        'id': Id,
                        'name': Titulo,
                        'position': 'home-inferior-' + Posicion
                    }]
            }
        }
    });
    if (Tipo == "1") {
        window.location.href = URL;
        if (!OpenTab) return false;
    }
    else
        id = URL;

    if (URL > 0) {
        var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
        window.open(url, '_blank');
    } else {
        window.open(URL, '_blank');
    }
    return false;
}
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
}

function CargarMisDatos() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Bienvenida/JSONGetMisDatos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                var temp = data.lista;
                $('#hdn_NombreArchivoContratoMD').val(temp.NombreArchivoContrato);
                $('#hdn_CodigoUsuarioMD').val(temp.CodigoUsuario);
                $('#hdn_CodigoUsuarioReal').val(temp.CodigoUsuarioReal);
                $('#hdn_CorreoMD').val(temp.EMail);
                $('#hdn_NombreCompletoMD').val(temp.NombreCompleto);
                $('#codigoUsurioMD').html(temp.CodigoUsuario);
                $('#nombresUsuarioMD').html(temp.NombreCompleto);
                $('#nombreGerenteZonal').html($.trim(temp.NombreGerenteZonal));
                if ($.trim(temp.IndicadorConsultoraDigital) == "0") {
                    $('#GerenteZona').show();
                } else {
                    $('#GerenteZona').hide();
                }
                $('#txtSobrenombreMD').val(temp.Sobrenombre);
                $('#txtEMailMD').val(temp.EMail);
                $('#txtTelefonoMD').val(temp.Telefono);
                $('#txtTelefonoTrabajoMD').val(temp.TelefonoTrabajo);
                $('#txtCelularMD').val(temp.Celular);
                PopupMostrar('popupMisDatos');
                if (popupCambioClave == "1")
                    $(".misDatosContraseniaEnlace").trigger("click");
                closeWaitingDialog();
            }
        },
        error: function (data, error) { }
    });
}

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

function CambiarContrasenia() {
    var oldPassword = $("#txtContraseniaAnterior").val();
    var newPassword01 = $("#txtNuevaContrasenia01").val();
    var newPassword02 = $("#txtNuevaContrasenia02").val();
    var vMessage = "";

    if (oldPassword == "")
        vMessage += "- Debe ingresar la Contraseña Anterior.\n";

    if (newPassword01 == "")
        vMessage += "- Debe ingresar la Nueva Contraseña.\n";

    if (newPassword02 == "")
        vMessage += "- Debe repetir la Nueva Contraseña.\n";

    if (newPassword01.length <= 3)
        vMessage += "- La Nueva Contraseña debe de tener mas de 6 caracteres.\n";

    if (newPassword01 != "" && newPassword02 != "") {
        if (newPassword01 != newPassword02)
            vMessage += "- Los campos de la nueva contraseña deben ser iguales, verifique.\n";
    }

    if (vMessage != "") {
        alert(vMessage);
        return false;
    } else {

        var item = {
            OldPassword: oldPassword,
            NewPassword: newPassword01
        };

        waitingDialog({});
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'MisDatos/CambiarContrasenia',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    if (data.success == true) {
                        if (data.message == "0") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("La contraseña anterior ingresada es inválida");
                        } else if (data.message == "1") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            alert("Hubo un error al intentar cambiar la contraseña, por favor intente nuevamente.");
                        } else if (data.message == "2") {
                            $("#txtContraseniaAnterior").val('');
                            $("#txtNuevaContrasenia01").val('');
                            $("#txtNuevaContrasenia02").val('');
                            $(".campos_cambiarContrasenia").fadeOut(200);
                            $(".popup_actualizarMisDatos").removeClass("incremento_altura_misDatos");
                            $(".campos_actualizarDatos").delay(200);
                            $(".campos_actualizarDatos").fadeIn(200);
                            alert("Se cambió satisfactoriamente la contraseña.");
                        }
                        return false;
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    alert("Error en el Cambio de Contraseña");
                }
            }
        });
    }
}

function ActualizarMD() {

    if (viewBagPaisID != 4) {

        if (jQuery.trim($('#txtEMail').val()) == "") {

            $('#txtEMailMD').focus();
            alert("Debe ingresar EMail.\n");
            return false;
        }

        if (!validateEmail(jQuery.trim($('#txtEMail').val()))) {
            $('#txtEMailMD').focus();
            alert("El formato del correo electrónico ingresado no es correcto.\n");
            return false;
        }

        if (($('#txtTelefonoMD').val() == null || $.trim($('#txtTelefonoMD').val()) == "") &&
            ($('#txtCelularMD').val() == null || $.trim($('#txtCelularMD').val()) == "")) {
            $('#txtTelefonoMD').focus();
            alert('Debe ingresar al menos un número de contacto: celular o teléfono.');
            return false;
        }

        if (jQuery.trim($('#txtCelularMD').val()) != "") {
            if (!ValidarTelefono($("#txtCelularMD").val())) {
                alert('El celular que está ingresando ya se encuenta registrado.');
                return false;
            }
        }

        //Validando cantidad de caracteres minimos.
        var MinCaracterCelular = limitarMinimo($('#txtCelularMD').val(), $("#hdn_CaracterMinimo").val(), 2);
        if (!MinCaracterCelular) {
            $('#txtCelularMD').focus();
            alert('El formato del celular no es correcto.');
            return false;
        }

        if ($("#txtTelefonoTrabajoMD").val().trim() != "") {
            var MinCaracterOtroTelefono = limitarMinimo($('#txtTelefonoTrabajoMD').val(), $("#hdn_CaracterMinimo").val(), 3);
            if (!MinCaracterOtroTelefono) {
                return false;
            }
        }
    }

    if (!$('#chkAceptoContratoMD').is(':checked')) {
        alert('Debe aceptar los términos y condiciones para poder actualizar sus datos.');
        return false;
    }

    waitingDialog({});

    var item = {
        CodigoUsuario: jQuery('#hdn_CodigoUsuarioReal').val(),
        EMail: $.trim(jQuery('#txtEMailMD').val()),
        Telefono: jQuery('#txtTelefonoMD').val(),
        TelefonoTrabajo: jQuery('#txtTelefonoTrabajoMD').val(),
        Celular: jQuery('#txtCelularMD').val(),
        Sobrenombre: jQuery('#txtSobrenombreMD').val(),
        CorreoAnterior: $.trim(jQuery('#hdn_CorreoMD').val()),
        NombreCompleto: jQuery('#hdn_NombreCompletoMD').val(),
        CompartirDatos: false,
        AceptoContrato: $('#chkAceptoContratoMD').is(':checked')
    };

    if (showPopupMisDatos == '1') {
        dataLayerVC("Banner Actualizar Datos", "Click botón Actualizar");
        showPopupMisDatos = '0';
    }
    if (viewBagPaisID != 4) {

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'MisDatos/ActualizarDatos',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {

                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    PopupCerrar('popupMisDatos');
                    alert(data.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    PopupCerrar('popupMisDatos');
                    alert("ERROR");
                }
            }
        });
    }
    else {

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'MisDatos/AceptarContrato',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    PopupCerrar('popupMisDatos');
                    alert(data.message);
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    PopupCerrar('popupMisDatos');
                    alert("ERROR");
                }
            }
        });
    }
}

function ValidateOnlyNums(id) {
    return $("#" + id).val($("#" + id).val().replace(/[^\d]/g, ""));
}
function DownloadAttachPDFMD(requestedFile) {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    iframe_.setAttribute("src", baseUrl + 'WebPages/DownloadPDF.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {

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
}
function DownloadAttachContratoActualizarDatos() {
    $('#hrefTerminosMD').attr('href', UrlPdfTerminosyCondiciones);
}

function CargarMisCursos() {

    $(window).scroll(function () {
        if ($("#seccionMiAcademiaLiquidacion").offset().top - $(window).scrollTop() < $("#seccionMiAcademiaLiquidacion").height()) {
            porcentajesCursos();
        }
    });

    if (UrlImgMiAcademia != null) {
        $('.item_video_left').find('.item_video').css('background', 'url(' + UrlImgMiAcademia + ' ) no-repeat center center');
    }
    $('#divSinTutoriales').hide();
    $('#divTutorialesV').hide();

    $('#divMisCursos').html('<div style="text-align: center;">Cargando Mis Cursos ...<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: baseUrl + 'MiAcademia/GetMisCursos',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    if (paisISO == 'VE') {
                        SetHandlebars("#miscursosv-template", response.data, "#divMisCursosV");
                        $('#divTutoriales').hide();
                        $('#divTutorialesV').show();
                    }
                    else {
                        SetHandlebars("#miscursos-template", response.data, "#divMisCursos");
                        $('#divTutoriales').show();
                    }
                }
                else {
                    $('#divTutoriales').hide();
                    $('#divSinTutoriales').show();
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                $('#divTutoriales').hide();
                $('#divSinTutoriales').show();
            }
        }
    });
}
function porcentajesCursos() {
    $(".porcentaje_curso").addClass("mostrarPorcentajes");

    $('.porcentaje_cursosAcademia').easyPieChart({
        barColor: isEsika == true ? '#e81c36' : '#642f80',
        trackColor: '#f0f0f0',
        scaleColor: 'transparent',
        animate: 1000,
        size: 55,
        lineWidth: 3,
        onStep: function (value) {
            this.$el.find('span').text(Math.round(value));
        },
        onStop: function (value, to) {
            this.$el.find('span').text(Math.round(to));
        }
    });
}
function GetCursoMarquesina(id) {
    var url = baseUrl + "MiAcademia/Cursos?idcurso=" + id;
    window.open(url, '_blank');
}

function ActualizarDatos() {
    var result = false;
    var ClaveSecreta = $('#txtActualizarClaveSecreta').val();
    var ConfirmarClaveSecreta = $('#txtConfirmarClaveSecreta').val();
    var telefono = $('#txtTelefono').val();
    var celular = $('#txtCelular').val();
    var correoElectronico = $('#txtEMail').val();
    var confirmacionCorreoElectronico = $('#txtConfirmarEMail').val();

    if (!ValidarTelefono($("#txtCelular").val())) {
        alert('Este número de celular ya está siendo utilizado. Intenta con otro.');
        return false;
    }

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

    if (correoElectronico.toUpperCase() != confirmacionCorreoElectronico.toUpperCase()) {
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
        TelefonoTrabajo: jQuery('#txtTelefonoTrabajo').val(),
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
            if (checkTimeout(data)) {
                closeWaitingDialog();
                result = data.success;

                if (data.message && data.message != "" && data.message != null) {
                    var mensajeHtml = "";
                    $.each(data.message.split("-"), function (i, v) {
                        mensajeHtml += v + "<br/>"
                    });
                    PopupCerrar('popupActualizarMisDatos');
                    alert_unidadesAgregadas(mensajeHtml, result ? 1 : 0);
                }
                if (data.success) {
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Formulario',
                        'action': 'Actualizar datos',
                        'label': data.message
                    });
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                result = false;
                closeWaitingDialog();
                PopupCerrar('popupActualizarMisDatos');
            }
        }
    });

    return result;
}
function DownloadAttachPDFTerminos() {
    $('#hrefTerminos').attr('href', UrlPdfTerminosyCondiciones);
}
function CerrarPopupActualizacionDatos() {

    var ClaveSecreta = $('#txtActualizarClaveSecreta').val();
    var ConfirmarClaveSecreta = $('#txtConfirmarClaveSecreta').val();

    if (ClaveSecreta != ConfirmarClaveSecreta) {
        alert('Las claves ingresadas no coinciden');
        return false;
    }
    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'ActualizarDatos/Cancelar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                PopupCerrar('popupActualizarMisDatos');
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                PopupCerrar('popupActualizarMisDatos');
            }
        }
    });
}


function ActualizarDatosMexico() {
    var Result = false;
    var m_nombre = $('#m_txtNombre').val();
    var m_apellidos = $('#m_txtApellidos').val();
    var m_telefonoCasa = '';
    var m_telefonoTrabajo = '';
    var m_telefonoCelular = '';

    if ($('#m_txtTelefonoCasa').val() != '' && $('#m_txtTelefonoCasa').val() != $('#m_txtTelefonoCasa').attr('placeholder')) {
        m_telefonoCasa = $('#m_txtTelefonoCasa').val();
    }
    if ($('#m_txtTelefonoTrabajo').val() != '' && $('#m_txtTelefonoTrabajo').val() != null && $('#m_txtTelefonoTrabajo').val() != $('#m_txtTelefonoTrabajo').attr('placeholder')) {
        m_telefonoTrabajo = $('#m_txtTelefonoTrabajo').val();
    }
    if ($('#m_txtTelefonoCelular').val() != '' && $('#m_txtTelefonoCelular').val() != $('#m_txtTelefonoCelular').attr('placeholder')) {
        m_telefonoCelular = $('#m_txtTelefonoCelular').val();
    }

    var m_email = $('#m_txtEMail').val();
    if (typeof (m_email) == "undefined")
        m_email = ''
    var m_error = 0;
    var m_mensaje = "<font color=red>";

    $('.requerido').each(function (i, elem) {
        if ($(elem).val() == '' || typeof ($(elem).val()) == 'undefined') {
            $(elem).css({ 'border': '1px solid red' });
            m_error++;

            if (elem.id == 'm_txtNombre') m_mensaje += '* Debe ingresar su nombre<br />';
            if (elem.id == 'm_txtApellidos') m_mensaje += '* Debe ingresar su apellido<br />';
            if (elem.id == 'm_txtTelefonoCasa') m_mensaje += '* Debe ingresar teléfono de casa<br />';
            if (elem.id == 'm_txtTelefonoCelular') m_mensaje += '* Debe ingresar teléfono celular<br />';
            if (elem.id == 'm_txtEMail') m_mensaje += '* Debe ingresar correo electrónico<br />';
        } else {
            if (elem.id == 'm_txtTelefonoCasa') {
                $(elem).css({ 'border': '1px solid red' });
                if (m_telefonoCasa == '') {
                    m_error++;
                    m_mensaje += '* Debe ingresar teléfono de casa<br />';
                } else
                    if ($(elem).val().length < 10) {

                        m_error++;
                        m_mensaje += '* Debe digitar 10 dígitos en el campo teléfono de casa<br />';
                    }
                    else {
                        $(elem).css({ 'border': '' });
                    }
            } else {
                if (elem.id == 'm_txtTelefonoCelular') {
                    $(elem).css({ 'border': '1px solid red' });
                    if (m_telefonoCelular == '') {
                        m_mensaje += '* Debe ingresar teléfono celular<br />';
                        m_error++;
                    }
                    else
                        if ($(elem).val().length < 10) {
                            m_error++;
                            m_mensaje += '* Debe digitar 10 dígitos en el campo teléfono celular<br />';
                        }
                        else {
                            $(elem).css({ 'border': '' });
                        }
                } else {
                    $(elem).css({ 'border': '' });
                }
            }
        }
    });

    $('#m_txtTelefonoTrabajo').css({ 'border': '' });
    if (m_telefonoTrabajo != '') {
        if (m_telefonoTrabajo.length != 10) {
            m_error++;
            $('#m_txtTelefonoTrabajo').css({ 'border': '1px solid red' });
            m_mensaje += '* Debe digitar 10 dígitos en el campo otro teléfono.<br />';
        }
    }

    if (m_error > 0) m_mensaje += '</font><br />';

    if (m_email != '') {
        var emailReg = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
        if (emailReg.test(m_email) == false) {
            $('#m_txtEMail').css({ 'border': '1px solid red' });
            m_mensaje += '<font color=red>* Formato  de correo electrónico No Válido</font><br />';
            m_error++;
        }
        else {
            $('#m_txtEMail').css({ 'border': '' });
        }
    }

    if (m_error > 0) {
        $('#aviso').html(m_mensaje);
    }
    else {
        $('#aviso').html('');

        var item = {
            m_Nombre: m_nombre,
            m_Apellidos: m_apellidos,
            Telefono: m_telefonoCasa,
            TelefonoTrabajo: m_telefonoTrabajo,
            Celular: m_telefonoCelular,
            Email: m_email
        };

        waitingDialog({});
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + 'ActualizarDatos/RegistrarMexico',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    Result = data.success;
                    if (data.success) {
                        AbrirMensaje(data.message)
                        CerrarPopupActualizacionDatosMexico();
                        dataLayer.push({
                            'event': 'virtualEvent',
                            'category': 'Formulario',
                            'action': 'Actualizar datos',
                            'label': data.message
                        });
                    }
                    else {
                        $('#aviso').html(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    Result = false;
                    closeWaitingDialog();
                }
            }
        });
    }

    return Result;
}
function CerrarPopupActualizacionDatosMexico() {
    PopupCerrar('popupActualizarMisDatosMexico');
}

function AbrirAceptacionContrato() {
    if (viewBagPaisID == 4) { // Colombia
        if (viewBagIndicadorContrato == 0) {
            var AlreadyViewContrato = sessionIsContrato;
            if (AlreadyViewContrato == 1) {
                PopupMostrar('popupAceptacionContrato');
            }
        }
    }
}

function AceptarContrato() {
    var parameter = { checkAceptar: 1, origenAceptacion: OrigenAceptacionContrato, AppVersion: "" };
    waitingDialog({});

    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarContrato",
        data: JSON.stringify(parameter),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (!data.success) {
                    alert(data.message);
                    if (data.extra != "nocorreo") return;
                }
                PopupCerrar('popupAceptacionContrato');
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error inesperado al momento de registrar los datos. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
}

function DownloadAttachPDF() {
    var iframe_ = document.createElement("iframe");
    iframe_.style.display = "none";
    var requestedFile = urlContratoCOpdf;
    iframe_.setAttribute("src", baseUrl + 'WebPages/Download.aspx?file=' + requestedFile);

    if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {
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
}

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
                    PopupMostrar('popupDemandaAnticipada');
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
}
function AceptarDemandaAnticipada() {
    InsertarDemandaAnticipada(1);
}
function CancelarDemandaAnticipada() {
    InsertarDemandaAnticipada(0);
}
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
                    PopupCerrar('popupDemandaAnticipada');
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
}

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
            HideDialog("divComunicado");
        }
    });
}
function AbrirComunicado() {
    if (viewBagVisualizoComunicado == "0") {
        showDialog("divComunicado");
        $("#divComunicado").siblings(".ui-dialog-titlebar").hide();
    }
}
function AceptarComunicado() {
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/AceptarComunicado",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                HideDialog("divComunicado");
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

function AbrirPopupFlexipago() {
    if (typeof gTipoUsuario !== 'undefined') {
        if (gTipoUsuario == '2') {
            return false;
        }
    }

    if (viewBagPaisID == 4 || viewBagPaisID == 3) { // Colombia || Chile
        if (viewBagInvitacionRechazada == "False" || viewBagInvitacionRechazada == "0" || viewBagInvitacionRechazada == "") {
            if (viewBagInscritaFlexipago == "0") {
                if (viewBagIndicadorFlexiPago == "1" && viewBagCampanaInvitada != "0") {
                    if ((parseInt(viewBagCampaniaActual) - parseInt(viewBagCampanaInvitada)) >= parseInt(viewBagNroCampana)) {
                        PopupMostrar('popupInvitaionFlexipago');
                    }
                }
            }
        }
    }
}
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
                PopupCerrar('popupInvitaionFlexipago');
                closeWaitingDialog();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                PopupCerrar('popupInvitaionFlexipago');
                closeWaitingDialog();
            }
        }
    });
    return false;
}
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
}
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
}

function RedirectPagaEnLineaAnalytics() {
    if (ViewBagRutaChile != "") {
        window.open(ViewBagRutaChile + viewBagUrlChileEncriptada, "_blank");
    }
    else {
        window.open('https://www.belcorpchile.cl/BP_Servipag/PagoConsultora.aspx?c=' + viewBagUrlChileEncriptada, "_blank");
    }
}

function MostrarCajaSuenioNavidad() {
    $("#txtSuenioNavidad").focus();
    $("#imgSuenioNavidad").fadeOut("fast", function () {
        $("#imgSuenioNavidad2").fadeIn("fast");
    });
    $("#registroSuenioNavidad").show();
    scrollWin();
}
function scrollWin() {
    $('html,body').animate({
        scrollTop: $("#registroSuenioNavidad").offset().top - 500
    }, 500);
}
function cerrarSueniosNavidad() {
    HideDialog("idSueniosNavidad");
}
function cerrarSuenioConfirmacion() {
    HideDialog("divSuenioConfirmacion");
}
function AgregarSuenio() {
    var descSuenio = $("#txtSuenioNavidad").val();

    if ($.trim(descSuenio) == "") {
        alert_msgPedidoBanner("Ingrese una descripción");
        return false;
    }

    var params = { descripcion: descSuenio };
    HideDialog("idSueniosNavidad");
    waitingDialog({});
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/RegistrarSuenioNavidad",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    showDialog("divSuenioConfirmacion");
                    closeWaitingDialog();
                } else {
                    alert_msgPedidoBanner(data.message);
                    closeWaitingDialog();
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert_msgPedidoBanner("Ocurrió un error inesperado al momento de registrar los datos. Consulte con su administrador del sistema para obtener mayor información");
            }
        }
    });
}

function EsconderFlechasCarouseLiquidaciones(accion) {
    var itemsLength = $('#divCarruselLiquidaciones').find('.slick-slide').length;
    var indexActive = $($('#divCarruselLiquidaciones').find('.slick-active')).attr('data-slick-index');

    if (accion == 'prev') {
        if (Number(indexActive) - 1 == 0) {
            $('.js-slick-prev-liq').hide();
        } else {
            $('.js-slick-next-liq').show();
        }

    } else if (accion == 'next') {
        if (Number(indexActive) + 1 == Number(itemsLength) - 1) {
            $('.js-slick-next-liq').hide();
        } else {
            $('.js-slick-prev-liq').show();
        }
    }
}

function stopVideo() {
    var player = oYTPlayers['ytBienvenidaIndex'].instance;
    try {
        if (player) {

            if (player.stopVideo) {
                player.stopVideo();
            }
            else {
                var urlVideo = $divPlayer.attr("src");
                $divPlayer.attr("src", "");
                $divPlayer.attr("src", urlVideo);
            }

        }
    } catch (e) { }
}
function playVideo() {
    var player = oYTPlayers['ytBienvenidaIndex'].instance;
    try {
        if (player) {
            if (player.playVideo) { player.playVideo(); }
            else {
                $divPlayer[0].contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
            }
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Home',
                'action': 'Video de Bienvenida: Iniciar video',
                'label': 'SomosBelcorp.com ¡se renueva para ti!'
            });
        }
    } catch (e) { }
}

function CrearPopShow() {
    // 18/07/2017 => AlanAupe => cbNoMostrarPopupShowRoom => no existe en todo el portal
    // En desktop se llama solo en "switch (TipoPopUpMostrar)" y En mobile no se llama
    // el metod ShowRoom/UpdatePopupShowRoom solo se llama en CrearPopShow();

    var noMostrarShowRoom = true;

    $("#cbNoMostrarPopupShowRoom").click(function () {
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

                        $('#PopShowroomIntriga').hide();
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                }
            }
        });
    });
}
function MostrarShowRoom() {
    if (viewBagRol == 1) {
        if (!sesionEsShowRoom) {
            return;
        }
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/MostrarShowRoomPopup",
            data: null,
            contentType: 'application/json',
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        var showroomConsultora = response.data;
                        var txtSaludoIntriga;
                        var container;
                        if (!(showroomConsultora.EventoConsultoraID != 0 && showroomConsultora.MostrarPopup)) {
                            return false;
                        }

                        var evento = response.evento;
                        var personalizacion = response.personalizacion;
                        var urlImagenPopupIntriga = "";
                        var urlImagenPopupVenta = "";
                        var noMostrarShowRoomIntriga = response.mostrarPopupIntriga;
                        var noMostrarShowRoomVenta = response.mostrarPopupVenta;
                        var eventoID = response.evento.EventoID;
                        var eventoNombre = response.evento.Nombre;
                        $.each(personalizacion, function (k, item) {
                            if (item.Atributo == 'PopupImagenIntriga') {
                                urlImagenPopupIntriga = item.Valor;
                                return;
                            }

                            if (item.Atributo == 'PopupImagenVenta') {
                                urlImagenPopupVenta = item.Valor;

                                return;
                            }
                        });

                        $("#spnShowRoomEvento").html(evento.Tema);

                        if (response.mostrarShowRoomProductos && noMostrarShowRoomVenta) {

                            $("#spnShowRoomEventoVenta").html(eventoNombre);
                            $("#spnShowRoomEventoVenta").val(eventoNombre);
                            $("#spnShowRoomEventoDescripcionVenta").val(evento.Tema);
                            AgregarTagManagerShowRoomPopupAnalytics(eventoID, eventoNombre, evento.Tema, "1");
                            $("#hdEventoIDShowRoomVenta").val(eventoID);
                            container = $('#PopShowroomVenta');

                            txtSaludoIntriga = '<b>' + response.nombre + '</b>, YA COMENZÓ';
                            $(container).find('.saludo_consultora_showroom').html(txtSaludoIntriga);
                            $(container).find('.imagen_dias_intriga').attr('src', urlImagenPopupVenta);
                            $(container).show();
                        }

                        if (!response.mostrarShowRoomProductos && noMostrarShowRoomIntriga) {

                            $("#spnShowRoomEvento").html(eventoNombre);
                            $("#spnShowRoomEvento").val(eventoNombre);
                            $("#spnShowRoomEventoDescripcion").val(evento.Tema);
                            AgregarTagManagerShowRoomPopupAnalytics(eventoID, eventoNombre, evento.Tema, "2")
                            $('#hdEventoIDShowRoom').val(eventoID);
                            if (parseInt(response.diasFaltan) > 0) {
                                container = $('#PopShowroomIntriga');
                                var txtDiasIntriga = 'FALTAN ' + response.diasFaltan + ' DÍAS';
                                if (response.diasFaltan == 1) txtDiasIntriga = 'FALTA 1 DÍA';
                                txtSaludoIntriga = '<b>' + response.nombre + '</b>, prepárate para';
                                $(container).find('.saludo_consultora_showroom').html(txtSaludoIntriga);
                                $(container).find('.dias_intriga_home').text(txtDiasIntriga);
                                $(container).find('.imagen_dias_intriga').attr('src', urlImagenPopupIntriga);
                                $(container).show();
                            }
                        }
                    }
                }
            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    closeWaitingDialog();
                }
            }
        });
    }
}

function NoMostrarPopupShowRoomIntrigaVenta(tipo) {
    var item = {
        TipoShowRoom: tipo
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/NoMostrarShowRoomPopup',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        success: function (response) {
            if (checkTimeout(response)) {
                click_no_volver_a_ver_este_anuncio_PopShowroomVenta();
                $('#PopShowroomVenta').hide();
            }
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                closeWaitingDialog();
            }
            click_no_volver_a_ver_este_anuncio_PopShowroomVenta();
            $('#PopShowroomVenta').hide();
        }
    });
}

function AgregarTagManagerShowRoomPopupAnalytics(eventoID, eventoNombre, tema, tipo) {
    var streventoNombre = "";
    if (tipo == "1") {
        streventoNombre = eventoNombre + ' ' + tema + ' - Compra Ya';
    }
    if (tipo == "2") {
        streventoNombre = eventoNombre + ' ' + tema + ' - Entérate';
    }

    dataLayer.push({
        'event': 'promotionView',
        'ecommerce': {
            'promoView': {
                'promotions': [
                    {
                        'id': eventoID,
                        'name': streventoNombre,
                        'position': 'Home pop-up - 1',
                        'creative': 'Banner'
                    }
                ]
            }
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

function AgregarTagManagerShowRoomPopupClick(tipo) {

    var name = "", nombre = "", id = "", tema;

    if (tipo == 1) {
        nombre = $("#spnShowRoomEventoVenta").val();
        tema = $("#spnShowRoomEventoDescripcionVenta").val();
        name = nombre + ' ' + tema + ' - Compra Ya';
        id = $("#hdEventoIDShowRoomVenta").val();
    }

    if (tipo == 2) {
        nombre = $("#spnShowRoomEvento").val();
        tema = $("#spnShowRoomEventoDescripcion").val();
        name = nombre + ' ' + tema + ' - Entérate';
        id = $("#hdEventoIDShowRoom").val();
    }

    dataLayer.push({
        'event': 'promotionClick',
        'ecommerce': {
            'promoClick': {
                'promotions': [
                    {
                        'id': id,
                        'name': name,
                        'position': 'Home pop-up - 1',
                        'creative': 'Banner'
                    }
                ]
            }
        }
    });
}

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
}

function AgregarTagManagerShowRoomCheckBox() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Ofertas Showroom',
        'action': 'checkbox',
        'label': '(not available)'
    });
}

function abrir_popup_tutorial(obligado) {
    obligado = obligado == undefined ? false : obligado;
    if (!obligado) {
        if (viewBagVioTutorial == 1) {
            return false;
        }
        UpdateUsuarioTutoriales(constanteVioTutorialDesktop);
    }
    PopupMostrar('popup_tutorial_home');
    $('html').css({ 'overflow-y': 'hidden' });
    var paisCP = false;
    var CatalogoPersonalizado_ZonaValida = $("#hdEsCatalogoPersonalizadoZonaValida").val() == "False" ? 0 : 1;
    if ((viewBagPaisID == "11" || viewBagPaisID == "3") && CatalogoPersonalizado_ZonaValida) {
        paisCP = true;
    }
    fnMovimientoTutorial = setInterval(function () {
        $(".img_slide" + numImagen).animate({ 'opacity': '0' });
        numImagen++;
        if (!paisCP && numImagen == 8) {
            $(".img_slide" + numImagen).hide();
            numImagen++;
        }

        if (numImagen > 9) {
            numImagen = 1;
            $(".imagen_tutorial").animate({ 'opacity': '1' });
        }
    }, 3000);
}

function cerrar_popup_tutorial() {
    PopupCerrar('popup_tutorial_home');
    $('html').css({ 'overflow-y': 'auto' });
    $(".imagen_tutorial").animate({ 'opacity': '1' });
    window.clearInterval(fnMovimientoTutorial);
    numImagen = 1;
    viewBagVioTutorial = 1;
}

function ObtenerComunicadosPopup() {
    waitingDialog();

    $.ajax({
        type: "GET",
        url: baseUrl + 'Bienvenida/ObtenerComunicadosPopUps',
        contentType: 'application/json',
        success: function (response) {
            if (checkTimeout(response)) {
                armarComunicadosPopup(response);
                var images = $("#popupComunicados img.img-comunicado");
                var loadedImgNum = 0;

                if (images.length == 0) {
                    closeWaitingDialog();
                } else {
                    images.on('load', function () {
                        loadedImgNum += 1;
                        if (loadedImgNum == images.length) {
                            closeWaitingDialog();
                            mostrarComunicadosPopup(response.data);
                        }
                    });
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
}

function armarComunicadosPopup(response) {
    viewBagVerComunicado = response.comunicadoVisualizado;

    var item = response.data;
    if (item.CodigoConsultora != null) {

        var dialogComunicadoID = item.CodigoConsultora + '_' + item.ComunicadoId;
        var nombreEvento = encodeURI(item.Descripcion);


        if (item.Accion == "URL") {
            urlAccion = item.DescripcionAccion;
            if (urlAccion > 0) {
                urlAccion = baseUrl + "MiAcademia/Cursos/idcurso/" + urlAccion;
            }
            displayTerminos = 'float:right;display:none;';
            target = '_blank';
        }
        var comunicado = {
            id: dialogComunicadoID,
            hrefUrl: urlAccion,
            target: target,
            urlImg: item.UrlImagen,
            idComunicado: item.ComunicadoId,
            display: displayTerminos,
            comunicadoDescripcion: nombreEvento
        };

        var content = SetHandlebars("#template-comunicado", comunicado);
        $('#popupComunicados').append(content);
    }
}

function mostrarComunicadosPopup(data) {
    if (viewBagVerComunicado != '1' || viewBagVioTutorial == 0 || viewBagVioVideo == 0 || viewBagVioTutorialSalvavidas == 0) {
        PopupCerrar('popupComunicados');
        return true;
    }

    var lista = $('#popupComunicados').find('div.popup_comunicados[data-cerrado="0"]');
    if (lista.length == 0) {
        PopupCerrar('popupComunicados');
        return true;
    }
    ActualizarVisualizoComunicado(data.ComunicadoId);

    PopupMostrar('popupComunicados');
    var j = 0;

    lista.each(function (index, element) {
        var id = $(element).attr('id');
        $('#' + id).show();
        centrarComunicadoPopup(id);
        j++;
        return false;
    });

    return (j <= 0);
}

function ActualizarVisualizoComunicado(comunicadoId) {
    var params = { ComunicadoId: comunicadoId };
    $.ajax({
        type: "POST",
        url: baseUrl + "Bienvenida/ActualizarVisualizoComunicado",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            //
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("Ocurrió un error al actualizar la visualización del comunicado.");
            }
        }
    });
}

function centrarComunicadoPopup(ID) {
    var altoPopup = ($(window).height() - $("#" + ID).outerHeight()) / 2;
    var imagenPopup = $('#' + ID).find(".img-comunicado");
    $("#" + ID).css({ "width": imagenPopup.width() });
    $("#" + ID).css({ "top": altoPopup });
}

function clickCerrarComunicado(obj) {
    var comunicadoID = $(obj).attr('data-comunicado');
    var dialogComunicadoID = $(obj).attr('data-id');

    AceptarComunicadoVisualizacion(comunicadoID, dialogComunicadoID);

    $('#' + dialogComunicadoID).hide();
    $('#' + dialogComunicadoID).attr('data-cerrado', 1);
    var vclose = mostrarComunicadosPopup();

    if (vclose) {
        closeComunicadosPopup = true;
        PopupCerrar('popupComunicados');
    }
}

function clickImagenComunicado(obj) {
    var dialogComunicadoID = $(obj).attr('data-id');

    $('#' + dialogComunicadoID).hide();
    $('#' + dialogComunicadoID).attr('data-cerrado', 1);
    mostrarComunicadosPopup();
}

function AceptarComunicadoVisualizacion(ID, dialogComunicadoID) {
    if ($('#chkMostrarComunicado_' + ID + '').is(':checked')) {
        var params = { ComunicadoID: ID };

        waitingDialog({});
        $.ajax({
            type: "POST",
            url: baseUrl + "Bienvenida/AceptarComunicadoVisualizacion",
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function (data) {
                if (checkTimeout(data)) {
                    $('#' + dialogComunicadoID).hide();
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

    $('#' + dialogComunicadoID).hide();
}

function PopupMostrarPrioridad() {
    var mostrar = new Object();
    $.each(popupListaPrioridad, function (ind, prioridad) {
        prioridad.Prioridad = parseFloat(prioridad.Prioridad);
        if ((mostrar.Prioridad > prioridad.Prioridad && prioridad.Prioridad > 0) || ind == 0) {
            if (prioridad.Activo == '1') {
                mostrar = Clone(prioridad);
            }
        }
    });

    var listaMostrar = new Array();
    if (parseInt(mostrar.Prioridad) < mostrar.Prioridad) {
        $.each(popupListaPrioridad, function (ind, prioridad) {
            prioridad.Prioridad = parseFloat(prioridad.Prioridad);
            if (parseInt(mostrar.Prioridad) == parseInt(prioridad.Prioridad)) {
                listaMostrar.push(Clone(prioridad));
            }
        });
    }
    if (listaMostrar.length == 0) {
        listaMostrar.push(mostrar);
    }



}
function PopupMostrar(idPopup) {
    var id = "";
    if (typeof (idPopup) === "string")
        id = "#" + $.trim(idPopup);

    if (id === "") return false;

    $(id).attr("data-popup-activo", "1");
    var padreComun = $(id).parent().attr("id");
    if (padreComun === "fondoComunPopUp") {
        if ($("#fondoComunPopUp").attr("data-activo-salvavidas") != "1") {
            $("#fondoComunPopUp").show();
        }
    }

    $(id).show();
}
function PopupCerrar(idPopup) {
    var id = "";
    if (typeof (idPopup) == "string")
        id = "#" + idPopup;

    var obj = "";
    if (id == "") {
        obj = $(idPopup);
    }
    else {
        obj = $(id);
    }

    if (obj == "") return false;

    $(obj).attr("data-popup-activo", "0");

    $(obj).hide();
    if ($("#fondoComunPopUp >div[data-popup-activo='1']").length == 0) {
        $("#fondoComunPopUp").hide();
    }
}

function mostrarCatalogoPersonalizado() {
    document.location.href = urlCatalogoPersonalizado;
}

function ValidarTelefono(celular) {
    var resultado = false;

    var item = {
        Telefono: celular
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/ValidadTelefonoConsultora',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data))
                resultado = false;
            else
                resultado = data.success;
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

    return resultado;
}

function VerShowRoomIntriga() {
    AgregarTagManagerShowRoomPopupClick(2);
    document.location.href = urlShowRoomIntriga;
    $('#PopShowroomIntriga').hide();
}

function VerShowRoomVenta() {
    AgregarTagManagerShowRoomPopupClick(1);
    document.location.href = urlOfertasIndex;
    $('#PopShowroomVenta').hide();
}

function CerrarPopShowroomIntriga() {
    var nombre = $("#spnShowRoomEvento").val();
    var tema = $("#spnShowRoomEventoDescripcion").val();
    var action = 'Banner ' + nombre + ' ' + tema + ' - Entérate';

    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': action,
        'label': 'Cerrar Popup'
    });

    CerrarPopup("#PopShowroomIntriga");
}

function CerrarPopShowroomVenta() {
    var nombre = $("#spnShowRoomEventoVenta").val();
    var tema = $("#spnShowRoomEventoDescripcionVenta").val();
    var action = 'Banner ' + nombre + ' ' + tema + ' -  Compra Ya';

    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': action,
        'label': 'Cerrar Popup'
    });

    CerrarPopup("#PopShowroomVenta");
}

function SRPopupCerrar(tipo) {
    if (tipo == 'I')
        CerrarPopShowroomIntriga();

    if (tipo == 'V')
        CerrarPopShowroomVenta();

    AbrirLoad();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'ShowRoom/PopupCerrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            CerrarPopup("#PopShowroomVenta");
            CerrarPopup("#PopShowroomIntriga");
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopShowroomVenta");
            CerrarPopup("#PopShowroomIntriga");
        }
    });
}

function click_no_volver_a_ver_este_anuncio_PopShowroomIntriga() {
    var action = 'Banner ' + $("#spnShowRoomEvento").val() + ' ' + $("#spnShowRoomEventoDescripcion").val() + ' - Entérate';

    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': action,
        'label': 'Cerrar Popup'
    });
}

function click_no_volver_a_ver_este_anuncio_PopShowroomVenta() {
    var action = 'Banner ' + $("#spnShowRoomEventoVenta").val() + ' ' + $("#spnShowRoomEventoDescripcionVenta").val() + ' -  Compra Ya';

    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Home',
        'action': action,
        'label': 'Cerrar Popup'
    });
}

function MostrarPopupInicial() {

    if (showPopupMisDatos == '1' || popupCambioClave == "1") {
        CargarMisDatos();
        return;
    }
    switch (TipoPopUpMostrar) {
        case popupAceptacionContrato:
            if (ObtenerEstadoContrato()) PopupMostrar('popupAceptacionContrato');
            break;
        case popupVideoIntroductorio:
            mostrarVideoIntroductorio();
            break;
        case popupGPR:
            break;
        case popupDemandaAnticipada:
            $('#fechaHasta').text(mensajeFechaDA);
            $('#fechaLuego').text(mensajeFechaDA);
            PopupMostrar('popupDemandaAnticipada');
            break;
        case popupShowRoom:
            CrearPopShow();
            MostrarShowRoom();
            break;
        case popupActualizarDatos:
            if (mostrarPopupActualizarDatosXPais == 9) {
                PopupMostrar('popupActualizarMisDatosMexico');
            } else {
                if (mostrarPopupActualizarDatosXPais == 11) {
                    $('#tituloActualizarDatos').html('<b>ACTUALIZACIÓN Y AUTORIZACIÓN</b> DE USO DE DATOS PERSONALES');
                } else {
                    $('#tituloActualizarDatos').html('<b>ACTUALIZAR</b> DATOS');
                }
                PopupMostrar('popupActualizarMisDatos');
            }
            break;
        case popupFlexipago:
            PopupMostrar('popupInvitaionFlexipago');
            break;
        case popupComunicado:
            ObtenerComunicadosPopup();
            break;
        case popupRevistaDigitalSuscripcion:
            rdPopup.Mostrar();
            break;
        case popupCupon:
            cuponModule.mostrarPopupGana();
            break;
        case popupCuponForzado:
            cuponModule.mostrarPopupGanaste();
            break;
        case popupAsesoraOnline:
            if (popupInicialCerrado == 0) asesoraOnlineObj.mostrar();
            break;
        case popupActualizarCorreo:
            PopupMostrar('popupVerificacionCorreoElectronicoPendiente');
            break;
    }
}

function VerSeccionBienvenida(seccion) {
    var id = "";
    switch (seccion) {
        case "Belcorp":
            id = ".content_belcorp";
            break
        case "MisOfertas":
            id = "#contenedor_template_estrategia_cabecera";
            break;
        case "MiAcademia":
            id = "#seccionMiAcademiaLiquidacion";
            break;
        case "Footer":
            id = "footer";
            break;
        default://Home
            id = ".flexslider";
            break;
    }

    if (id != "") {
        if ($(id).length) {
            var topOf = $(id).offset().top - 60;
            if (id == ".flexslider")
                topOf = 0;

            $("html, body").animate({
                scrollTop: topOf
            }, 1000);
        }
    }
}

function dataLayerVC(action, label) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Coach Virtual',
        'action': action,
        'label': label
    });
}

function ConsultarEmailPendiente() {
    var item = {
        pagina: "1"
    }
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/ObtenerActualizacionEmailSms',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        success: function (data) {
            if (checkTimeout(data)) {
                /*En este caso se mostrarà el tooltip*/
                if (parseInt(data.tipoMostrador) == 0) {
                    if (data.mensaje.length > 0) {
                        document.getElementsByClassName('popup__wrapper')[0].style.display = 'none';
                        document.getElementById('mensajeToolTip').innerHTML = data.mensaje;
                        document.getElementsByClassName('tooltip_info_revision_correo')[0].style.display = 'block';
                    } else {
                        document.getElementsByClassName('popup__wrapper')[0].style.display = 'none';
                        document.getElementsByClassName('tooltip_info_revision_correo')[0].style.display = 'none';
                    }
                    /*En este caso se mostrarà el popup*/
                } else {
                    document.getElementsByClassName('tooltip_info_revision_correo')[0].style.display = 'none';
                    var hrefUrl = document.getElementById('hrfUrl');
                    var URLdomain = window.location.origin;
                    hrefUrl.href = URLdomain + data.urlDispositivo;

                    if (parseInt(data.valor) == 0)
                        document.getElementsByClassName('popup__wrapper')[0].style.display = 'none';
                    else if (parseInt(data.valor) == 1) {
                        document.getElementsByClassName('popup__wrapper')[0].style.display = 'block';
                        document.getElementById("mensaje").innerHTML = "";
                        document.getElementById("mensaje").innerHTML = data.mensaje;

                    }
                }
            }
        },
        error: function (data, error) {
            alert(error);
        }
    });
}

function ObtenerEstadoContrato() {
    var re = false;
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/ObtenerEstadoContrato',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        cache: false,
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success)
                    if (data.estado) re = true;
            }
        },
        error: function (data, error) {
            alert(error);
        }
    });

    return re;
}

function BotonAbrirCaminoBrillante() {
    dataLayer.push(
        {
            'event': 'virtualEvent',
            'category': 'Home',
            'action': 'Clic botón',
            'label': 'Ver Beneficios'
        });
}
