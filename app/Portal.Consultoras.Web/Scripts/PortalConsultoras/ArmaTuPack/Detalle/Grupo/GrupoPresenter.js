var GrupoPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    //
    if (typeof config.grupoView === "undefined" || config.grupoView === null) throw "config.grupoView is null or undefined";
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config.armaTuPackProvider is null or undefined";

    var _config = {
        grupoView: config.grupoView,
        armaTuPackProvider: config.armaTuPackProvider,
    };

    var _init = function () {
        var cuv = '9999';
        _config
            .armaTuPackProvider
            .getPackComponentsPromise(cuv)
            .done(function(){

            });
    };

    return {
        init : _init
    };
};