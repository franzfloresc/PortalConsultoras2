var paraPopup = 0;
var paramVideoBienvenida = 0;
var paramVioTutorialDesktop = 0;
var cont = 0;
var cancel = 0;
var x = 1; 
function MostrarPopusEnOrden(param, VideoBienvenida, VioTutorialDesktop) {
    if (cont==0) {
        paraPopup = param * 1;
        paramVideoBienvenida = VideoBienvenida * 1;
        paramVioTutorialDesktop = VioTutorialDesktop * 1;
        cont++;
    }       
    if (paraPopup>0) {
        switch (paraPopup) {     
            case 1://video introductorio
                if (cancel==0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }
                for (var i = 0; i < document.querySelectorAll("img[src='/Content/Images/btn_cerrar_popup.svg']").length; i++) {
                    var btn = document.querySelectorAll("img[src='/Content/Images/btn_cerrar_popup.svg']")[i];
                    btn.onclick = function () {

                        if (document.getElementById('videoIntroductorio').style.display == "" && paramVioTutorialDesktop == 1)
                        {

                                if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                    document.getElementById('survicate-box').style.display = 'block';

                                    document.getElementsByClassName('surv-close')[0].onclick = function () {
                                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                        document.getElementsByClassName('flexslider')[0].style.display = 'block';                        
                                        clearTimeout(timeoutHandle);
                                    }

                                    document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                        document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                        clearTimeout(timeoutHandle);
                                    }
                                }
                                else {      
                                        cancel = 1;
                                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                        document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                        clearTimeout(timeoutHandle);
                                  }
                         
                        }else if (document.getElementById('videoIntroductorio').style.display == "none" && paramVioTutorialDesktop == 0) {

                            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                document.getElementById('survicate-box').style.display = 'block';

                                document.getElementsByClassName('surv-close')[0].onclick = function () {
                                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                    document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                    clearTimeout(timeoutHandle);
                                }

                                document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                    document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                    clearTimeout(timeoutHandle);
                                }
                            }
                            else {
                                cancel = 1;
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                clearTimeout(timeoutHandle);
                        
                            }
                            
                        }else if (VideoBienvenida ==1 && paramVioTutorialDesktop == 0) {

                            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                document.getElementById('survicate-box').style.display = 'block';

                                document.getElementsByClassName('surv-close')[0].onclick = function () {
                                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                    document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                    clearTimeout(timeoutHandle);
                                }

                                document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                    document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                    clearTimeout(timeoutHandle);
                                }
                            }
                            else {
                                cancel = 1;
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block'; 
                                clearTimeout(timeoutHandle);
                            }

                        }

                        document.getElementsByClassName('cerrar_tooltipTutorial')[0].onclick = function () {

                            if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                                document.getElementById('survicate-box').style.display = 'block';

                                document.getElementsByClassName('surv-close')[0].onclick = function () {
                                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                    document.getElementsByClassName('flexslider')[0].style.display = 'block';
                                    clearTimeout(timeoutHandle);
                                }

                                document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                    document.getElementsByClassName('flexslider')[0].style.display = 'block';
                                    clearTimeout(timeoutHandle);
                                }
                            }
                            else {
                                cancel = 1;
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block';
                                clearTimeout(timeoutHandle);
                            }
                        }
                        



                    }
                }


                break;
            //case 9: //RevistaDigitalSuscripcion 

            //    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
            //    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
            //    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';


            //    for (var i = 0; i < document.querySelectorAll("img[src='/Content/Images/close-icon.svg']").length; i++) {
            //        var btn = document.querySelectorAll("img[src='/Content/Images/close-icon.svg']")[i];
            //        btn.onclick = function () {                  
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
            case 10, 11: //Cupon 
                if (cancel == 0) {
                    if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';
                    document.getElementsByClassName('flexslider')[0].style.display = 'None';
                }

                for (var i = 0; i < document.querySelectorAll("img[src='/Content/Images/cerrar_04_blanco.png']").length; i++) {
                    var btn = document.querySelectorAll("img[src='/Content/Images/cerrar_04_blanco.png']")[i];
                    btn.onclick = function () {
                        clearTimeout(timeoutHandle);
                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';

                            document.getElementsByClassName('surv-close')[0].onclick = function () {
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            }

                            document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            }

                        }

                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        }
                    }
                }

                document.getElementById('Cupon1').onclick = document.getElementById('Cupon2').onclick = document.getElementById('Cupon3').onclick = function () {
                    if (document.getElementById('Cupon1').style.display == '' || document.getElementById('Cupon2').style.display == '' || document.getElementById('Cupon3').style.display == '') {
                        clearTimeout(timeoutHandle);
                        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                            document.getElementById('survicate-box').style.display = 'block';

                            document.getElementsByClassName('surv-close')[0].onclick = function () {
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            }

                            document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                                document.getElementsByClassName('flexslider')[0].style.display = 'block';
                            }

                        }
                        else {
                            cancel = 1;
                            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                            document.getElementsByClassName('flexslider')[0].style.display = 'block';
                        }

                    }
                };       
            break;
            default:
                clearTimeout(timeoutHandle);
        }
    }
    else {
        clearTimeout(timeoutHandle);
    }
    timeoutHandle= setTimeout(MostrarPopusEnOrden, x * 10);
}
MostraPopupOrdenCupon();