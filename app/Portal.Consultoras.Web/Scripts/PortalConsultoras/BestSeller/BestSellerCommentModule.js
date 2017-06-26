var bestSellerCommentModule = (function () {
    "use strict"

    var CONTANSTES_ = {
        
    };

    var elements = {
        btnAgregarComentario: 'div.texto_agregarComentarios',
        btnCancelarComentario: 'a.cancelar_comentario',
        btnEnviarComentario: 'a.enviar_comentario_Seller',
        btnCerrarContenedorConfirmacionComentario: 'a.btn_cerrar_comentario',
        btnRecomendar: '#btnRecomendar',
        btnNoRecomendar: '#btnNoRecomendar',
        contenedorValoracion: 'div.contentValoracion',
        contenedorConfirmacionComentario: 'div.content_confirmacion_comentario',
        contenedorPuntuacion: '.rateyo-puntuacion-seccion-comentario',
        hdRecomendado: '#hdRecomendado',
        txtComentario: '#txtComentario'
    };

    var setting = {
        urlListarComentarios: '',
        urlRegistrarComentario: ''
    };

    var _bindEvents = function () {
        $(document).on("click", elements.btnAgregarComentario, function () {
            _limpiarElementosContenedorValoracion();
            _mostrarContenedorValoracion();
        });

        $(document).on("click", elements.btnCancelarComentario, function () {
            _ocultarContenedorValoracion();
        });

        $(document).on("click", elements.btnEnviarComentario, function () {
            waitingDialog({});
            _registrarComentario();
        });

        $(document).on("click", elements.btnCerrarContenedorConfirmacionComentario, function () {
            _ocultarContenedorConfirmacionComentario();
        });

        $(document).on("click", elements.btnRecomendar, function () {
            $(elements.hdRecomendado).val(true);
        });

        $(document).on("click", elements.btnNoRecomendar, function () {
            $(elements.hdRecomendado).val(false);
        });
    }

    var _bindRate = function () {
        $(elements.contenedorPuntuacion).rateYo({
            rating: 0,
            precision: 2,
            minValue: 1,
            maxValue: 5,
            starWidth: "25px",
            spacing: "7px",
            fullStar: true
        })
    };

    var _mostrarContenedorValoracion = function () {
        $(elements.btnAgregarComentario).hide();
        $(elements.contenedorValoracion).show();
    };

    var _ocultarContenedorValoracion = function () {
        $(elements.btnAgregarComentario).show();
        $(elements.contenedorValoracion).hide();
    };

    var _mostrarContenedorConfirmacionComentario = function () {
        $(elements.contenedorValoracion).hide();
        $(elements.contenedorConfirmacionComentario).show();
    };

    var _ocultarContenedorConfirmacionComentario = function () {
        $(elements.contenedorConfirmacionComentario).hide();
        $(elements.btnAgregarComentario).show();
    };

    var _registrarComentario = function () {
        var model = _obtenerRegistrarComentarioModel();
        var registrarComentarioPromise = _registrarComentarioPromise(model);
        
        $.when(registrarComentarioPromise).then(function (registrarComentarioResponse) {
            if (checkTimeout(registrarComentarioResponse)) {
                if (registrarComentarioResponse.success) {
                    _mostrarContenedorConfirmacionComentario();
                } else {
                    alert(registrarComentarioResponse.message);
                }

                closeWaitingDialog();
            }
        });
        
    };

    var _obtenerRegistrarComentarioModel = function () {
        var objRate = $(elements.contenedorPuntuacion).rateYo();
        var model = {
            recomendado: ($(elements.hdRecomendado).val().toLowerCase() == 'true'),
            comentario: $(elements.txtComentario).val().trim(),
            valorizado: objRate.rateYo("rating")
        };

        return model;
    };

    var _limpiarElementosContenedorValoracion = function () {
        $(elements.contenedorPuntuacion).rateYo("destroy");
        _bindRate();
        $(elements.hdRecomendado).val('');
        $(elements.txtComentario).val('');
    };

    var _registrarComentarioPromise = function (model) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'POST',
            url: (setting.urlRegistrarComentario),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(model),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    var _initializer = function (parameters) {
        setting.urlRegistrarComentario = parameters.urlRegistrarComentario;
        _bindEvents();
        _bindRate();
    };

    return {
        ini: function (parameters) {
            _initializer(parameters);
        }
    };
})();