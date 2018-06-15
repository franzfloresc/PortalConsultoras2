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
var cont = 0;
var cancel = 0;
var x = 1;
var timeoutHandle = 0;

function MostrarPopusEnOrden(param, VideoBienvenida, VioTutorialDesktop) {

    if (cont == 0) {
        paraPopup = param * 1;
        paramVideoBienvenida = VideoBienvenida * 1;
        paramVioTutorialDesktop = VioTutorialDesktop * 1;
        cont++;
    }
    if (paraPopup > 0) {
        switch (paraPopup) {

            case 1://video introductorio
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }

                $('#videoIntroductorio').on('hide', function () {

                    if (document.getElementById('videoIntroductorio').style.display == "" && paramVioTutorialDesktop == 1) {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
         
                            valEncuesta=window.setInterval("ValidacionEncuesta()", 500);
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            clearTimeout(timeoutHandle);
                        }

                    } else if (document.getElementById('videoIntroductorio').style.display == "none" && paramVioTutorialDesktop == 0) {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
                            valEncuesta = window.setInterval("ValidacionEncuesta()", 500);
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            clearTimeout(timeoutHandle);

                        }

                    } else if (VideoBienvenida == 1 && paramVioTutorialDesktop == 0) {

                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';
                            valEncuesta = window.setInterval("ValidacionEncuesta()", 500);
                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            clearTimeout(timeoutHandle);
                        }

                    }

                    clearTimeout(timeoutHandle);

                });

                $('#popup_tutorial_home').on('hide', function () {

                    clearTimeout(timeoutHandle);
                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';

                        valEncuesta = window.setInterval("ValidacionEncuesta()", 500);
                    }
                    else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        clearTimeout(timeoutHandle);
                    }


                })
                
                break;

            case 4: //AceptacionContrato 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }

                $('#popupAceptacionContrato').on('hide', function () {

            
                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';

                        valEncuesta = window.setInterval("ValidacionEncuesta()", 500);

                    }
                    else {
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        clearTimeout(timeoutHandle);
                    }
                        

                });

            break;
            case 6://ActualizarDatos 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }

                $('#popupActualizarMisDatos').on('hide', function () {

                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';

                        valEncuesta = window.setInterval("ValidacionEncuesta()", 500);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        clearTimeout(timeoutHandle);
                    }
                    
                });
               
                break;

            case 7: //Flexipago 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }
                $('#popupInvitaionFlexipago').on('hide', function () {

                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';
                        valEncuesta = window.setInterval("ValidacionEncuesta()", 500);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        clearTimeout(timeoutHandle);
                    }
                  
                });
                break;
            case 8://Comunicado 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }
                $('#popupComunicados').on('hide', function () {

                    if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        document.getElementById('survicate-box').style.display = 'block';

                        valEncuesta = window.setInterval("ValidacionEncuesta()", 500);
                    } else {
                        cancel = 1;
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        clearTimeout(timeoutHandle);
                    }
                    
                });
                break;
             //case 9: //RevistaDigitalSuscripcion 

            //    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
            //    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
            //    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';


            //    for (var i = 0; i < document.querySelectorAll("img[src='/Content/Images/close-icon.svg']").length; i++) {
            //        var btn = document.querySelectorAll("img[src='/Content/Images/close-icon.svg']")[i];
            //        btn.onclick = function () {                  
                        //if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                        //    document.getElementById('survicate-box').style.display = 'block';

                        //    document.getElementsByClassName('surv-close')[0].onclick = function () {
                        //        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        //        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        //        document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        //    }

                        //    document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                        //        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        //        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        //    }

                        //}
                        //else {
                        //    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        //    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                        //    document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        //}
            //            clearTimeout(timeoutHandle);
            //        }
            //    }


            //    document.getElementById('PopRDSuscripcion').onclick =  function () {
            //        if (document.getElementById('PopRDSuscripcion').style.display == '' ) {
            //            clearTimeout(timeoutHandle);
            //            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
            //                document.getElementById('survicate-box').style.display = 'block';

            //                document.getElementsByClassName('surv-close')[0].onclick = function () {
            //                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
            //                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            //                }

            //                document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
            //                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
            //                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            //                }

            //            }
            //            else {
            //                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
            //                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            //            }
            //        }
            //    };

            //    break;

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

    timeoutHandle = setTimeout(MostrarPopusEnOrden, x * 10);
}

function Cupon()
{ 
    if (cancel == 0) {
        if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
        document.getElementsByClassName('flexslider')[0].style.display = 'None';
    }

    $('#Cupon3').on('hide', function () {
            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                document.getElementById('survicate-box').style.display = 'block';
                cancel = 1;
                valEncuesta = window.setInterval("ValidacionEncuesta()", 500);                
            }
            else {              
                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                document.getElementsByClassName('flexslider')[0].style.display = 'block';
                clearTimeout(timeoutHandle); 
                cancel = 1;
            }  
    });

}
var contValEncuesta = 0;
function ValidacionEncuesta() {

    if (document.getElementById('survicate-box') == null) {
        if (contValEncuesta==0) {
            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            document.getElementsByClassName('flexslider')[0].style.display = 'block';
            contValEncuesta = contValEncuesta+1;
            clearInterval(valEncuesta);
            clearTimeout(timeoutHandle);
            cancel = 1;
        }
   
    }
}
var valEncuesta = 0;