var localStorageModule;
var analyticsPortalModule;

var fichaModule;
var componenteDetalleModule;

$(document).ready(function () {
    AbrirLoad();

    localStorageModule = LocalStorageModule();
    analyticsPortalModule = AnalyticsPortalModule;

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

        generalModule: GeneralModule,
        palanca: modelPalanca,
        campania: modelCampania,
        cuv: modelCuv,
        origen: modelOrigen
    });

    fichaModule.Inicializar();

    CerrarLoad();
});

$(document).ajaxStop(function () {
    //
});