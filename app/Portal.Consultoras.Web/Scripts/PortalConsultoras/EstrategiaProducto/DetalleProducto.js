var masVendidosModule = (function () {
    "use strict"

    var CONTANSTES_ = {

    };

    var elements = {
        
    };

    var setting = {
        baseUrl: '',
        urlVerDetalleProducto: 'EstrategiaProducto/DetalleProducto',

    };

    var lista = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnAgregarComentario, function () {
            
        });

        $(document).ready(function () {
            debugger;
            var model = get_local_storage("data_mas_vendidos");
            var item = model.Item;
            SetHandlebars("#template-detalle-producto", item, "#contenedor-detalle-producto");
        });
    }

    var _setDefaultValues = function () { };

    var _initializer = function (parameters) {
        setting.baseUrl = parameters.baseUrl;
        _bindEvents();
    };

    var _verDetalleProductoMasVendidos = function (estrategiaId) {
        var objProducto = _obtenerProductoDesdeStorage(estrategiaId);
        var verDetallePromise = _verDetallePromise(objProducto);

        $.when(verDetallePromise)
            .then(function (verDetalleResponse) {
                if (checkTimeout(verDetalleResponse)) {
                    if (verDetalleResponse.success) {
                        var item = verDetalleResponse.data.Item;
                        var model = get_local_storage("data_mas_vendidos");
                        model.Item = item;
                        model.Lista = _actualizarListaStorate(model.Lista, item);
                        set_local_storage(model, "data_mas_vendidos");
                        location.href = baseUrl + 'EstrategiaProducto/DetalleProducto';
                } else {
                    console.log(verDetalleResponse.menssage);
                }
            }
        });
    };

    var _obtenerProductoDesdeStorage = function (estrategiaId) {
        var model = get_local_storage("data_mas_vendidos");
        var lista = model.Lista;
        var item = null;

        lista.forEach(elem => {if (elem.EstrategiaID == estrategiaId) {item = elem;}});

        return item;
    };
    
    var _actualizarListaStorate = function (lista, item) {
        var temp = [];
        lista.forEach(elem => {
            if (elem.EstrategiaID == item.EstrategiaID) {
                temp.push(item);
            } else {
                temp.push(elem);
            }
        })
        return temp;
    };

    var _verDetallePromise = function (data) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: "EstrategiaProducto/ObtenerDetalleProducto",
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    return {
        ini: function (parameters) {
            _initializer(parameters);
        },
        estrategiaVerDetalle: function (estrategiaId) {
            debugger;
            _verDetalleProductoMasVendidos(estrategiaId);
        }
    };
})();