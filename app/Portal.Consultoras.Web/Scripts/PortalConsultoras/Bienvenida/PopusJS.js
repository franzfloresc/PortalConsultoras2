window.onload = function () {

    if (document.getElementById('Cupon1').style.display == 'block' || document.getElementById('Cupon1').style.display == '' ||
        document.getElementById('Cupon2').style.display == 'block' || document.getElementById('Cupon2').style.display == '' ||
        document.getElementById('Cupon3').style.display == 'block' || document.getElementById('Cupon3').style.display == '') {

        if (document.getElementById('survicate-box') != null) document.getElementById('survicate-box').style.display = 'None';
        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';

        for (var i = 0; i < document.querySelectorAll("img[src='/Content/Images/cerrar_04_blanco.png']").length; i++) {
            var btn = document.querySelectorAll("img[src='/Content/Images/cerrar_04_blanco.png']")[i];
            btn.onclick = function () {

                if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                    document.getElementById('survicate-box').style.display = 'block';

                    document.getElementsByClassName('surv-close')[0].onclick = function () {
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                    }

                    document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                    }

                }

                else {
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                }
            }
        }

        document.getElementById('Cupon1').onclick = document.getElementById('Cupon2').onclick = document.getElementById('Cupon3').onclick = function () {
            if (document.getElementById('Cupon1').style.display == '' || document.getElementById('Cupon2').style.display == '' || document.getElementById('Cupon3').style.display == '') {
                if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
                    document.getElementById('survicate-box').style.display = 'block';

                    document.getElementsByClassName('surv-close')[0].onclick = function () {
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                    }

                    document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                        if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                        if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                    }

                }
                else {
                    if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                    if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
                }

            }
        };
    }
    else
    {
        if (document.getElementById('survicate-box') != null && document.getElementById('survicate-box').innerHTML != "") {
            if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'None';
            if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'None';

            document.getElementsByClassName('surv-close')[0].onclick = function () {
                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            }

            document.getElementsByClassName('surv-radio-input')[0].onclick = document.getElementsByClassName('surv-radio-input')[1].onclick = function () {
                if (document.getElementById('marca') != null) document.getElementById('marca').style.display = 'block';
                if (document.getElementById('showroom_banner_inferior') != null) document.getElementById('showroom_banner_inferior').style.display = 'block';
            }
        }
    }

}