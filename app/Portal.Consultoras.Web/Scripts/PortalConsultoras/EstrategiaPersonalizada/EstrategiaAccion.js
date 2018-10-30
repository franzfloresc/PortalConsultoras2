
// 1: escritorio Home    11 : escritorio Pedido 
// 2: mobile  Home       21 : mobile pedido
    //var tipoOrigenEstrategia = tipoOrigenEstrategia || "";

// Cuarto Dígito
// 0. Sin popUp         1. Con popUp


var revistaDigital = revistaDigital || {};

var belcorp = belcorp || {};
belcorp.estrategia = belcorp.estrategia || {};
belcorp.estrategia.initialize = function () {
    registerEvent.call(this, "onProductoAgregado");
};

function VerPopupExpGanaMas() {

    var divMensaje = "";

    if (revistaDigital) {
        if (revistaDigital.TieneRDC) {
            if (!revistaDigital.EsSuscrita && !revistaDigital.EsActiva) {
                if (isMobile()) {
                    divMensaje = $("#divNSPopupBloqueadoMob");
                } else {
                    divMensaje = $("#divNSPopupBloqueadoDesk");
                }

            } else if (revistaDigital.EsSuscrita && !revistaDigital.EsActiva) {
                if (isMobile()) {
                    divMensaje = $("#divSNAPopupBloqueadoMob");
                } else {
                    divMensaje = $("#divSNAPopupBloqueadoDesk");
                }
            }
        }
    }

    if (divMensaje != "") {
        divMensaje.show();
    }

}