function Init()
{
    // if (event.which == 13 && this.value.length > 0)
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