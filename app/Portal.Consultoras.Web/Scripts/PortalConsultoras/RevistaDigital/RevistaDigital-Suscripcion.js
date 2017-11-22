﻿
$(document).ready(function () {
    $("[data-campania1]").html(campaniaNro + 1);
    $("[data-campania2]").html(campaniaNro + 2);
});

function RDPopupCerrar(tipo) {
    AbrirLoad();
    if (tipo == 1) {
        rdAnalyticsModule.CerrarPopUp('Banner Inscripción Exitosa');
        location.href = location.href;
        return false;
    }
    if (tipo == 2) {
        rdAnalyticsModule.CerrarPopUp('Banner Inscripción Exitosa');
        CerrarPopup("#PopRDSuscripcion");
        CerrarLoad();
        return true;
    }

    rdAnalyticsModule.CerrarPopUp('Banner Inscribirme a Ésika para mí');
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/PopupCerrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDSuscripcion(accion) {
   
    AbrirLoad();
    rdAnalyticsModule.Inscripcion();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Suscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                CerrarPopup("#PopRDSuscripcion");
                CerrarPopup("#divMensajeBloqueada");
                AbrirMensaje(data.message);
                return false;
            }

            accion = accion || 0;
            if (accion === 2) {
                $("[data-estadoregistro]").attr("data-estadoregistro", "1");
                $("[data-estadoregistro0]").hide();
                $("[data-estadoregistro2]").hide();
                $("[data-estadoregistro1]").show();
                rdAnalyticsModule.SuscripcionExistosa();
                return true;
            }

            $("#PopRDInscrita [data-usuario]").html($.trim(usuarioNombre).toUpperCase());

            if (accion == 0) {
                
                MostrarMenu(data.CodigoMenu);
                if (!isMobile()) {
                    CargarBanners();
                }
            }
            else if (accion == 1) {
                CerrarPopup("#divMensajeBloqueada");
            }
            AbrirPopupFade("#PopRDInscrita");
            rdAnalyticsModule.suscripcionExitosa();
        },
        error: function (data, error) {
            CerrarLoad();
            
        }
    });
}

function RDDesuscripcion(accion) {
    AbrirLoad();
    rdAnalyticsModule.CancelarSuscripcion();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/Desuscripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            accion = accion || 0;
            if (accion == 2) {
                $("[data-estadoregistro]").attr("data-estadoregistro", "2");
                $("[data-estadoregistro0]").show();
                $("#divCambiosEstadoRegistro [data-estadoregistro0]").hide();
                $("[data-estadoregistro1]").hide();
                $("[data-estadoregistro2]").show();
            }
        },
        error: function (data, error) {
            CerrarLoad();
            CerrarPopup("#PopRDSuscripcion");
        }
    });
}

function RDPopupNoVolverMostrar() {
    rdAnalyticsModule.CerrarPopUp('Banner Inscribirme a Ésika para mí');
    CerrarPopup("#PopRDSuscripcion");
    AbrirLoad();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'RevistaDigital/PopupNoVolverMostrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            CerrarLoad();
        },
        error: function (data, error) {
            CerrarLoad();
        }
    });
}

function RDInformacion() {
    location.href = urlInformacionSuscripcion;
}

function RDRedireccionarInformacion(seccion) {
    seccion = seccion || 0;
    rdAnalyticsModule.IrCancelarSuscripcion();
    var url = (isMobile() ? "/Mobile" : "") + "/RevistaDigital/Informacion";

    if (seccion == 1) url += "#divCambiosEstadoRegistro";
    else if (seccion == 2) url += "?tipo=" + seccion;
    
    var urlLocal = $.trim(window.location).toLowerCase() + "/";
    window.location = url;
    if (urlLocal.indexOf("/revistadigital//Informacion/") >= 0) {
        window.location.reload();
    }
}

function RDRedireccionarDetalle(event) {
    var obj = EstrategiaObtenerObj(event);
    EstrategiaGuardarTemporal(obj);
    var url = ((isMobile() ? "/Mobile" : "") + "/RevistaDigital/Detalle");
    window.location = url + "?cuv=" + obj.CUV2 + "&campaniaId=" + obj.CampaniaID;
}

function MostrarTerminos() {
    var win = window.open(urlTerminosCondicionesRD, '_blank');
    if (win) {
        //Browser has allowed it to be opened
        win.focus();
    } else {
        //Browser has blocked it
        console.log("Habilitar mostrar popup");
    }
}

function RedirectToLandingRD(origenWeb) {
    // Save analytics before redirect 
    rdAnalyticsModule.Access(origenWeb);
    window.location = urlRevistaDigital;
}

function RedireccionarContenedorComprar(origenWeb, codigo) {
    rdAnalyticsModule.Access(origenWeb);
    codigo = $.trim(codigo);
    window.location = (isMobile() ? "/Mobile" : "") + "/Ofertas" + (codigo != "" ? "#" + codigo : "");
}