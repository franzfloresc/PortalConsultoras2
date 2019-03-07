var ArmaTuPackPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null";
    if (typeof config.armaTuPackProvider === "undefined" || config.armaTuPackProvider === null) throw "config is null";

    var _packComponents = {};

    var _config = {
        armaTuPackProvider: config.armaTuPackProvider,
        cuv: config.cuv
    };

    var _getModelo = function () {
        _config.armaTuPackProvider
            .getPackComponentsPromise()
            .done(function (data) {
                _PackComponents = data;
            })
            .fail(function (data, error) {
                _PackComponents = {};
            });
    };

    var _init = function () {
        _getModelo();
    };

    return {
        init: _init,
        packComponents: _packComponents
    };
};