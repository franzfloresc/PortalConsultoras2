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
    //AgregarProducto();
});

$("#Demostradores").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-demostrador]').attr("data-demostrador")); 
    var cantidad = $(contenedor).find("#txtCantidad").val();
    AgregarProducto(obj, cantidad, contenedor);
});

$("#kits").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-kit]').attr("data-kit"));
    var cantidad = 1;
    AgregarProducto(obj, cantidad);
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
                //if (!data.verMas) UnlinkCargarOfertasToScroll();
                //offsetRegistros += cantidadRegistros;
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
    //data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#template-Kits", data);
    $('#kits').append(htmlDiv);
    $('#kits').show();
    //EstablecerAccionLazyImagen("img[data-lazy-seccion-liquidacion]");
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
                //if (!data.verMas) UnlinkCargarOfertasToScroll();
                //offsetRegistros += cantidadRegistros;
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
    //data = EstructurarDataCarouselLiquidaciones(data);
    var htmlDiv = SetHandlebars("#template-Demostradores", data);
    $('#Demostradores').append(htmlDiv);
    $('#Demostradores').show();
    //EstablecerAccionLazyImagen("img[data-lazy-seccion-liquidacion]");
}

//$(window).scroll(function (event) {
//    if ($("#Tab-kits").hasClass('activado-dorado')) {
//        TabUno = $(window).scrollTop();
//    }

//    if ($("#Tab-Demostradores").hasClass('activado-dorado')) {
//        TabDos = $(window).scrollTop();
//    }
//});

function AgregarProducto(data, cantidad, contenedor) {
    AbrirSplash();
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
            $(contenedor).find('[data-Agregado="DivAgregado"]').show();
            if ($("#Tab-kits").hasClass('activado-dorado')) {                       
                $('#kits').addClass("producto_desactivado");
            }
            CerrarSplash();
            CargarResumenCampaniaHeader(true);
        },
        error: function (data, error) {
            alert("error");
        }
    });
}

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
        'event': 'productImpression', 'ecommerce': {
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