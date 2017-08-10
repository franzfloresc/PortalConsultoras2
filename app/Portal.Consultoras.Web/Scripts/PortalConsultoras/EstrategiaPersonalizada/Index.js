
var sElementos = {
    seccion: '[data-seccion]',
    load: '[data-seccion-load]',
    listadoProductos: "[data-seccion-productos]"
};

var sProps = {
    UrlObtenerSeccion: baseUrl + 'EstrategiaPersonalizada/ObtenerSeccion'
};

$(document).ready(function () {
    SeccionCargarProductos();
});

function SeccionCargarProductos() {
    var listaSecciones = $(sElementos.seccion);
    if (listaSecciones.length === 0)
        return false;

    $.each(listaSecciones, function (ind, seccion) {
        $(seccion).find(sElementos.load).show();
        var objSeccion = SeccionObtenerSeccion(seccion);
        if (objSeccion.Codigo !== "") {
            SeccionCargarProductos(objSeccion);
        }
        else {
            $(seccion).remove();
        }
    });

}

function SeccionObtenerSeccion(seccion) {
    var codigo = $.trim($(seccion).data("seccion"));
    var campania = $.trim($(seccion).data("campania"));
    var detalle = {};

    if (codigo === "" || campania === "")
        return detalle;

    $.ajaxSetup({
        cache: false
    });

    var param = {
        Codigo: codigo,
        CampaniaId: campania
    }

    $.ajax({
        type: 'GET',
        url: sProps.UrlObtenerSeccion,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: false,
        success: function (data) {
            detalle = data || {};
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });

    return detalle;
}

function SeccionCargarProductos(objConsulta) {
    
    objConsulta = objConsulta || {};
    if (typeof objConsulta.urlObtenerProductos === "undefined")
        return false;

    $.ajaxSetup({
        cache: false
    });

    $.ajax({
        type: 'GET',
        url: objConsulta.urlObtenerProductos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            data.Seccion = objConsulta;
            SeccionMostrarProductos(data);
        },
        error: function (error, x) {
            console.log(error, x);
        }
    });    
}

function SeccionMostrarProductos(data) {
    var htmlSeccion = $("[data-seccion=" + data.Seccion.Codigo + "]");
    if (htmlSeccion.length !== 1) 
        return false
    
    var divListadoProductos = htmlSeccion.find(sElementos.listadoProductos);
    if (divListadoProductos.length !== 1) 
        return false
    
    SetHandlebars(data.template, data.lista, divListadoProductos);

    if (data.seccion.Tipo) {
        // Carrusel
    }
}