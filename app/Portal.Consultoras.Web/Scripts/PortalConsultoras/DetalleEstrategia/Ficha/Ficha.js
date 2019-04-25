var localStorageModule;
var analyticsPortalModule;
var generalModule;
var detalleEstrategiaProvider;
var componenteDetalleModule;

var fichaModule;

$(document).ready(function () {
    AbrirLoad();

    try {
        localStorageModule = LocalStorageModule();
        analyticsPortalModule = AnalyticsPortalModule;
        generalModule = GeneralModule;
        detalleEstrategiaProvider = DetalleEstrategiaProvider;

        componenteDetalleModule = ComponenteDetalleModule({
            localStorageModule: localStorageModule,
            analyticsPortalModule: analyticsPortalModule,
            generalModule: generalModule,
            palanca: modelPalanca,
            campania: modelCampania,
            cuv: modelCuv,
            origen: modelOrigen
        });

        fichaModule = FichaModule({
            localStorageModule: localStorageModule,
            analyticsPortalModule: analyticsPortalModule,
            generalModule: generalModule,
            detalleEstrategiaProvider: detalleEstrategiaProvider,
            componenteDetalleModule: componenteDetalleModule,

            palanca: modelPalanca,
            campania: modelCampania,
            cuv: modelCuv,
            origen: modelOrigen
        });

        fichaModule.Inicializar();
    }
    catch (error) {
        console.log(error);
        if (typeof error === "string") {
            window.onerror(error);
        }
        else if (typeof error === "object") {
            registrarLogErrorElastic(error);
        }
        generalModule.redirectTo("ofertas");
    }

    CerrarLoad();
});

$(document).ajaxStop(function () {
    //
});