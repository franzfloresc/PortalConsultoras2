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
        contenedorComentarios: '#contenedorComentarios',
        hdRecomendado: '#hdRecomendado',
        txtComentario: '#txtComentario',
        ddlFiltro: '#ddlFiltro'
    };

    var setting = {
        urlListarComentarios: '',
        urlRegistrarComentario: '',
        urlImagenUsuarioDefault: '',
        cantidadCrecienteMostrarInicial: 0,
        cantidadCrecienteMostrar: 10,
        esperarScroll: false
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

        $(document).on("change", elements.ddlFiltro, function () {
            setting.cantidadCrecienteMostrarInicial = 0;
            $(elements.contenedorComentarios).empty();
            _bindScroll();
            _listarComentarios(setting.cantidadCrecienteMostrarInicial);
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

    var _bindScroll = function () {
        $(window).scroll(_listarComentariosScroll);
    };

    var _unbindScroll = function(){
        $(window).off("scroll", _listarComentariosScroll);
    };
    
    var _listarComentariosScroll = function () {
        if ($(window).scrollTop() + $(window).height() > ($(document).height() - $('footer').outerHeight())) {
            if (!setting.esperarScroll) {
                setting.cantidadCrecienteMostrarInicial += setting.cantidadCrecienteMostrar;
                _listarComentarios(setting.cantidadCrecienteMostrarInicial);
            }
        }
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

    var _listarComentarios = function (cantidadCrecienteMostrarInicial) {
        waitingDialog();
        setting.esperarScroll = true;

        var model = {
            codigoSAP: '0123456789',
            cantidadMostrar: cantidadCrecienteMostrarInicial,
            orden: $(elements.ddlFiltro + ' option:selected').val()
        };
        var listarComentariosPromise = _listarComentariosPromise(model);

        $.when(listarComentariosPromise).then(function (listarComentariosResponse) {
            if (checkTimeout(listarComentariosResponse)) {
                if (listarComentariosResponse.success) {
                    _buildHtmlSeccionComentarios(listarComentariosResponse.data);
                    if (listarComentariosResponse.data.length < setting.cantidadCrecienteMostrar)
                        _unbindScroll();
                } else {
                    alert(listarComentariosResponse.message);
                }

                setting.esperarScroll = false;
                closeWaitingDialog();
            }
        });
    };

    var _buildHtmlSeccionComentarios = function (listaComentarios) {
        var htmlSeccionComentarios = '';
        var listaContenedoresEstrellasId = [];

        $.each(listaComentarios, function (index, item) {
            index++;
            var contenedorStarsId = 'puntuacion_usuario_visible-' + (index);
            listaContenedoresEstrellasId.push({ contenedorStarsId: contenedorStarsId, cantidadEstellas: item.Valorizado });

            htmlSeccionComentarios += '' + index;
            htmlSeccionComentarios += '<div class="content_comentario_usuario">';
            htmlSeccionComentarios += '<div class="foto_usuario_comentario">';
            htmlSeccionComentarios += '<img src="' + (item.URLFotoConsultora == null ? setting.urlImagenUsuarioDefault : item.URLFotoConsultora) + '" />';
            htmlSeccionComentarios += '</div>';
            htmlSeccionComentarios += '<div class="datos_usuario_comentario">';
            htmlSeccionComentarios += '<div class="' + contenedorStarsId + '"></div>';
            htmlSeccionComentarios += '<div class="nombre_usuario_comentario">' + item.NombreConsultora + '</div>';
            htmlSeccionComentarios += '<div class="fecha_comentario">' + item.FechaRegistroFormateada + '</div>';
            htmlSeccionComentarios += '</div>';
            htmlSeccionComentarios += '<div class="comentario_realizado_usuario">' + (item.Comentario ? item.Comentario : '') + '</div>';
            htmlSeccionComentarios += '</div>';
        });

        $(elements.contenedorComentarios).append(htmlSeccionComentarios);

        _renderizarEstrellasPorContenedor(listaContenedoresEstrellasId);
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

    var _renderizarEstrellasPorContenedor = function (listaContenedoresEstrellasId) {
        
        $.each(listaContenedoresEstrellasId, function (index, item) {
            
            $('.' + item.contenedorStarsId).rateYo({
                rating: item.cantidadEstellas,
                precision: 2,
                minValue: 1,
                maxValue: 5,
                starWidth: "19px",
                spacing: "5px",
                fullStar: true,
                readOnly: true
            })
        });

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

    var _listarComentariosPromise = function (model) {
        var d = $.Deferred();

        var promise = $.ajax({
            type: 'GET',
            url: (setting.urlListarComentarios),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: model,
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    var _initializer = function (parameters) {
        setting.urlListarComentarios = parameters.urlListarComentarios;
        setting.urlRegistrarComentario = parameters.urlRegistrarComentario;
        setting.urlImagenUsuarioDefault = parameters.urlImagenUsuarioDefault;
        _bindEvents();
        _bindRate();
        _bindScroll();
        _listarComentarios(setting.cantidadCrecienteMostrarInicial);
    };

    return {
        ini: function (parameters) {
            _initializer(parameters);
        }
    };
})();