(function ($) {
    $.each(['hide'], function (i, ev) { //'show', 
        var el = $.fn[ev];
        $.fn[ev] = function () {
            this.trigger(ev);
            return el.apply(this, arguments);
        };
    });
})(jQuery);

var paraPopup = 0;
var paramVideoBienvenida = 0;
var paramVioTutorialDesktop = 0;
var paramCambioClave = 0;
var cont = 0;
var cancel = 0;
var x = 1;
var timeoutHandle;
var timeoutEncuesta;
var contValEncuesta = 0;
var countFlexlider = 0;
var countCambioClave = 0;
var countcerrarAceptacionContrato = 0;
var countPopupActualizoDatos = 0;
function MostrarPopusEnOrden(param, VideoBienvenida, VioTutorialDesktop, CambioClave) {
    if (cont == 0) {
        paraPopup = param * 1;
        paramVideoBienvenida = VideoBienvenida * 1;
        paramVioTutorialDesktop = VioTutorialDesktop * 1;
        paramCambioClave = CambioClave * 1;
        cont++;
    }
    if (paraPopup > 0) {
        switch (paraPopup) {
            case 1://video introductorio
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }

                $('#videoIntroductorio').on('hide', function () {

                    if (document.getElementById('videoIntroductorio').style.display == "" && paramVioTutorialDesktop == 1) {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
                            ValidacionEncuesta();
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            PresentarNovedadBuscador('block');
                            EmpezarSlider();
                            clearTimeout(timeoutHandle);
                        }

                    } else if (document.getElementById('videoIntroductorio').style.display == "none" && paramVioTutorialDesktop == 0) {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
                            ValidacionEncuesta();
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            PresentarNovedadBuscador('block');
                            EmpezarSlider();
                            clearTimeout(timeoutHandle);

                        }

                    } else if (VideoBienvenida == 1 && paramVioTutorialDesktop == 0) {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
                            ValidacionEncuesta();
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            PresentarNovedadBuscador('block');
                            EmpezarSlider();
                            clearTimeout(timeoutHandle);
                        }

                    }
                    clearTimeout(timeoutHandle);
                });

                $('#popup_tutorial_home').on('hide', function () {

                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        ValidacionEncuesta();
                        clearTimeout(timeoutHandle);
                    }
                    else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        PresentarNovedadBuscador('block');
                        EmpezarSlider();
                        clearTimeout(timeoutHandle);
                    }

                })

                break;
            case 4: //AceptacionContrato 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }

                if (countcerrarAceptacionContrato == 0) {
                    countcerrarAceptacionContrato++;
                    for (var i = 0; i < document.querySelectorAll("img[src='/Content/Images/btn_cerrar_popup.svg']").length; i++) {
                        var btn = document.querySelectorAll("img[src='/Content/Images/btn_cerrar_popup.svg']")[i];
                        btn.onclick = function () {

                            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                document.getElementById('survicate-box').style.display = 'block';
                                cancel = 1;
                                ValidacionEncuesta();
                                clearTimeout(timeoutHandle);
                            } else {
                                cancel = 1;
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                PresentarNovedadBuscador('block');
                                EmpezarSlider();
                                clearTimeout(timeoutHandle);
                            }

                        }

                    }

                    window.onkeyup = function () {
                        var e = window.event;
                        var tecla = (document.all) ? e.keyCode : e.which;
                        if (tecla == 27) {

                            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                document.getElementById('survicate-box').style.display = 'block';
                                cancel = 1;
                                ValidacionEncuesta();
                                clearTimeout(timeoutHandle);
                            } else {
                                cancel = 1;
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                PresentarNovedadBuscador('block');
                                EmpezarSlider();
                                clearTimeout(timeoutHandle);
                            }
                        }

                    }


                }

                if (paramCambioClave == 0) {
                    if (document.getElementById('popupActualizarMisDatos').style.display == 'none' && document.getElementById('popupActualizarMisDatos').getAttribute('data-popup-activo') == '0') {

                        if (countPopupActualizoDatos == 0) {
                            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                document.getElementById('survicate-box').style.display = 'block';
                                ValidacionEncuesta();
                                cancel = 1;
                                clearTimeout(timeoutHandle);
                                countPopupActualizoDatos++;
                            }
                            else {
                                cancel = 1;
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                PresentarNovedadBuscador('block');
                                EmpezarSlider();
                                clearTimeout(timeoutHandle);
                                countPopupActualizoDatos++;
                            }
                        }

                    }

                } else {
                    if (document.getElementById('popupAceptacionContrato').style.display == 'none' && document.getElementById('popupAceptacionContrato').getAttribute('data-popup-activo') == '0') {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
                            ValidacionEncuesta();
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            PresentarNovedadBuscador('block');
                            EmpezarSlider();
                            clearTimeout(timeoutHandle);
                        }
                        cancel = 1;
                    }

                }
                break;
            case 5: // Showroom
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }

                $('#PopShowroomVenta').on('hide', function () {
                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        cancel = 1;
                        ValidacionEncuesta();
                        clearTimeout(timeoutHandle);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        PresentarNovedadBuscador('block');
                        EmpezarSlider();
                        clearTimeout(timeoutHandle);
                    }
                });

                //$('#DialogoMensajeBannerShowRoom').on('hide', function () {
                //    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                //        document.getElementById('survicate-box').style.display = 'block';
                //        cancel = 1;
                //        ValidacionEncuesta();
                //        clearTimeout(timeoutHandle);
                //    } else {
                //        cancel = 1;
                //        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                //        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                //        EmpezarSlider();
                //        clearTimeout(timeoutHandle);
                //    }
                //});

                break;
            case 6://ActualizarDatos 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }
                $('#popupActualizarMisDatos').on('hide', function () {
                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        cancel = 1;
                        ValidacionEncuesta();
                        clearTimeout(timeoutHandle);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        PresentarNovedadBuscador('block');
                        EmpezarSlider();
                        clearTimeout(timeoutHandle);
                    }
                });
                break;
            case 7: //Flexipago 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }
                $('#popupInvitaionFlexipago').on('hide', function () {

                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        cancel = 1;
                        ValidacionEncuesta();
                        clearTimeout(timeoutHandle);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        PresentarNovedadBuscador('block');
                        EmpezarSlider();
                        clearTimeout(timeoutHandle);
                    }

                });
                break;
            case 8://Comunicado 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }
                $('#popupComunicados').on('hide', function () {
                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        cancel = 1;
                        ValidacionEncuesta();
                        clearTimeout(timeoutHandle);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        PresentarNovedadBuscador('block');
                        clearTimeout(timeoutHandle);
                        EmpezarSlider();
                    }

                });
                break;
            case 9: //RevistaDigitalSuscripcion  gana +
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    PresentarNovedadBuscador('None');
                }

                $('#PopRDSuscripcion').on('hide', function () {
                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        cancel = 1;
                        ValidacionEncuesta();
                        clearTimeout(timeoutHandle);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        PresentarNovedadBuscador('block');
                        clearTimeout(timeoutHandle);
                        EmpezarSlider();
                    }

                });

                break;
            case 10: //Cupon 
                Cupon();
                break;
            case 11: //CuponForzado 
                Cupon();
                break;

        }
    }
    else {
        clearTimeout(timeoutHandle);
    }
    timeoutHandle = setTimeout(MostrarPopusEnOrden, x * 100);

}
var countEslaider = 0;
var timeoutSlider = 0;

(function () {
    timeoutSlider = setInterval(function () {
        if (paraPopup > 0) {

            if ($('.flexslider').length && jQuery().flexslider) {
                if ($('.flexslider').length && typeof jQuery().flexslider == 'function') {
                    var firstImage = jQuery(".flexslider").find("img").filter(":first");
                    var image = firstImage.get(0);
                    if (image != null) {
                        if (typeof jQuery().flexslider !== "undefined" && image.complete) {
                            if (countEslaider == 0) {
                                $('.flexslider').flexslider("pause");
                                countEslaider++;
                            }
                        }
                    }
                }
            }

        }
    }, 1000);
})();



function ValidacionEncuesta() {

    if (document.getElementById('survicate-box') == null) {
        if (contValEncuesta == 0) {
            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            PresentarNovedadBuscador('block');
            EmpezarSlider();
            contValEncuesta = contValEncuesta + 1;
            clearTimeout(timeoutEncuesta);
            //clearTimeout(timeoutHandle);
            cancel = 1;
        }
    }
    timeoutEncuesta = setTimeout(ValidacionEncuesta, x * 100);
}
function Cupon() {
    if (cancel == 0) {
        if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
        PresentarNovedadBuscador('None');
    }

    $('#Cupon3').on('hide', function () {
        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
            document.getElementById('survicate-box').style.display = 'block';
            cancel = 1;
            ValidacionEncuesta();
        }
        else {
            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            PresentarNovedadBuscador('block');
            EmpezarSlider();
            clearTimeout(timeoutHandle);
            cancel = 1;
        }
    });
}


function EmpezarSlider() {

    if ($('.flexslider').length && jQuery().flexslider) {
        if ($('.flexslider').length && typeof jQuery().flexslider == 'function') {
            var firstImage = jQuery(".flexslider").find("img").filter(":first");
            var image = firstImage.get(0);
            if (image != null) {
                if (typeof jQuery().flexslider !== "undefined" && image.complete) {
                    //if (countEslaider == 0) {
                    //    $('.flexslider').flexslider("pause");
                    //    countEslaider++;
                    //}
                    if (countFlexlider == 0) {
                        countFlexlider++;
                        clearInterval(timeoutSlider);
                        $('.flexslider').flexslider('next')
                        $('.flexslider').flexslider('play');
                    }

                }
            }
        }
    }
}

function PresentarNovedadBuscador(_val) {
    if (CantidadVecesInicioSesionNovedad > 0) {
        if (NovedadBuscadorVisitasUsuario >= 0 && NovedadBuscadorVisitasUsuario < CantidadVecesInicioSesionNovedad) {
            if (document.getElementById('toolTipBuscador') != null) document.getElementById('toolTipBuscador').style.display = _val;
        }
    }
}