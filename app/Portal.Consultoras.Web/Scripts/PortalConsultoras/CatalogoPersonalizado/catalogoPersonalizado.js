﻿
var tipoOrigen = tipoOrigen || "";// 1: escritorio (no home)     2: mobile,  3: home
var cantidadTonosPorFila = 6;
var cantidadRegistros = cantidadRegistros || 12;
var offsetRegistros = 0;
var totalRegistros = 0;
var primeraVez = false;
var primerScroll = false;
var filters = [];
var clearFilters = false;
var cargandoRegistros = false;
var loadAdd = true;
var urlLoad = urlLoad || "";

var rangoPrecios = 0;
var mPremax = 0.00;
var mPremin = 0.00;
var flagEvento = true;

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

    CargarFiltros();

    if (tipoOrigen != '3') {
        if (typeof cargarItemsFAV != 'undefined') {
            if (cargarItemsFAV) {
                Inicializar();
            }
        }
        else {
            Inicializar();
        }
    }

    $("#divmaquetaof48nivel").hide();
    $("[data-maq]").hide();

    if (tipoOrigen == '2') {
        $(".chkFiltroMobile").on("click", function () {
            if ($('#custom-filters').is(":visible"))
                processFilterCatalogoPersonalizado();
        });
    }

    $(".texto_fav_filtro").on("click", function () {
        deleteFilters();
    });

    $(".seleccion_filtro_fav").on("click", function () {
        $(this).toggleClass("seleccion_click_flitro");
        filterFAVDesktop();
    });

    $('#filter-sorting').val('03');

    if (tipoOrigen == 2) $('#orderby-price').val('03'); 

    if (tipoOrigen == '1') {

        var myformat = simbolo + '%s';
        var scala1 = simbolo + precioMin;
        var scala2 = simbolo + precioMax;
        $('.range-slider').val(precioMin + ',' + precioMax);

        $('.range-slider').show();
        $('.range-slider').jRange({
            from: precioMin,
            to: precioMax,
            step: 0.01,
            scale: [scala1,scala2],
            format: myformat,
            width: '',
            showLabels: true,
            isRange: true,
            ondragend: function (myvalue) {
                rangoPrecios = myvalue;
                $(".slider-container").addClass("disabledbutton");
                filterFAVDesktop();

            },
            onbarclicked: function (myvalue) {
                rangoPrecios = myvalue;

                $(".slider-container").addClass("disabledbutton");
                filterFAVDesktop();
            }
        });
        $('.slider-container').css('width', '');
        
    }
});

function Inicializar() {
    //IniDialog();
    ValidarCargaCatalogoPersonalizado();
    LinkCargarCatalogoToScroll();
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
    if ($(window).scrollTop() + $(window).height() > ($(document).height() - $('footer').outerHeight())) {
        ValidarCargaCatalogoPersonalizado();
        primerScroll = true;
    }
}

function ValidarCargaCatalogoPersonalizado() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    DialogLoadingAbrir();
    ReservadoOEnHorarioRestringidoAsync(
        true,
        function () {
            UnlinkCargarCatalogoToScroll();
            DialogLoadingCerrar();
        },
        function () {
            DialogLoadingCerrar();
            CargarCatalogoPersonalizado();
        });
}

function MostrarNoHayProductos() {
    if (tipoOrigen != '3') {
        $('.texto_descripcionCatalogoPersonalizado').text('Estamos cargando los productos. Por favor regresa más tarde.');
        $('#orderby-filter').hide();
    }
}

function processFilterCatalogoPersonalizado()
{
    // reset values
    filters = [];
    primerScroll = false;
    //ordenamiento
    if ($('#orderby-price').val() != '-1') {
        var f = {
            Id: '1',
            Orden: $('#orderby-price').val().toUpperCase()
        }
        filters.push(f);
    }
   
    //Categorias
    var values = "";
    $('#idcategory').find('input[type="checkbox"]:checked').each(function () {
        values += $(this).val() + ',';
    });       

    var f = {
        Id: '2',
        Valor1: values.substring(0, values.length - 1)
    }
    filters.push(f);

    //Marca
    values = "";
    $('#idmarca').find('input[type="checkbox"]:checked').each(function () {
        values += $(this).val() + ',';
    });        

    var f = {
        Id: '3',
        Valor1: values.substring(0, values.length - 1)
    }
    filters.push(f);
    
    //precio
    var range = $('#txt-range-price').bootstrapSlider('getValue');
    if (range != 'undefined') {
        var f = {
            Id: '4',
            Valor1: range[0],
            Valor2: range[1]
        }
        filters.push(f);
    }
    
    if (filters.length > 0) {
        LinkCargarCatalogoToScroll();
        CargarCatalogoPersonalizado();
        $('body').css({ 'overflow-y': 'scroll' });
    }

    flagEvento = true;
}

function OcultarSliderMobile()
{
    processFilterCatalogoPersonalizado()
    $('#custom-filters').hide();  
    $('#orderby-filter').show();
    $('#divCatalogoPersonalizado').show();
}

function showCustomFilters() {
    $('body').css({ 'overflow-x': 'hidden' });
    $('body').css({ 'overflow-y': 'hidden' });
    $('#orderby-filter').hide();
    $('#divCatalogoPersonalizado').hide();
    $('#custom-filters').show();

    UnlinkCargarCatalogoToScroll();
}

function showOrderbyFilter() {
    $('body').css({ 'overflow-y': 'scroll' });
    $('#custom-filters').hide();
    $('#orderby-filter').show();
    $('#divCatalogoPersonalizado').show();
    LinkCargarCatalogoToScroll();
}
$(".title-accordion").on("click", function () { $(this).toggleClass("flecha_arriba"); });

function deleteFilters() {
    if (tipoOrigen == '2') {
        $('#custom-filters').hide();
        //$('#summary-filters').hide();
        $('#div-delete-filters').hide();
        $('#orderby-filter').show();
        $('#divCatalogoPersonalizado').show();

        // reset values
        filters = [];
        $('#orderby-price').val('03');
        //$('input[name="category"]:checkbox').attr('checked', false);
        $('input[name="brand"]:checkbox').attr('checked', false);
        $('input[name="categoria"]:checkbox').attr('checked', false);
        //PL20-1274
        $("#btnfltm").attr('value', 'FILTROS');
    }

    if (tipoOrigen == '1') {
        filters = [];
        $('.seleccion_filtro_fav').removeClass("seleccion_click_flitro");
        var rs = precioMin + ',' + precioMax;
        $('.range-slider').jRange('setValue', rs);
        $('#filter-sorting').val('03');
        $('.texto_fav_filtro').hide();
        $('#limiteFlt').hide();
        //filterFAVDesktop();
    }

    $('#txt-range-price').bootstrapSlider('setValue', [mPremin, mPremax]);

    jQuery.ajax({
        type: 'POST',
        url: '/CatalogoPersonalizado/BorrarFiltros',
        dataType: 'json',
        //data: JSON.stringify(obj),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    clearFilters = true;
                    CargarCatalogoPersonalizado();
                    $('body').css({ 'overflow-y': 'scroll' });
                }
                else {
                    alert(response.message);
                }
            }
        },
        error: function (data, xhr, status, err) {
            if (checkTimeout(data)) {
                alert('Error al borrar los filtros');
            }
        },
        complete: function () {
        }
    });
    LinkCargarCatalogoToScroll();   
}

function CargarCatalogoPersonalizado() {

    var cataPer = $("#hdTipoCatalogoPersonalizado").val();
    if (cataPer != "1" && cataPer != "2") {
        if (tipoOrigen == '3') $("#divMainCatalogoPersonalizado").remove();        
        else if (tipoOrigen == '1') UnlinkCargarCatalogoToScroll();

        if (!primeraVez) MostrarNoHayProductos();

        return false;
    }

    var esCatalogoPersonalizadoZonaValida = $("#hdEsCatalogoPersonalizadoZonaValida").val();
    if (esCatalogoPersonalizadoZonaValida != "True") {
        if (tipoOrigen == '3') $("#divMainCatalogoPersonalizado").remove();

        if (!primeraVez) MostrarNoHayProductos();

        return false;
    }
    
    if (clearFilters) {
        offsetRegistros = 0;
        loadAdd = true;
        clearFilters = false;
    }

    var dataAjax = null;
    if (tipoOrigen != '3') {

        if (filters.length > 0) {
            if (!primerScroll) {
                offsetRegistros = 0;
                loadAdd = true;
            }
            dataAjax = { cantidad: cantidadRegistros, offset: offsetRegistros, lstFilters: filters, tipoOrigen: 1 };
        }
        else dataAjax = { cantidad: cantidadRegistros, offset: offsetRegistros, tipoOrigen: 1 };

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
            if (checkTimeout(data)) {
                data.data = data.data || new Array();
                if (data.success) {
                    if (loadAdd) $("#divCatalogoPersonalizado").html("");
                    loadAdd = false;

                    if (tipoOrigen == '3') $("#linea_separadoraCP").show();
                    if (data.data.length == 0) {
                        if (tipoOrigen == '3') {
                            $("#divMainCatalogoPersonalizado").remove();

                            var rsnum = 'Mostrando 0 de ' + data.totalRegistros + ' productos';
                            $('#result-number').text(rsnum);
                            $('#div-delete-filters').show();
                        }

                        if (tipoOrigen == '1') {
                            $("#divCantProductos").html("Mostrando 0 de " + data.totalRegistros + " productos");
                            UnlinkCargarCatalogoToScroll();
                        }
                        return false;
                    }

                    if (tipoOrigen == 1) {
                        if (data.totalFiltros != 0) {
                            $('.texto_fav_filtro').show();
                            $('#limiteFlt').show();
                        } else {
                            $('.texto_fav_filtro').hide();
                            $('#limiteFlt').hide();
                        }
                    }

                    var htmlDiv = SetHandlebars("#template-catalogopersonalizado", data.data);
                    $('#divCatalogoPersonalizado').append(htmlDiv);

                    if (tipoOrigen == 1) {
                        var t = offsetRegistros + data.data.length
                        $("#divCantProductos").html('Mostrando ' + t.toString() + " de " + data.totalRegistros + " productos");
                    }

                    if (!primeraVez) {
                        totalRegistros = data.totalRegistros;
                        if (tipoOrigen == 2) {
                            if (mPremin == 0.00 || mPremax == 0.00) {
                                mPremin = parseFloat(data.precioMinimo);
                                mPremax = parseFloat(data.precioMaximo);
                            }

                            var rr = [];
                            rr.push(mPremin);
                            rr.push(mPremax);

                            $('#min-range-price').text(data.precioMinimo);
                            $('#max-range-price').text(data.precioMaximo);

                            $('#txt-range-price').bootstrapSlider({
                                'precision': 2,
                                'min': parseFloat(data.precioMinimo),
                                'max': parseFloat(data.precioMaximo),
                                'value': rr,
                            });
                        }

                        primeraVez = true;
                    }


                    if (tipoOrigen == '3') $("#divMainCatalogoPersonalizado").show();
                    else {
                        if (data.data.length < cantidadRegistros) UnlinkCargarCatalogoToScroll();
                        offsetRegistros += data.data.length;
                    }

                    if (tipoOrigen == 2) {
                        var cont = offsetRegistros;
                        var rsnum = 'Mostrando ' + cont.toString() + ' de ' + totalRegistros + ' productos'; //PL20 - 1273
                        $('#result-number').text(rsnum);

                        if (data.totalFiltros != 0) $('#div-delete-filters').show();
                        else $('#div-delete-filters').hide();


                        $('#divProductosEncontrados b').text(cont.toString()); //PL1274 

                        var btnflt = "FILTROS";

                        if (data.totalFiltros != 0)
                            btnflt = "FILTROS (" + data.totalFiltros + ")";
                        $("#btnfltm").attr('value', btnflt);
                    }
                
                    if (tipoOrigen == 3) {
                    $('#fav-home-total').text('Te mostramos ' + data.data.length + ' de ' + data.totalRegistros + ' productos.');
                    }

                }
                else data.data = new Array();

                if (data.data.length == 0) {
                    $("#divMainCatalogoPersonalizado").remove();
                    $("#linea_separadoraCP").hide();
                    if (!primeraVez) MostrarNoHayProductos();

                }
            }
        },
        error: function (data) {
            if (checkTimeout(data)) {
                if (loadAdd) $("#divCatalogoPersonalizado").html("Ocurrió un problema de conexión al intentar cargar los productos.");
            }
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
            if (checkTimeout(data)) {
                if (data.success == true) {
                    //ActualizarGanancia(data.DataBarra);
                    if (tipoOrigen == '3') {
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

                    if (tipoOrigen == '2') {

                        if (parseInt(item.Cantidad) > 1) {
                            if (typeof codTipoOferta != 'undefined' && codTipoOferta == '048N') {
                                var resumen = getDatosResumenOferta048N(parseInt(item.Cantidad));
                                if (resumen != null && resumen.lista_oObjGratis.length > 0) {
                                    SetHandlebars("#template-resumenoferta048N", resumen, '#PopupResumenOferta048N');
                                    $('#PopupResumenOferta048N').show();
                                    DialogLoadingCerrar();
                                    return false;
                                }
                            }
                        }

                        if (typeof isAddFichaProductoFAV !== 'undefined') {
                            document.location.href = urlCatalogoPersonalizado;
                        }
                    }

                    if (tipoOrigen != 2) {
                        if ($('#PopFichaProductoNueva').is(':visible')) {
                            $('#PopFichaProductoNueva').hide();
                        }
                    }

                }
                else {
                    messageInfoError(data.message);
                }

                DialogLoadingCerrar();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                tieneMicroefecto = false;
                AjaxError(data, error);
            }
        }
    });
}

function ObtenerOfertaRevista(item) {

    DialogLoadingAbrir();
    var $contenedor = item;
    var cuv = $contenedor.find('.hdItemCuv').val();

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
            if (checkTimeout(response)) {
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
                            SetHandlebars("#template-mod-ofer1", settings, '[data-oferta]');
                            $('[data-oferta]').addClass('mod-ofer1').show();
                            break;
                        case '048':
                            if (settings.lista_oObjPack.length > 0) {
                                settings.lista_oObjPack = RemoverRepetidos(settings.lista_oObjPack);
                                settings.lista_oObjItemPack = RemoverRepetidos(settings.lista_oObjItemPack);
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
            }
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                DialogLoadingCerrar();
            }
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
        AbrirMensaje(msj);
    }
}

function DialogLoadingCerrar() {
    //console.log('DialogLoadingCerrar');
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
    /*
    if (typeof gTipoUsuario !== 'undefined') {
        if (gTipoUsuario == '2') {
            alert('Acceso restringido, aun no puede agregar pedidos');
            return true;
        }
    }
    */

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
        error: function (data, error) {
            if (checkTimeout(data)) {
                DialogLoadingCerrar();
                DialogMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
            }
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
        data: { tipoAccion : '2' },
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
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.log(error);
                DialogMensaje('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
            }
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

function mostrarFichaProductoFAV(cuv) {
    $('#CUVFP').val(cuv);
    $('#frmFichaProductoFAV').submit();
}

function mostrarFichaProductoFAV2(cuv) {
    
    waitingDialog();
    var obj = { cuv: cuv };

    jQuery.ajax({
        type: 'POST',
        url: urlGetInfoFichaProducto,
        dataType: 'json',
        data: JSON.stringify(obj),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    var _data = response.data;
                    var content = SetHandlebars("#template-fichaproductofav", _data);
                    $('#PopFichaProductoNueva').html(content);
                    AjustarTonoTooltips($('#PopFichaProductoNueva'))
                    $('#PopFichaProductoNueva').show();

                    dataFichaProductoFAV = _data.Hermanos;

                    $('#fav_tono_' + cuv).addClass("borde_seleccion_tono");
                    $('#fav_cbo_tono').val(cuv);

                    $('#hdCuvFichaProductoFAVSelect').val(cuv);

                    $(".content_tono_detalle").on("click", function () {
                        $('.content_tono_detalle').removeClass('borde_seleccion_tono');
                        $(this).addClass("borde_seleccion_tono");
                    });

                    closeWaitingDialog();
                }
                else {
                    console.log(response.message);
                }
            }
        },
        error: function (data, err) {
            if (checkTimeout(data)) {
                console.log(err);
            }
        },
        complete: function () {

        }
    });
}

function cambiarInfoFichaProductoFAV(tipo, cuv, origen) {
    if (dataFichaProductoFAV != null && dataFichaProductoFAV.length > 0) {

        var xcuv = $('#hdCuvFichaProductoFAV').val();
        var result;
        if (tipo == 1) {
            result = $.grep(dataFichaProductoFAV, function (e) { return e.CUV == cuv; });
        }
        else {
            var scuv = $('#fav_cbo_tono').val();
            result = $.grep(dataFichaProductoFAV, function (e) { return e.CUV == scuv; });
        }

        if (result != null && result.length > 0) {
            var obj = result[0];
            var container;
            if (origen == 1) container = $('#PopFichaProductoNueva');   // desktop
            else container = $('#PrecioCatalogo');// mobile

            container.find('#fav_imagen_prod').attr('src', obj.ImagenProductoSugerido);
            container.find('#fav_nombre_prod').text(obj.Descripcion);
            container.find('#fav_descripcion_prod').text(obj.DescripcionComercial);
            $('#fav_cbo_tono').val(obj.CUV);
            $('.content_tono_detalle').removeClass('borde_seleccion_tono');
            $('#fav_tono_' + obj.CUV).addClass("borde_seleccion_tono");
            $('#hdCuvFichaProductoFAVSelect').val(obj.CUV);

            $('#hdCuvFichaProductoFAVSelect').parents("[data-item]").find("[data-compartir-campos]").find(".CUV").val(obj.CUV);
            $('#hdCuvFichaProductoFAVSelect').parents("[data-item]").find("[data-compartir-campos]").find(".rsFBRutaImagen").val(obj.ImagenProductoSugerido);
            $('#hdCuvFichaProductoFAVSelect').parents("[data-item]").find("[data-compartir-campos]").find(".rsWARutaImagen").val(obj.ImagenProductoSugerido);
            $('#hdCuvFichaProductoFAVSelect').parents("[data-item]").find("[data-compartir-campos]").find(".Nombre").val(obj.Descripcion);
            $('#hdCuvFichaProductoFAVSelect').parents("[data-item]").find("[data-compartir-campos]").find(".ProductoDescripcion").val(obj.DescripcionComercial);
            //$('#hdCuvFichaProductoFAVSelect').parents("[data-item]").find("[data-compartir-campos]").find(".Volumen").val(obj.Volumen);
        }
    }
}

function agregarCuvPedidoFichaProductoFAV(tipo) {
    
    var container = null;
    if (tipo == 2)
        container = $('#PrecioCatalogo').find('[data-item="catalogopersonalizado"]');
    else
        container = $('#PopFichaProductoNueva').find('[data-item="catalogopersonalizado"]');

    if (typeof container != 'undefined') {

        var cuv = $(container).find('#hdCuvFichaProductoFAVSelect').val();

        if (typeof cuv != 'undefined' && cuv != '') {
            var esMaquillaje = $(container).find('.hdItemEsMaquillaje').val();

            if (esMaquillaje) {
                $(container).find('.hdItemCuv').val(cuv);
            }

            tipoOrigen = tipo;

            if (ReservadoOEnHorarioRestringido())
                return false;

            agregarProductoAlCarrito(this);

            AgregarProductoCatalogoPersonalizado(container);
        }
    }
    
}

function AjustarTonoTooltips(objcontenedor) {
    var arrayObjTooltip = objcontenedor.find('.content_tonos_maquillaje .tooltip_tono');
    var length = arrayObjTooltip.length;

    var index = cantidadTonosPorFila - 1;
    while (index < length) {
        arrayObjTooltip.eq(index).css('left', '-20px');
        index += cantidadTonosPorFila;
    }
}

function filterFAVDesktop() {
    $('.seleccion_filtro_fav').prop('disabled', true);
    $('.select_filtros_fav option:not(:selected)').prop('disabled', true);

    filters = [];
    primerScroll = false;

    // sorting
    var f = {
        Id: 1,
        Orden: $('#filter-sorting').val()
    }
    filters.push(f);

    // category
    var values = "";
    $('#div-filter-category').find('div[class*="seleccion_click_flitro"]').each(function () {
        values += $(this).data('value') + ',';        
    });

    var f = {
        Id: 2,
        Valor1: values.substring(0, values.length - 1)
    }
    filters.push(f);
    
    // brand
    values = "";
    $('#div-filter-brand').find('div[class*="seleccion_click_flitro"]').each(function () {
        values += $(this).data('value') + ',';
    });

    var f = {
        Id: 3,
        Valor1: values.substring(0, values.length - 1)
    }
    filters.push(f);
    // range prices
    if (rangoPrecios != 0) {
        var arr = rangoPrecios.toString().split(',');
        var f = {
            Id: 4,
            Valor1: arr[0],
            Valor2: arr[1]
        }
        filters.push(f);
    }

    // published
    values = "";
    $('#div-filter-published').find('div[class*="seleccion_click_flitro"]').each(function () {
        values += $(this).data('value') + ',';
    });

    var f = {
        Id: 5,
        Valor1: values.substring(0, values.length - 1)
    }
    filters.push(f);

    //console.log(filters);

    $('.seleccion_filtro_fav').prop('disabled', false);
    $('.select_filtros_fav option:not(:selected)').prop('disabled', false);
    $(".slider-container").removeClass("disabledbutton");

    LinkCargarCatalogoToScroll();
    CargarCatalogoPersonalizado();


}

function CargarFiltros()
{    
    jQuery.ajax({
        type: 'POST',
        url: urlCargarFiltros,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                var datos = data.data;
                if (datos.length != 0) {

                    $.each(datos, function (i) {
                        var h = datos[i].Id;
                        if (datos[i].Id == "1") {
                            if (tipoOrigen == 2) {
                                $('#orderby-price').val(datos[i].Orden);
                            }
                            else {
                                $('#filter-sorting').val(datos[i].Orden);
                            }
                        }

                        if (datos[i].Id == "2") {
                            if (datos[i].Valor1 != null) {
                                if (tipoOrigen == 2) {
                                    $('#idcategory').find('input[type="checkbox"]').each(function () {
                                        var valor = $(this).val();
                                        if (datos[i].Valor1.indexOf(valor) != -1) {
                                            $(this).trigger("click");
                                        }
                                    });
                                }
                                else {
                                    $('#div-filter-category').find('div[class*="seleccion_filtro_fav"]').each(function () {
                                        var valor = $(this).data('value');
                                        if (datos[i].Valor1.indexOf(valor) != -1) {
                                            $(this).toggleClass("seleccion_click_flitro");
                                        }
                                    });
                                }
                            }
                        }

                        if (datos[i].Id == "3") {
                            if (datos[i].Valor1 != null) {
                                if (tipoOrigen == 2) {
                                    $('#idmarca').find('input[type="checkbox"]').each(function () {
                                        var valor = $(this).val();
                                        if (datos[i].Valor1.indexOf(valor) != -1) {
                                            $(this).trigger("click");
                                        }
                                    });
                                }
                                else {
                                    $('#div-filter-brand').find('div[class*="seleccion_filtro_fav"]').each(function () {
                                        var valor = $(this).data('value');
                                        if (datos[i].Valor1.indexOf(valor) != -1) {
                                            $(this).toggleClass("seleccion_click_flitro");
                                        }
                                    });
                                }
                            }
                        }

                        if (datos[i].Id == "4") {
                            if (tipoOrigen == 2) {
                                mPremin = parseFloat(datos[i].Valor1);
                                mPremax = parseFloat(datos[i].Valor2);

                                if (primeraVez)
                                    $('#txt-range-price').bootstrapSlider('setValue', [mPremin, mPremax]);
                            }
                            else {
                                var nRango = datos[i].Valor1 + ',' + datos[i].Valor2;
                                $('.range-slider').jRange('setValue', nRango);
                            }
                        }

                        if (datos[i].Id == "5") {
                            if (datos[i].Valor1 != null) {
                                $('#div-filter-published').find('div[class*="seleccion_filtro_fav"]').each(function () {
                                    var valor = $(this).data('value');
                                    if (datos[i].Valor1.indexOf(valor) != -1) {
                                        $(this).toggleClass("seleccion_click_flitro");
                                    }
                                });
                            }
                        }
                    });
                }
            }
        },
        error: function (data, err) {
            if (checkTimeout(data)) {
                console.log(err);
            }
        },
        complete: function () {
            DialogLoadingCerrar();
            cargandoRegistros = false;
        }
    });
}

function getDatosResumenOferta048N(cantidad) {

    var datos = Clone(dataOfertaEnRevista);
    datos.lista_ObjNivel = new Array();
    datos.lista_oObjGratis = new Array();
    datos['Cantidad_Total'] = cantidad;

    var escalas = [];
    escalas.push(1);

    $.each(dataOfertaEnRevista.lista_ObjNivel, function (i, obj) {
        escalas.push(parseInt(obj.escala_nivel));
    });

    escalas.sort();
    var xescalas = [];

    for (var i = escalas.length - 1; i >= 0; i--) {
        var m = (cantidad % escalas[i]);
        if (m == 0) {
            var d = { nivel: escalas[i], cant: (cantidad / escalas[i]) }
            xescalas.push(d);
            break;
        }
        else {
            if ((cantidad - m) > 0) {
                var a = ((cantidad - m) / escalas[i]);
                var d = { nivel: escalas[i], cant: a }
                xescalas.push(d);
                cantidad = m;
            }
        }
    }

    var tprecio = 0;
    var tganancia = 0;
    var arrGratis = [];

    $.each(xescalas, function (i, obj1) {
        if (obj1.nivel == 1) {
            tprecio += parseFloat(datos.precio_revista);
            tganancia += parseFloat(datos.ganancia);
        }
        else {
            var objNivel = $.grep(dataOfertaEnRevista.lista_ObjNivel, function (e) { return e.escala_nivel == obj1.nivel; });
            if (objNivel != null && objNivel.length > 0) {
                tprecio += parseFloat(objNivel[0].precio_nivel * obj1.cant);
                tganancia += parseFloat(objNivel[0].ganancia_nivel * obj1.cant);

                var objGratis = $.grep(dataOfertaEnRevista.lista_oObjGratis, function (e) { return e.escala_nivel_gratis == obj1.nivel; });
                if (objGratis != null && objGratis.length > 0) {

                    $.each(objGratis, function (j, obj2) {

                        if (arrGratis.length == 0) {
                            var d = {
                                'cantidad': (parseInt(obj2.cantidad) * obj1.cant),
                                'codsap_nivel_gratis': obj2.codsap_nivel_gratis,
                                'descripcion_gratis': obj2.descripcion_gratis,
                                'escala_nivel_gratis': obj2.escala_nivel_gratis,
                                'imagen_gratis': obj2.imagen_gratis
                            };
                            arrGratis.push(d);
                        }
                        else {
                            var indexes = $.map(arrGratis, function (obj, index) {
                                if (obj.codsap_nivel_gratis == obj2.codsap_nivel_gratis) {
                                    return index;
                                }
                            })

                            if (indexes.length > 0) {
                                var ind = indexes[0];
                                var old = arrGratis[ind]['cantidad'];
                                var nv = old + (obj2.cantidad * obj1.cant)
                                arrGratis[ind]['cantidad'] = nv;
                            }
                            else {
                                var d = {
                                    'cantidad': (parseInt(obj2.cantidad) * obj1.cant),
                                    'codsap_nivel_gratis': obj2.codsap_nivel_gratis,
                                    'descripcion_gratis': obj2.descripcion_gratis,
                                    'escala_nivel_gratis': obj2.escala_nivel_gratis,
                                    'imagen_gratis': obj2.imagen_gratis
                                };
                                arrGratis.push(d);
                            }
                        }

                    });
                }
            }
        }
    });

    datos['Precio_Total'] = tprecio;
    datos['Ganancia_Total'] = tganancia;
    datos.lista_oObjGratis = arrGratis;

    return datos;
}

function closeResumenOferta048Mobile() {
    $('#PopupResumenOferta048N').hide();
    document.location.href = urlCatalogoPersonalizado;
}