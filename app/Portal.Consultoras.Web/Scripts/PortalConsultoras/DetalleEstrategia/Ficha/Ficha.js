var localStorageModule;
var analyticsPortalModule;
var generalModule;

var fichaModule;
var componenteDetalleModule;

$(document).ready(function () {
    AbrirLoad();

    localStorageModule = LocalStorageModule();
    analyticsPortalModule = AnalyticsPortalModule;
    generalModule = GeneralModule;

    componenteDetalleModule = ComponenteDetalleModule({
        localStorageModule: localStorageModule,
        analyticsPortalModule: analyticsPortalModule,
        palanca: modelPalanca,
        campania: modelCampania,
        cuv: modelCuv,
        origen: modelOrigen
    });

    fichaModule = FichaModule({
        localStorageModule: localStorageModule,
        analyticsPortalModule: analyticsPortalModule,
        componenteDetalleModule: componenteDetalleModule,

        generalModule: generalModule,
        palanca: modelPalanca,
        campania: modelCampania,
        cuv: modelCuv,
        origen: modelOrigen
    });

    try {
        fichaModule.Inicializar();
    }
    catch (error) {
        console.log(error);
        var url = "/ofertas";
        if (generalModule.isMobile()) {
            url = "/mobile" + url;
        } 
        generalModule.redirectTo(url);
    }

    CerrarLoad();
});

$(document).ajaxStop(function () {
    //
});