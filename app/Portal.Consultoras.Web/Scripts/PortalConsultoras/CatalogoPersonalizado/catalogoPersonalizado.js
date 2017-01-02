﻿
var tipoOrigen = tipoOrigen || "";// 1: escritorio (no home)     2: mobile,  3: home
var cantidadRegistros = cantidadRegistros || 12;
var offsetRegistros = 0;
/* SB20-1197 - INICIO */
var totalRegistros = 0;
//var precioMinimo = 0;
//var precioMaximo = 0;
var primeraVez = false;
var primerScroll = false;
var filters = [];
var clearFilters = false;
/* SB20-1197 - FIN */
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
    $("#divmaquetaof48nivel").hide();
    $("[data-maq]").hide();

    //$("#txt-range-price").slider({});

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
        primerScroll = true;
    }
}

function ValidarCargaCatalogoPersonalizado() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    DialogLoadingAbrir();
    ReservadoOEnHorarioRestringidoAsync(true, UnlinkCargarCatalogoToScroll, CargarCatalogoPersonalizado);
}


/* SB20-1197- INICIO */

function processFilterCatalogoPersonalizado(type)
{
    // reset values
    filters = [];
    primerScroll = false;

    if ($('#orderby-price').val() != '-1') {
        var f = {
            Id: '1',
            Orden: $('#orderby-price').val().toUpperCase()
        }
        filters.push(f);
    }

    $('#custom-filters').hide();
    $('#orderby-filter').show();
    $('#divCatalogoPersonalizado').show();
   
    var marcaIds = "";
    $('.content-category').find('input[type="checkbox"]:checked').each(function () {
        marcaIds += $(this).val() + ',';
    });

    if (marcaIds != "") {
        var f = {
            Id: '2',
            Valor1: marcaIds.substring(0, marcaIds.length - 1)
        }
        filters.push(f);
    }
    
    var range = $('#txt-range-price').bootstrapSlider('getValue');
    if (range != 'undefined') {
        var f = {
            Id: '3',
            Valor1: range[0],
            Valor2: range[1]
        }
        filters.push(f);
    }
    
    if (filters.length > 0) {
        LinkCargarCatalogoToScroll();
        CargarCatalogoPersonalizado();
    }
}

function showCustomFilters() {
    $('#orderby-filter').hide();
    $('#divCatalogoPersonalizado').hide();
    $('#custom-filters').show();
    UnlinkCargarCatalogoToScroll();
}

function showOrderbyFilter() {
    $('#custom-filters').hide();
    $('#orderby-filter').show();
    $('#divCatalogoPersonalizado').show();
    LinkCargarCatalogoToScroll();
}

//function deleteFilters() {
//    $('#custom-filters').hide();
//    $('#summary-filters').hide();
//    $('#orderby-filter').show();

//    $('#orderby-price').val('-1');
//    //$('input[name="category"]:checked').attr('checked', false);
//    $('input[name="brand"]:checked').attr('checked', false);
//}

function deleteFilters() {

    $('#custom-filters').hide();
    //$('#summary-filters').hide();
    $('#div-delete-filters').hide();
    $('#orderby-filter').show();
    $('#divCatalogoPersonalizado').show();

    // reset values
    filters = [];
    $('#orderby-price').val('-1');
    //$('input[name="category"]:checkbox').attr('checked', false);
    $('input[name="brand"]:checkbox').attr('checked', false);

    jQuery.ajax({
        type: 'POST',
        url: '/CatalogoPersonalizado/BorrarFiltros',
        dataType: 'json',
        //data: JSON.stringify(obj),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                clearFilters = true;
                CargarCatalogoPersonalizado();
            }
            else {
                alert(response.message);
            }
        },
        error: function (xhr, status, err) {
            alert('Error al borrar los filtros');
        },
        complete: function () {
        }
    });
}

/* SB20-1197 - FIN */

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
    
    if (clearFilters) {
        offsetRegistros = 0;
        loadAdd = true;
        clearFilters = false;
    }

    /* SB20-1197 - FIN */

    var dataAjax = null;
    if (tipoOrigen != '3') {
        /* SB20-1197 - INICIO */
        if (filters.length > 0) {
            if (!primerScroll) {
                offsetRegistros = 0;
                loadAdd = true;
            }
            dataAjax = { cantidad: cantidadRegistros, offset: offsetRegistros, lstFilters: filters };
        }
        else {
            dataAjax = { cantidad: cantidadRegistros, offset: offsetRegistros };
        }
        /* SB20-1197 - FIN */
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

                    var rsnum = 'Mostrando 0 de ' + data.totalRegistros + ' productos';
                    $('#result-number').text(rsnum);
                    $('#div-delete-filters').show();

                    return false;
                }

                //data.data[0].TieneOfertaEnRevista = true;
                //data.data[0].TipoOfertaRevista = '048';
                //data.data[0].CUV = '96847'; //03184
                //data.data[1].TieneOfertaEnRevista = true;
                //data.data[1].TipoOfertaRevista = '048';
                //data.data[1].CUV = '01411';

                var htmlDiv = SetHandlebars("#template-catalogopersonalizado", data.data);
                $('#divCatalogoPersonalizado').append(htmlDiv);

                /* SB20-1197 - INICIO */
                if (!primeraVez) {
                    totalRegistros = data.totalRegistros;

                    var min = parseFloat(data.precioMinimo);
                    var max = parseFloat(data.precioMaximo);
                    var rr = [];
                    rr.push(min);
                    rr.push(max);

                    $('#min-range-price').text(min);
                    $('#max-range-price').text(max);

                    $('#txt-range-price').bootstrapSlider({
                        'precision': 2,
                        'min': min,
                        'max': max,
                        'value': rr,
                    });

                    primeraVez = true;
                }
                /* SB20-1197 - FIN */

                if (tipoOrigen == '3') {
                    $("#divMainCatalogoPersonalizado").show();
                } else {
                    if (data.data.length < cantidadRegistros) UnlinkCargarCatalogoToScroll();
                    offsetRegistros += cantidadRegistros;
                    //offsetRegistros += data.data.length;
                }

                /* SB20-1197 - INICIO */
                var rsnum = 'Mostrando ' + data.totalRegistrosFilter + ' de ' + totalRegistros + ' productos';
                $('#result-number').text(rsnum);

                if (totalRegistros != data.totalRegistrosFilter) {
                    $('#div-delete-filters').show();
                }
                else {
                    $('#div-delete-filters').hide();
                }
                /* SB20-1197 - FIN */
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

/* SB20-1197 - FIN */

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
                //ActualizarGanancia(data.DataBarra);
                if (tipoOrigen == "3") {
                    MostrarBarra(data, '1');
                }
                else {
                    ActualizarGanancia(data.DataBarra);
                }
                
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
            else messageInfoError(data.message);
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
                $('[data-oferta]').addClass("MensajeAlertaMobile");
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
                        //settings.lista_oObjPack = settings.lista_ObjNivel;
                        //settings.lista_oObjItemPack = settings.lista_oObjGratis;
                        if (settings.lista_oObjPack.length > 0) {
                            settings.lista_oObjPack = RemoverRepetidos(settings.lista_oObjPack);
                            settings.lista_oObjItemPack = RemoverRepetidos(settings.lista_oObjItemPack);
                            //settings.lista_oObjPack.splice(2, settings.lista_oObjPack.length);
                            settings.lista_oObjPack[settings.lista_oObjPack.length - 1].EsUltimo = 1;
                            SetHandlebars("#template-mod-ofer3", settings, '[data-oferta]');
                            $('[data-oferta]').addClass('mod-ofer3').show();

                            if (tipoOrigen != "2") {
                                $('.js-slick-prev').remove();
                                $('.js-slick-next').remove();
                                $('#divCarruselPack.slick-initialized').slick('unslick');
                                $('#divCarruselPack').not('.slick-initialized').slick({
                                    infinite: true,
                                    vertical: false,
                                    slidesToShow: 2,
                                    slidesToScroll: 1,
                                    autoplay: false,
                                    speed: 260,
                                    prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: -20px;top: 40px;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                                    nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: -20px;top:40px;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
                                    responsive: [
                                        {
                                            breakpoint: 1025,
                                            settings: {
                                                slidesToShow: 3
                                            }
                                        }
                                    ]
                                });
                            }                            
                        }
                        else if (settings.lista_ObjNivel.length > 0) {
                            settings.lista_ObjNivel = RemoverRepetidos(settings.lista_ObjNivel);
                            settings.lista_oObjGratis = RemoverRepetidos(settings.lista_oObjGratis);
                            var lista = Clone(settings.lista_ObjNivel);
                            settings.lista_ObjNivel = new Array();
                            $.each(lista, function (ind, nivel) {
                                if (nivel.escala_nivel > 1) {
                                    settings.lista_ObjNivel.push(nivel);
                                }
                            });
                            //settings.lista_ObjNivel.splice(3, settings.lista_ObjNivel.length);
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
                                //if (tipoOrigen != "2") {
                                //    var marginP = $("[data-oferta] [data-oferta-popup]").height() / 2;
                                //    $("[data-oferta] [data-oferta-popup]").css('margin', '-' + marginP + 'px auto auto auto');
                                //}
                            }
                            
                            if (tipoOrigen != "2") {
                                $('.js-slick-prev').remove();
                                $('.js-slick-next').remove();
                                $('#divCarruselNivel.slick-initialized').slick('unslick');
                                $('#divCarruselNivel').not('.slick-initialized').slick({
                                    infinite: true,
                                    vertical: false,
                                    slidesToShow: 3,
                                    slidesToScroll: 1,
                                    autoplay: false,
                                    speed: 260,
                                    prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                                    nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
                                    responsive: [
                                        {
                                            breakpoint: 1025,
                                            settings: {
                                                slidesToShow: 3
                                            }
                                        }
                                    ]
                                });
                            }                            
                        }
                        else {
                            if (settings.precio_catalogo != "" && settings.CUV != "") {
                                SetHandlebars("#template-mod-ofer1", settings, '[data-oferta]');
                                $('[data-oferta]').addClass('mod-ofer1').show();
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
    if (carrito.length <= 0) {
        return false;
    }

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

function DialogMensaje(msj, funcionRedireccionar) {
    if (tipoOrigen == '2') {
        messageInfo(msj, funcionRedireccionar);
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
                    DialogMensaje(data.message);
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
            DialogLoadingAbrir();

            var fnRedireccionar = function () {
                DialogLoadingAbrir();
                location.href = urlPedidoValidado;
            };                       

            if (data.pedidoReservado) {
                if (mostrarAlerta) {
                    DialogLoadingCerrar();
                    DialogMensaje(data.message, fnRedireccionar);
                } else
                    fnRedireccionar();
                return false;
            }

            fnRestringido();
        },
        error: function (error) {
            console.log(error);
            DialogMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
}

function AbrirMaqueta(tipo)
{
    if (tipo == 2) {
        $('#divmaquetaof48nivel').addClass('mod-ofer2').show();
        $('#divmaquetaof48nivel').show();
    }
    else if (tipo == 3) {
        $('#divmaquetaof48pack').addClass('mod-ofer3').show();
        $('#divmaquetaof48pack').show();
    }
}