var masVendidosModule = (function () {
    "use strict"

    var CONTANSTES_ = {

    };

    var elements = {
        
    };

    var setting = {
        baseUrl: '',
        urlVerDetalleProducto: 'EstrategiaProducto/DetalleProducto'
    };

    var lista = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnAgregarComentario, function () {
            
        });
    }

    var _setDefaultValues = function () { };

    var _initializer = function (parameters) {
        setting.baseUrl = parameters.baseUrl;
        _bindEvents();
    };

    var _verDetalleProductoMasVendidos = function (estrategiaId) {
        debugger;
        var objProducto = _obtenerProductoDesdeStorage(estrategiaId);
        var verDetallePromise = _verDetallePromise(objProducto);

        $.when(verDetallePromise).then(function (verDetalleResponse) {
            if (checkTimeout(campaniasResponse)) {
                if (verDetalleResponse.success) {
                    model.Lista = _actualizarListaStorate(lista, data);
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

        $.each(lista, function (index, value) {
            if (value.EstrategiaID == estrategiaId) {
                item = value;
            }
        });

        return item;
    };
    
    var _actualizarListaStorate = function (lista, data) {
        var temp = [];
        $.each(lista, function (index, value) {
            if (value.EstrategiaID == item.EstrategiaID) {
                temp.push(item);
            } else {
                temp.push(value);
            }
        });
        return temp;
    };

    var _verDetallePromise = function (data) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: (setting.baseUrl + setting.urlVerDetalleProducto),
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
            _verDetalleProductoMasVendidos(estrategiaId);
        }
    };
})();