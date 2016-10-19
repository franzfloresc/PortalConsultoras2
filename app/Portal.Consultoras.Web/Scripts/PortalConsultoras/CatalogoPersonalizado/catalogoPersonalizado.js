
var tipoOrigen = tipoOrigen || "";// 1: escritorio (no home)     2: mobile,  3: home
var cantidadRegistros = cantidadRegistros || 12;
var offsetRegistros = 0;
var cargandoRegistros = false;
var loadAdd = true;
var urlLoad = urlLoad || "";

$(document).ready(function () {
    $(document).on('click', '[data-btn-agregar-catalogopersonalizado]', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;

        agregarProductoAlCarrito(this);

        var contenedor = $(this).parents("[data-item='catalogopersonalizado']");
        AgregarProductoCatalogoPersonalizado(contenedor);
    });
    $(document).on('click', '#boton_vermas', function () {
        CargarCatalogoPersonalizado();
    });
    $(document).on('click', '.pop-ofertarevista', function () {
        var contenedor = $(this).parents('[data-item="catalogopersonalizado"]');
        ObtenerOfertaRevista(contenedor);
    });
    $(document).on('click', '.agregar-ofertarevista', function () {
        if (ReservadoOEnHorarioRestringido())
            return false;
        agregarProductoAlCarrito(this);
        AgregarProductoOfertaRevista(this);
    });

    $(document).on('click', '[data-close]', function () {
        $('[data-oferta]').attr("class", "").hide();
    });

    if (tipoOrigen != '3') {
        Inicializar();
    }
});

function Inicializar() {
    IniDialog();
    ValidarCargaCatalogoPersonalizado();
    LinkCargarCatalogoToScroll();
}

function IniDialog() {
    $('#DialogMensajes').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
        buttons:
        {
            "Aceptar": function () {
                $(this).dialog('close');
            }
        }
    });
}

function LinkCargarCatalogoToScroll() {
    if (tipoOrigen != '3') {
        $(window).scroll(CargarCatalogoScroll);
    }    
}

function UnlinkCargarCatalogoToScroll() {
    $(window).off("scroll", CargarCatalogoScroll);
    cargandoRegistros = false;
}

function CargarCatalogoScroll() {
    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
        ValidarCargaCatalogoPersonalizado();
    }
}

function ValidarCargaCatalogoPersonalizado() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    DialogLoadingAbrir();
    ReservadoOEnHorarioRestringidoAsync(true, UnlinkCargarCatalogoToScroll, CargarCatalogoPersonalizado);
}

function CargarCatalogoPersonalizado() {
    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
    if (cataPer != "1" && cataPer != "2") {
        if (tipoOrigen == '3') 
            $("#divMainCatalogoPersonalizado").remove();        
        else if (tipoOrigen == '1') 
            UnlinkCargarCatalogoToScroll();
        
        return false;
    }

    var esCatalogoPersonalizadoZonaValida = $("#hdEsCatalogoPersonalizadoZonaValida").val();
    if (esCatalogoPersonalizadoZonaValida != "True") {
        if (tipoOrigen == '3')
            $("#divMainCatalogoPersonalizado").remove();
        //else if (tipoOrigen == '1') 
        //    $('#boton_vermas').hide();  // ya no esta el btn ver mas
        return false;
    }

    var dataAjax = null;
    if (tipoOrigen != '3') {
        dataAjax = { cantidad: cantidadRegistros, offset: offsetRegistros };
    }
    if (loadAdd) {
        $('#divCatalogoPersonalizado').html('<div style="text-align: center; min-height:150px;"><br><br><br><br>Cargando Catalogo Personalizado<br><img src="' + urlLoad + '" /></div>');
    }
    
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerProductosCatalogoPersonalizado,
        dataType: 'json',
        data: JSON.stringify(dataAjax),
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            data.data = data.data || new Array();
            if (data.success) {
                if (loadAdd) {
                    $("#divCatalogoPersonalizado").html("");
                }
                loadAdd = false;

                if (tipoOrigen == '3') {
                    $("#linea_separadoraCP").show();
                }
                if (data.data.length == 0) {
                    if (tipoOrigen == '3') {
                        $("#divMainCatalogoPersonalizado").remove();
                    }
                    return false;
                }

                //data.data[0].TieneOfertaEnRevista = true;
                //data.data[0].TipoOfertaRevista = '048';
                //data.data[0].CUV = '10989';
                //data.data[1].TieneOfertaEnRevista = true;
                //data.data[1].TipoOfertaRevista = '048';
                //data.data[1].CUV = '11791';

                var htmlDiv = SetHandlebars("#template-catalogopersonalizado", data.data);
                $('#divCatalogoPersonalizado').append(htmlDiv);
                
                if (tipoOrigen == '3') {
                    $("#divMainCatalogoPersonalizado").show();
                } else {
                    if (data.data.length < cantidadRegistros) UnlinkCargarCatalogoToScroll();
                    offsetRegistros += cantidadRegistros;
                }
            }
            else {
                data.data = new Array();
            }

            if (data.data.length == 0) {
                $("#divMainCatalogoPersonalizado").remove();
                $("#linea_separadoraCP").hide();
            }
        },
        error: function (data, error) {
        },
        complete: function () {
            DialogLoadingCerrar();
            cargandoRegistros = false;
        }
    });
}

function AgregarProductoCatalogoPersonalizado(item) {
    DialogLoadingAbrir();

    var divPadre = item;
    var attItem = $(item).attr("data-item") || "";
    if (attItem == "") {
        divPadre = $(item).parents("[data-item]").eq(0);
    }

    var cuv = $(divPadre).find(".hdItemCuv").val();
    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
    var tipoOfertaSisID = $(divPadre).find(".hdItemTipoOfertaSisID").val();
    var configuracionOfertaID = $(divPadre).find(".hdItemConfiguracionOfertaID").val();
    var indicadorMontoMinimo = $(divPadre).find(".hdItemIndicadorMontoMinimo").val();
    var tipo = $(divPadre).find(".hdItemTipo").val();
    var marcaID = $(divPadre).find(".hdItemMarcaID").val();
    var precioUnidad = $(divPadre).find(".hdItemPrecioUnidad").val();
    var descripcionProd = $(divPadre).find(".hdItemDescripcionProd").val();
    var pagina = $(divPadre).find(".hdItemPagina").val();
    var descripcionCategoria = $(divPadre).find(".hdItemDescripcionCategoria").val();
    var descripcionMarca = $(divPadre).find(".hdItemDescripcionMarca").val();
    var descripcionEstrategia = $(divPadre).find(".hdItemDescripcionEstrategia").val();
    var OrigenPedidoWeb = $(divPadre).find(".OrigenPedidoWeb").val();

    if (!isInt(cantidad)) {
        DialogMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
        DialogLoadingCerrar();
        return false;
    }

    if (cantidad <= 0) {
        DialogMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
        DialogLoadingCerrar();
        return false;
    }

    var model = {
        TipoOfertaSisID: tipoOfertaSisID,
        ConfiguracionOfertaID: configuracionOfertaID,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        MarcaID: marcaID,
        Cantidad: cantidad,
        PrecioUnidad: precioUnidad,
        CUV: cuv,
        Tipo: tipo,
        DescripcionProd: descripcionProd,
        Pagina: pagina,
        DescripcionCategoria: descripcionCategoria,
        DescripcionMarca: descripcionMarca,
        DescripcionEstrategia: descripcionEstrategia,
        EsSugerido: false,
        OrigenPedidoWeb: OrigenPedidoWeb
    };

    if (tipoOrigen == '3') {
        var imagenProducto = $('#imagenAnimacion>img', item);

        if (imagenProducto.length > 0) {
            var carrito = $('.campana');

            $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

            $(".transicion").css({
                'height': imagenProducto.css("height"),
                'width': imagenProducto.css("width"),
                'top': imagenProducto.offset().top,
                'left': imagenProducto.offset().left,
            }).animate({
                'top': carrito.offset().top - 60,
                'left': carrito.offset().left + 100,
                'height': carrito.css("height"),
                'width': carrito.css("width"),
                'opacity': 0.5
            }, 450, 'swing', function () {
                $(this).animate({
                    'top': carrito.offset().top,
                    'opacity': 0,
                }, 150, 'swing', function () {
                    $(this).remove();
                });
            });
        }
    }

    AgregarProducto('Insert', model, function () { $(divPadre).find(".product-add").show(); });
    //TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);    
}
function AgregarProducto(url, item, otraFunct) {
    DialogLoadingAbrir();

    tieneMicroefecto = true;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/' + url,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (data.success == true) {
                ActualizarGanancia(data.DataBarra);
                if (tipoOrigen == '2') {
                    CargarCantidadProductosPedidos();
                }
                else {
                    CargarResumenCampaniaHeader(true);
                }

                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);

                if (typeof (otraFunct) == 'function' || typeof (otraFunct) == 'string') {
                    setTimeout(otraFunct, 50);
                }
            }
            else {
                DialogMensaje(data.message);
            }
            DialogLoadingCerrar();
        },
        error: function (data, error) {
            tieneMicroefecto = false;
            AjaxError(data, error);
        }
    });
}

function ObtenerOfertaRevista(item) {
    // 201615 - 032610099 peru
    DialogLoadingAbrir();
    var $contenedor = item;
    var cuv = $contenedor.find('.hdItemCuv').val();
    // 11791 (mucha data) "10989" (niveles);// 
    var tipoOfertaRevista = $.trim($contenedor.find('.hdItemTipoOfertaRevista').val());

    var obj = {
        UrlImagen: $contenedor.find('[data-img]>img').attr('src'),
        CUV: $contenedor.find('.hdItemCuv').val(),
        TipoOfertaSisID: $contenedor.find('.hdItemTipoOfertaSisID').val(),
        ConfiguracionOfertaID: $contenedor.find('.hdItemConfiguracionOfertaID').val(),
        IndicadorMontoMinimo: $contenedor.find('.hdItemIndicadorMontoMinimo').val(),
        MarcaID: $contenedor.find('.hdItemMarcaID').val(),
        PrecioCatalogo: $contenedor.find('.hdItemPrecioUnidad').val(),
        Descripcion: $contenedor.find('.hdItemDescripcionProd').val(),
        DescripcionCategoria: $contenedor.find('.hdItemDescripcionCategoria').val(),
        DescripcionMarca: $contenedor.find('.hdItemDescripcionMarca').val(),
        DescripcionEstrategia: $contenedor.find('.hdItemDescripcionEstrategia').val()
    };
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'CatalogoPersonalizado/ObtenerOfertaRevista',
        dataType: 'json',
        data: JSON.stringify({ cuv: cuv, tipoOfertaRevista: tipoOfertaRevista }),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            $('[data-oferta]').attr("class", "").hide();
            if (tipoOrigen == '2') {
                $('[data-oferta]').addClass("MensajeAlertaMobile")
            }
            if (!response.success) {
                DialogLoadingCerrar();
                return false;
            }
            response.data.dataPROL.Simbolo = vbSimbolo;
            response.data.dataPROL.TxtGanancia = response.data.txtGanancia;
            response.data.dataPROL.TxtRecibeGratis = response.data.txtRecibeGratis;
            var settings = $.extend({}, response.data.dataPROL, obj);
            settings.productoRevista = response.data.producto;
            TrackingJetloreView(cuv, $("#hdCampaniaCodigo").val())
            if (response.data.dataPROL != undefined && response.data.dataPROL != null) {
                switch (settings.tipo_oferta) {
                    case '003':
                        //settings.precio_catalogo = DecimalToStringFormat(settings.precio_catalogo);
                        //settings.precio_revista = DecimalToStringFormat(settings.precio_revista);
                        //settings.ganancia = DecimalToStringFormat(settings.ganancia);
                        SetHandlebars("#template-mod-ofer1", settings, '[data-oferta]');
                        $('[data-oferta]').addClass('mod-ofer1').show();
                        break;
                    case '048':
                        if (settings.lista_oObjPack.length > 0) {
                            settings.lista_oObjPack = RemoverRepetidos(settings.lista_oObjPack);
                            settings.lista_oObjItemPack = RemoverRepetidos(settings.lista_oObjItemPack);
                            settings.lista_oObjPack.splice(2, settings.lista_oObjPack.length);
                            settings.lista_oObjPack[settings.lista_oObjPack.length - 1].EsUltimo = 1;
                            SetHandlebars("#template-mod-ofer3", settings, '[data-oferta]');
                            $('[data-oferta]').addClass('mod-ofer3').show();
                        }
                        else if (settings.lista_ObjNivel.length > 0) {
                            settings.lista_ObjNivel = RemoverRepetidos(settings.lista_ObjNivel);
                            settings.lista_oObjGratis = RemoverRepetidos(settings.lista_oObjGratis);
                            settings.lista_ObjNivel.splice(3, settings.lista_ObjNivel.length);
                            SetHandlebars("#template-mod-ofer2", settings, '[data-oferta]');
                            var cantNo = 0;
                            $.each($('[data-oferta] .item1_oferta_personalizada'), function (ind, nivel) {
                                if ($.trim($(nivel).find(".content_sub_items").html()) == "") {
                                    $(nivel).find(".gratis_set").html("");
                                    $(nivel).find(".content_sub_items").remove("");
                                    cantNo++;
                                }
                            });
                            $('[data-oferta]').addClass('mod-ofer2').show();
                            if (cantNo == $('[data-oferta] .item1_oferta_personalizada').length) {
                                $('[data-oferta] .item1_oferta_personalizada .content_sub_items').remove();
                                var marginP = $("[data-oferta] [data-oferta-popup]").height() / 2;
                                $("[data-oferta] [data-oferta-popup]").css('margin', '-' + marginP + 'px auto auto auto');
                            }
                        }
                        break;
                }
            }
            
            DialogLoadingCerrar();
        },
        error: function (response, error) {
            DialogLoadingCerrar();
        }
    });
}

function AgregarProductoOfertaRevista(btn) {

    var tipoCUV = $(btn).attr('data-cuv');
    var item = $(btn).parents("[data-oferta-popup]");

    DialogLoadingAbrir();
    var hidden = "";

    if (tipoCUV == 'revista' || tipoCUV == 'pack') {
        hidden = $(item).find('#hiddenRevista');
    } else if (tipoCUV == 'catalogo') {
        hidden = $(item).find('#hiddenCatalogo');
    }

    if (hidden.length == 0) {
        DialogLoadingCerrar();
        return false;
    }

    var cantidad = $(item).find('[data-cantidad-input="' + tipoCUV + '"]').val();
    
    if (!isInt(cantidad)) {
        DialogMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
        DialogLoadingCerrar();
        return false;
    }

    if (cantidad <= 0) {
        DialogMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
        DialogLoadingCerrar();
        return false;
    }

    var precioUnidadAdd = $(hidden).find(".hdItemPrecioUnidad").val();
    if (tipoCUV == 'pack') {
        precioUnidadAdd = $(btn).parents(".item_pack_personalizado").find('.hdItemPackPrecio').val();
    }

    var cuvAdd = tipoCUV == 'pack' ? $(btn).attr("data-cuvadd") : $(hidden).find(".hdItemCuv").val();
    var model = {
        TipoOfertaSisID: $(hidden).find(".hdItemTipoOfertaSisID").val(),
        ConfiguracionOfertaID: $(hidden).find(".hdItemConfiguracionOfertaID").val(),
        IndicadorMontoMinimo: $(hidden).find(".hdItemIndicadorMontoMinimo").val(),
        MarcaID: $(hidden).find(".hdItemMarcaID").val(),
        Cantidad: cantidad,
        PrecioUnidad: precioUnidadAdd,
        CUV: cuvAdd,
        Tipo: $(hidden).find(".hdItemTipo").val(),
        DescripcionProd: $(hidden).find(".hdItemDescripcionProd").val(),
        Pagina: $(hidden).find(".hdItemPagina").val(),
        DescripcionCategoria: $(hidden).find(".hdItemDescripcionCategoria").val(),
        DescripcionMarca: $(hidden).find(".hdItemDescripcionMarca").val(),
        DescripcionEstrategia: $(hidden).find(".hdItemDescripcionEstrategia").val(),
        EsSugerido: false,
        OrigenPedidoWeb: $(hidden).find(".OrigenPedidoWeb").val()
    };

    var imagenProducto = $('#imagenAnimacion>img', item);

    if (imagenProducto.length > 0) {
        var carrito = $('.campana');

        $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

        $(".transicion").css({
            'height': imagenProducto.css("height"),
            'width': imagenProducto.css("width"),
            'top': imagenProducto.offset().top,
            'left': imagenProducto.offset().left,
        }).animate({
            'top': carrito.offset().top - 60,
            'left': carrito.offset().left + 100,
            'height': carrito.css("height"),
            'width': carrito.css("width"),
            'opacity': 0.5
        }, 450, 'swing', function () {
            $(this).animate({
                'top': carrito.offset().top,
                'opacity': 0,
            }, 150, 'swing', function () {
                $(this).remove();
            });
        });
    }

    AgregarProducto('Insert', model, function () {
        $("[data-item='catalogopersonalizado']:has(.hdItemCuv[value='" + cuvAdd + "'])").find(".product-add").show();
        //$('[class^=mod-ofer]').hide();
        $('[data-oferta]').attr("class", "").hide();
    });
    //TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
}

function agregarProductoAlCarrito(o) {
    var btnClickeado = $(o);
    var contenedorItem = btnClickeado.parent().parent();
    var imagenProducto = $('.imagen_producto', contenedorItem);

    if (imagenProducto.length <= 0) {
        return false;
    }

    var carrito = $('.campana');

    $("body").prepend('<img src="' + imagenProducto.attr("src") + '" class="transicion">');

    $(".transicion").css({
        'height': imagenProducto.css("height"),
        'width': imagenProducto.css("width"),
        'top': imagenProducto.offset().top,
        'left': imagenProducto.offset().left,
    }).animate({
        'top': carrito.offset().top - 60,
        'left': carrito.offset().left + 100,
        'height': carrito.css("height"),
        'width': carrito.css("width"),
        'opacity': 0.5
    }, 450, 'swing', function () {
        $(this).animate({
            'top': carrito.offset().top,
            'opacity': 0,
            //}, 100, 'swing', function () {
            //    $(".campana .info_cam").fadeIn(200);
            //    $(".campana .info_cam").delay(2500);
            //    $(".campana .info_cam").fadeOut(200);
        }, 150, 'swing', function () {
            $(this).remove();
        });
    });

}

function DialogMensaje(msj) {
    if (tipoOrigen == '2') {
        messageInfo(msj);
    }
    else {
        alert_msg_pedido(msj);
    }
}

function alert_msg_pedido(message) {
    $('#DialogMensajes .pop_pedido_mensaje').html(message);
    $('#DialogMensajes').dialog('open');
}

function DialogLoadingCerrar() {
    if (tipoOrigen == '2') {
        CloseLoading();
    }
    else {
        closeWaitingDialog();
    }
}
function DialogLoadingAbrir() {
    if (tipoOrigen == '2') {
        ShowLoading();
    }
    else {
        waitingDialog();
    }
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        async: false,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }
            if (!data.pedidoReservado || mostrarAlerta == true) {
                if (mostrarAlerta == true) {
                    DialogLoadingCerrar();
                    DialogMensaje(data.message)
                }
                return false;
            }

            if (mostrarAlerta != true) {
                DialogLoadingAbrir();
                location.href = urlPedidoValidado;
            }
            
        },
        error: function (error) {
            DialogLoadingCerrar();
            DialogMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}

function ReservadoOEnHorarioRestringidoAsync(mostrarAlerta, fnRestringido, fnNoRestringido) {
    if (!$.isFunction(fnRestringido)) return false;
    if (!$.isFunction(fnNoRestringido)) return false;
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        async: true,
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (!checkTimeout(data)) return false;
            if (!data.success) {
                fnNoRestringido();
                return false;
            }

            if (data.pedidoReservado && !mostrarAlerta) {
                DialogLoadingAbrir();
                location.href = urlPedidoValidado;
                return false;
            }

            if (mostrarAlerta) {
                DialogLoadingCerrar();
                DialogMensaje(data.message);
            }
            fnRestringido();
        },
        error: function (error) {
            console.log(error);
            DialogMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
}