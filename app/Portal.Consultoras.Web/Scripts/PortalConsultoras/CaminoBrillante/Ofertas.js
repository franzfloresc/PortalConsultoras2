﻿var baseUrl = "/";
var TabUno = 0;
var TabDos = 0;
var tipoOrigen = "1";
var cargandoRegistros = false;
var offsetRegistrosDemo = 0;
var offsetRegistrosKits = 0;
var verMasKits = true;
var verMasDemostradores = true;
var reservaResponse = {
    data: { Reserva: false }
};
var contadorkit = 0
var contadordemo = 0

var moneda = ($('#moneda').val());

$(document).ready(function () {    
    CambiarOferta();
    Inicializar();
});

$("#Demostradores").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-demostrador]').attr("data-demostrador"));
    var cantidad = $(contenedor).find("#txtCantidad").val();
    var tab = $("#Demostradores").attr('id');
    if (cantidad <= 0) {
        AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
        CerrarSplash();
         } else {
            AgregarProducto(obj, cantidad, contenedor, tab, false);
        }
    
});

$("#kits").on('click', '.boton_agregar_ofertas', function (e) {
    var contenedor = $(this).parents('[data-item="BuscadorFichasProductos"]');
    var obj = JSON.parse($(this).parents('[data-item="BuscadorFichasProductos"]').find('div [data-kit]').attr("data-kit"));
    var cantidad = 1;
    var tab = $("#kits").attr('id');
    AgregarProducto(obj, cantidad, contenedor, tab, true);
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

    if ($('#kits').is(':visible')) {
        waitingDialog();
        CargarKits();
    } else if ($('#Demostradores').is(':visible'))
        CargarDemostradores();        
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
                contadorkit = contadorkit + data.lista.length;
                verMasKits = data.verMas;
                $(window).scroll(CargarOfertasScroll);
                if (!verMasKits) UnlinkCargarOfertasToScroll();
                offsetRegistrosKits += nroRegistrosKits;
                $("#divresultadosKit").html("Mostrando " + contadorkit + " de " + data.total);

                var productos = [];
                for (i = 0; i < data.lista.length; i++) {
                    var product = data.lista[i]
                    var productoAnalicits = {
                        'name': product.DescripcionCUV,
                        'id': product.CUV,
                        'price': product.PrecioCatalogo,
                        'brand': product.DescripcionMarca,
                        'category': 'Kits',
                        'variant': 'Estándar',
                        'position': i + 1,
                    }
                    productos.push(productoAnalicits);
                }
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'currencyCode': moneda,
                        'impressions': {
                            'actionField': 'list: Kits',
                            'products': productos                          
                        }
                    }
                })
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
                contadordemo = contadordemo + data.lista.length;
                verMasDemostradores = data.verMas;   
                $(window).scroll(CargarOfertasScroll);
                if (!verMasDemostradores) UnlinkCargarOfertasToScroll();
                offsetRegistrosDemo += nroRegistrosDemostradores;
                $("#divresultadosDemostradores").html("Mostrando " + contadordemo + " de " + data.total);

                var productos = [];
                for (i = 0; i < data.lista.length; i++) {
                    var product = data.lista[i]
                    var productoAnalicits = {
                        'name': product.DescripcionCUV,
                        'id': product.CUV,
                        'price': product.PrecioCatalogo,
                        'brand': product.DescripcionMarca,
                        'category': 'Demostradores',
                        'variant': 'Estándar',
                        'position': i + 1,
                    }
                    productos.push(productoAnalicits);
                }                
                dataLayer.push({
                    'event': 'productImpression',
                    'ecommerce': {
                        'currencyCode': moneda,
                        'impressions': {
                            'actionField': 'list: Demostradores',
                            'products': productos
                        }
                    }
                })

            }
        },
        error: function (data, error) { },
        complete: function (data) {
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

    $("#Mensaje").empty();

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
                    $('.ficha__producto__tag_disable').removeClass("hide");
                    $('.ficha__producto__tag_disable').show();
                }
                CerrarSplash();
                CargarResumenCampaniaHeader(true);
            } else {
                CerrarSplash();
                AbrirMensaje(data.message);
            }
            
            dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                    'currencyCode': moneda,
                    'add': {
                        'actionField': { 'list': 'Ofertas-CaminoBrillante : ' + categoria},
                        'products': [{
                            'name': nombre_producto,
                            'price': precio_producto,
                            'brand': marca_producto,
                            'id': id_producto,
                            'category': categoria,
                            'variant': 'Estándar',
                            'quantity': cantidad
                        }]
                    }
                }
            })

        },
        error: function (data, error) {
            
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
        if (contadorkit == 0) { CargarKits(); }
        else { LinkCargarOfertasToScroll();}        
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
        if (contadordemo == 0) { CargarDemostradores(); }
        else { LinkCargarOfertasToScroll();}
    });
}

