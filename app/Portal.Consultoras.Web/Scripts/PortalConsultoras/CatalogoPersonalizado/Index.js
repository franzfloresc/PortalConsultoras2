//var cantidadRegistros = 12;
//var offsetRegistros = 0;
//var cargandoRegistros = false;
//var tipoOrigen = "1";

//$(document).ready(function () {
//    $(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
//        if (ReservadoOEnHorarioRestringido())
//            return false;

//        agregarProductoAlCarrito(this);

//        var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
//        AgregarProductoCatalogoPersonalizado(contenedor);
//    });
//    $(document).on('click', '#boton_vermas', function () {
//        CargarCatalogoPersonalizado();
//    });
//    $(document).on('click', '.pop-ofertarevista', function () {
//        var contenedor = $(this).parents('.contiene-productos');
//        ObtenerOfertaRevista(contenedor);
//    });
//    $(document).on('click', '.agregar-ofertarevista', function () {
//        if (ReservadoOEnHorarioRestringido())
//            return false;

//        var contenedor = $(this).parents(".cuerpo-mod");
//        var tipoCUV = $(this).attr('data-cuv');
//        var cantidad = $(this).siblings('.liquidacion_rango_home, .ofertarevista_rango_home').find('#txtCantidad').val();

//        AgregarProductoOfertaRevista(contenedor, cantidad, tipoCUV, this);
//    });

//    Inicializar();
//});

//function Inicializar() {
//    IniDialog();
//    ValidarCargaCatalogoPersonalizado();
//    LinkCargarCatalogoToScroll();
//}
//function IniDialog() {
//    $('#DialogMensajes').dialog({
//        autoOpen: false,
//        resizable: false,
//        modal: true,
//        closeOnEscape: true,
//        width: 400,
//        draggable: true,
//        buttons:
//        {
//            "Aceptar": function () {
//                $(this).dialog('close');
//            }
//        }
//    });
//}

//function LinkCargarCatalogoToScroll() { $(window).scroll(CargarCatalogoScroll); }
//function UnlinkCargarCatalogoToScroll() {
//    $(window).off("scroll", CargarCatalogoScroll);
//    cargandoRegistros = false;
//}
//function CargarCatalogoScroll() {
//    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
//        ValidarCargaCatalogoPersonalizado();
//    }
//}

//function ValidarCargaCatalogoPersonalizado() {
//    if (cargandoRegistros) return false;
//    cargandoRegistros = true;

//    waitingDialog();
//    ReservadoOEnHorarioRestringidoAsync(true, UnlinkCargarCatalogoToScroll, CargarCatalogoPersonalizado);
//}

//function ObtenerOfertaRevista(item) {
//    var $contenedor = item;
//    // 201615 - 032610099 peru
//    waitingDialog();
//    var cuv = $contenedor.find('.hdItemCuv').val(); // 11791 (mucha data) "10989";// 
//    var tipoOfertaRevista = $contenedor.find('.hdItemTipoOfertaRevista').val().trim();

//    var obj = {
//        UrlImagen: $contenedor.find('.producto_img_home>img').attr('src'),
//        CUV: $contenedor.find('.hdItemCuv').val(),
//        TipoOfertaSisID: $contenedor.find('.hdItemTipoOfertaSisID').val(),
//        ConfiguracionOfertaID: $contenedor.find('.hdItemConfiguracionOfertaID').val(),
//        IndicadorMontoMinimo: $contenedor.find('.hdItemIndicadorMontoMinimo').val(),
//        MarcaID: $contenedor.find('.hdItemMarcaID').val(),
//        PrecioCatalogo: $contenedor.find('.hdItemPrecioUnidad').val(),
//        Descripcion: $contenedor.find('.hdItemDescripcionProd').val(),
//        DescripcionCategoria: $contenedor.find('.hdItemDescripcionCategoria').val(),
//        DescripcionMarca: $contenedor.find('.hdItemDescripcionMarca').val(),
//        DescripcionEstrategia: $contenedor.find('.hdItemDescripcionEstrategia').val()
//    };
//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'CatalogoPersonalizado/ObtenerOfertaRevista',
//        dataType: 'json',
//        data: JSON.stringify({ cuv: cuv, tipoOfertaRevista: tipoOfertaRevista }),
//        contentType: 'application/json; charset=utf-8',
//        success: function (response) {
//            if (response.success) {
//                response.data.dataPROL.Simbolo = viewBagSimbolo;
//                var settings = $.extend({}, response.data.dataPROL, obj);
//                settings.productoRevista = response.data.producto;
//                TrackingJetloreView(cuv, $("#hdCampaniaCodigo").val())
//                switch (settings.tipo_oferta) {
//                    case '003':
//                        settings.precio_catalogo = DecimalToStringFormat(settings.precio_catalogo);
//                        settings.precio_revista = DecimalToStringFormat(settings.precio_revista);
//                        settings.ganancia = DecimalToStringFormat(settings.ganancia);
//                        var html = SetHandlebars("#template-mod-ofer1", settings);
//                        $('.mod-ofer1').html(html).show();
//                        break;
//                    case '048':
//                        //console.log(settings);
//                        //settings.lista_ObjNivel = new Array();
//                        if (settings.lista_oObjPack.length > 0) {
//                            settings.lista_oObjPack = RemoverRepetidos(settings.lista_oObjPack);
//                            settings.lista_oObjItemPack = RemoverRepetidos(settings.lista_oObjItemPack);
//                            settings.lista_oObjPack.splice(2, settings.lista_oObjPack.length);
//                            var html = SetHandlebars("#template-mod-ofer3", settings);
//                            $('.mod-ofer3').html(html).show();
//                        }
//                        else if (settings.lista_ObjNivel.length > 0) {
//                            settings.lista_ObjNivel = RemoverRepetidos(settings.lista_ObjNivel);
//                            settings.lista_oObjGratis = RemoverRepetidos(settings.lista_oObjGratis);
//                            settings.lista_ObjNivel.splice(3, settings.lista_ObjNivel.length);
//                            var html = SetHandlebars("#template-mod-ofer2", settings);
//                            $('.mod-ofer2').html(html).show();
//                        }
//                        break;
//                }
//            } else {
//                console.log(response.message);
//            }
//            closeWaitingDialog();
//        },
//        error: function (response, error) {
//            console.log(error);
//            closeWaitingDialog();
//        }
//    });
//}

//function CargarCatalogoPersonalizado() {
//    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
//    if (cataPer != "1" && cataPer != "2") {
//        UnlinkCargarCatalogoToScroll();
//        return false;
//    }

//    var esCatalogoPersonalizadoZonaValida = $("#hdEsCatalogoPersonalizadoZonaValida").val();
//    if (esCatalogoPersonalizadoZonaValida != "True") {
//        $('#boton_vermas').hide();
//        return false;
//    }

//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'CatalogoPersonalizado/ObtenerProductosCatalogoPersonalizado',
//        dataType: 'json',
//        data: JSON.stringify({ cantidad: cantidadRegistros, offset: offsetRegistros }),
//        contentType: 'application/json; charset=utf-8',
//        success: function (data) {
//            if (data.success) {
//                if (data.data.length > 0) {
//                    data.data[0].TieneOfertaEnRevista = true;
//                    data.data[0].TipoOfertaRevista = '048';
//                    data.data[0].CUV = '10989';
//                    data.data[1].TieneOfertaEnRevista = true;
//                    data.data[1].TipoOfertaRevista = '048';
//                    data.data[1].CUV = '11791';
//                    var htmlDiv = SetHandlebars("#template-catalogopersonalizado", data.data);
//                    $('#divCatalogoPersonalizado').append(htmlDiv);
//                }

//                if (data.data.length < cantidadRegistros) UnlinkCargarCatalogoToScroll();
//                offsetRegistros += cantidadRegistros;
//            }
//        },
//        error: function (data, error) {
//            console.log(error);
//        },
//        complete: function () {
//            closeWaitingDialog();
//            cargandoRegistros = false;
//        }
//    });
//}
//function AgregarProductoCatalogoPersonalizado(item) {
//    waitingDialog();

//    var divPadre = item;
//    var attItem = $(item).attr("data-item") || "";
//    if (attItem == "") {
//        divPadre = $(item).parents("[data-item]").eq(0);
//    }

//    var cuv = $(divPadre).find(".hdItemCuv").val();
//    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
//    var tipoOfertaSisID = $(divPadre).find(".hdItemTipoOfertaSisID").val();
//    var configuracionOfertaID = $(divPadre).find(".hdItemConfiguracionOfertaID").val();
//    var indicadorMontoMinimo = $(divPadre).find(".hdItemIndicadorMontoMinimo").val();
//    var tipo = $(divPadre).find(".hdItemTipo").val();
//    var marcaID = $(divPadre).find(".hdItemMarcaID").val();
//    var precioUnidad = $(divPadre).find(".hdItemPrecioUnidad").val();
//    var descripcionProd = $(divPadre).find(".hdItemDescripcionProd").val();
//    var pagina = $(divPadre).find(".hdItemPagina").val();
//    var descripcionCategoria = $(divPadre).find(".hdItemDescripcionCategoria").val();
//    var descripcionMarca = $(divPadre).find(".hdItemDescripcionMarca").val();
//    var descripcionEstrategia = $(divPadre).find(".hdItemDescripcionEstrategia").val();
//    var OrigenPedidoWeb = $(divPadre).find(".OrigenPedidoWeb").val();

//    if (!isInt(cantidad)) {
//        alert_msg_pedido("La cantidad ingresada debe ser un número mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    if (cantidad <= 0) {
//        alert_msg_pedido("La cantidad ingresada debe ser mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    var model = {
//        TipoOfertaSisID: tipoOfertaSisID,
//        ConfiguracionOfertaID: configuracionOfertaID,
//        IndicadorMontoMinimo: indicadorMontoMinimo,
//        MarcaID: marcaID,
//        Cantidad: cantidad,
//        PrecioUnidad: precioUnidad,
//        CUV: cuv,
//        Tipo: tipo,
//        DescripcionProd: descripcionProd,
//        Pagina: pagina,
//        DescripcionCategoria: descripcionCategoria,
//        DescripcionMarca: descripcionMarca,
//        DescripcionEstrategia: descripcionEstrategia,
//        EsSugerido: false,
//        OrigenPedidoWeb: OrigenPedidoWeb
//    };

//    AgregarProducto('Insert', model, function () { $(divPadre).find(".product-add").show(); });
//    TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
//}
//function AgregarProducto(url, item, otraFunct) {
//    waitingDialog();

//    tieneMicroefecto = true;

//    jQuery.ajax({
//        type: 'POST',
//        url: baseUrl + 'Pedido/' + url,
//        dataType: 'json',
//        contentType: 'application/json; charset=utf-8',
//        data: JSON.stringify(item),
//        async: true,
//        success: function (data) {
//            if (data.success == true) {
//                ActualizarGanancia(data.DataBarra);
//                CargarResumenCampaniaHeader(true);
//                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);

//                if (typeof (otraFunct) == 'function') {
//                    setTimeout(otraFunct, 50);
//                }
//                else if (typeof (otraFunct) == 'string') {
//                    setTimeout(otraFunct, 50);
//                }
//            }
//            else {
//                alert_msg_pedido(data.message);
//            }
//            closeWaitingDialog();
//        },
//        error: function (data, error) {
//            tieneMicroefecto = false;
//            AjaxError(data, error);
//        }
//    });
//}


//function agregarProductoAlCarrito(o) {
//    var btnClickeado = $(o);
//    var contenedorItem = btnClickeado.parent().parent();
//    var imagenProducto = $('.imagen_producto', contenedorItem);
            closeWaitingDialog();

//    if (imagenProducto.length > 0) {
//        var carrito = $('.campana');

//        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

//        $(".transicion").css({
//            'height': imagenProducto.css("height"),
//            'width': imagenProducto.css("width"),
//            'top': imagenProducto.offset().top,
//            'left': imagenProducto.offset().left,
//        }).animate({
//            'top': carrito.offset().top - 60,
//            'left': carrito.offset().left + 100,
//            'height': carrito.css("height"),
//            'width': carrito.css("width"),
//            'opacity': 0.5
//        }, 450, 'swing', function () {
//            $(this).animate({
//                'top': carrito.offset().top,
//                'opacity': 0,
//                //}, 100, 'swing', function () {
//                //    $(".campana .info_cam").fadeIn(200);
//                //    $(".campana .info_cam").delay(2500);
//                //    $(".campana .info_cam").fadeOut(200);
//            }, 150, 'swing', function () {
//                $(this).remove();
//            });
//        });
//    }
//}
//function ReservadoOEnHorarioRestringido(mostrarAlerta) {
//    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
//    var restringido = true;

//    $.ajaxSetup({ cache: false });
//    jQuery.ajax({
//        type: 'GET',
//        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
//        dataType: 'json',
//        async: false,
//        contentType: 'application/json; charset=utf-8',
//        success: function (data) {
//            if (!checkTimeout(data)) {
//                return false;
//            }

//            if (data.success == false) {
//                restringido = false;
//                return false;
//            }

//            if (data.pedidoReservado) {
//                var fnRedireccionar = function () {
//                    waitingDialog({});
//                    location.href = location.href = baseUrl + 'Pedido/PedidoValidado'
//                }
//                if (mostrarAlerta == true) {
//                    closeWaitingDialog();
//                    alert_msg_pedido(data.message);
//                }
//                else fnRedireccionar();
//            }
//            else if (mostrarAlerta == true) alert_msg_pedido(data.message);
//        },
//        error: function (error) {
//            console.log(error);
//            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
//        }
//    });
//    return restringido;
//}

//function ReservadoOEnHorarioRestringidoAsync(mostrarAlerta, fnRestringido, fnNoRestringido) {
//    if (!$.isFunction(fnRestringido)) return false;
//    if (!$.isFunction(fnNoRestringido)) return false;
//    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;

//    $.ajaxSetup({ cache: false });
//    jQuery.ajax({
//        type: 'GET',
//        url: baseUrl + "Pedido/ReservadoOEnHorarioRestringido",
//        dataType: 'json',
//        async: true,
//        contentType: 'application/json; charset=utf-8',
//        success: function (data) {
//            if (!checkTimeout(data)) return false;
//            if (!data.success) {
//                fnNoRestringido();
//                return false;
//            }

//            if (data.pedidoReservado && !mostrarAlerta) {
//                waitingDialog();
//                location.href = location.href = baseUrl + 'Pedido/PedidoValidado';
//                return false;
//            }

//            if (mostrarAlerta) {
//                closeWaitingDialog();
//                alert_msg_pedido(data.message);
//            }
//            fnRestringido();
//        },
//        error: function (error) {
//            console.log(error);
//            alert_msg_pedido('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
//        }
//    });
//}

//function alert_msg_pedido(message) {
//    $('#DialogMensajes .pop_pedido_mensaje').html(message);
//    $('#DialogMensajes').dialog('open');
//}

//function AgregarProductoOfertaRevista(item, cantidad, tipoCUV, btn) {
//    waitingDialog();
//    var hidden = "";

//    if (tipoCUV == 'revista') {
//        hidden = $(item).find('#hiddenRevista');
//    } else if (tipoCUV == 'catalogo') {
//        hidden = $(item).find('#hiddenCatalogo');
//    } else if (tipoCUV == 'pack') {
//        hidden = $(item).find('#hiddenRevista');
//    }
    
//    if (hidden.length == 0) {
//        return false;
//    }

//    if (tipoCUV == 'pack') {
//        cantidad = $(btn).parents("[data-cantidad-contenedor]").find('#txtCantidad').val();
//    }

//    if (!isInt(cantidad)) {
//        alert_msg_pedido("La cantidad ingresada debe ser un número mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    if (cantidad <= 0) {
//        alert_msg_pedido("La cantidad ingresada debe ser mayor que cero, verifique");
//        closeWaitingDialog();
//        return false;
//    }

//    var precioUnidadAdd = $(hidden).find(".hdItemPrecioUnidad").val();
//    if (tipoCUV == 'pack') {
//        cantidad = $(btn).parents("[data-cantidad-contenedor]").find('#txtCantidad').val();
//        precioUnidadAdd = $(btn).parents(".item_pack_personalizado").find('.hdItemPackvalorizado').val();
//    }

//    var cuvAdd = tipoCUV == 'pack' ? $(btn).attr("data-cuvadd") : $(hidden).find(".hdItemCuv").val();
//    var model = {
//        TipoOfertaSisID: $(hidden).find(".hdItemTipoOfertaSisID").val(),
//        ConfiguracionOfertaID: $(hidden).find(".hdItemConfiguracionOfertaID").val(),
//        IndicadorMontoMinimo: $(hidden).find(".hdItemIndicadorMontoMinimo").val(),
//        MarcaID: $(hidden).find(".hdItemMarcaID").val(),
//        Cantidad: cantidad,
//        PrecioUnidad: precioUnidadAdd,
//        CUV: cuvAdd,
//        Tipo: $(hidden).find(".hdItemTipo").val(),
//        DescripcionProd: $(hidden).find(".hdItemDescripcionProd").val(),
//        Pagina: $(hidden).find(".hdItemPagina").val(),
//        DescripcionCategoria: $(hidden).find(".hdItemDescripcionCategoria").val(),
//        DescripcionMarca: $(hidden).find(".hdItemDescripcionMarca").val(),
//        DescripcionEstrategia: $(hidden).find(".hdItemDescripcionEstrategia").val(),
//        EsSugerido: false,
//        OrigenPedidoWeb: $(hidden).find(".OrigenPedidoWeb").val()
//    };  

//    var imagenProducto = $('#imagenAnimacion>img', item);

//    if (imagenProducto.length > 0) {
//        var carrito = $('.campana');

//        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

//        $(".transicion").css({
//            'height': imagenProducto.css("height"),
//            'width': imagenProducto.css("width"),
//            'top': imagenProducto.offset().top,
//            'left': imagenProducto.offset().left,
//        }).animate({
//            'top': carrito.offset().top - 60,
//            'left': carrito.offset().left + 100,
//            'height': carrito.css("height"),
//            'width': carrito.css("width"),
//            'opacity': 0.5
//        }, 450, 'swing', function () {
//            $(this).animate({
//                'top': carrito.offset().top,
//                'opacity': 0,
//            }, 150, 'swing', function () {
//                $(this).remove();
//            });
//        });
//    }

//    AgregarProducto('Insert', model, function () { $(".contiene-productos:has(.hdItemCuv[value='" + $(item).find('#hiddenCatalogo').find(".hdItemCuv").val() + "'])").find(".product-add").show(); $('[class^=mod-ofer]').hide(); });
//    TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
//}