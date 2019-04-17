var TabUno = 0;
var TabDos = 0;
var tipoOrigen = "1";
var cargandoRegistros = false;

var offsetRegistros = 0;

var reservaResponse = {
    data: { Reserva: false }
};
var baseUrl = "/";

$(document).ready(function () {
    CargarKits();
    CambiarOferta();
});

$("#Demostradores").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-demostrador]').attr("data-demostrador"));
    var cantidad = $(contenedor).find("#txtCantidad").val();
    var tab = $("#Demostradores").attr('id');
    AgregarProducto(obj, cantidad, contenedor, tab, false);
});

$("#kits").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-kit]').attr("data-kit"));
    var cantidad = 1;
    var tab = $("#kits").attr('id');
    AgregarProducto(obj, cantidad, contenedor, tab, true);
});

function Inicializar() {
    ValidarCargaDemostradores();
    LinkCargarDemostradoresToScroll();
}

function LinkCargarDemostradoresToScroll() {
    $(window).scroll(CargarDemostradoresScroll);
}

function CargarDemostradoresScroll() {
    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
        ValidarCargaDemostradores();
    }
}

function ValidarCargaDemostradores() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    waitingDialog();
    CargarDemostradores();
}

function CargarKits() {
    $('#kits').show();
    $('#Demostradores').hide();
    $("#Tab-kits").addClass("activado-dorado");
    $("#Tab-Demostradores").removeClass("activado-dorado");
    $("#divresultadosDemostradores").hide();
    $("#divresultadosKit").show();
    document.body.scrollTop = TabUno;
    $(window).scrollTop(TabUno);


    $.ajax({
        type: 'GET',
        url: urlGetKits,
        data: { cantidadregistros: cantidadRegistros },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',

        success: function (data) {

            if (checkTimeout(data)) {
                if (data.lista.length > 0) ArmarOfertaKits(data.lista);
            }
        },

        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            cargandoRegistros = false;
        }
    });
}

function ArmarOfertaKits(data) {
    var htmlDiv = SetHandlebars("#template-Kits", data);
    $('#kits').append(htmlDiv);
    $('#kits').show();
}

function CargarDemostradores() {
    $.ajax({
        type: 'GET',
        url: urlGetDemostradores,
        data: { cantidadregistros: cantidadRegistros },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.lista.length > 0) ArmarOfertaDemostradores(data.lista);
            }
        },
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            cargandoRegistros = false;
        }
    });
}

function ArmarOfertaDemostradores(data) {
    var htmlDiv = SetHandlebars("#template-Demostradores", data);
    $('#Demostradores').append(htmlDiv);
    $('#Demostradores').show();
}

function AgregarProducto(data, cantidad, contenedor, tab, isKit) {

    AbrirSplash();
    var categoria = tab;
    var nombre_producto = data.DescripcionCUV;
    var precio_producto = data.PrecioCatalogo;
    var marca_producto = data.DescripcionMarca;
    var id_producto = data.CUV;

    var params = {
        CuvTonos: data.CUV,
        CUV: data.CUV,
        Cantidad: cantidad,
        TipoEstrategiaID: 0,
        EstrategiaID: "0",
        OrigenPedidoWeb: origenPedidoWeb,
        TipoEstrategiaImagen: "",
        EsEditable: false,
        SetId: null,
        ClienteID: 0
    };

    jQuery.ajax({
        type: "POST",
        url: urlAgregarUnico,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(params),
        async: true,
        cache: false,
        success: function (data) {
            if (data.success) {
                $(contenedor).find('[data-Agregado="DivAgregado"]').show();
                if (isKit) {
                    $(".ficha__producto__kit").addClass("producto_desactivado");
                    $('.ficha__producto__tag_enable').hide();
                    $('.ficha__producto__tag_disable').show();
                }
            } else {
                $("#Mensaje").append(data.message);
                $("#alertDialogMensajes").fadeIn();
            }
            CerrarSplash();
            CargarResumenCampaniaHeader(true);

            dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                    'currencyCode': 'PEN',
                    'add': {
                        'actionField': { 'list': 'Ofertas-CaminoBrillante' },
                        'products': [{
                            'name': nombre_producto,
                            'price': precio_producto,
                            'brand': marca_producto,
                            'id': id_producto,
                            'category': categoria,
                            'variant': 'Estándar',
                            'quantity': Cantidad
                        }]
                    }
                }
            })

        },
        error: function (data, error) {
            alert("error");
        }
    });
}

$(window).scroll(function (event) {
    if ($("#Tab-kits").hasClass('activado-dorado')) {
        TabUno = $(window).scrollTop();
    }

    if ($("#Tab-Demostradores").hasClass('activado-dorado')) {
        TabDos = $(window).scrollTop();
    }
});

function CambiarOferta() {
    $('#Tab-kits').click(function () {
        $('#kits').show();
        $('#Demostradores').hide();
        $("#Tab-kits").addClass("activado-dorado");
        $("#Tab-Demostradores").removeClass("activado-dorado");
        $("#divresultadosDemostradores").hide();
        $("#divresultadosKit").show();
        document.body.scrollTop = TabUno;
        $(window).scrollTop(TabUno);
        CargarKits();
    });

    $('#Tab-Demostradores').click(function () {
        $('#Demostradores').show();
        $('#kits').hide();
        $("#Tab-kits").removeClass("activado-dorado");
        $("#Tab-Demostradores").addClass("activado-dorado");
        $("#divresultadosKit").hide();
        $("#divresultadosDemostradores").show();
        document.body.scrollTop = TabDos;
        $(window).scrollTop(TabDos);
        CargarDemostradores();
    });
}

function TagImpresionProductos(pen, nombrelista, nombreProducto, idProducto, precioProducto, marcaProducto, categoriaProducto, varianteProducto, posicionProducto) {
    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'currencyCode': pen,
            'impressions': {
                'actionField': { 'list': nombrelista },
                'products': [{
                    'name': nombreProducto,
                    'id': idProducto,
                    'price': precioProducto,
                    'brand': marcaProducto,
                    'category': categoriaProducto,
                    'variant': varianteProducto,
                    'position': posicionProducto
                }]
            }
        }
    });
}