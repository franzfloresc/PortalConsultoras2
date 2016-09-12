Utils = {
    Ajax: function (opciones, successCallback, failureCallback, errorCallback) {

        if (opciones.url == null)
            opciones.url = "";

        if (opciones.parametros == null)
            opciones.parametros = {};

        if (opciones.async == null)
            opciones.async = true;

        if (opciones.datatype == null)
            opciones.datatype = "json";

        if (opciones.contentType == null)
            opciones.contentType = "application/json; charset=utf-8";

        if (opciones.type == null)
            opciones.type = "POST";

        $.ajax({
            type: opciones.type,
            url: opciones.url,
            contentType: opciones.contentType,
            dataType: opciones.datatype,
            async: opciones.async,
            data: opciones.contentType == "application/json; charset=utf-8"
                ? JSON.stringify(opciones.parametros)
                : opciones.parametros,
            success: function (response) {
                if (successCallback != null && typeof (successCallback) == "function")
                    successCallback(response);
            },
            failure: function (msg) {
                if (failureCallback != null && typeof (failureCallback) == "function")
                    failureCallback(msg);
            },
            error: function (xhr, status, error) {
                if (errorCallback != null && typeof (errorCallback) == "function")
                    errorCallback(xhr, status, error);
            }
        });
    }
};