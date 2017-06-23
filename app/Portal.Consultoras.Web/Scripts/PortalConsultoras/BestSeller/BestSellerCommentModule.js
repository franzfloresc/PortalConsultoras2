var bestSellerCommentModule = (function () {
    "use strict"

    var CONTANSTES_ = {
        
    };

    var elements = {
        btnAgregarComentario: 'div.texto_agregarComentarios',
        btnCancelarComentario: 'a.cancelar_comentario',
        btnEnviarComentario: 'a.enviar_comentario_Seller',
        btnCerrarContenedorConfirmacionComentario: 'a.btn_cerrar_comentario',
        contenedorValoracion: 'div.contentValoracion',
        contenedorConfirmacionComentario: 'div.content_confirmacion_comentario'
    };

    var setting = {
        urlListarComentarios: ''
    };

    var lista = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnAgregarComentario, function () {
            _mostrarContenedorValoracion();
        });

        $(document).on("click", elements.btnCancelarComentario, function () {
            _ocultarContenedorValoracion();
        });

        $(document).on("click", elements.btnEnviarComentario, function () {
            _mostrarContenedorConfirmacionComentario();
        });

        $(document).on("click", elements.btnCerrarContenedorConfirmacionComentario, function () {
            _ocultarContenedorConfirmacionComentario();
        });
    }

    var _setDefaultValues = function () { };

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

    var _initializer = function (parameters) {
        _bindEvents();
    };

    return {
        ini: function (parameters) {
            _initializer(parameters);
        }
    };
})();