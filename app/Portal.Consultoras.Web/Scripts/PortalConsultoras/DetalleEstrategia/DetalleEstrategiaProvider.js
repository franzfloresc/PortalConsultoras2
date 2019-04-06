var DetalleEstrategiaProvider = function () {
    var _urlDetalleEstrategia = ConstantesModule.UrlDetalleEstrategia;

    var _promiseObternerComponentes = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: "POST",
                url: _urlDetalleEstrategia.obtenerComponentes,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: false,
                cache: false,
                success: function (data) {
                    if (data.success) {
                        dfd.resolve(data);
                    }
                    else {
                        dfd.reject(data);
                    }
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

        } catch (e) {
            dfd.reject({}, {});
        }
        return dfd.promise();
    };

    var _promiseObternerDetallePedido = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: 'post',
                url: _urlDetalleEstrategia.obtenerPedidoWebSetDetalle,
                datatype: 'json',
                contenttype: 'application/json; charset=utf-8',
                data: params,
                success: function (data) {
                    if (data.success) {
                        dfd.resolve(data);
                    }
                    else {
                        dfd.reject(data);
                    }
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

        } catch (e) {
            dfd.reject({}, {});
        }
        return dfd.promise();
    };

    var _promiseObternerModelo = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: "POST",
                url: _urlDetalleEstrategia.obtenerModelo,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: false,
                cache: false,
                success: function (data) {
                    if (data.success) {
                        dfd.resolve(data);
                    }
                    else {
                        dfd.reject(data);
                    }
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });

        } catch (e) {
            dfd.reject({}, {});
        }
        return dfd.promise();
    };

    return {
        promiseObternerComponentes: _promiseObternerComponentes,
        promiseObternerDetallePedido: _promiseObternerDetallePedido,
        promiseObternerModelo: _promiseObternerModelo
    };
}();