/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";
var urlOfertaCargarProductos = urlOfertaCargarProductos || '';
var urlOfertaDetalle = urlOfertaDetalle || '';
var campaniaId = campaniaId || 0;
var indCampania = indCampania || 0;
var lsListaRD = lsListaRD || "ListaRD";
var filtroCampania = new Array();
var filtroIni = {
    CampaniaID: 0,
    ListaFiltro: new Array(),
    Ordenamiento: new Object(),
    CantMostrados: 0,
    CantTotal: -1,
    IsLoad: false,
    Completo: 0
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
    var busquedaModel = OfertaObtenerFiltro(filtro, clear);
    if (busquedaModel.CampaniaID > 0) {
        OfertaCargarProductos(busquedaModel, clear);
    }
}

function OfertaObtenerFiltro(filtro, clear) {

    var listaFiltros = Clone(filtroIni);
    if (filtro == null) {
        // solo con el scroll
        listaFiltros = filtroCampania[OfertaObtenerDataLocal(campaniaId)];
        if (listaFiltros != undefined) {
            return listaFiltros;
        }
    }

    var listaFiltros = Clone(filtroIni);
    campaniaId = campaniaId || $(filtro).parents("[data-listado-campania]").attr("data-listado-campania") || 0;
    campaniaId = parseInt(campaniaId) || 0;
    listaFiltros.CampaniaID = campaniaId;

    var listadoFiltros = $(filtro).parents("#divFiltros").find("[data-filtro-campo]");

    var variante = $.trim($(filtro).attr("data-filtro-tipo"));
    var campo = $.trim($(filtro).attr("data-filtro-campo"));
    var accion = $.trim($(filtro).attr("data-filtro-accion"));
    if (variante == "borrar" || variante == "" || campo == "") {

        $(filtro).parent().hide();

        if (listadoFiltros.length == 0) {
            listadoFiltros = $(filtro).parents("#orderby-filter").find("#divFiltros").find("[data-filtro-campo]");
        }

        $.each(listadoFiltros, function (indSel, select) {
            $(select).val($($(select).find("option").get(0)).val());
        });

        return listaFiltros;
    }
    
    if (listadoFiltros.length == 0) {
        return new Array();
    }

    OfertaObtenerDataLocal(campaniaId);
    if (filtroCampania[indCampania] != undefined && clear) {
        var aux = filtroCampania[indCampania].ListaFiltro || new Array();
        listaFiltros = aux.length > 0 ? filtroCampania[indCampania] : Clone(filtroIni);
    }
    listaFiltros.CampaniaID = campaniaId;

    $("[data-filtro-tipo='borrar']").parent().show();

    $.each(listadoFiltros, function (indSel, select) {
        variante = $.trim($(select).attr("data-filtro-tipo"));
        campo = $.trim($(select).attr("data-filtro-campo"));
        accion = $.trim($(select).attr("data-filtro-accion"));
        var valor = $.trim($(select).val()); // para este caso solo es tag html select

        if (valor == "-" || valor == "") {
            if (accion == "orden") {
                listaFiltros.Ordenamiento = new Object();
            }
            else {
                listaFiltros.ListaFiltro = new Array();
            }
            return;
        }

        if (accion == "orden") {
            listaFiltros.Ordenamiento = {
                Tipo: campo,
                Valor: valor
            };
            //return listaFiltros;
        }
        else {

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
        }
    });
    return listaFiltros;
}

function OfertaCargarProductos(busquedaModel, clear) {

    if (urlOfertaCargarProductos == '') return false;
    
    busquedaModel = busquedaModel || Clone(filtroIni);
    busquedaModel.CampaniaID = busquedaModel.CampaniaID || campaniaId || 0;

    if (busquedaModel.CampaniaID <= 0) return false;

    OfertaObtenerDataLocal(busquedaModel.CampaniaID)

    if (filtroCampania[indCampania] == undefined) {
        filtroCampania[indCampania] = Clone(busquedaModel);
    }
    else {
        jQuery.extend(filtroCampania[indCampania], Clone(busquedaModel));
    }

    if (filtroCampania[indCampania].IsLoad) return false;
    filtroCampania[indCampania].IsLoad = true;

    var divProd = $("[data-listado-campania=" + busquedaModel.CampaniaID + "]");

    divProd.find('#divOfertaProductosLoad').html('<div style="text-align: center; min-height:150px;padding: 50px;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');
    divProd.find("#divOfertaProductosLoad").show();

    if (filtroCampania[indCampania] != undefined) {
        if (filtroCampania[indCampania].response != undefined) {
            if (filtroCampania[indCampania].response.Completo == 1) {
                jQuery.extend(filtroCampania[indCampania], Clone(busquedaModel));
                OfertaCargarProductoRespuesta(filtroCampania[indCampania].response, clear);
                return true;
            }
        }
    }

    var valLocalStorage = LocalStorageListado(lsListaRD + busquedaModel.CampaniaID, null, 1);
    if (valLocalStorage != null) {
        filtroCampania[indCampania] = JSON.parse(valLocalStorage);
        jQuery.extend(filtroCampania[indCampania], Clone(busquedaModel));
        filtroCampania[indCampania].response.Completo = 0
        OfertaCargarProductoRespuesta(filtroCampania[indCampania].response, clear);
        return true;
    }

    busquedaModel = busquedaModel || new Object();
    //AbrirLoad();
    $.ajaxSetup({
        cache: false
    });

    $('#divOfertaProductosLoad').html('<div style="text-align: center; min-height:150px;padding: 50px;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');
    $("#divOfertaProductosLoad").show();

    busquedaModel.IsMobile = isMobile();
    busquedaModel.Valoropcional = $.trim($("[data-tag='" + busquedaModel.CampaniaID + "']").attr("data-tab-tipo"));
    jQuery.ajax({
        type: 'POST',
        url: urlOfertaCargarProductos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(busquedaModel),
        async: true,
        success: function (response) {
           
            OfertaCargarProductoRespuesta(response, clear);
 
        },
        error: function (response, error) {
            divProd.find("#divOfertaProductosLoad").hide();
            $("#divOfertaProductosLoad").hide();
            if (checkTimeout(response)) {
                CerrarLoad();
                console.log(response);
            }
        }
    });
}

function OfertaCargarProductoRespuesta(response, clear) {
    CerrarLoad();

    var divProd = $("[data-listado-campania=" + response.campaniaId + "]");
    if (divProd.length > 0) {
        divProd.find("#divOfertaProductosLoad").hide();
    }
    else {
        $("#divOfertaProductosLoad").hide();
    }
    
    if (response.success == true) {
        OfertaObtenerDataLocal(response.campaniaId);
        if (clear || false) {
            divProd.find('#divOfertaProductos').html("");
            filtroCampania[indCampania].CantMostrados = 0;
        }
        filtroCampania[indCampania].response = response;
        OfertaArmarEstrategias(response);
        filtroCampania[indCampania].IsLoad = false;
        return true;
    }

    //messageInfoError(response.message);
}

function OfertaObtenerDataLocal(campId) {
    indCampania = 0;
    if (campId > campaniaAnio * 100 + campaniaNro) {
        indCampania = 1;
    }
    return indCampania;
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
        
        var filtroCamp = filtroCampania[OfertaObtenerDataLocal(campaniaId)];
        if (filtroCamp == undefined) filtroCamp = Clone(filtroIni);

        if ((filtroCamp.CantMostrados < filtroCamp.CantTotal && !filtroCamp.IsLoad) || filtroCamp.CantTotal == -1) {
            document.body.scrollTop = $(window).scrollTop();
            OfertaObtenerProductos();
        }
    }

}

function LocalStorageListado(key, valor, accion) {
    // accion => 0 insertar => 1 obtener => 2 eliminar
    accion = accion || 0;

    if (accion == 0) {
        if (valor != undefined) {
            localStorage.setItem(key, valor);
        }
    }
    else if (accion == 1) {
        return localStorage.getItem(key);
    }

    if (accion == 3) {
        localStorage.removeItem(key);
    }
}