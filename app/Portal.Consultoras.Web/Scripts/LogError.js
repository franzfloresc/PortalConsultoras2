
if (!window.location.origin) {
    window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
}

// Tracking de errores en JS
window.onerror = function (msg, url, line, col, error) {
    // Browser compatibility
    // https://blog.sentry.io/2016/01/04/client-javascript-reporting-window-onerror.html
    // https://blog.bugsnag.com/js-stacktraces/

    if (!url) {
        url = window.location.origin;
    }

    // Tener en cuenta que col & error son nuevos en la especificación HTML 5 y no pueden ser 
    // soportados en todos los navegadores. 
    var stackTrace = "";
    if (!error && !col) {
        stackTrace = url + ' -> line: ' + line;
    } else {
        stackTrace = url + ' -> line: ' + line + ', col: ' + col + ', error: ' + error;
    }

    if (msg === 'Script error.') {
        //Errores de JS externos
        return;
    }

    // TODO: Reportar el error a través de ajax para que pueda realizar un seguimiento
    // de qué páginas tienen problemas JS
    var objError = {
        Mensaje: msg,
        StackTrace: stackTrace,
        Url: url,
        Origen: 'Cliente',
        TipoTrace: 'ScriptError'
    };

    registrarLogErrorElastic(objError);
    registrarLogError(objError);

    var suppressErrorAlert = true;
    // Si devuelve true, entonces las alertas de error (como en versiones anteriores de
    // Internet Explorer) se suprimirá.
    return suppressErrorAlert;
};

// Tracking de llamadas $.ajax
$(document).ajaxError(function (event, jqxhr, settings, thrownError) {

    // No se registra errores por Sesión expirada
    if (jQuery.type(jqxhr.responseText) === "string") {
        if ((jqxhr.responseText.indexOf('<input type="hidden" id="PaginaLogin" />') > -1) ||
            (jqxhr.responseText.indexOf('<input type="hidden" id="PaginaSesionExpirada" />') > -1)) {
            if (!checkTimeout(jqxhr))
                return;
            return;
        }
    }

    // Jquery Ajax
    // http://api.jquery.com/ajaxerror/

    // AJAX - Server Response
    // https://www.w3schools.com/xml/ajax_xmlhttprequest_response.asp

    // HTTP Status Messages 
    // https://www.w3schools.com/tags/ref_httpmessages.asp

    var urlAjax = window.location.origin + " -> " + settings.url;

    var message = settings.url + ": ";
    var stackTrace = "";

    if (thrownError == 'parsererror') {
        message += "Parsing request was failed.";
        stackTrace = thrownError;
    }
    else if (thrownError == 'timeout') {
        message += "Request time out.";
        stackTrace = thrownError;
    }
    else if (thrownError == 'abort') {
        //message += "Request was aborted.";
        //stackTrace = thrownError;
        return;
    }
    else if (jqxhr.status === 0) {
        //message += "No connection.";
        //stackTrace = jqxhr.responseText;
        return;
    }
    else if (jqxhr.status >= 400) {
        message += "HTTP Error " + jqxhr.status + " – " + jqxhr.statusText + ".";
        stackTrace = jqxhr.responseText;
    }
    else {
        message += "Unknown error.";
        stackTrace = jqxhr.responseText + " - " + thrownError;
    }

    // TODO: Reportar el error a través de ajax para que pueda realizar un seguimiento
    // de qué invocaciones AJAX tienen problemas
    var objError = {
        Mensaje: message,
        StackTrace: stackTrace,
        Url: urlAjax,
        Origen: 'Cliente',
        TipoTrace: 'AjaxError'
    };
    registrarLogErrorElastic(objError);
    registrarLogError(objError);
});

function registrarLogError(objError) {

    if (isPagina('localhost')) {
        return;
    }

    if (!urlLogDynamo) return;

    var urlLogError = urlLogDynamo + "Api/LogError";

    // Ctrl, Action, Url actual
    var controllerName = window.controllerName
        , actionName = window.actionName
        , currentUrl = window.location.href
    ;

    var extra = [
        { 'key': 'Origen', 'value': objError.Origen },
        { 'key': 'Url', 'value': objError.Url },
        { 'key': 'Browser', 'value': navigator.appVersion },
        { 'key': 'TipoTrace', 'value': objError.TipoTrace }
    ];

    var data = {
        'Aplicacion': userData.aplicacion,
        'Pais': userData.pais,
        'Usuario': userData.codigoConsultora,
        'Mensaje': objError.Mensaje,
        'StackTrace': objError.StackTrace,

        'CurrentUrl': currentUrl,
        'ControllerName': controllerName,
        'ActionName': actionName,

        'Extra': extra
    };

    if (urlLogError != "") {
        $.ajax({
            type: "POST",
            async: true,
            crossDomain: true,
            url: urlLogError,
            dataType: "json",
            global: false,
            data: data,
            success: function (result) { },
            error: function (x, xh, xhr) { }
        });
    }
}

function registrarLogErrorElastic(objError) {

    if (isPagina('localhost')) {
        console.log(objError);
        return;
    }
    else if (location.host.indexOf('qa') > 0 || location.host.indexOf('ppr') > 0) {
        console.log(objError);
    }

    if (!urlLogElastic) return;

    var urlLogError = urlLogElastic + getIndexName() + "/LogEvent";

    // Ctrl, Action, Url actual
    var controllerName = window.controllerName
        , actionName = window.actionName
        , currentUrl = window.location.href
        ;

    var data = {
        'Date': new Date(),
        'Path': window.location.pathname,
        'HostName': window.location.origin,
        'Ajax': objError.Url,
        'Class': controllerName,
        'Method': actionName,
        'Url': currentUrl,
        'Level': 'ERROR',
        'Message': objError.Mensaje,
        'Application': 'Javascript',
        'Trace': objError.TipoTrace,
        'Pais': userData.pais,
        'User': userData.codigoConsultora,
        'Navigator': navigator.appVersion,
        'Exception': JSON.stringify(objError.StackTrace)
    };

    if (urlLogError != "") {
        $.ajax({
            type: "POST",
            async: true,
            crossOrigin: true,
            url: urlLogError,
            dataType: "json",
            contentType: 'application/json',
            global: false,
            data: JSON.stringify(data),
            success: function (result) { },
            error: function (x, xh, xhr) { }
        });
    }
}

function getIndexName() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd
    }

    if (mm < 10) {
        mm = '0' + mm
    }

    return patternElastic + yyyy + '.' + mm + '.' + dd;
}
