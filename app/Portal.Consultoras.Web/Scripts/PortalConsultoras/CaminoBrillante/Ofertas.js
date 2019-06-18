var dataKits;
var dataDemostradores;
var baseUrl = "/";
var TabUno = 0;
var TabDos = 0;
var tipoOrigen = "1";
var cargandoRegistros = false;
var offsetRegistrosDemo = 0;
var offsetRegistrosKits = 0;
var verMasKits = true;
var verMasDemostradores = true;
var i = 0; 
var reservaResponse = {
    data: { Reserva: false }
};
var contadorkit = 0
var contadordemo = 0
var codOrdenar = "00";
var codFiltro = "00";
var getUrl;

var moneda = ($('#moneda').val());

$(document).ready(function () {  
    Handlebars.registerPartial("kit_template", $("#template-kit").html());
    Handlebars.registerPartial("demostrador_template", $("#template-demostrador").html());
    CargarKits();
    getUrl = getGET();
    Inicializar();
    CambiarOferta();

    if (getUrl) {
        cargandoRegistros = true;
        offsetRegistrosDemo = 0;
        contadordemo = 0;
        TabDos = 0;
        $(window).scrollTop(TabDos);
        $("#Tab-Demostradores").trigger("click");
        TabDos = $(window).scrollTop();
        $('#kits').addClass("hide");
    } 

    $("#ddlOrdenar").on("change", function () {
        codOrdenar = $("#ddlOrdenar").val();
        $("#Demostradores").empty();
        contadordemo = 0;
        offsetRegistrosDemo = 0;
        CargarDemostradores();
    });

    $("#ddlfiltros").on("change", function () {
        codFiltro = $("#ddlfiltros").val();
        $("#Demostradores").empty();
        contadordemo = 0;
        offsetRegistrosDemo = 0;
        CargarDemostradores();
    });

    
    
});


function getGET() {
    var loc = document.location.href;
    if (loc.indexOf('?') > 0) {
        var getString = loc.split('?')[1];
        var GET = getString.split('&');
        var get = {};
        return get;
    }
}

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
        $(window).scrollTop(TabUno);
    } else if ($('#Demostradores').is(':visible'))
        CargarDemostradores();        
}

function TagListaProductos(data, lista) {

    var productos = [];
    for (i = 0; i < data.lista.length; i++) {
        var product = data.lista[i]
        var productoAnalicits = {
            'name': product.DescripcionCUV,
            'id': product.CUV,
            'price': product.PrecioCatalogo,
            'brand': product.DescripcionMarca,
            'category': lista,
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
                'actionField': { 'list': lista },
                'products': productos
            }
        }
    })
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
                dataKits = data;
                TagListaProductos(dataKits, 'Kits');
                return dataKits;
            }
        },
        
        error: function (data, error) { },
        complete: function (data) {
            closeWaitingDialog();
            cargandoRegistros = false;
        }
    });
}



function CargarDemostradores() {
    $.ajax({
        type: 'GET',
        url: urlGetDemostradores,
        data: { cantRegistros: nroRegistrosDemostradores, regMostrados: offsetRegistrosDemo, codOrdenar: codOrdenar, codFiltro: codFiltro},
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
                dataDemostradores = data;
                TagListaProductos(dataDemostradores,'Demostradores');
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

function ArmarOfertaKits(data)
{
    var htmlDiv = SetHandlebars("#template-Kits", data);
    $('#kits').append(htmlDiv);
    $('#kits').show();

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
        OrigenPedidoWeb: _origenPedidoWeb,
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
                        'actionField': { 'list': categoria },
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
            $('#kits').removeClass("hide");
            $('#kits').addClass("boxgrid");
            $('#Demostradores').hide();
            $('.opOrdenar').hide();
            $("#Tab-kits").addClass("activado-dorado");
            $("#Tab-Demostradores").removeClass("activado-dorado");
            $("#divresultadosDemostradores").hide();
            $("#divresultadosKit").show();
                
            document.body.scrollTop = TabUno;
            $(window).scrollTop(TabUno);
            if (contadorkit == 0) { CargarKits(); }
            else {
                $('#kits').empty();
                offsetRegistrosKits = 0;
                contadorkit = 0;
                CargarKits();
            }

        });

    $('#Tab-Demostradores').click(function () {
            $('#kits').hide();
            $('#kits').removeClass("boxgrid");
            $('#kits').addClass("hide");
            $("#Tab-kits").removeClass("activado-dorado");
            $("#divresultadosKit").hide();
            $('.opOrdenar').show();
            $('#Demostradores').show();
            $("#Tab-Demostradores").addClass("activado-dorado");
            $("#divresultadosDemostradores").show();
            document.body.scrollTop = TabDos;
            $(window).scrollTop(TabDos);
            if (contadordemo == 0) {
                ObtenerFiltros();
                CargarDemostradores();
            }
            else {
                LinkCargarOfertasToScroll();
                TagListaProductos(dataDemostradores, 'Demostradores');
            }
        });
    
}

function ObtenerFiltros() {
    $.ajax({
        type: 'GET',
        url: urlObtenerFiltros,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.lista != null) {
                    var _filtros = data.lista.DatosFiltros;
                    var _orden = data.lista.DatosOrden;
                    $('#ddlfiltros').empty();
                    $('#ddlOrdenar').empty();
                    $.each(_filtros, function (index, value) {
                        $("#ddlfiltros").append('<option value="' + value.Codigo + '">' + value.Descripcion + '</option>');
                    });
                    $.each(_orden, function (index, value) {
                        $("#ddlOrdenar").append('<option value="' + value.Codigo + '">' + value.Descripcion + '</option>');
                    });
                }
            }
        },
        error: function (data, error) { },
        complete: function (data) {
            cargandoRegistros = false;
        }
    });
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    closeWaitingDialog();
}

