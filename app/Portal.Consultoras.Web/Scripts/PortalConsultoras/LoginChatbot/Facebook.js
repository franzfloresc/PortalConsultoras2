var accessTokenFB;

function Init() {
    ShowLoading();
    FB.init({ appId: appFacebookId, xfbml: true, version: 'v2.8' });

    FB.getLoginStatus(function (response) {
        CloseLoading();
        if (response.status === 'connected') ValidarUsuarioFBAsociado(response);
        //else LoginFB();
    });

    $('#btnLoginFB').on('click', LoginFB);
    $('#btnLogin').on('click', AsociarUsuarioFB);
}

function LoginFB() {
    ShowLoading();
    FB.login(
        function (response) {
            CloseLoading();
            if (response.status === 'connected') ValidarUsuarioFBAsociado(response);
        },
        { scope: 'public_profile,email,user_birthday,user_location' }
    );
}

function ValidarUsuarioFBAsociado(responseFB) {
    var exists = ExistsExternalUser('Facebook', responseFB.authResponse.userID, function (exists) {
        if (exists == null) MessageInfoError('Ocurrió un problema al intentar validar si tiene una consultora asociada.');
        else if (!exists) MostrarLoginNormal(responseFB);
        else ResponderBotmakerFB(responseFB.authResponse.userID, responseFB.authResponse.accessToken);
    });
}

function ExistsExternalUser(provider, id, fnFinal) {
    var exists = null;

    ShowLoading();
    $.post('/Login/CheckExternalUser', { proveedor: provider, appid: id })
        .done(function (response) { if (response.success) exists = response.exists; })
        .fail(function (error) { ConsoleLog(error); })
        .always(function () {
            CloseLoading();
            if ($.isFunction(fnFinal)) fnFinal(exists);
        });
}

function MostrarLoginNormal(responseFB) {
    accessTokenFB = responseFB.authResponse.accessToken;
    $('#div-facebook').hide();
    $('#div-asociacion-normal').show();
}

function AsociarUsuarioFB() {
    ValidarLoginNormal(function (paisID, paisISO, user, password) {
        ShowLoading();
        FB.api('/me', 'GET', { fields: 'birthday,email,first_name,gender,hometown,id,last_name,link,location,name,picture.type(large)' }, function (responseFB) {
            CloseLoading();
            if (IsNullOrEmpty(responseFB.id)) {
                MessageInfoError('Ocurrió un error al intentar obtener los datos de su cuenta de Facebook.');
                return;
            }

            usuario = {
                'PaisID': paisID,
                'CodigoISO': paisISO,
                'CodigoUsuario': user,
                'ClaveSecreta': password,
                'UsuarioExterno': {
                    'Proveedor': 'Facebook',
                    'IdAplicacion': responseFB.id,
                    'Login': responseFB.name,
                    'Nombres': responseFB.first_name,
                    'Apellidos': responseFB.last_name,
                    'FechaNacimiento': responseFB.birthday,
                    'Correo': responseFB.email,
                    'Genero': responseFB.gender,
                    'Ubicacion': (typeof responseFB.location === 'object') ? responseFB.location.name : "",
                    'LinkPerfil': responseFB.link,
                    'FotoPerfil': (typeof responseFB.picture === 'object') ? responseFB.picture.data.url : ""
                }
            }

            $.ajax({
                type: 'POST',
                url: '/Login/Login',
                data: JSON.stringify(usuario),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json'
            })
                .always(CloseLoading)
                .done(function (response) {
                    if (response.success) ResponderBotmakerFB(responseFB.id, accessTokenFB)
                    else MessageInfoError(response.message);
                })
                .fail(function (error) { MessageInfoError('Ocurrió un error al intentar asociar su consultora con su cuenta de Facebook.'); });
        })
    });
}

function ResponderBotmakerFB(userID, accessToken) {
    ResponderBotmaker(urlBotmakerLoginFacebook, { fbId: userID, fbAccessToken: accessToken });
}