function Init() {
    ShowLoading();
    FB.init({ appId: appFacebookId, xfbml: true, version: 'v2.8' });

    FB.getLoginStatus(function (response) {
        CloseLoading();
        if (response.status === 'connected') ResponderBotmakerFacebook(response);
        else LoginFB();
    });
}

function LoginFB() {
    ShowLoading();
    FB.login(
        function (response) {
            CloseLoading();
            if (response.status === 'connected') ResponderBotmakerFacebook(response);
        },
        { scope: 'public_profile,email,user_birthday,user_location' }
    );
}

function ResponderBotmakerFacebook(facebookResponse) {
    ResponderBotmaker(urlBotmakerLoginFacebook, {
        fbId: facebookResponse.authResponse.userID,
        fbAccessToken: facebookResponse.authResponse.accessToken
    })
}