
// 1: escritorio Home    11 : escritorio Pedido 
// 2: mobile  Home       21 : mobile pedido
var tipoOrigenEstrategia = tipoOrigenEstrategia || "";

// Cuarto Dígito
// 0. Sin popUp         1. Con popUp
var conPopup = conPopup || "";

var origenRetorno = $.trim(origenRetorno);

$(document).ready(function () {

});

function loadOfertaDelDia() {
    if (($('#OfertaDelDia') || new Array()).length == 0)
        return false;
    
    $.ajax({
        type: 'GET',
        url: baseUrl + 'Pedido/GetOfertaDelDia',
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (!response.success)
                return false;
            
            var _data = response.data;
            SetHandlebars("#ofertadeldia-template", _data, '#OfertaDelDia');
            var tq = _data.TeQuedan;

            $('#OfertaDelDia').hide();
            if (tq.TotalSeconds > 0) {
                var URLactual = window.location.href;
                var urlIntriga = URLactual.indexOf("Intriga");

                if (urlIntriga <= 0) {
                    $('#OfertaDelDia').show();
                }

                $('#OfertaDelDia').css('background', 'url("' + _data.ImagenFondo1 + '") repeat-x');
                $('#banner-odd').css('background-color', _data.ColorFondo1);
                $('#img-banner-odd').attr('src', _data.ImagenBanner);
                $('#img-solohoy-odd').attr('src', _data.ImagenSoloHoy);
                $('#PopOfertaDia').css('background', 'url("' + _data.ImagenFondo2 + '") no-repeat');
                $('#PopOfertaDia').css('background-color', _data.ColorFondo2);
                $('#img-display-odd').attr('src', _data.ImagenDisplay);

                var obj1 = $('#OfertaDelDia').find('.descripcion_set_ofertaDia');
                obj1.html(obj1.text());

                $('.content_slider_home').css('margin-top', '160px');
                if (MostrarODD == "True") {
                    $('.ubicacion_web ').css('margin-top', '85px');
                } else {
                    $('.ubicacion_web ').css('margin-top', '185px');
                }

                var intv1 = setInterval(function () {
                    if ($('#OfertaDelDia:visible').length > 0) {

                        if ($('.content_banner_intriga').length > 0) {
                            $('.ubicacion_web ').css('margin-top', '162px');
                        }
                        else {
                            $('.ubicacion_web ').css('margin-top', '185px');
                        }

                        clearInterval(intv1);
                    }
                }, 300);

                var clock = $('.clock').FlipClock(tq.TotalSeconds, {
                    clockFace: 'HourlyCounter',
                    countdown: true
                });

                $('.btn_detalle_hoy').on('click', function () {
                    if (showDisplayODD == 0) {
                        $('#PopOfertaDia').slideDown();
                        $('.circulo_hoy span').html('-');

                        showDisplayODD = 1;
                    }
                    else {
                        $('#PopOfertaDia').slideUp();
                        $('.circulo_hoy span').html('+');

                        showDisplayODD = 0;
                    }
                });
            }

        },
        error: function (err) {
            console.log(err);
        }
    });
};

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
