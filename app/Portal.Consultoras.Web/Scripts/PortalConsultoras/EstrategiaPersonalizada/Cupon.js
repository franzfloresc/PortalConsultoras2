function ProcesarActualizacionMostrarContenedorCupon() {
    if (typeof paginaOrigenCupon == "undefined") {
        return false;
    }

    if (paginaOrigenCupon) {
        if (cuponModule) {
            cuponModule.actualizarContenedorCupon();
        }
    }
}