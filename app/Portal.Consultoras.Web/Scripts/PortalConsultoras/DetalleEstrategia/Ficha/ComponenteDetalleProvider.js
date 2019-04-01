var ComponenteDetalleProvider = function () {
    var _urlDetalleEstrategia = ConstantesModule.UrlDetalleEstrategia;

    var _promiseObternerComponenteDetalle = function (params) {
        var dfd = $.Deferred();

        try {

            $.ajax({
                type: "POST",
                url: _urlDetalleEstrategia.obtenerComponenteDetalle,
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
        PromiseObternerComponenteDetalle: _promiseObternerComponenteDetalle 
    };
}();