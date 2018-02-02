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
var isScroll = typeof isScroll == "undefined" ? true : isScroll;
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

    urlOfertaCargarProductos = $.trim(urlOfertaCargarProductos);

    $("select[data-filtro-tipo]").change(function (event) {
        OfertaObtenerProductos(this, true);
    });

    $("a[data-filtro-tipo]").click(function (event) {
        OfertaObtenerProductos(this, true);
    });

    $("#divBorrarFiltros").click(function () {
        OfertaCargarProductos(null);
        $(this).hide();
    });

    if (isPagina("revistadigital") || isPagina("guianegocio")) {
        OfertaCargarProductos(null);
    }

    $(window).scroll(function () {
        OfertaCargarScroll();
    });

    $(window).scroll();
});

function OfertaObtenerProductos(filtro, clear) {
    var busquedaModel = OfertaObtenerFiltro(filtro, clear);
    if (busquedaModel.CampaniaID > 0) {
        OfertaCargarProductos(busquedaModel, clear);
    }
    //Analytics para RD
    try {
        if (typeof filtro != 'undefined') {
            var label = $(filtro).find("option:selected").text();
            var tipo = $(filtro).data("filtro-campo");
            rdAnalyticsModule.FiltrarProducto(tipo, label);
        }
    } catch (e) {
        console.log("Error analytic RD: " + e);
    }
}

function OfertaObtenerFiltro(filtro, clear) {

    var listaFiltros = Clone(filtroIni);
    if (filtro == null) {
        // solo con el scroll
        listaFiltros = filtroCampania[OfertaObtenerIndLocal(campaniaId)];
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

    OfertaObtenerIndLocal(campaniaId);
    if (filtroCampania[indCampania] != undefined && clear) {
        var aux = filtroCampania[indCampania].ListaFiltro || new Array();
        listaFiltros = aux.length > 0 ? filtroCampania[indCampania] : Clone(filtroIni);
    }
    listaFiltros.CampaniaID = campaniaId;

    var borrarFiltro = 'borrar' + campaniaId;
    $("[data-filtro-tipo='" + borrarFiltro + "']").parent().show();

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

    if (listaFiltros.ListaFiltro.length > 0 || listaFiltros.Ordenamiento.Valor != "01") {
        if ($("#div-delete-filters").length)
            $("#div-delete-filters").css("display", "");
    } else {
        if ($("#div-delete-filters").length)
            $("#div-delete-filters").css("display", "none");
    }
    return listaFiltros;
}

function OfertaCargarProductos(busquedaModel, clear, objSeccion) {

    busquedaModel = busquedaModel || Clone(filtroIni);
    objSeccion = objSeccion || {};
    busquedaModel.CampaniaID = busquedaModel.CampaniaID || objSeccion.CampaniaId || campaniaId || campaniaCodigo || 0;

    if (busquedaModel.CampaniaID <= 0) return false;

    if (urlOfertaCargarProductos == '') return false;

    OfertaObtenerIndLocal(busquedaModel.CampaniaID);

    if (filtroCampania[indCampania] == undefined) {
        filtroCampania[indCampania] = Clone(busquedaModel);
    }
    else {
        jQuery.extend(filtroCampania[indCampania], Clone(busquedaModel));
    }

    if (filtroCampania[indCampania].IsLoad) return false;
    filtroCampania[indCampania].IsLoad = true;

    var divProd = $("[data-listado-campania=" + busquedaModel.CampaniaID + "]");

    divProd.find('#divOfertaProductosLoad').html('<div style="text-align: center; min-height:100px;padding: 15px;">Cargando Productos<br><img src="' + urlLoad + '" /></div>');
    divProd.find("#divOfertaProductosLoad").show();

    if (filtroCampania[indCampania] != undefined) {
        if (filtroCampania[indCampania].response != undefined) {
            if (filtroCampania[indCampania].response.Completo == 1) {
                jQuery.extend(filtroCampania[indCampania], Clone(busquedaModel));
                OfertaCargarProductoRespuesta(filtroCampania[indCampania].response, clear, objSeccion);
                return true;
            }
        }
    }

    var valLocalStorage = LocalStorageListado(lsListaRD + busquedaModel.CampaniaID, null, 1);
    if (valLocalStorage != null) {
        filtroCampania[indCampania] = JSON.parse(valLocalStorage);
        jQuery.extend(filtroCampania[indCampania], Clone(busquedaModel));
        filtroCampania[indCampania].response = filtroCampania[indCampania].response || {};
        filtroCampania[indCampania].response.Completo = 0;
        OfertaCargarProductoRespuesta(filtroCampania[indCampania].response, clear, objSeccion);
        return true;
    }

    busquedaModel = busquedaModel || new Object();

    $.ajaxSetup({
        cache: false
    });

    busquedaModel.IsMobile = isMobile();
    jQuery.ajax({
        type: 'POST',
        url: urlOfertaCargarProductos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(busquedaModel),
        async: true,
        success: function (response) {

            OfertaCargarProductoRespuesta(response, clear, objSeccion);

        },
        error: function (response, error) {
            divProd.find("#divOfertaProductosLoad").hide();
            if (checkTimeout(response)) {
                CerrarLoad();
                console.log(response);
            }
        }
    });
}

function OfertaCargarProductoRespuesta(response, clear, objSeccion) {
    CerrarLoad();

    var divProd = $("[data-listado-campania=" + response.campaniaId + "]");
    if (divProd.length > 0) {
        divProd.find("#divOfertaProductosLoad").hide();
    }
    else {
        $("#divOfertaProductosLoad").hide();
    }

    if (response.success !== true) return false;

    divProd.find('[data-listado-content]').show();
    OfertaObtenerIndLocal(response.campaniaId);
    if (clear || false) {
        divProd.find('#divOfertaProductos').html("");
        filtroCampania[indCampania].CantMostrados = 0;
    }
    filtroCampania[indCampania].response = response;
    filtroCampania[indCampania].IsLoad = false;
    OfertaArmarEstrategias(response);
    
    return true;
    
}

function OfertaObtenerIndLocal(campId) {
    indCampania = 0;
    if (campId > campaniaAnio * 100 + campaniaNro) {
        indCampania = 1;
    }
    return indCampania;
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

    if (isScroll === false) return false;

    var footerH = $(window).scrollTop() + $(window).height()

    if (footerH == $(document).height()) {
        $(".flecha_scroll").animate({
            opacity: 0
        }, 100, 'swing', function () {
            $(".flecha_scroll a").addClass("flecha_scroll_arriba");
            $(".flecha_scroll").delay(100);
            $(".flecha_scroll").animate({
                opacity: 1
            }, 100, 'swing');
        });
    }
    else {
        $(".flecha_scroll a").removeClass("flecha_scroll_arriba");
    }

    if (campaniaId <= 0) return false;

    footerH += $("footer").innerHeight() || 0;
    if (footerH >= $(document).height()) {

        var filtroCamp = filtroCampania[OfertaObtenerIndLocal(campaniaId)];
        if (filtroCamp == undefined) filtroCamp = Clone(filtroIni);

        if ((filtroCamp.CantMostrados < filtroCamp.CantTotal && !filtroCamp.IsLoad) || filtroCamp.CantTotal == -1) {
            document.body.scrollTop = $(window).scrollTop();
            OfertaObtenerProductos();
        }

        if (filtroCamp.CantMostrados === filtroCamp.CantTotal) {
            
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - $("footer").height()) {
                $('.desplegablegnd').css("visibility", "hidden");
                $('.desplegablegnd .gndcontenido .gnd .gndbloque a').css("display", "none");
            }
            else {
                $('.desplegablegnd').css("visibility", "visible");
                $('.desplegablegnd .gndcontenido .gnd .gndbloque a').css("display", "block");

            }

        }
    }

}
