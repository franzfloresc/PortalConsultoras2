function Init()
{
    $('#btnLogin').on('click', LoginNormal);
    $('#txtUsuario').on("keydown", function (event) { if (event.which == 13 ) $('#btnLogin').click(); });
    $('#txtPassword').on("keydown", function (event) { if (event.which == 13) $('#btnLogin').click(); });
}

function LoginNormal() { ValidarLoginNormal(ResponderBotmakerNormal); }

function ResponderBotmakerNormal(paisID, paisISO, user, password) {
    ResponderBotmaker(urlBotmakerLoginNormal, {
        loginCountry: paisISO,
        loginUser: user,
        loginPassword: password
    })
}