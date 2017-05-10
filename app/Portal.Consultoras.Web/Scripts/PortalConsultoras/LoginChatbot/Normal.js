function Init() {
    $('#ddlPais').on('change', function () {
        $('#css-main').attr('href', paisesEsika.indexOf($(this).val()) >= 0 ? cssMainEsika : cssMainLbel)
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