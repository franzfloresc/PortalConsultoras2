var baseUrl = "/";
var TabUno = 0;
var TabDos = 0;
var tipoOrigen = "1";
var cargandoRegistros = false;
var offsetRegistrosDemo = 0;
var offsetRegistrosKits = 0;
var verMasKits = false;
var verMasDemostradores = false;
var reservaResponse = {
    data: { Reserva: false }
};

$(document).ready(function () {    
    CambiarOferta();
    //CargarKits();
    //CargarDemostradores
    Inicializar();
});

$("#Demostradores").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-demostrador]').attr("data-demostrador")); 
    var cantidad = $(contenedor).find("#txtCantidad").val();
    AgregarProducto(obj, cantidad, contenedor, false);
});

$("#kits").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-kit]').attr("data-kit"));
    var cantidad = 1;
    AgregarProducto(obj, cantidad, contenedor, true);
});

function Inicializar() {
    ValidarCargaOfertas();
    LinkCargarOfertasToScroll();
}

function LinkCargarOfertasToScroll() {
    $(window).scroll(CargarOfertasScroll);
}

function UnlinkCargarOfertasToScroll() {
    $(window).off("scroll", CargarOfertasScroll);
    cargandoRegistros = false;
}

function CargarOfertasScroll() {
    if ($(window).scrollTop() + $(window).height() > $(document).height() - $('footer').outerHeight()) {
        ValidarCargaOfertas();
    }
}

function ValidarCargaOfertas() {
    if (cargandoRegistros) return false;
    cargandoRegistros = true;

    waitingDialog();
    if ($('#Demostradores').is(':visible'))
        CargarDemostradores();
    else if ($('#kits').is(':visible'))
        CargarKits();
}

function CargarKits() {   
    $.ajax({
        type: 'GET',
        url: urlGetKits,
        data: { offset: offsetRegistrosKits, cantidadregistros: nroRegistrosKits},
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.lista.length > 0) ArmarOfertaKits(data.lista);
                verMasKits = data.verMas;
                if (!verMasKits) UnlinkCargarOfertasToScroll();
                offsetRegistrosKits += nroRegistrosKits;
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
        data: { offset: offsetRegistrosDemo, cantidadregistros: nroRegistrosDemostradores },
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.lista.length > 0) ArmarOfertaDemostradores(data.lista);
                verMasDemostradores = data.verMas;
                if (!verMasDemostradores) UnlinkCargarOfertasToScroll();
                offsetRegistrosDemo += nroRegistrosDemostradores;
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

$(window).scroll(function (event) {
    if ($("#Tab-kits").hasClass('activado-dorado')) {
        TabUno = $(window).scrollTop();
    }

    if ($("#Tab-Demostradores").hasClass('activado-dorado')) {
        TabDos = $(window).scrollTop();
    }
});

function AgregarProducto(data, cantidad, contenedor, isKit) {
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
            if (data.success) {                
                $(contenedor).find('[data-Agregado="DivAgregado"]').show();
                if (isKit) {
                    $(".ficha__producto__kit").addClass("producto_desactivado");
                    $('.ficha__producto__tag_enable').hide();
                    $('.ficha__producto__tag_disable').show();
                }                
            } else {
                alert(data.message); //Temportal
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
    $("#Tab-kits").trigger("click");
    $('#Tab-kits').click(function () {
        $('#kits').show();
        $('#Demostradores').hide();
        $("#Tab-kits").addClass("activado-dorado");
        $("#Tab-Demostradores").removeClass("activado-dorado");
        $("#divresultadosDemostradores").hide();
        $("#divresultadosKit").show();
        document.body.scrollTop = TabUno;
        $(window).scrollTop(TabUno);
        if (!verMasKits) CargarKits();
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
        if (!verMasDemostradores) CargarDemostradores();
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