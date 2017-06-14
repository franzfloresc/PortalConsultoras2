$(document).ready(function () {
    window.OfertaDelDia = window.OfertaDelDia || {};

    var self = window.OfertaDelDia;

    var CONS_TIPO_ORIGEN = {
        ESCRITORIO_HOME: 1,
        MOBILE_HOME: 2,
        ESCRITORIO_PEDIDO: 11,
        MOBILE_PEDIDO: 21
    };

    var CONS_TIPO_ACCION = {
        AGREGAR: 'AGREGAR',
        VERDETALLE: 'VERDETALLE',
        REGRESAR: 'REGRESAR',
        VEROFERTA: 'VEROFERTA'
    };

    var props = {
        UrlGetOfertaDelDia: 'Pedido/GetOfertaDelDia',
        UrlActual: window.location.href.toLowerCase(),
        UrlValidarStockEstrategia: 'Pedido/ValidarStockEstrategia',
        UrlAgregarProducto: 'Pedido/AgregarProductoZE',
        EsPaginaIntriga: (window.location.href.toLowerCase().indexOf("intriga") > 0),
        TipoOrigenPantallaODD: TipoOrigenPantallaODD
    };

    var elements = {
        ContenedorOfertaDelDiaMobile: '#OfertasDiaMobile',
        ContenedorEstrategiaTemplateCarrusel: '#estrategia-template_carrusel',
        ContenedorInternoSliderOfertaDelDiaMobileHome: '#content_oferta_dia_mobile',
        ContenedorInternoSliderOfertaDelDiaMobile: '.BloqueOfertaDiaHeader',
        BtnAgregarMobile: '#btnAgregarMobile',
        TxtCantidadMobile: '#txtCantidad'
    };

    self.CargarODD = function() {

        if (props.EsPaginaIntriga) {
            return false;
        }
        if (props.TipoOrigenPantallaODD == CONS_TIPO_ORIGEN.MOBILE_HOME) {
            CargarODDMobile();
        }
        if (props.TipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_HOME) {
            self.CargarODDEscritorio();
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

    self.CargarODDEscritorio = function () {
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

                if (!response.success)
                    return false;

                var _data = response.data;
                var tq = _data.TeQuedan;
                if (tq.TotalSeconds <= 0)
                    return false;

                var lista = _data.ListaOfertas || new Array();
                _data.CantidadProductos = lista.length;

                if (_data.CantidadProductos <= 0)
                    return false;

                _data.Simbolo = vbSimbolo;
                _data.ClassDimension = _data.CantidadProductos < 3 ? "content_780_ODD" : "";
                _data.TextoVerDetalle = _data.CantidadProductos > 1 ? "VER MÁS OFERTAS" : "VER OFERTA";
                _data.UsuarioNombre = $.trim(usuarioNombre).toUpperCase();
                var idOdd = '#OfertaDelDia';
                _data.ListaOfertas = AsignarClaseCssAPalabraGratisDesktop(_data.ListaOfertas);
                SetHandlebars("#ofertadeldia-template", _data, idOdd);

                $(idOdd + ' [data-odd-tipoventana="detalle"]').hide();
                $(idOdd + ' [data-odd-tipoventana="carrusel"]').hide();

                if (_data.CantidadProductos == 1) {
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

                if (_data.CantidadProductos > 3) {
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
                    var witem = ((wc) / _data.CantidadProductos);
                    var witemc = $($('#divOddCarrusel [data-item]>div').get(0)).innerWidth();
                    witemc = (witem - witemc) / 2;
                    $('#divOddCarrusel [data-item]').css("width", witem + "px");
                    $('#divOddCarrusel [data-item]>div').css("margin-left", witemc + "px");
                    $('#divOddCarrusel [data-item]>div').css("margin-right", witemc + "px");
                }
                if (_data.CantidadProductos > 1) {
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
    }

    function AsignarPosicionAListaOfertas(listaOfertas) {
        var posicion = 0;
        var nuevaListaOfertas = [];
        $.each(listaOfertas, function (index, value) {
            posicion++;
            value.Posicion = posicion;
            value.DescripcionOferta = (value.DescripcionOferta == "" || value.DescripcionOferta == null) ? "" : ConstruirDescripcionOferta(value.DescripcionOferta.split('+'));
            nuevaListaOfertas.push(value);
        });

        return nuevaListaOfertas;
    }

    function ResolverGetOfertaDelDiaResponse(response) {
        if (response.success) {
            var _data = response.data;

            var tq = _data.TeQuedan;
            if (tq.TotalSeconds <= 0)
                return false;

            var clock = $('.clock').FlipClock(tq.TotalSeconds, {
                clockFace: 'HourlyCounter',
                countdown: true
            });

            $(elements.ContenedorOfertaDelDiaMobile).hide();
            _data.CantidadProductos = _data.ListaOfertas.length;
            _data.TextoVerDetalle = _data.CantidadProductos > 1 ? "VER MÁS OFERTAS" : "VER OFERTA";
            _data.ListaOfertas = AsignarPosicionAListaOfertas(_data.ListaOfertas);
            _data.ListaOfertas = AsignarClaseCssAPalabraGratisMobile(_data.ListaOfertas);
            SetHandlebars(elements.ContenedorEstrategiaTemplateCarrusel, _data, elements.ContenedorOfertaDelDiaMobile);
        }
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

        if (cantidad <= 0 || isNaN(cantidad)) {
            AbrirMensaje("Ingrese la cantidad a solicitar");
            CerrarLoad();
            return false;
        }

        if (cantidad > limiteVenta) {
            ResetearCantidadEnMobile();
            AbrirMensaje(mesageLimiteVenta);
            CerrarLoad();
            return false;
        }

        var cqty = GetQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID);
        if (cqty > 0) {
            var tqty = cqty + cantidad;
            if (tqty > limiteVenta) {
                ResetearCantidadEnMobile();
                AbrirMensaje(mesageLimiteVenta);
                CerrarLoad();
                return false;
            }
        }

        return true;
    }

    function ObtenerProducto(itemCampos, cantidad) {        
        var esMobile = ViewBagEsMobile == 1 ? 0 : 1000; /*1 Desktop, 2 Mobile*/

        var origenPedidoWeb = parseInt(itemCampos.find('.origenPedidoWeb-odd').val());
        if (typeof origenPagina == 'undefined') origenPedidoWeb = 1990 + origenPedidoWeb + esMobile;
        else if (origenPagina == 1) origenPedidoWeb = 1190 + origenPedidoWeb + esMobile;
        else if (origenPagina == 2) origenPedidoWeb = 1290 + origenPedidoWeb + esMobile;

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

    function OddAgregarMobile(btn) {
        AbrirLoad();
        var contenedor = $(btn).parents(".row.contenedor-botones").siblings("#OfertasDiaMobile").find(".slick-active")
        var itemCampos = contenedor.find("[data-item-campos]");
        var valorCantidad = $(btn).parents(".row.contenedor-botones").find(elements.TxtCantidadMobile).val().trim();
        var cantidad = parseInt(valorCantidad == '' ? 0 : valorCantidad);

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
                ResetearCantidadEnMobile();

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

    function OddAgregar(btn) {
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
        var valorCantidad = item.find('.txtcantidad-odd').val().trim();
        var cantidad = parseInt(valorCantidad == '' ? 0 : valorCantidad);
        if (cantidad <= 0 || isNaN(cantidad)) {
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
            ResetearCantidadesDelPopup();
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

        var cqty = GetQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID);
        if (cqty > 0) {
            var tqty = cqty + cantidad;
            if (tqty > limiteVenta) {
                $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
                $('#dialog_ErrorMainLayout').show();
                closeWaitingDialog();
                ResetearCantidadesDelPopup();
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

                        MarcarProductoComoAgregado(btn, item);

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

                        if (typeof origenPagina !== 'undefined') {
                            if (origenPagina == 2) {
                                CargarDetallePedido();
                            }
                        }

                        ResetearCantidadesDelPopup();
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

    function MarcarProductoComoAgregado(btn, item) {
        var esCabecera = ($(btn).attr('data-odd-cabecera-position') != undefined || $(btn).attr('data-odd-cabecera-position') != null);
        var positionOddCabecera = 0;
        if (esCabecera) {
            positionOddCabecera = $(btn).attr('data-odd-cabecera-position');
            $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').find('[data-item-position="' + positionOddCabecera + '"]').find(".product-add").css("display", "block");
        } else {
            var perteneceContenedorDetalle = $(btn).parents('div [data-odd-tipoventana="detalle"]').length > 0;
            if (perteneceContenedorDetalle) {
                var posicion = $(btn).parents("[data-item]").attr("data-item-position");
                $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').find('[data-item-position="' + posicion + '"]').find(".product-add").css("display", "block");
            } else
                $(item).find(".product-add").css("display", "block");
        }
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

    function GetQtyPedidoDetalleByCuvODD(cuv2, tipoEstrategiaID) {
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

    function MostrarContenedorOverOfertaDelDia() {
        $('#txtCantidad').val('1');
        $('body').css({ 'overflow-x': 'hidden' });
        $('body').css({ 'overflow-y': 'hidden' });
        $('#pop_oferta_mobile').toggle('slide', { direction: 'Right' }, 500);
    }

    function ResetearCantidadesDelPopup() {
        $("#divOddCarrusel").find(".liquidacion_rango_cantidad_pedido.txtcantidad-odd").val(1);
        $('#divOddCarruselDetalle').find('.liquidacion_rango_cantidad_pedido.txtcantidad-odd').val(1);
    }

    function ResetearCantidadEnMobile() {
        $(elements.TxtCantidadMobile).val(1);
    }

    function ConfigurarSlick()
    {
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
            prevArrow: '<a style="width: auto; display: block; left:  0; margin-left:  -13%; top: 24%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a style="width: auto; display: block; right: 0; margin-right: -13%; text-align:right;  top: 24%;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        });
        $(elements.ContenedorOfertaDelDiaMobile).slick('slickGoTo', 0);
    }
    
    function AsignarClaseCssAPalabraGratisMobile(listaOfertas) {
        var listaOfertasConClases = [];

        $.each(listaOfertas, function (index, value) {
            value.DescripcionOferta = value.DescripcionOferta.replace("(¡GRATIS!)", "<span class='color-por-marca'>¡GRATIS!</span>");
            listaOfertasConClases.push(value);
        });

        return listaOfertasConClases;
    }

    function AsignarClaseCssAPalabraGratisDesktop(listaOfertas) {
        var listaOfertasConClases = [];

        $.each(listaOfertas, function (index, value) {
            value.DescripcionOferta = value.DescripcionOferta.replace("(¡GRATIS!)", "<span class='color-para-todas-marcas'>¡GRATIS!</span>");
            listaOfertasConClases.push(value);
        });

        return listaOfertasConClases;
    }

    $(elements.ContenedorInternoSliderOfertaDelDiaMobileHome + ", " + elements.ContenedorInternoSliderOfertaDelDiaMobile).click(function () {
        MostrarContenedorOverOfertaDelDia();
        ConfigurarSlick();
    });

    $("body").on("click", elements.BtnAgregarMobile, function (e) {
        var accion = $(this).attr("data-odd-accion").toUpperCase();

        if (accion == CONS_TIPO_ACCION.AGREGAR) {
            OddAgregarMobile(this);
        }
    });

    $("body").on("click", "#OfertaDelDia [data-odd-accion]", function (e) {
        var accion = $(this).attr("data-odd-accion").toUpperCase();
        if (accion == CONS_TIPO_ACCION.VEROFERTA) {
            ResetearCantidadesDelPopup();
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

            if ($(this).parents('div [data-odd-tipoventana="detalle"]').length == 1) {
                $('div [data-odd-tipoventana="detalle"]').show();
            }
        }
        else if (accion == CONS_TIPO_ACCION.VERDETALLE) {

            $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').hide();
            $('#OfertaDelDia [data-odd-tipoventana="detalle"]').show();
            var posicion = $(this).parents("[data-item]").attr("data-item-position");
            $('#divOddCarruselDetalle').slick('slickGoTo', posicion);
            // asignar valores del ver detalle
        }
        else if (accion == CONS_TIPO_ACCION.REGRESAR) {

            $('#divOddCarrusel').slick('refresh', false);
            $('#OfertaDelDia [data-odd-tipoventana="detalle"]').hide();
            $('#OfertaDelDia [data-odd-tipoventana="carrusel"]').show();
        }
        else if (accion == CONS_TIPO_ACCION.AGREGAR) {
            OddAgregar(this);
        }
    });

    $("body").on("click", ".btn_cerrar_pop_oferta_hoy", function (e) {
        $('#pop_oferta_mobile').hide('slide', { direction: 'Right' }, 500);
        $('body').css({ 'overflow-y': 'auto' });
    });

    $("body").on("click", ".ver_detalle_carrusel", function (e) {
        $('#divOddCarruselDetalle').find('.liquidacion_rango_cantidad_pedido.txtcantidad-odd').val(1);
    });

    self.CargarODD();
});