/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";
var urlOfertaCargarProductos = urlOfertaCargarProductos || '';
var urlOfertaDetalle = urlOfertaDetalle || '';
var isLoad = false;
var filtroCampania = new Array();
var campaniaId = campaniaId || 0;
var filtroIni = {
    CampaniaID: 0,
    ListaFiltro: new Array(),
    Ordenamiento: new Object(),
    CantMostrados: 0,
    CantTotal: -1,
    Listado: new Array()
};

$(document).ready(function () {

    $("select[data-filtro-tipo]").change(function (event) {
        OfertaObtenerProductos(this, true);
    });

    $("a[data-filtro-tipo]").click(function (event) {
        OfertaObtenerProductos(this, true);
    });
        
    $("#divBorrarFiltros").click(function () {

        /*Ordenamiento*/
        var ordenamiento = {
            Tipo: "PRECIO",
            Valor: $("#filter-sorting").val()
        }

        var busquedaModel = {
            Ordenamiento: ordenamiento
        };

        OfertaCargarProductos(busquedaModel);

        $(this).hide();
    });

    //$("body").on("click", "[data-btn-agregar-sr]", function (e) {
    //    var padre = $(this).parents("[data-item]");
    //    var article = $(padre).find("[data-campos]").eq(0);
    //    //AgregarProductoAlCarrito(padre);
    //    OfertaAgregar(article);
    //    e.preventDefault();
    //    (this).blur();
    //});

    OfertaCargarProductos(null);
        
    $(window).scroll(function () {
        if ($(window).scrollTop() + $(window).height() == $(document).height()) {
            $(".flecha_scroll").animate({
                opacity: 0
            }, 100, 'swing', function () {
                $(".flecha_scroll a").addClass("flecha_scroll_arriba");
                $(".flecha_scroll").delay(100);
                $(".flecha_scroll").animate({
                    opacity: 1
                }, 100, 'swing');
            });
        } else {
            $(".flecha_scroll a").removeClass("flecha_scroll_arriba");
        }

        OfertaCargarScroll();
    });

    $(window).scroll();
});

function OfertaObtenerProductos(filtro, clear) {
    var busquedaModel = OfertaObtenerFiltro(filtro);
    if (busquedaModel.CampaniaID > 0) {
        filtroCampania[busquedaModel.CampaniaID] = busquedaModel;
        OfertaCargarProductos(busquedaModel, clear);
    }
}

function OfertaObtenerFiltro(filtro) {

    if (filtro == null) {
        listaFiltros = filtroCampania[campaniaId];
        if (listaFiltros != undefined) {
            return listaFiltros;
        }
    }

    var listaFiltros = Clone(filtroIni);
    campaniaId = campaniaId || $(filtro).parents("[data-listado-campania]").attr("data-listado-campania") || 0;
    campaniaId = parseInt(campaniaId) || 0;
    listaFiltros.CampaniaID = campaniaId;

    var variante = $.trim($(filtro).attr("data-filtro-tipo"));
    var campo = $.trim($(filtro).attr("data-filtro-campo"));
    var accion = $.trim($(filtro).attr("data-filtro-accion"));
    if (variante == "borrar" || variante == "" || campo == "") {

        $("[data-filtro-tipo='borrar']").parent().hide();

        $.each($("[data-filtro-tipo]"), function (indSel, select) {
            $(select).val($($(select).find("option").get(0)).val());
        });

        filtroCampania[listaFiltros.CampaniaID] = listaFiltros;
        return listaFiltros;
    }

    var valor = $(filtro).val(); // para este caso solo es tag html select
        
    $("[data-filtro-tipo='borrar']").parent().show();

    if (accion == "orden") {
        listaFiltros.Ordenamiento = {
            Tipo: campo,
            Valor: valor
        };
        return listaFiltros;
    }
    
    var posFiltro = -1;
    $.each(listaFiltros.ListaFiltro, function (index, item) {
        if (item.Tipo == campo) {
            posFiltro = index;
        }
    });
    
    if (posFiltro < 0) {
        listaFiltros.ListaFiltro = new Array();
        listaFiltros.ListaFiltro.push({
            Tipo: campo,
            Valores: [valor]
        });
        return listaFiltros;
    }

    if (variante == "multiple") {
        var listaValores = listaFiltros.ListaFiltro[posFiltro].Valores || new Array();
        listaValores.push(valor);
        listaFiltros.ListaFiltro[posFiltro] = {
            Tipo: campo,
            Valores: listaValores
        };
    }
    else if (variante == "fijo") {
        listaFiltros.ListaFiltro[posFiltro] = {
            Tipo: campo,
            Valores: [valor]
        };
    }
    return listaFiltros;
}

function OfertaCargarProductos(busquedaModel, clear) {
    if (urlOfertaCargarProductos == '') {
        $("#divOfertaProductos").hide();
        return false;
    }
    if (isLoad) return false;

    busquedaModel = busquedaModel || Clone(filtroIni);
    busquedaModel.CampaniaID = busquedaModel.CampaniaID || campaniaId || 0;

    if (busquedaModel.CampaniaID <= 0) return false;
    isLoad = true;

    $.ajaxSetup({
        cache: false
    });

    $('#divOfertaProductosLoad').html('<div style="text-align: center; min-height:150px;padding: 50px;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');
    $("#divOfertaProductosLoad").show();

    jQuery.ajax({
        type: 'POST',
        url: urlOfertaCargarProductos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(busquedaModel),
        async: true,
        success: function (response) {
            CerrarLoad();

            $("#divOfertaProductosLoad").hide();
            if (response.success == true) {
                if (clear || false) {
                    $('#divOfertaProductos').html("");
                    filtroCampania[busquedaModel.CampaniaID].CantMostrados = 0;
                }
                filtroCampania[busquedaModel.CampaniaID].CantMostrados += response.lista.length;
                filtroCampania[busquedaModel.CampaniaID].CantTotal = response.cantidad;
                OfertaArmarEstrategias(response);
                isLoad = false;
                return true;
            }

            //messageInfoError(response.message);
        },
        error: function (response, error) {
            $("#divOfertaProductosLoad").hide();
            if (checkTimeout(response)) {
                CerrarLoad();
                console.log(response);
            }
        }
    });
}

function OfertaAgregar(article) {
    var cantidad = $(article).find("[data-input='cantidad']").val() || '';

    if (cantidad == "" || cantidad == 0) {
        AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.");
        return false;
    }

    var CUV = $(article).find(".valorCuv").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var descripcionMarca = $(article).find(".DescripcionMarca").val();
    var origen = $(article).find(".origenPedidoWeb").val() || 0;

    AbrirLoad();
    $.ajaxSetup({
        cache: false
    });
    $.getJSON(baseUrl + 'ShowRoom/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
        if (parseInt(data.Saldo) < parseInt(cantidad)) {
            var Saldo = data.Saldo;
            var UnidadesPermitidas = data.UnidadesPermitidas;

            CerrarLoad();

            if (Saldo == UnidadesPermitidas)
                AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
            else {
                if (Saldo == "0")
                    AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                else
                    AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
            }
        } else {
            var Item = {
                MarcaID: MarcaID,
                Cantidad: cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID,
                OrigenPedidoWeb: origen
            };

            AgregarProductoAlCarrito($(article).parents("[data-item]"));

            $.ajaxSetup({ cache: false });

            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'ShowRoom/InsertOfertaWebPortal',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(Item),
                async: true,
                success: function (response) {
                    CerrarLoad();

                    if (response.success == true) {

                        if ($.trim(tipoOrigenPantalla)[0] == '1') {
                            CargarResumenCampaniaHeader(true);

                            $(article).parents("[data-item]").find(".product-add").css("display", "block");
                        }
                        else if (tipoOrigenPantalla == 21) {
                            CargarCantidadProductosPedidos();
                        }

                        var padre = $(article).parents("[data-item]");
                        $(padre).find("[data-input='cantidad']").val(1);                        
                    }
                    else messageInfoError(response.message);
                },
                error: function (response, error) {
                    if (checkTimeout(response)) {
                        CerrarLoad();
                        console.log(response);
                    }
                }
            });
        }
    });
}

function AgregarProductoAlCarrito(padre) {
    if ($.trim(tipoOrigenPantalla)[0] != '1')
        return false;

    var carrito = $('.campana');
    if (carrito.length <= 0)
        return false;

    var contenedorImagen = $(padre).find("[data-img]");
    var imagenProducto = $('.imagen_producto', contenedorImagen);

    if (imagenProducto.length <= 0)
        return false;

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
            'opacity': 0
        }, 150, 'swing', function () {
            $(this).remove();
        });
    });

}

function OfertaCargarScroll() {
    var footerH = $(window).scrollTop() + $(window).height() + $("footer").innerHeight();
    if (footerH >= $(document).height()) {
        if (campaniaId <= 0) return false;
        
        var filtroCamp = filtroCampania[campaniaId];
        if (filtroCamp == undefined) filtroCamp = Clone(filtroIni);

        if ((filtroCamp.CantMostrados < filtroCamp.CantTotal && !isLoad) || filtroCamp.CantTotal == -1) {
            document.body.scrollTop = $(window).scrollTop();
            OfertaObtenerProductos();
        }
    }

}