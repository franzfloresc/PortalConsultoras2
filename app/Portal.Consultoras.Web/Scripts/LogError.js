// Tracking de errores en JS
window.onerror = function (msg, url, line, col, error) {
    // Browser compatibility
    // https://blog.sentry.io/2016/01/04/client-javascript-reporting-window-onerror.html
    // https://blog.bugsnag.com/js-stacktraces/

    // Tener en cuenta que col & error son nuevos en la especificación HTML 5 y no pueden ser 
    // soportados en todos los navegadores. 
    var stackTrace = "";
    if (!error && !col) {
        stackTrace = msg + ' en ' + url + ' linea ' + line;
    } else {
        stackTrace = 'linea: ' + line + ', columna: ' + col + ', ' + error.stack;
    }

    // Solo Chrome, Opera y IE > 9 pasan el objeto error.
    //var column = column || (window.event && window.event.errorCharacter);
    //var stack = [];
    //var f = arguments.callee.caller;
    //while (f) {
    //    stack.push(f.name);
    //    f = f.caller;
    //}
    //console.log(message, "from", stack);

    // TODO: Reportar el error a través de ajax para que pueda realizar un seguimiento
    // de qué páginas tienen problemas JS
    var objError = {
        Mensaje: msg,
        StackTrace: stackTrace,
        Url: url,
        Origen: 'Cliente',
        TipoTrace: 'ScriptError'
    };
    registrarLogError(objError);

    var suppressErrorAlert = true;
    // Si devuelve true, entonces las alertas de error (como en versiones anteriores de
    // Internet Explorer) se suprimirá.
    return suppressErrorAlert;
};

// Tracking de llamadas $.ajax
$(document).ajaxError(function (event, jqxhr, settings, thrownError) {
    // Jquery Ajax
    // http://api.jquery.com/ajaxerror/

    // AJAX - Server Response
    // https://www.w3schools.com/xml/ajax_xmlhttprequest_response.asp

    // HTTP Status Messages 
    // https://www.w3schools.com/tags/ref_httpmessages.asp

    if (!window.location.origin) {
        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
    }

    var urlAjax = window.location.origin + "" + settings.url;

    // TODO: Reportar el error a través de ajax para que pueda realizar un seguimiento
    // de qué invocaciones AJAX tienen problemas
    var objError = {
        Mensaje: jqxhr.status + ' - ' + jqxhr.statusText,
        StackTrace: jqxhr.responseText,
        Url: urlAjax,
        Origen: 'Cliente',
        TipoTrace: 'AjaxError'
    };
    registrarLogError(objError);
});

function registrarLogError(objError) {
    console.log(objError);

    if (!urlLogDynamo) return;

    var urlLogError = urlLogDynamo + "Api/LogError";
    
    var extra = [
        { 'key': 'Origen', 'value': objError.Origen },
        { 'key': 'Url', 'value': objError.Url },
        { 'key': 'Browser', 'value': navigator.appVersion },
        { 'key': 'TipoTrace', 'value': objError.TipoTrace }
    ];

    data = {
        'Aplicacion': userData.aplicacion,
        'Pais': userData.pais,
        'Usuario': userData.codigoConsultora,
        'Mensaje': objError.Mensaje,
        'StackTrace': objError.StackTrace,
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
            success: function (result) { console.log(result); },
            error: function (x, xh, xhr) { console.log(x); }
        });
    }
}
