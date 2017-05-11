function Init() { $('#btnLogin').on('click', LoginNormal); }

function LoginNormal() { ValidarLoginNormal(ResponderBotmakerNormal); }

function ResponderBotmakerNormal(paisID, paisISO, user, password) {
    ResponderBotmaker(urlBotmakerLoginNormal, {
        loginCountry: paisISO,
        loginUser: user,
        loginPassword: password
    })
}