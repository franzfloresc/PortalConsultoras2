function Init() {
    $('#ddlPais').on('change', function () {
        var paisISO = $(this).val();
        if (IsNullOrEmpty(paisISO)) {
            $('#css-main').attr('href', cssMainEsika);
            $('#div_select_pais').css('background-image', '');
            $('#tooltip_usuario').css('display', 'none');
            $('#tooltip_password').css('display', 'none');
        }
        else {
            $('#css-main').attr('href', paisesEsika.indexOf(paisISO) >= 0 ? cssMainEsika : cssMainLbel);
            $('#div_select_pais').css('background-image', urlFormatImagenBandera.replace(/\{0\}/g, paisISO));
            $('#tooltip_usuario').css('display','').html(listTooltipUsuario[paisISO]);
            $('#tooltip_password').css('display', '').html(listTooltipPassword[paisISO]);
        }
    });
}

function LoginNormal() {
    var arrayMessage = [];
    var paisISO = $('#ddlPais').val();
    var user = $('#txtUsuario').val();
    var password = $('#txtPassword').val();

    if (IsNullOrEmpty(paisISO)) arrayMessage.push('Seleccione un pais');
    if (IsNullOrEmpty(user)) arrayMessage.push('Ingrese su código de usuario');
    if (IsNullOrEmpty(password)) arrayMessage.push('Ingrese su password');
    if (arrayMessage.length > 0) {
        MostrarArrayMensaje(arrayMessage);
        return;
    }

    ResponderBotmakerNormal(paisISO, user, password);
}

function ResponderBotmakerNormal(paisISO, user, password) {
    ResponderBotmaker(urlBotmakerLoginNormal, {
        loginCountry: paisISO,
        loginUser: user,
        loginPassword: password
    })
}