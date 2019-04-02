var fichaModule;
var componenteDetalleModule;

$(document).ready(function () {
    AbrirLoad();
    
    componenteDetalleModule = ComponenteDetalleModule({
        localStorageModule: LocalStorageModule(),
        analyticsPortalModule: AnalyticsPortalModule,
        palanca: modelPalanca,
        campania: modelCampania,
        cuv: modelCuv,
        origen: modelOrigen
    });

    fichaModule = FichaModule({
        localStorageModule: LocalStorageModule(),
        analyticsPortalModule: AnalyticsPortalModule,
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