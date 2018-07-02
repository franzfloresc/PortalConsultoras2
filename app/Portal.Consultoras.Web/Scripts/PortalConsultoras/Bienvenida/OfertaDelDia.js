var fechaMostrarBanner = Date.now();
var codigoAnclaOdd = codigoAnclaOdd || "";

$(document).ready(function () {
    window.OfertaDelDia = window.OfertaDelDia || {};
    var odd_desktop_google_analytics_promotion_impresion_flag = true;
    var odd_desktop_google_analytics_promotion_impresion_fech;


    var self = window.OfertaDelDia;

    var CONS_TIPO_ORIGEN = {
        ESCRITORIO_HOME: 1,
        MOBILE_HOME: 2,
        ESCRITORIO_PEDIDO: 11,
        MOBILE_PEDIDO: 21,
        ESCRITORIO_OFERTAS: 111,
        MOBILE_OFERTAS: 211,
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
        TipoOrigenPantallaODD: TipoOrigenPantallaODD,
        OrigenDesktopODD: OrigenDesktopODD //para Analytics
    };

    var CONS_POSICION_BANNER = {
        BANNER_HOME: 'Banner Superior Home - 1',
        BANNER_PEDIDO: 'Banner Superior Pedido - 1'
    };

    var elements = {
        ContenedorOfertaDelDia: "#OfertaDelDia",
        ContenedorOfertaDelDiaMobile: "#OfertasDiaMobile",
        ContenedorOfertaDelDiaOfertas: "#OfertasDelDiaOfertas",
        ContenedorEstrategiaTemplateCarrusel: "#estrategia-template_carrusel",
        ContenedorInternoSliderOfertaDelDiaMobileHome: "#content_oferta_dia_mobile",
        ContenedorInternoSliderOfertaDelDiaMobile: ".BloqueOfertaDiaHeader",
        BtnAgregarMobile: "#btnAgregarMobile",
        TxtCantidadMobile: "#txtCantidad"
    };

    self.CargarODD = function () {
        if (props.EsPaginaIntriga) {
            return false;
        }

        if (props.TipoOrigenPantallaODD == CONS_TIPO_ORIGEN.MOBILE_HOME) {
            self.CargarODDMobile();
            odd_mobile_home_google_analytics_promotion_impresion();
        }

        if (props.TipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_HOME) {
            self.CargarODDEscritorio(props.TipoOrigenPantallaODD);
        }

        if (props.TipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_OFERTAS) {
            self.CargarODDEscritorio(props.TipoOrigenPantallaODD);
        }
    }


    self.CargarODDMobile = function () {
        MostrarRelojOfertaDelDia($('.clock').data('total-seconds'));

        var contenedorOfertas = elements.ContenedorOfertaDelDiaMobile;

        if ($(contenedorOfertas).length == 0)
            return false;

        $.ajax({
            type: 'GET',
            url: baseUrl + props.UrlGetOfertaDelDia,
            cache: false,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                array_odd = response.data;

                if (!EsValidoResponseGetOfertaDelDia(response))
                    return false;
                var _data = response.data;

                RenderOfertaDelDiaMobile(_data, contenedorOfertas);
                MostrarRelojOfertaDelDia(_data.TeQuedan.TotalSeconds);

                $('#txtCantidad').val('1');
                $('body').css({ 'overflow-y': 'auto' });

            },
            error: function (err) {
                checkTimeout(err);
            }
        });
    }

    function MostrarRelojOfertaDelDia(totalSegundos) {
        $('.clock').each(function (index, elem) {
            $(elem).FlipClock(totalSegundos, {
                countdown: true,
                clockFace: 'HourlyCounter',
                language: 'es-es'
            });
        });

    }

    function EsValidoResponseGetOfertaDelDia(response) {
        $("#ODD").find(".seccion-loading-contenedor").fadeOut();
        if (!response.success)
            return false;

        if (response.data.TeQuedan.TotalSeconds <= 0)
            return false;

        if (response.data.ListaOfertas.length <= 0) {
            $("#ODD").find(".seccion-content-contenedor").fadeOut();
            return false;
        }
        $("#ODD").find(".seccion-content-contenedor").fadeIn();
        return true;
    }

    function RenderOfertaDelDiaMobile(data, contenedorOfertas) {
        $(contenedorOfertas).hide();

        data.CantidadProductos = data.ListaOfertas.length;
        data.TextoVerDetalle = data.CantidadProductos > 1 ? "VER MÁS OFERTAS" : "VER OFERTA";
        data.ListaOfertas = AsignarPosicionAListaOfertas(data.ListaOfertas);
        data.ListaOfertas = AsignarClaseCssAPalabraGratisMobile(data.ListaOfertas);

        SetHandlebars(elements.ContenedorEstrategiaTemplateCarrusel, data, elements.ContenedorOfertaDelDiaMobile);

        ConfigurarSlick();
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

    function ConstruirDescripcionOferta(arrDescripcion) {
        var descripcion = "";
        $.each(arrDescripcion, function (index, value) {
            value = value.replace("<br />", "");
            value = value.replace("<br/>", "");
            descripcion += "+ " + value + "<br />";
        });
        return descripcion;
    }

    var seAtacharonEventosOdd = false;
    self.CargarODDEscritorio = function (tipoOrigenPantallaODD) {
        var contenedorOfertas = '';

        if (tipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_HOME)
            contenedorOfertas = elements.ContenedorOfertaDelDia;

        if (tipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_OFERTAS)
            contenedorOfertas = elements.ContenedorOfertaDelDiaOfertas;

        if ($(contenedorOfertas).length == 0)
            return false;

        $.ajax({
            type: 'GET',
            url: baseUrl + props.UrlGetOfertaDelDia,
            cache: false,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {

                array_odd = response.data;

                if (!EsValidoResponseGetOfertaDelDia(response))
                    return false;

                var _data = response.data;

                RenderOfertaDelDia(_data, contenedorOfertas);

                MostrarRelojOfertaDelDia(_data.TeQuedan.TotalSeconds);
                

                var setColorFondo = _data.ColorFondo1;
                var setColorTexto = "";

                if (_data.ConfiguracionContenedor.ColorFondo !== "") {
                    setColorFondo = _data.ConfiguracionContenedor.ColorFondo;
                }

                if (_data.ConfiguracionContenedor.ColorTexto !== "") {
                    setColorTexto = _data.ConfiguracionContenedor.ColorTexto;
                }


                var url = window.location.href.toLowerCase() + "/";
                url = url.replace("#", "/");
                if (url.indexOf("/ofertas/") >= 0) {
                    if (_data.ConfiguracionContenedor.UsarImagenFondo &&
                        _data.ConfiguracionContenedor.ImagenFondo !== "") {
                        $(contenedorOfertas).css('background', 'url("' + _data.ConfiguracionContenedor.ImagenFondo + '")');
                    } else {
                        $(contenedorOfertas).css('background-color', setColorFondo);
                    }
                }
                else {
                    $('#banner-odd .izquierda_img img').attr('src', _data.ImagenFondo1);
                    $('#banner-odd .derecha_img img').attr('src', _data.ImagenFondo1);
                    $(contenedorOfertas).css('background-color', _data.ColorFondo1);
                }

                SetHandlebars("#ofertadeldia-template-style", _data, "#styleRelojOdd");

                $(contenedorOfertas).show();

                ConfigurarCarruselProductos(contenedorOfertas, _data.CantidadProductos);
                ConfigurarCarruselDetalleProductos(contenedorOfertas, _data.CantidadProductos);
                if (setColorTexto !== "") {
                    $(".clase_control_color_dinamico").css("color", setColorTexto);
                    $(".clase_control_color_dinamico").css("border-color", setColorTexto);
                    $(".icono_clase_control_color_dinamico").css("-webkit-filter", "opacity(.5) drop-shadow(0 0 0 " + setColorTexto + ")");
                    $(".icono_clase_control_color_dinamico").css("filter", "opacity(.5) drop-shadow(0 0 0 " + setColorTexto + ")");
                    $(".cross_clase_control_color_dinamico").css("background", setColorTexto);

                    var styleElemTrick = document.head.appendChild(document.createElement("style"));
                    styleElemTrick.innerHTML = ".cross_clase_control_color_dinamico:after {background: " + setColorTexto + ";}";

                    $(".cross_line_clase_control_color_dinamico").css("background", setColorTexto);
                }

                $('#PopOfertaDia').hide();

                if (tipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_OFERTAS) {
                    $('#banner-odd').parent().hide();
                    $('#PopOfertaDia').show();
                }

                if (tipoOrigenPantallaODD == CONS_TIPO_ORIGEN.ESCRITORIO_HOME) {
                    LayoutHeader();
                    if (odd_desktop_google_analytics_promotion_impresion_flag) {
                        odd_desktop_google_analytics_promotion_impresion();
                        odd_desktop_google_analytics_promotion_impresion_flag = false;
                    }
                }
            },
            error: function (err) { }
        });

        if (!seAtacharonEventosOdd) {

            $("body").off("click", contenedorOfertas + " [data-odd-accion]");
            $("body").on("click", contenedorOfertas + " [data-odd-accion]", function (e) {
                var accion = $(this).attr("data-odd-accion").toUpperCase();
                if (accion == CONS_TIPO_ACCION.VEROFERTA) {
                    var urlOfertas = '/Ofertas' + (codigoAnclaOdd == "" ? '' : '#' + codigoAnclaOdd);
                    document.location.href = urlOfertas;
                }
                else if (accion == CONS_TIPO_ACCION.VERDETALLE) {
                    $(contenedorOfertas + ' #imgSoloHoy').hide();
                    $(contenedorOfertas + ' [data-odd-accion="regresar"]').show();
                    $(contenedorOfertas + ' [data-odd-tipoventana="carrusel"]').hide();
                    $(contenedorOfertas + ' [data-odd-tipoventana="detalle"]').show();
                    var posicion = $(this).parents("[data-item]").attr("data-item-position");
                    $('#divOddCarruselDetalle').slick('slickGoTo', posicion);
                }
                else if (accion == CONS_TIPO_ACCION.REGRESAR) {

                    $('#divOddCarrusel').slick('refresh', false);
                    $(contenedorOfertas + ' #imgSoloHoy').show();
                    $(contenedorOfertas + ' [data-odd-accion="regresar"]').hide();
                    $(contenedorOfertas + ' [data-odd-tipoventana="detalle"]').hide();
                    $(contenedorOfertas + ' [data-odd-tipoventana="carrusel"]').show();
                }
                else if (accion == CONS_TIPO_ACCION.AGREGAR) {
                    OddAgregar(this);
                }
            });
            seAtacharonEventosOdd = true;
        }
    }

    function RenderOfertaDelDia(data, contenedorOfertas) {

        $(contenedorOfertas).hide();

        data.CantidadProductos = data.ListaOfertas.length;
        data.Simbolo = variablesPortal.SimboloMoneda;
        data.TextoVerDetalle = data.CantidadProductos > 1 ? "VER MÁS OFERTAS" : "VER OFERTA";
        data.UsuarioNombre = $.trim(usuarioNombre).toUpperCase();
        data.ListaOfertas = AsignarClaseCssAPalabraGratisDesktop(data.ListaOfertas);

        SetHandlebars("#ofertadeldia-template", data, contenedorOfertas);
        odd_desktop_google_analytics_product_impresion(data, contenedorOfertas);
    }

    function ConfigurarCarruselProductos(contenedorOfertas, cantidadProductos) {
        if (cantidadProductos > 1) {
            $(contenedorOfertas + ' #imgSoloHoy').show();
            $(contenedorOfertas + ' [data-odd-accion="regresar"]').hide();
            $(contenedorOfertas + ' [data-odd-tipoventana="carrusel"]').show();
        }
        
        if (cantidadProductos > 2) {
            EstablecerLazyCarrusel($('#divOddCarrusel'));

            $('#divOddCarrusel.slick-initialized').slick('unslick');
            $('#divOddCarrusel').not('.slick-initialized').slick({
                lazyLoad: 'ondemand',
                infinite: true,
                vertical: false,
                slidesToShow: 2,
                slidesToScroll: 1,
                variableWidth: true, 
                autoplay: false,
                speed: 260,
                prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',
                nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>'
            }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                odd_desktop_procesar_evento_before_change(event, slick, currentSlide, nextSlide);
            });
            $("#divOddCarrusel > .slick-list").css("width", "824px");
        }
    }

    function ConfigurarCarruselDetalleProductos(contenedorOfertas, cantidadProductos) {
        if (cantidadProductos == 1) {
            $(contenedorOfertas + ' #imgSoloHoy').show();
            $(contenedorOfertas + ' [data-odd-accion="regresar"]').hide();
            $(contenedorOfertas + ' [data-odd-tipoventana="detalle"]').show();
        }

        if (cantidadProductos > 1) {
            EstablecerLazyCarrusel($('#divOddCarruselDetalle'));

            $('#divOddCarruselDetalle.slick-initialized').slick('unslick');
            $('#divOddCarruselDetalle').not('.slick-initialized').slick({
                lazyLoad: 'ondemand',
                infinite: true,
                vertical: false,
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: false,
                speed: 260,
                prevArrow: '<a style="display: block;left: 0;margin-left: -5%; top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/left_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>',
                nextArrow: '<a style="display: block;right: 0;margin-right: -5%; text-align:right;  top: 40%;"><img src="' + baseUrl + 'Content/Images/PL20/right_compra.png")" alt="" class="icono_clase_control_color_dinamico"/></a>'
            });
            $('#divOddCarruselDetalle').slick('slickGoTo', 0);
        }
    }

    function odd_desktop_google_analytics_promotion_impresion() {
        if ($('#banner-odd').length > 0) {
            var id = $('#banner-odd').find(".estrategia-id-odd").val();
            var name = "Oferta del día - " + $('#banner-odd').find(".nombre-odd").val();
            var creative = $('#banner-odd').find(".nombre-odd").val() + " - " + $('#banner-odd').find(".cuv2-odd").val();
            var positionName = props.OrigenDesktopODD == 1 ? CONS_POSICION_BANNER.BANNER_HOME : props.OrigenDesktopODD == 2 ? CONS_POSICION_BANNER.BANNER_PEDIDO : "";
            dataLayer.push({
                'event': 'promotionView',
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                        {
                            'id': id,
                            'name': name,
                            'position': positionName,
                            'creative': creative
                        }]
                    }
                }
            });
        }
    }

    function odd_mobile_home_google_analytics_promotion_impresion() {
        if ($('#banner-odd-mobile').length > 0) {
            var id = $('#banner-odd-mobile').find("#estrategia-id-odd").val();
            var name = "Oferta del día - " + $('#banner-odd-mobile').find("#nombre-odd").val();
            var creative = $('#banner-odd-mobile').find("#nombre-odd").val() + " - " + $('#banner-odd-mobile').find("#cuv2-odd").val();
            var positionName = props.OrigenDesktopODD == 1 ? CONS_POSICION_BANNER.BANNER_HOME : props.OrigenDesktopODD == 2 ? CONS_POSICION_BANNER.BANNER_PEDIDO : "";
            dataLayer.push({
                'event': 'promotionView',
                'ecommerce': {
                    'promoView': {
                        'promotions': [
                            {
                                'id': id,
                                'name': name,
                                'position': positionName,
                                'creative': creative
                            }]
                    }
                }
            });
        }
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
            TipoEstrategiaID: itemCampos.find('.tipoestrategia-id-odd').val(),
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
                odd_mobile_google_analytics_addtocart();

                ResetearCantidadEnMobile();
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
            alert_msg_pedido('La Oferta del Día se terminó');
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
        var msg1 = 'Sólo puede llevar ' + limiteVenta.toString() + ' unidades de este producto.';
        if (cantidad > limiteVenta) {
            $('#dialog_ErrorMainLayout').find('.mensaje_agregarUnidades').text(msg1);
            $('#dialog_ErrorMainLayout').show();
            closeWaitingDialog();
            ResetearCantidadesDelPopup();
            return false;
        }

        var tipoEstrategiaID = itemCampos.find('.tipoestrategia-id-odd').val();
        var marcaID = itemCampos.find('.marca-id-odd').val();
        var cuv2 = itemCampos.find('.cuv2-odd').val();
        var precio = itemCampos.find('.precio-odd').val();
        var descripcion = itemCampos.find('.nombre-odd').val();
        var indMontoMinimo = itemCampos.find('.indmonto-min-odd').val();
        var teImagenMostrar = itemCampos.find('.teimagenmostrar-odd').val();

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

        var obj = {
            CUV: cuv2,
            Cantidad: cantidad,
            PrecioUnidad: precio,
            TipoEstrategiaID: tipoEstrategiaID,
            OrigenPedidoWeb: origenPedidoWeb,
            MarcaID: marcaID,
            DescripcionProd: descripcion,
            IndicadorMontoMinimo: indMontoMinimo,
            ClienteID_: '-1',
            TipoEstrategiaImagen: teImagenMostrar || 0,
            Descripcion: descripcion,
            TipoOferta: tipoEstrategiaID
        };

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
                    url: baseUrl + props.UrlAgregarProducto,
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
                        }

                        var tipo = $(btn).attr('data-odd-accion-type');
                        var indiceElemeto = $(btn).attr('data-odd-accion-element');
                        odd_desktop_google_analytics_addtocart(tipo, indiceElemeto);

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
                $(btn).parents('.content_pop_oferta_dia ')
                    .find('[data-odd-tipoventana="carrusel"]')
                    .find('[data-item-position="' + posicion + '"]')
                    .find(".product-add")
                    .css("display", "block");

            } else {
                $(item).find(".product-add").css("display", "block");

                var clonados = $('#divOddCarrusel div.slick-slide');
                var posi1 = $(item).attr('data-item-position');

                $.each(clonados, function (key, value) {
                    var posi2 = $(value).attr('data-item-position');
                    if (posi1 == posi2) {
                        $(value).find(".product-add").css("display", "block");
                    }
                });
            }
                
        }
    }

    function CheckCountdownODD() {
        var ok = true;
        $.ajax({
            type: 'GET',
            url: baseUrl + props.UrlGetOfertaDelDia,
            async: false,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        var _data = response.data;

                        if (_data.TeQuedan.TotalSeconds <= 0)
                            ok = false;
                    }
                }
            },
            error: function (err) { }
        });

        return ok;
    }

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
            error: function (err) { }
        });

        return qty;
    }

    function ResetearCantidadesDelPopup() {
        $("#divOddCarrusel").find(".liquidacion_rango_cantidad_pedido.txtcantidad-odd").val(1);
        $('#divOddCarruselDetalle').find('.liquidacion_rango_cantidad_pedido.txtcantidad-odd').val(1);
    }

    function ResetearCantidadEnMobile() {
        $(elements.TxtCantidadMobile).val(1);
    }

    function ConfigurarSlick() {
        $(elements.ContenedorOfertaDelDiaMobile).show();

        EstablecerLazyCarrusel($(elements.ContenedorOfertaDelDiaMobile));

        $(elements.ContenedorOfertaDelDiaMobile + '.slick-initialized').slick('unslick');
        $(elements.ContenedorOfertaDelDiaMobile).slick({
            lazyLoad: 'ondemand',
            dots: false,
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a style="width: auto; display: block; left:  0; margin-left:  -13%; top: 24%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a style="width: auto; display: block; right: 0; margin-right: -13%; text-align:right;  top: 24%;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'
        }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            var list = array_odd.ListaOfertas;
            var evento = "arrow_click";
            var index = odd_mobile_procesar_evento_before_change(event, slick, currentSlide, nextSlide, list)
            if (index !== -1)
                odd_mobile_google_analytics_promotion_impresion(list, evento, index)
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

    $(elements.ContenedorInternoSliderOfertaDelDiaMobileHome).click(function () {
        try {
            if (typeof rdAnalyticsModule !== "undefined") {
                rdAnalyticsModule.ContendorSection("Solo por Hoy");
            }
        } catch (e) {
            console.error(e);
        } 
        document.location.href = urlOfertaDelDiaMobile;
    });

    $(elements.ContenedorInternoSliderOfertaDelDiaMobile).click(function () {
        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                    {
                        'id': '002',
                        'name': 'Oferta del dia',
                        'position': controllerName + ' - Banner superior',
                        'creative': 'Banner'
                    }]
                }
            }
        });

        document.location.href = urlOfertaDelDiaMobile;
    });

    $("body").on("click", elements.BtnAgregarMobile, function (e) {
        var accion = $(this).attr("data-odd-accion").toUpperCase();

        if (accion == CONS_TIPO_ACCION.AGREGAR) {
            OddAgregarMobile(this);
        }
    });

    $("body").on("click", ".btn_cerrar_pop_oferta_hoy", function (e) {
        $('#pop_oferta_mobile').hide('slide', { direction: 'Right' }, 500);
        $('body').css({ 'overflow-y': 'auto' });
    });

    $("body").on("click", ".ver_detalle_carrusel", function (e) {
        $('#divOddCarruselDetalle').find('.liquidacion_rango_cantidad_pedido.txtcantidad-odd').val(1);
    });
});

function odd_desktop_procesar_evento_before_change(event, slick, currentSlide, nextSlide) {
    if (currentSlide != nextSlide) {
        var accion = "";
        var index = 0;
        var impresions = [];

        if (nextSlide == 0 && currentSlide + 1 == array_odd.CantidadProductos) {
            accion = 'next';
        } else if (currentSlide == 0 && nextSlide + 1 == array_odd.CantidadProductos) {
            accion = 'prev';
        } else if (nextSlide > currentSlide) {
            accion = 'next';
        } else {
            accion = 'prev';
        }

        if (accion == "prev") {
            index = nextSlide;
        }
        if (accion == "next") {
            index = nextSlide + 2;
        }
        if (index >= array_odd.CantidadProductos) {
            index = index - array_odd.CantidadProductos;
        }

        var div = $('#divOddCarrusel').find("[data-item-position=" + index + "]");
        var name = $(div).find("[data-item-campos]").find(".nombre-odd").val();
        var id = $(div).find("[data-item-campos]").find(".cuv2-odd").val();
        var price = $(div).find("[data-item-campos]").find(".precio-odd").val();
        var brand = $(div).find("[data-item-campos]").find(".marca-descripcion-odd").val();
        var variant = $(div).find("[data-item-campos]").find(".tipoestrategia-descripcion-odd").val();
        var position = index + 1;
        impresions.push({
            'name': name,
            'id': id,
            'price': price,
            'brand': brand,
            'category': 'No disponible',
            'variant': variant,
            'list': 'Oferta del día',
            'position': position
        });
        dataLayer.push({ 'event': 'productImpression', 'ecommerce': { 'impressions': impresions } });
    }
}

function odd_mobile_procesar_evento_before_change(event, slick, currentSlide, nextSlide, list) {
    if (currentSlide != nextSlide) {
        var accion = "";
        var index = 0;

        if (nextSlide == 0 && currentSlide + 1 == list.length) {
            accion = 'next';
        } else if (currentSlide == 0 && nextSlide + 1 == list.length) {
            accion = 'prev';
        } else if (nextSlide > currentSlide) {
            accion = 'next';
        } else {
            accion = 'prev';
        }

        if (accion == "prev") {
            index = nextSlide;
        }
        if (accion == "next") {
            index = nextSlide;
        }
        if (index >= list.length) {
            index = index - list.length;
        }

        return index;
    }
    else
        return -1;
}
