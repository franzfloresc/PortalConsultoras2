﻿$(document).ready(function () {
    var CONS_TIPO_ORIGEN = {
        ESCRITORIO_HOME: 1,
        MOBILE_HOME: 2,
        ESCRITORIO_PEDIDO: 11,
        MOBILE_PEDIDO: 21
    };

    var CONS_TIPO_ACCION = {
        AGREGAR: 'AGREGAR',
        VERDETALLE: 'VERDETALLE',
        REGRESAR: 'REGRESAR'
    };

    var props = {
        UrlGetOfertaDelDia: 'Pedido/GetOfertaDelDia',
        UrlActual: window.location.href.toLowerCase(),
        UrlValidarStockEstrategia: 'Pedido/ValidarStockEstrategia',
        UrlAgregarProducto: 'Pedido/AgregarProductoZE',
        EsPaginaIntriga: (window.location.href.toLowerCase().indexOf("intriga") > 0),
        TipoOrigen: TipoOrigen
    };

    var elements = {
        ContenedorOfertaDelDiaMobile: '#OfertasDiaMobile',
        ContenedorEstrategiaTemplateCarrusel: '#estrategia-template_carrusel',
        ContenedorInternoSliderOfertaDelDiaMobile: '#content_oferta_dia_mobile',
        BtnAgregarMobile: '#btnAgregarMobile'
    };

    function CargarODD() {

        if (props.EsPaginaIntriga) {
            return false;
        }
        if (props.TipoOrigen == CONS_TIPO_ORIGEN.MOBILE_HOME) {
            CargarODDMobile();
        }
        if (props.TipoOrigen == CONS_TIPO_ORIGEN.ESCRITORIO_HOME) {

        }

    }

    function CargarODDMobile() {
        $.ajax({
            type: 'GET',
            url: baseUrl + props.UrlGetOfertaDelDia,
            cache: false,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                ResolverGetOfertaDelDiaResponse(response);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    function AsignarPosicionAListaOfertas(listaOfertas) {
        var posicion = 0;
        var nuevaListaOfertas = [];
        $.each(listaOfertas, function (index, value) {
            posicion++;
            value.Posicion = posicion;
            value.DescripcionOferta = ConstruirDescripcionOferta(value.DescripcionOferta.split('+'));
            nuevaListaOfertas.push(value);
        });

        return nuevaListaOfertas;
    }

    function ResolverGetOfertaDelDiaResponse(response) {
        var _data = response.data;
        $(elements.ContenedorOfertaDelDiaMobile).hide();
        _data.TotalOfertas = _data.ListaOfertas.length;
        _data.ListaOfertas = AsignarPosicionAListaOfertas(_data.ListaOfertas);
        SetHandlebars(elements.ContenedorEstrategiaTemplateCarrusel, _data, elements.ContenedorOfertaDelDiaMobile);
    }

    function ConstruirDescripcionOferta(arrDescripcion) {
        var descripcion = "";
        $.each(arrDescripcion, function (index, value) {
            value = value.replace("<br />", "");
            value = value.replace("<br/>", "");
            descripcion += "+ " + value + "<br />";
        });
        return descripcion;
    }

    function EsOddAgregarValido(btn, cantidad) {

        var contenedor = $(btn).parents(".row.contenedor-botones").siblings("#OfertasDiaMobile").find(".slick-active")
        var itemCampos = contenedor.find("[data-item-campos]");
        var limiteVenta = parseInt(itemCampos.find('.limite-venta-odd').val());
        var mesageLimiteVenta = 'Solo puede llevar ' + limiteVenta.toString() + ' unidades de este producto.';
        var cuv2 = itemCampos.find('.cuv2-odd').val();
        var tipoEstrategiaID = itemCampos.find('.tipoestrategia-id-odd').val();

        if (ReservadoOEnHorarioRestringido()) {
            CerrarLoad();
            return false;
        }

        if (!CheckCountdownODD()) {
            AbrirMensaje('La Oferta del Día se terminó');
            CerrarLoad();
            return false;
        }

        if (cantidad <= 0) {
            AbrirMensaje("Ingrese la cantidad a solicitar");
            CerrarLoad();
            return false;
        }

        if (cantidad > limiteVenta) {
            AbrirMensaje(mesageLimiteVenta);
            CerrarLoad();
            return false;
        }

        var cqty = getQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID);
        if (cqty > 0) {
            var tqty = cqty + cantidad;
            if (tqty > limiteVenta) {
                AbrirMensaje(mesageLimiteVenta);
                CerrarLoad();
                return false;
            }
        }

        return true;
    }

    function ObtenerProducto(itemCampos, cantidad) {

        var origenPedidoWeb = parseInt(itemCampos.find('.origenPedidoWeb-odd').val());
        if (typeof origenPagina == 'undefined') origenPedidoWeb = 1990 + origenPedidoWeb;
        else if (origenPagina == 1) origenPedidoWeb = 1190 + origenPedidoWeb;
        else if (origenPagina == 2) origenPedidoWeb = 1290 + origenPedidoWeb;

        var producto = {
            MarcaID: itemCampos.find('.marca-id-odd').val(),
            CUV: itemCampos.find('.cuv2-odd').val(),
            PrecioUnidad: itemCampos.find('.precio-odd').val(),
            Descripcion: itemCampos.find('.nombre-odd').val(),
            Cantidad: cantidad,
            IndicadorMontoMinimo: itemCampos.find('.indmonto-min-odd').val(),
            TipoOferta: itemCampos.find('.tipoestrategia-id-odd').val(),
            ClienteID_: '-1',
            tipoEstrategiaImagen: itemCampos.find('.teimagenmostrar-odd').val() || 0,
            OrigenPedidoWeb: origenPedidoWeb
        };

        return producto;
    }

    function OddAgregar(btn) {
        AbrirLoad();
        var contenedor = $(btn).parents(".row.contenedor-botones").siblings("#OfertasDiaMobile").find(".slick-active")
        var itemCampos = contenedor.find("[data-item-campos]");
        var cantidad = parseInt($(btn).parents(".row.contenedor-botones").find("#txtCantidad").val());

        if (!EsOddAgregarValido(btn, cantidad)) {
            return false;
        }
        
        var producto = ObtenerProducto(itemCampos, cantidad);

        var promiseValidarStockEstrategia = ValidarStockEstrategia(producto);
        $.when(promiseValidarStockEstrategia).then(function (response) {
            if (!response.result) {
                AbrirMensaje(response.message);
                CerrarLoad();
                return false;
            }
            var promiseAgregarProducto = AgregarProducto(producto);
            $.when(promiseAgregarProducto).then(function (responseAgregarProd) {
                if (!checkTimeout(responseAgregarProd)) {
                    CerrarLoad();
                    return false;
                }

                if (!responseAgregarProd.success) {
                    AbrirMensaje(responseAgregarProd.message);
                    CerrarLoad();
                    return false;
                }

                CargarCantidadProductosPedidos();
                CerrarLoad();
                AbrirMensaje('Producto agregado satisfactoriamente', 'ÉXITO', null, 2);
            });
        });

    }

    function CheckCountdownODD() {
        var ok = true;
        $.ajax({
            type: 'GET',
            url: baseUrl + 'Pedido/GetOfertaDelDia',
            async: false,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        var _data = response.data;
                        var tq = _data.TeQuedan;

                        if (tq.TotalSeconds <= 0)
                            ok = false;
                    }
                }
            },
            error: function (err) {
                console.log(err);
            }
        });

        return ok;
    };

    function ValidarStockEstrategia(producto) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: baseUrl + props.UrlValidarStockEstrategia,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(producto),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    function AgregarProducto(producto) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: baseUrl + props.UrlAgregarProducto,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(producto),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    function ResolverPromiseValidarStockEstrategia(response) {
        if (!response.result) {
            AbrirMensaje(response.message);
            CerrarLoad();
            return false;
        } else {
            var promiseAgregarProducto = AgregarProducto(producto);
            $.when(promiseAgregarProducto).then(
                ResolverPromiseAgregarProducto(response), 
                ResolverPromiseAgregarProductoError(response)
             );
        }
    }

    function ResolverPromiseAgregarProducto(response) {
        if (!checkTimeout(response)) {
            CerrarLoad();
            return false;
        }

        if (!response.success) {
            AbrirMensaje(response.message);
            CerrarLoad();
            return false;
        }

        CargarCantidadProductosPedidos();
        CerrarLoad();
    }

    function ResolverPromiseAgregarProductoError(response) {
        if (checkTimeout(response)) {
            closeWaitingDialog();
        }
    }

    function ResolverPromiseValidarStockEstrategiaEnError(response) {
        if (checkTimeout(response)) {
            closeWaitingDialog();
        }
    }

    $(elements.ContenedorInternoSliderOfertaDelDiaMobile).click(function () {
        $(elements.ContenedorOfertaDelDiaMobile).show();
        $(elements.ContenedorOfertaDelDiaMobile + '.slick-initialized').slick('unslick');
        $(elements.ContenedorOfertaDelDiaMobile).slick({
            dots: false,
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a style="display: block;left: 0;margin-left: -0%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_compra.png")" alt="" /></a>',
            nextArrow: '<a style="display: block;right: 0;margin-right: -0%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_compra.png")" alt="" /></a>'
        });
        $(elements.ContenedorOfertaDelDiaMobile).slick('slickGoTo', 0);
    });

    $("body").on("click", elements.BtnAgregarMobile, function (e) {
        var accion = $(this).attr("data-odd-accion").toUpperCase();

        if (accion == CONS_TIPO_ACCION.AGREGAR) {
            OddAgregar(this);
        }
    });

    CargarODD();
});



// 1: escritorio Home    11 : escritorio Pedido 
// 2: mobile  Home       21 : mobile pedido
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";

// Cuarto Dígito
// 0. Sin popUp         1. Con popUp
var conPopup = conPopup || "";

var origenRetorno = $.trim(origenRetorno);

$(document).ready(function () {
    ODDCargarEventos();
});

function ODDCargar() {
    if (($('#OfertaDelDia') || new Array()).length == 0)
        return false;

    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetOfertaDelDia',
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            $('#OfertaDelDia').hide();

            var URLactual = window.location.href.toLowerCase();
            var urlIntriga = URLactual.indexOf("intriga");

            if (urlIntriga > 0)
                return false;

            if (!response.success)
                return false;

            var _data = response.data;
            var tq = _data.TeQuedan;
            if (tq.TotalSeconds <= 0)
                return false;

            //_data.ListaOfertas = _data.ListaOfertas.splice(0, 2);

            var lista = _data.ListaOfertas || new Array();
            _data.CantidadProducto = lista.length;

            if (_data.CantidadProducto <= 0)
                return false;

            _data.Simbolo = vbSimbolo;
            _data.ClassDimension = _data.CantidadProducto < 3 ? "content_780_ODD" : "";
            _data.TextoVerDetalle = _data.CantidadProducto > 1 ? "VER MÁS OFERTAS" : "VER DETALLE";
            _data.UsuarioNombre = $.trim(usuarioNombre).toUpperCase();
            console.log(_data);
            var idOdd = '#OfertaDelDia';
            SetHandlebars("#ofertadeldia-template", _data, idOdd);

            $(idOdd + ' [data-odd-tipoventana="detalle"]').hide();
            $(idOdd + ' [data-odd-tipoventana="carrusel"]').hide();

            if (_data.CantidadProducto == 1) {
                $(idOdd + ' [data-odd-accion="regresar"]').hide();
                //$(idOdd + ' [data-odd-texto="cliente"]').hide();
                $(idOdd + ' [data-odd-tipoventana="detalle"]').show();
            }
            else {
                $(idOdd + ' [data-odd-accion="regresar"]').show();
                //$(idOdd + ' [data-odd-texto="cliente"]').show();
                $(idOdd + ' [data-odd-tipoventana="carrusel"]').show();
            }

            $('#OfertaDelDia').css('background', 'url("' + _data.ImagenFondo1 + '") repeat-x');
            $('#banner-odd').css('background-color', _data.ColorFondo1);
            $('#PopOfertaDia').css('background', 'url("' + _data.ImagenFondo2 + '") no-repeat');
            $('#PopOfertaDia').css('background-color', _data.ColorFondo2);
            //$('#PopOfertaDia').css('background-color', "red");

            $('#OfertaDelDia').show();
            $('#PopOfertaDia').show();

            if (_data.CantidadProducto > 3) {
                $('#PopOfertaDia [data-odd-tipoventana="carrusel"]').show();
                $('#divOddCarrusel.slick-initialized').slick('unslick');
                $('#divOddCarrusel').not('.slick-initialized').slick({
                    infinite: true,
                    vertical: false,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    autoplay: false,
                    speed: 260,
                    prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_compra.png")" alt="" /></a>',
                    nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_compra.png")" alt="" /></a>'
                });
                $('#PopOfertaDia [data-odd-tipoventana="carrusel"]').hide();
            }
            else {
                var wc = $('#divOddCarrusel').width();
                var witem = ((wc) / _data.CantidadProducto);
                var witemc = $($('#divOddCarrusel [data-item]>div').get(0)).innerWidth();
                witemc = (witem - witemc) / 2;
                $('#divOddCarrusel [data-item]').css("width", witem + "px");
                $('#divOddCarrusel [data-item]>div').css("margin-left", witemc + "px");
                $('#divOddCarrusel [data-item]>div').css("margin-right", witemc + "px");
            }
            if (_data.CantidadProducto > 1) {
                $('#PopOfertaDia [data-odd-tipoventana="detalle"]').show();
                $('#divOddCarruselDetalle.slick-initialized').slick('unslick');
                $('#divOddCarruselDetalle').not('.slick-initialized').slick({
                    infinite: true,
                    vertical: false,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    autoplay: false,
                    speed: 260,
                    prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_compra.png")" alt="" /></a>',
                    nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_compra.png")" alt="" /></a>'
                });
                $('#divOddCarruselDetalle').slick('slickGoTo', 0);
                $('#PopOfertaDia [data-odd-tipoventana="detalle"]').hide();
            }

            $('#PopOfertaDia').hide();

            LayoutHeader();

            var clock = $('.clock').FlipClock(tq.TotalSeconds, {
                clockFace: 'HourlyCounter',
                countdown: true
            });

        },
        error: function (err) {
            console.log(err);
        }
    });
};

function ODDCargarEventos() {
    $("body").on("click", "#OfertaDelDia [data-odd-accion]", function (e) {
        var accion = $(this).attr("data-odd-accion");
        if (accion == "veroferta") {
            if (showDisplayODD == 0) {
                var cantidad = parseInt($(this).attr("data-odd-cantidad"));
                if (cantidad > 3) {
                    var posicion = "0";
                    $('#divOddCarrusel').slick('slickGoTo', posicion);
                    $('#divOddCarruselDetalle').slick('slickGoTo', posicion);
                }
                if (cantidad == 1) {
                    $('#OfertaDelDia [data-odd-tipoventana="detalle"]').show();
                    $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').hide();
                }
                else {
                    $('#OfertaDelDia [data-odd-tipoventana="detalle"]').hide();
                    $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').show();
                }
                $('#PopOfertaDia').slideDown();
                $('.circulo_hoy span').html('-');
                showDisplayODD = 1;
            }
            else {
                $('#PopOfertaDia').slideUp();
                $('.circulo_hoy span').html('+');
                showDisplayODD = 0;
            }
        }
        else if (accion == "verdetalle") {
            $('#OfertaDelDia [data-odd-tipoventana="detalle"]').show();
            $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').hide();
            var posicion = $(this).parents("[data-item]").attr("data-item-position");
            $('#divOddCarruselDetalle').slick('slickGoTo', posicion);
            // asignar valores del ver detalle
        }
        else if (accion == "regresar") {
            $('#OfertaDelDia [data-odd-tipoventana="detalle"]').hide();
            $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').show();
        }
        else if (accion == "agregar") {
            ADDAgregar(this);
        }
    });
};

function ADDAgregar(btn) {

    waitingDialog();

    if (ReservadoOEnHorarioRestringido()) {
        closeWaitingDialog();
        return false;
    }

    if (!checkCountdownODD()) {
        alert_msg_pedido('La Oferta del Día se termino');
        closeWaitingDialog();
        return false;
    }

    var item = $(btn).parents("[data-item]");
    var itemCampos = item.find("[data-item-campos]");
    var cantidad = parseInt(item.find('.txtcantidad-odd').val());
    if (cantidad <= 0) {
        alert_msg_pedido("Ingrese la cantidad a solicitar");
        closeWaitingDialog();
        return false;
    }

    var limiteVenta = parseInt(itemCampos.find('.limite-venta-odd').val());
    var msg1 = 'Solo puede llevar ' + limiteVenta.toString() + ' unidades de este producto.';
    if (cantidad > limiteVenta) {
        $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
        $('#dialog_ErrorMainLayout').show();
        closeWaitingDialog();
        return false;
    }

    var tipoEstrategiaID = itemCampos.find('.tipoestrategia-id-odd').val();
    var estrategiaID = itemCampos.find('.estrategia-id-odd').val();
    var marcaID = itemCampos.find('.marca-id-odd').val();
    var cuv2 = itemCampos.find('.cuv2-odd').val();
    var flagNueva = itemCampos.find('.flagnueva-odd').val();
    var precio = itemCampos.find('.precio-odd').val();
    var descripcion = itemCampos.find('.nombre-odd').val();
    var indMontoMinimo = itemCampos.find('.indmonto-min-odd').val();
    var teImagenMostrar = itemCampos.find('.teimagenmostrar-odd').val();
    //var objImg = itemCampos.find('#imagen-odd').val();
    var origenPedidoWeb = parseInt(itemCampos.find('.origenPedidoWeb-odd').val());
    if (typeof origenPagina == 'undefined') origenPedidoWeb = 1990 + origenPedidoWeb;
    else if (origenPagina == 1) origenPedidoWeb = 1190 + origenPedidoWeb;
    else if (origenPagina == 2) origenPedidoWeb = 1290 + origenPedidoWeb;

    var cqty = getQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID);
    if (cqty > 0) {
        var tqty = cqty + cantidad;
        if (tqty > limiteVenta) {
            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
            $('#dialog_ErrorMainLayout').show();
            closeWaitingDialog();
            return false;
        }
    }

    var obj = ({
        MarcaID: marcaID,
        CUV: cuv2,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indMontoMinimo,
        TipoOferta: tipoEstrategiaID,
        ClienteID_: '-1',
        tipoEstrategiaImagen: teImagenMostrar || 0,
        OrigenPedidoWeb: origenPedidoWeb
    });


    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                alert_msg_pedido(datos.message);
                closeWaitingDialog();
                return false;
            }
            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'Pedido/AgregarProductoZE',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(obj),
                async: true,
                success: function (data) {
                    if (!checkTimeout(data)) {
                        closeWaitingDialog();
                        return false;
                    }

                    if (!data.success) {
                        messageInfoError(data.message);
                        closeWaitingDialog();
                        return false;
                    }

                    agregarProductoAlCarrito(btn);

                    waitingDialog();
                    if (typeof origenPagina !== 'undefined') {
                        MostrarBarra(data, '1');
                        ActualizarGanancia(data.DataBarra);
                        TagManagerClickAgregarProducto();
                    }

                    CargarResumenCampaniaHeader(true);
                    TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv2);
                    closeWaitingDialog();

                    //if (tipo == 2) {
                    //    $('#PopOfertaDia').slideUp();
                    //    $('.circulo_hoy span').html('+');
                    //    $('#txtcantidad-odd').val('1');
                    //}

                    if (typeof origenPagina !== 'undefined') {
                        if (origenPagina == 2) {
                            CargarDetallePedido();
                        }
                    }
                },
                error: function (data, error) {
                    if (checkTimeout(data)) {
                        closeWaitingDialog();
                    }
                }
            });

        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
}

function closeOfertaDelDia() {
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/CloseOfertaDelDia',
        cache: false,
        success: function (response) {
            if (response.success) {
                $('#OfertaDelDia').hide();

                LayoutHeader();
            }
        },
        error: function (err) {
            console.log(err);
        }
    });
};

function addOfertaDelDiaPedido(tipo) {

    var tipoEstrategiaID = $('#tipoestrategia-id-odd').val();
    var estrategiaID = $('#estrategia-id-odd').val();
    var marcaID = $('#marca-id-odd').val();
    var cuv2 = $('#cuv2-odd').val();
    var limiteVenta = parseInt($('#limite-venta-odd').val());
    var flagNueva = $('#flagnueva-odd').val();
    var precio = $('#precio-odd').val();
    var descripcion = $('#nombre-odd').val();
    var indMontoMinimo = $('#indmonto-min-odd').val();
    var teImagenMostrar = $('#teimagenmostrar-odd').val();
    var cantidad = (tipo == 1) ? 1 : parseInt($('#txtcantidad-odd').val());
    var origenPedidoWeb = 0;
    var msg1 = 'Solo puede llevar ' + limiteVenta.toString() + ' unidades de este producto.';

    if (tipo == 2 && cantidad <= 0) {
        alert_msg_pedido("Ingrese la cantidad a solicitar");
        return;
    }

    if (tipo == 1) {
        if (typeof origenPagina == 'undefined') origenPedidoWeb = 1991;
        else if (origenPagina == 1) origenPedidoWeb = 1191;
        else if (origenPagina == 2) origenPedidoWeb = 1291;
    }
    else {
        if (typeof origenPagina == 'undefined') origenPedidoWeb = 1992;
        else if (origenPagina == 1) origenPedidoWeb = 1192;
        else if (origenPagina == 2) origenPedidoWeb = 1292;

        if (cantidad > limiteVenta) {
            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
            $('#dialog_ErrorMainLayout').show();
            return;
        }
    }

    if (!checkCountdownODD()) {
        alert_msg_pedido('La Oferta del Día se termino');
        return false;
    }

    var cqty = getQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID);
    if (cqty > 0) {
        var tqty = cqty + cantidad;
        if (tqty > limiteVenta) {
            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
            $('#dialog_ErrorMainLayout').show();
            return;
        }
    }

    if (ReservadoOEnHorarioRestringido())
        return false;

    var objImg = (tipo == 1) ? $('#img-banner-odd') : $('#img-display-odd');

    var obj = ({
        MarcaID: marcaID,
        CUV: cuv2,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indMontoMinimo,
        TipoOferta: tipoEstrategiaID,
        ClienteID_: '-1',
        tipoEstrategiaImagen: teImagenMostrar || 0,
        OrigenPedidoWeb: origenPedidoWeb
    });

    waitingDialog({});

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ValidarStockEstrategia',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                alert_msg_pedido(datos.message);
                closeWaitingDialog();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'Pedido/AgregarProductoZE',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(obj),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            closeWaitingDialog();
                            return false;
                        }

                        if (!data.success) {
                            messageInfoError(data.message);
                            closeWaitingDialog();
                            return false;
                        }

                        waitingDialog({});
                        if (typeof origenPagina !== 'undefined') {
                            MostrarBarra(data, '1');
                            ActualizarGanancia(data.DataBarra);
                            TagManagerClickAgregarProducto();
                        }

                        CargarResumenCampaniaHeader(true);
                        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv2);
                        closeWaitingDialog();

                        if (tipo == 2) {
                            $('#PopOfertaDia').slideUp();
                            $('.circulo_hoy span').html('+');
                            $('#txtcantidad-odd').val('1');
                        }

                        if (typeof origenPagina !== 'undefined') {
                            if (origenPagina == 2) {
                                CargarDetallePedido();
                            }
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            closeWaitingDialog();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
            }
        }
    });
};

// mobile
function CargarEventosODD() {
    $("#content_oferta_dia_mobile").click(function () {
        $('#txtCantidad').val('1');
        $('body').css({ 'overflow-x': 'hidden' });
        $('body').css({ 'overflow-y': 'hidden' });
        $('#pop_oferta_mobile').toggle('slide', { direction: 'Right' }, 500);
    });

    $(".header_pop_oferta").click(function () {
        $('body').css({ 'overflow-y': 'scroll' });
        $('#pop_oferta_mobile').toggle('slide', { direction: 'right' }, 500);
    });
};

function closeBannerPL20() {
    $.ajax({
        type: 'GET',
        url: urlCloseBannerPL20,
        cache: false,
        success: function (response) {
            if (checkTimeout(data)) {
                if (response.success) {
                    $('#content_slider_banner').hide();
                    $('#contentmobile').css('margin-top', '');
                }
            }
        },
        error: function (err) {
            if (checkTimeout(data)) {
                console.log(err);
            }
        }
    });
};

function addOfertaDelDiaPedido(popup) {
    var tipoEstrategiaID = $('#tipoestrategia-id-odd').val();
    var estrategiaID = $('#estrategia-id-odd').val();
    var flagNueva = $('#flag-nueva-odd').val();
    var teImagenMostrar = $('#teimagenmostrar-odd').val();
    var cantidad = $('#txtCantidad').val();//$("#txtCantidadZE").val();
    var cantidadLimite = $('#limite-venta-odd').val();//$("#txtCantidadZE").attr("est-cantidad");
    var cuv = $('#cuv2-odd').val();//$("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $('#marca-id-odd').val();//$("#txtCantidadZE").attr("est-marcaID");
    var precio = $('#precio-odd').val();//$("#txtCantidadZE").attr("est-precio2");
    var descripcion = $('#nombre-odd').val();//$("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $('#indmonto-min-odd').val();//$("#txtCantidadZE").attr("est-montominimo");
    var origenPedidoWeb = 0;

    if (typeof origenPagina == 'undefined') origenPedidoWeb = 2991; // general
    else if (origenPagina == 1) origenPedidoWeb = 2191// home
    else if (origenPagina == 2) origenPedidoWeb = 2291; // pedido

    var intCantidad = parseInt(cantidad);
    var intLimiteVenta = parseInt(cantidadLimite);
    var msg1 = 'Solo puede llevar ' + cantidadLimite + ' unidades de este producto.';

    if (intCantidad > intLimiteVenta) {
        $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(msg1);
        $('#popupInformacionSB2Error').show();
        return;
    }

    if (!checkCountdownODD()) {
        messageInfoMalo('La Oferta del Día se termino', '');
        return false;
    }

    var cqty = getQtyPedidoDetalleByCuvODD(cuv, tipoEstrategiaID);
    if (cqty > 0) {
        var tqty = parseInt(cqty) + intCantidad;
        if (parseInt(tqty) > intLimiteVenta) {
            $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(msg1);
            $('#popupInformacionSB2Error').show();
            return;
        }
    }

    if (ReservadoOEnHorarioRestringido())
        return false;

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: tipoEstrategiaID,
        tipoEstrategiaImagen: teImagenMostrar || 0,
        OrigenPedidoWeb: origenPedidoWeb
    });

    ShowLoading();

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                messageInfo(datos.message);
                CloseLoading();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: urlPedidoInsertZe,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            CloseLoading();
                            return false;
                        }

                        if (data.success != true) {
                            messageInfoError(data.message);
                            CloseLoading();
                            return false;
                        }

                        ShowLoading();

                        ActualizarGanancia(data.DataBarra);

                        TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);

                        if (typeof origenPagina !== 'undefined') {
                            if (origenPagina == 1) {    // home
                                TagManagerClickAgregarProducto();
                            }
                        }

                        CloseLoading();

                        $('body').css({ 'overflow-y': 'scroll' });
                        var effect = 'slide';
                        var options = { direction: 'right' };
                        var duration = 500;

                        $('#pop_oferta_mobile').toggle(effect, options, duration);
                        $('#txtCantidad').val('1');

                        if (typeof origenPagina !== 'undefined') {
                            if (origenPagina == 2) {    // pedido
                                CargarPedido();
                            }
                        }

                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CloseLoading();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
            }
        }
    });
};

function checkCountdownODD() {
    var ok = true;
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetOfertaDelDia',
        //data: '{}',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    var _data = response.data;
                    var tq = _data.TeQuedan;

                    if (tq.TotalSeconds <= 0)
                        ok = false;
                }
            }
        },
        error: function (err) {
            console.log(err);
        }
    });

    return ok;
};

function getQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID) {
    var qty = 0;
    var obj = { cuv: cuv2, tipoEstrategiaID: tipoEstrategiaID };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/GetQtyPedidoDetalleByCuvODD',
        data: JSON.stringify(obj),
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    qty = parseInt(response.cantidad);
                }
            }
        },
        error: function (err) {
            console.log(err);
        }
    });

    return qty;
};