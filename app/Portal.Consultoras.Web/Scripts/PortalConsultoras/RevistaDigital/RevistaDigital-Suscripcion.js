﻿
var lsListaRD = lsListaRD || "RDLista";

$(document).ready(function () {
    "use strict";
    var clickabrir = 1;

    if (isMobile()) {

        $(".preguntas-frecuentes-cont-sus ul.preg-frecuentes li a.abrir-preg-frecuente").click(function () {
            $(".preguntas-frecuentes-cont-sus ul.preg-frecuentes ul").slideToggle();

            if (clickabrir === 1) {
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.despliegue").css("display", "none");
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.nodespliegue").css("display", "block");
                clickabrir = 0;
            }
            else {
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.nodespliegue").css("display", "none");
                $(".preguntas-frecuentes-cont-sus .contenedor-mobile-fix span.despliegue").css("display", "block");
                clickabrir = 1;
            }
        });
    }
    else {

        $(".preguntas-frecuentes-cont-sus ul.preg-frecuentes li:has(ul)").click(function () {
            $(this).find("ul").slideToggle();
            if (clickabrir === 1) {
                $(this).find("span.despliegue").css("display", "none");
                $(this).find("span.nodespliegue").css("display", "block");
                clickabrir = 0;
            }
            else {
                $(this).find("span.despliegue").css("display", "block");
                $(this).find("span.nodespliegue").css("display", "none");
                clickabrir = 1;
            }
        });
    }

});

//function ScrollUser(anchor, alto) {
//    var topMenu = ($("#seccion-fixed-menu").position() || {}).top || 0;
//    if (topMenu > 0)
//        alto = alto + $("#seccion-fixed-menu").height() + 10;

//    alto = (jQuery(anchor).offset() || {}).top - alto;
//    return alto;
//}

function RDPopupMobileCerrar() {

    AbrirLoad();

    rdAnalyticsModule.CerrarPopUp("ConfirmarDatos");

    $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/PopupCerrar",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            CerrarLoad();
            window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDSuscripcion() {

    AbrirLoad();
    rdAnalyticsModule.Inscripcion();

    var rdSuscriocionPromise = RDSuscripcionPromise();
    rdSuscriocionPromise.then(
        function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (!data.success) {
                AbrirMensaje(data.message);
                return false;
            }

            if (data.Inmediata) {
                LimpiarLocalStorage();
            }
            else if (data.revistaDigital) {
                var key = lsListaRD + data.CampaniaID;
                RDActualizarTipoAccionAgregar(data.revistaDigital, key);
            }

            if (typeof esAppMobile == 'undefined') {

                $("#PopRDSuscripcion").css("display", "block"); // Confirmar datos
                $(".popup_confirmacion_datos .form-datos input").keyup(); //to update button 

            } else if (esAppMobile) {
                window.location = (isMobile() ? "/Mobile" : "") + "/RevistaDigital/ConfirmacionAPP";
            }

            return false;

        },
        function (xhr, status, error) {
            CerrarLoad();
        }
    );
}

function RDSuscripcionPromise() {
    var d = $.Deferred();

    var promise = $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/Suscripcion",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: true
    });

    promise.done(function (response) {
        d.resolve(response);
    });

    promise.fail(d.reject);

    return d.promise();
}


function RDDesuscripcion_pregunta() {

    rdAnalyticsModule.CancelarSuscripcion();
    $('#alerta_cancelar_suscripcion').show();
    $('#pregunta').show();
    $('#frmMotivoDesuscripcion').find('input:checked').click();
    $('#opciones').hide();
}

function RDDesuscripcion_cerrar(e) {
    if (e)
        if (revistaDigital.EsSuscrita)
            rdAnalyticsModule.DesuscripcionPopup(e.innerHTML);
        else {

            var MensajeEncuesta = "";
            for (var i = 0; i < $('#frmMotivoDesuscripcion').find('input:checked').parent().length; i++) {
                if (i === 0) {
                    MensajeEncuesta = $('#frmMotivoDesuscripcion').find('input:checked').parent()[i].id
                }
                else
                    MensajeEncuesta = MensajeEncuesta + '|' + $('#frmMotivoDesuscripcion').find('input:checked').parent()[i].id
            }

            rdAnalyticsModule.CancelarSuscripcionEncuesta(MensajeEncuesta);
        }

    else
        if (revistaDigital.EsSuscrita)
            rdAnalyticsModule.DesuscripcionPopupCerrar("Cerrar Popup");
        else
            rdAnalyticsModule.DesuscripcionPopupCerrar("Cerrar Encuesta");

    $('#pregunta').show();
    $('#opciones').hide();

    if (!revistaDigital.EsSuscrita) {
        window.location.href = (isMobile() ? "/Mobile" : "") + "/Ofertas";
    }
    $('#alerta_cancelar_suscripcion').hide();
}




function RDDesuscripcion_check() {

    if ($('#frmMotivoDesuscripcion').find('input:checked ~ .checkmark_desuscrita')[0])
        $('#btnDesuscrita').removeClass('disable');
    else
        $('#btnDesuscrita').addClass('disable');
}

function RDDesuscripcion_motivos(e) {
    rdAnalyticsModule.DesuscripcionPopup(e.innerHTML);
    RDDesuscripcion(e);
}



function RDDesuscripcion(e) {

    AbrirLoad();

    $.ajax({
        type: "POST",
        url: baseUrl + "RevistaDigital/Desuscripcion",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success !== true) {
                AbrirMensaje(data.message);
                return false;
            }
            if (data.Inmediata) {
                LimpiarLocalStorage();
            }
            else if (data.revistaDigital) {
                var key = lsListaRD + data.CampaniaID;
                RDActualizarTipoAccionAgregar(data.revistaDigital, key);
            }
            revistaDigital = data.revistaDigital;
            $('#pregunta').hide();
            $('#opciones').show();

        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function MostrarTerminos() {
    var win = window.open(urlTerminosCondicionesRD, "_blank");
    if (win) {
        //Browser has allowed it to be opened
        win.focus();
    } else {
        //Browser has blocked it
    }
}

function RedireccionarContenedorComprar(origenWeb, codigo) {
    origenWeb = $.trim(origenWeb);
    if (origenWeb !== "")
        rdAnalyticsModule.Access(origenWeb);

    codigo = $.trim(codigo);
    window.location = (isMobileNative.any() || isMobile() ? "/Mobile" : "") + "/Ofertas" + (codigo !== "" ? "#" + codigo : "");
}

function RedireccionarContenedorInformativa(origenWeb) {
    origenWeb = $.trim(origenWeb);
    if (origenWeb !== "")
        rdAnalyticsModule.Access(origenWeb);

    window.location = (isMobileNative.any() ? "/Mobile" : "") + "/RevistaDigital/Informacion";
}
function GetItemLocalStorageSurvicate() {
    var surviKeys = {};
    for (var key in localStorage) {
        if (key.indexOf('survi::') > -1)
            surviKeys[key] = localStorage[key];
    }
    return surviKeys;
}
function SetItemLocalStorageSurvicate(storage) {

    if (typeof storage !== 'undefined' && typeof storage === 'object') {
        for (var key in storage) {
            if (storage.hasOwnProperty(key))
                localStorage.setItem(key, storage[key]);
        }
    }
}

function LimpiarLocalStorage() {
    if (typeof (Storage) !== 'undefined') {
        var itemSBTokenPais = localStorage.getItem('SBTokenPais');
        var itemSBTokenPedido = localStorage.getItem('SBTokenPedido');
        var itemChatEConnected = localStorage.getItem('connected');
        var itemChatEConfigParams = localStorage.getItem('ConfigParams');
        var itemSurvicateStorage = GetItemLocalStorageSurvicate();
        localStorage.clear();

        if (typeof (itemSBTokenPais) !== 'undefined' && itemSBTokenPais !== null) {
            localStorage.setItem('SBTokenPais', itemSBTokenPais);
        }

        if (typeof (itemSBTokenPedido) !== 'undefined' && itemSBTokenPedido !== null) {
            localStorage.setItem('SBTokenPedido', itemSBTokenPedido);
        }

        if (typeof (itemChatEConnected) !== 'undefined' && itemChatEConnected !== null) {
            localStorage.setItem('connected', itemChatEConnected);
        }

        if (typeof (itemChatEConfigParams) !== 'undefined' && itemChatEConfigParams !== null) {
            localStorage.setItem('ConfigParams', itemChatEConfigParams);
        }
        if (typeof (itemSurvicateStorage) !== 'undefined' && itemSurvicateStorage !== null) {
            SetItemLocalStorageSurvicate(itemSurvicateStorage);
        }
    }
};