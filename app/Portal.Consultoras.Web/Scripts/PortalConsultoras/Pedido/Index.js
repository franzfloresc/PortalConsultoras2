var animacion = true;
var contadorNext = 2;
var positionCarrousel = 0;
var posicionInicial = 0;
var posicionFinalPantalla = 2;
var posicionTotal = 0;
var salto = 3;

var arrayOfertasParaTi = [];
//var array_odd = [];
var arrayProductosSugeridos = [];
var arrayProductosGuardadoExito = [];
var numImagen = 1;
var fnMovimientoTutorial;
var origenPedidoWebEstrategia = origenPedidoWebEstrategia || 0;

var tipoOfertaFinal_Log = "";
var gap_Log = 0;
var tipoOrigen = "1";
var dataBarra = dataBarra || {};
var listaEscalaDescuento = listaEscalaDescuento || {};
var listaMensajeMeta = listaMensajeMeta;
var listaParametriaOfertaFinal = listaParametriaOfertaFinal || {};
var cuvbuscado = "";
var cuvEsCuponNuevas = false;
//INI HD-3908
var _flagNueva = false;
//FIN HD-3908
var pedidoProvider = PedidoProvider();

$(document).ready(function () {
    ValidarKitNuevas();

    var hdDataBarra = $("#hdDataBarra").val();
    if ($.trim(hdDataBarra) != "") {
        dataBarra = JSON.parse(hdDataBarra);
        listaMensajeMeta = dataBarra.ListaMensajeMeta || [];
    }

    var hdListaEscalaDescuento = $("#hdListaEscala").val();
    if ($.trim(hdListaEscalaDescuento) != "") {
        listaEscalaDescuento = JSON.parse(hdListaEscalaDescuento);
    }

    var hdListaParametriaOfertaFinal = $("#hdListaParametriaOfertaFinal").val();
    if ($.trim(hdListaParametriaOfertaFinal) != "") {
        listaParametriaOfertaFinal = JSON.parse(hdListaParametriaOfertaFinal);
    }

    dataBarra.TotalPedido = dataBarra.TotalPedido || parseFloat($("#hdfTotal").val(), 10);

    $("#hdDataBarra, #hdListaEscala").val("");

    ReservadoOEnHorarioRestringido(false);

    AnalyticsBannersInferioresImpression();
    $("#salvavidaTutorial").show();

    $("#salvavidaTutorial").click(function () {
        abrir_popup_tutorial();
    });
    $(".cerrar_tutorial").click(function () {
        cerrar_popup_tutorial();
    });

 

    $("body").click(function (e) {
        if (!$(e.target).closest(".ui-dialog").length) {
            if ($("#divObservacionesPROL").is(":visible"))
                HideDialog("divObservacionesPROL");
            if ($("#divReservaSatisfactoria").is(":visible"))
                HideDialog("divReservaSatisfactoria");
            if ($("#divReservaSatisfactoria3").is(":visible"))
                HideDialog("divReservaSatisfactoria3");
        }
    });

    $("#txtClienteDescripcion").autocomplete({
        source: baseUrl + "Pedido/AutocompleteByCliente",
        minLength: 4,
        select: function (event, ui) {
            currentClienteCreate = null;

            ui.item.ClienteID = ui.item.ClienteID || 0;

            if (gTipoUsuario == 2) {
                var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp";
                $("#dialog_MensajePostulante #tituloContenido").text("LO SENTIMOS");
                $("#dialog_MensajePostulante #mensajePostulante").text(mesg);
                $("#dialog_MensajePostulante").show();
                return false;
            }

            if (ui.item.ClienteID == 0) {
                return false;
            }
            else if (ui.item.ClienteID == -1) {
                showClienteDetalle(null, function (cliente) {
                    $("#hdfClienteID").val(cliente.ClienteID);
                    $("#hdnClienteID_").val(cliente.ClienteID);
                    $("#txtClienteDescripcion").val(cliente.Nombre);
                    $("#hdfClienteDescripcion").val(cliente.Nombre);

                });
            }
            else {
                $("#hdfClienteID").val(ui.item.ClienteID);
                $("#hdnClienteID_").val(ui.item.ClienteID);
                $("#txtClienteDescripcion").val(ui.item.Nombre);
                $("#hdfClienteDescripcion").val(ui.item.Nombre);

                currentClienteCreate = ui.item;

                if (ui.item.TieneTelefono == 0) showClienteDetalle(ui.item, function (cliente) {
                    $("#hdfClienteID").val(cliente.ClienteID);
                    $("#hdnClienteID_").val(cliente.ClienteID);
                    $("#txtClienteDescripcion").val(cliente.Nombre);
                    $("#hdfClienteDescripcion").val(cliente.Nombre);

                });
            }

            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<a>" + item.Nombre + "</a>")
            .appendTo(ul);
    };

    $("#txtDescripcionProd").keyup(function (evt) {
        $("#divObservaciones").html("");
        $("#txtCantidad").removeAttr("disabled");
        document.getElementById('divObservacionesDescripProd').style.display = "none";
    });
    $("#txtDescripcionProd").autocomplete({
        source: baseUrl + "Pedido/AutocompleteByProductoDescripcion",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.CUV == "0") return false;

            $("#txtDescripcionProd")[0].item = ui.item;
            $("#txtDescripcionProd").val(ui.item.Descripcion);
            $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
            $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
            $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
            $("#hdMetodoBusqueda").val("Por descripción");
            cuvEsCuponNuevas = ui.item.EsCuponNuevas;

            if (ui.item.CUV.length === 5) {
                BuscarByCUV(ui.item.CUV);
            }

            CargarProductosRecomendados(ui.item);

            event.preventDefault();
        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        if (item.Descripcion == "Sin Resultados") {
            document.getElementById('divObservacionesDescripProd').style.display = "inline-block";
            return $("<li></li>");
        } else
            return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a>" + item.Descripcion + "</a>")
                .appendTo(ul);
    };

    $("#txtCUV").keyup(function (evt) {

        $("#txtCantidad").removeAttr("disabled");
        $("#txtCantidad").val("");
        $("#hdfDescripcionProd").val("");
        $("#txtDescripcionProd").val("");
        $("#btnAgregar").attr("disabled", "disabled");
        $("#divMensaje").text("");
        $("#txtPrecioR").val("");
        $("#hdfPrecioUnidad").val("");
        document.getElementById('divObservacionesDescripProd').style.display = 'none';
        ProductoRecomendadoModule.OcultarProductosRecomendados();

        if ($(this).val().length === 5) {
            BuscarByCUV($(this).val());
        } else {
            $("#divProductoAgotadoFinal").fadeOut(100);
            $("#hdfCUV").val("");
            $("#divObservaciones").html("");
        }
    });

    $("#txtCUV").autocomplete({
        source: baseUrl + "Pedido/AutocompleteByProductoCUV",
        minLength: 4,
        select: function (event, ui) {
            if (ui.item.MarcaID != 0) {
                $("#hdTipoOfertaSisID").val(ui.item.TipoOfertaSisID);
                $("#hdConfiguracionOfertaID").val(ui.item.ConfiguracionOfertaID);
                $("#hdfIndicadorMontoMinimo").val(ui.item.IndicadorMontoMinimo);
                $("#hdTipoEstrategiaID").val(ui.item.TipoEstrategiaID);
                cuvEsCuponNuevas = ui.item.EsCuponNuevas;
                ObservacionesProducto(ui.item);

                CargarProductosRecomendados(ui.item);
            }
            event.preventDefault();
            return false;

        }
    }).data("autocomplete")._renderItem = function (ul, item) {
        if (isNaN(item.CUV) == true) {
            document.getElementById('divObservaciones').style.display = 'block';
            $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>El producto solicitado no existe</div></div>");
            return $("<li></li>");
        } else
            return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a>" + item.CUV + "</a>")
                .appendTo(ul);
    };

    $("#txtCUV").on('input', function () {
        if (isNaN($("#txtCUV").val()) == true) {
            $("#txtCUV").val("");
            //document.getElementById('divObservaciones').style.display = 'block';
            //$("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>El codigo CUV debe ser un número</div></div>");
            return false;
        }
    });

    $(".ValidaAlfanumerico").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : (window.event ? window.event.keyCode : null);
        if (!charCode) return false;
        if (charCode <= 13) {
            return true;
        } else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ' ]/;
            return re.test(keyChar);
        }
    });
    $(".ValidaAlfabeto").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return true;
        } else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-ZñÑáéíóúÁÉÍÓÚ' ]/;
            return re.test(keyChar);
        }
    });
    $(".ValidaNumeralPedido").live("keyup", function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });
    $(".ValidaNumeralPedido").live("keypress", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });
    $("#btnValidarPROL").on("click", function (e) {
        if (gTipoUsuario == 2) { //Postulante
            var mesg = "Recuerda que este pedido no se va a facturar. Pronto podrás acceder a todos los beneficios de Somos Belcorp.";
            $("#dialog_MensajePostulante #tituloContenido").text("IMPORTANTE");
            $("#dialog_MensajePostulante #mensajePostulante").text(mesg);
            $("#dialog_MensajePostulante").show();

            if (indicadorGPRSB == 1) ConfirmarModificar();
        }
        else EjecutarPROL();

        e.stopPropagation(); //Para evitar que se cierre el popup de divObservacionesPROL
    });
    

    $("body").on("mouseleave", ".cantidad_detalle_focus", function () {
        var rowElement = $(this).closest(".contenido_ingresoPedido");
        var cant = $(rowElement).find(".txtLPCant").val();
        var cantAnti = $(rowElement).find(".txtLPTempCant").val();
        if (cant == cantAnti) {
            return false;
        }
        $(rowElement).find("input.liquidacion_rango_cantidad_pedido").focus();
        $(rowElement).find("input.liquidacion_rango_cantidad_pedido").select();
        $("#txtCUV").focus();
    });

    $("body").on("click", ".agregarSugerido", function () {
        AbrirSplash();

        var divPadre = $(this).parents("[data-item='producto']").eq(0);
        var cuv = $(divPadre).find(".hdSugeridoCuv").val();
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var tipoOfertaSisID = $(divPadre).find(".hdSugeridoTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdSugeridoConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdSugeridoIndicadorMontoMinimo").val();

        var marcaID = $(divPadre).find(".hdSugeridoMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdSugeridoPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdSugeridoDescripcionProd").val();
        var descripcionMarca = $(divPadre).find(".hdSugeridoDescripcionMarca").val();
        var descripcionEstrategia = $(divPadre).find(".hdSugeridoDescripcionEstrategia").val();
        var OrigenPedidoWeb = DesktopPedidoSugerido;
        var posicion = $(divPadre).find(".hdPosicionSugerido").val();
        var tipoEstrategiaId = $(divPadre).find(".hdTipoEstrategiaID").val();

        if (!isInt(cantidad)) {
            AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $(".liquidacion_rango_cantidad_pedido").val(1);
            CerrarSplash();
            limpiarInputsPedido();
            return false;
        }

        if (HorarioRestringido()) {
            CerrarSplash();
            return;
        }
        if (cantidad <= 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
            $(".liquidacion_rango_cantidad_pedido").val(1);
            CerrarSplash();
            limpiarInputsPedido();
            return false;
        }

        InsertarDemandaTotalReemplazoSugerido(cuv, precioUnidad, cantidad, true);

        var model = {
            CUV: cuv,
            Cantidad: cantidad,
            PrecioUnidad: precioUnidad,
            TipoEstrategiaID: parseInt(tipoEstrategiaId),
            OrigenPedidoWeb: OrigenPedidoWeb,
            MarcaID: marcaID,
            DescripcionProd: descripcionProd,
            TipoOfertaSisID: tipoOfertaSisID,
            IndicadorMontoMinimo: indicadorMontoMinimo,
            ConfiguracionOfertaID: configuracionOfertaID,
            EsSugerido: true,

            DescripcionMarca: descripcionMarca,
            DescripcionEstrategia: descripcionEstrategia,
            Posicion: posicion
        };

        PedidoRegistroModule.AgregarProductoPorUrl("PedidoAgregarProductoTransaction", model, "divProductoSugerido", true);
        dataLayer.push({
            'event': "addToCart",
            'ecommerce': {
                'add': {
                    'actionField': { 'list': "Productos de reemplazo - Pedido" },
                    'products': [{
                        'name': model.DescripcionProd,
                        'price': model.PrecioUnidad,
                        'brand': model.DescripcionMarca,
                        'id': model.CUV,
                        'category': "NO DISPONIBLE",
                        'variant': (model.DescripcionEstrategia == "" || model.DescripcionEstrategia == null) ? "Estándar" : model.DescripcionEstrategia,
                        'quantity': Number(model.Cantidad),
                        'position': Number(model.Posicion)
                    }]
                }
            }
        });

        BloquearPantallaPedidoByPopupSugerido('');
        $("#divProductoAgotadoFinal").fadeOut(100);


    });
    $("body").on("click", "[data-close='divProductoAgotadoFinal']", function () {
        InsertarDemandaTotalReemplazoSugerido(null, 0, 1, false);
        limpiarInputsPedido();

        BloquearPantallaPedidoByPopupSugerido('');
        $("#divProductoAgotadoFinal").fadeOut(100);
        dataLayer.push({
            'event': "virtualEvent",
            'category': "Ingresa tu pedido",
            'action': "Productos de reemplazo",
            'label': "No gracias"
        });
    });
    $("#frmInsertPedido").on("submit", function () {
        if (!$(this).valid()) {
            AbrirMensaje("Argumentos no validos");
            return false;
        }

        var cantidad = $.trim($("#txtCantidad").val());
        if (cantidad == "" || cantidad[0] == "-") {
            AbrirMensaje("Ingrese una cantidad mayor que cero.");
            return false;
        }
        if (!isInt(cantidad)) {
            AbrirMensaje("Ingrese una cantidad mayor que cero.");
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            AbrirMensaje("Ingrese una cantidad mayor que cero.");
            return false;
        }

        var cuv = $("#txtCUV").val();
        var esKit = $("#divListadoPedido").find("input[data-kit='True']") || $("#divListadoPedido").find("input[data-kit='true']") || [];
        if (esKit.length > 0) {
            var tag = $(esKit).parents("tr");
            var cuvKit = $.trim(tag.attr("data-cuv"));
            if (cuv == cuvKit) {
                AbrirMensaje("El CUV ingresado pertenece a un Kit Nuevas, solo puede ser registrado 1 vez");
                return false;
            }
        }

        if ($("#hdTipoOfertaSisID").val() == constConfiguracionOfertaLiquidacion) {
            AbrirMensaje(mensajeNoAgregarLiquidacion);
            return false;
        }

        var flagNueva = $.trim($("#hdFlagNueva").val());
        if (flagNueva == "0" || flagNueva == "") {
            var form = FuncionesGenerales.GetDataForm(this);
            form.data.TipoOfertaSisID = $("#hdTipoEstrategiaID").val();
            form.data.TipoEstrategiaID = $("#hdTipoEstrategiaID").val();
            form.data.EsCuponNuevas = cuvEsCuponNuevas;
            PedidoRegistroModule.InsertarProductoPasePedido(form);
        } else {
            PedidoRegistroModule.AgregarProductoZonaEstrategia(flagNueva == "1" ? 2 : flagNueva);
        }

        if (cuv.substring(0, 3) == '999') {
            sessionStorage.setItem('cuvPack', cuv);
        }

        ProcesarActualizacionMostrarContenedorCupon();
        ProductoRecomendadoModule.OcultarProductosRecomendados();
        $("#btnAgregar").removeAttr("disabled");

        return false;
    });
    $("body").on("click", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "back" || accion === "next") {
            CambioPagina(obj);
        }
    });
    $("body").on("change", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion === "page" || accion === "rows") {
            CambioPagina(obj);
        }
    });

    $("#producto-faltante-busqueda-cuv, #producto-faltante-busqueda-descripcion").on("keypress", function (e) {
        if (e.which == 13) CargarProductoAgotados(0);
    });

    $("#ddlCategoriaProductoAgotado, #ddlCatalogoRevistaProductoAgotado").on("change", function (e) {
        CargarProductoAgotados(0);
    });

    $(document).on("click", "#idImagenCerrar", function (e) { $(this).parent().hide(); });

    CrearDialogs();
    MostrarBarra();

    //INI HD-4200
    ValidarSuscripcionSE(function () { CargarDetallePedido();},0);
    //FIN HD-4200
    
    CargarCarouselEstrategias();
    CargarAutocomplete();
    CargarDialogMesajePostulantePedido();
    EstablecerAccionLazyImagen("img[data-lazy-seccion-banner-pedido]");

    LayoutMenu();

    var myvar = setInterval(myTimer, 1000);
    var cont = 0;
    function myTimer() {
        if (cont <= 5) {
            cont++;
            if (document.getElementById('divListaEstrategias').style.display == 'none') {
                MostrarBarra();
                clearInterval(myvar);
            }

        }
        else
            clearInterval(myvar);

    }




    $("#observaciones_alerta").dialog({
        modal: true,
        draggable: false,
        resizable: false,
        width: 620,
        autoOpen: false,
        open: function (event, ui) {
            $("body").addClass("overflow_hidden");
            $(".ui-widget-header").css("display", "none");
        },
        close: function (event, ui) {
            $("body").removeClass("overflow_hidden");
        },
        create: function (event, ui) {

        },

    });

    $('.close_buttom_alerta').click(function () {
        HideDialog("observaciones_alerta");
        return false;
    });


});

function CargarDetallePedido(page, rows, asyncrono) {
    $(".pMontoCliente").css("display", "none");

    $("#tbobyDetallePedido").html('<div><div style="width:100%;"><div style="text-align: center;"><br>Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></div></div>');

    var pedidoPageParams = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 20,
        clienteId: $("#ddlClientes").val() || -1
    };

    pedidoProvider
        .cargarDetallePedidoPromise(pedidoPageParams)
        .done(function (response) {
            if (checkTimeout(response)) {
                var data = response.data;

                ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

                $("#pCantidadProductosPedido").html(data.TotalProductos);

                $("#hdnRegistrosPaginar").val(data.Registros);
                $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
                $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
                $("#hdnPaginaPaginar").val(data.Pagina);
                $("#hdnPaginaDePaginar").val(data.PaginaDe);

                $("#hdnRegistros").val(data.Registros);
                $("#hdnRegistrosDe").val(data.RegistrosDe);
                $("#hdnRegistrosTotal").val(data.RegistrosTotal);
                $("#hdnPagina").val(data.Pagina);
                $("#hdnPaginaDe").val(data.PaginaDe);

                var htmlCliente = "";

                $("#ddlClientes").empty();

                $.each(data.ListaCliente, function (index, value) {
                    if (value.ClienteID == -1) {
                        htmlCliente += '<option value="-1">Cliente</option>';
                    } else {
                        htmlCliente += '<option value="' + value.ClienteID + '">' + value.Nombre + "</option>";
                    }
                });

                $("#ddlClientes").append(htmlCliente);
                $("#ddlClientes").val(pedidoPageParams.clienteId);

                data.ListaDetalleModel = data.ListaDetalleModel || [];
                $.each(data.ListaDetalleModel, function (ind, item) {
                    item.EstadoSimplificacionCuv = data.EstadoSimplificacionCuv;
                });

                var html = ArmarDetallePedido(data.ListaDetalleModel);
                $("#tbobyDetallePedido").html(html);

                if ($("#divObservacionesPROL").is(":visible")) {
                    HideDialog("divObservacionesPROL");
                    ShowPopupObservacionesReserva();
                }

                data.footer = true;
                var htmlPaginadorH = ArmarDetallePedidoPaginador(data);

                data.footer = false;
                var htmlPaginadorF = ArmarDetallePedidoPaginador(data);

                $("#paginadorCab").html(htmlPaginadorH);
                $("#paginadorPie").html(htmlPaginadorF);

                $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

                MostrarInformacionCliente(pedidoPageParams.clienteId);
                mostrarSimplificacionCUV();

                MostrarBarra(response);
                CargarAutocomplete();

                if ($("#penmostreo").length > 0) {
                    if ($("#penmostreo").attr("[data-tab-activo]") == "1") {
                        $("ul.paginador_notificaciones").hide();
                    }
                }
                // camino brillante

                var filas = document.getElementById('tbListaPedido').children[1].getElementsByClassName('contenido_ingresoPedido mouse_encima');


                var Eskits = false;
                if (filas != null) {

                    for (var i = 0; i < filas.length; i++) {

                        if (filas[i].children[0].getElementsByClassName('texto_pedidos_ofertas')[0].firstElementChild.innerHTML == 'CAMINOBRILLANTE') {

                            for (var j = 0; j < kitsCaminoBrillante.length; j++) {
                                if (filas[i].getAttribute('data-cuv') == kitsCaminoBrillante[j].Cuv) {
                                    Eskits = true;
                                }
                            }

                            if (Eskits == true) {
                                filas[i].children[1].children[1].children[1].children[0].className = 'desactivo';
                                filas[i].children[1].children[1].children[1].children[0].onclick = function (e) {
                                    e.preventDefault();
                                }
                                filas[i].children[1].children[1].children[1].children[1].className = 'desactivo';
                                filas[i].children[1].children[1].children[1].children[1].onclick = function (e) {
                                    e.preventDefault();
                                }

                                filas[0].children[1].children[1].children[0].disabled = 'disabled';
                            }
                        }
                    }
                }

            }
        })
        .fail(function (response, error) {
        });

}

function CargarDialogMesajePostulantePedido() {
    if (gTipoUsuario == "2" && MensajePedidoDesktop == "0") {
        var mesg = "En este momento podrás simular el ingreso de tu pedido.";
        var title = "TE ENCUENTRAS EN UNA SESIÓN DE PRUEBA";
        $("#dialog_MensajePostulante_Pedido #titutloPedido").text(title);
        $("#dialog_MensajePostulante_Pedido #mensajePedido").text(mesg);
        $("#dialog_MensajePostulante_Pedido #btnOk").text("CONTINUAR");
        $("#dialog_MensajePostulante_Pedido").show();
        return false;
    }
}

function CerrarDialogMesajePostulantePedido() {
    $("#dialog_MensajePostulante_Pedido").hide();
    abrir_popup_tutorial();
    UpdateUsuarioTutoriales();
}

function abrir_popup_tutorial() {
    $("#popup_tutorial_pedido").fadeIn();
    $("html").css({ 'overflow-y': "hidden" });

    fnMovimientoTutorial = setInterval(function () {
        $(".img_slide" + numImagen + "Pedido").animate({ 'opacity': "0" });
        numImagen++;
        if (numImagen > 5) {
            numImagen = 1;
            $(".imagen_tutorial").animate({ 'opacity': "1" });
        }

    }, 3000);
}

function UpdateUsuarioTutoriales() {
    var item = {
        tipo: "1" // Para Desktop
    };

    pedidoProvider
        .updatePostulanteMensaje(item)
        .done(function (data) { })
        .fail(function (data, error) { });

    return true;
}

function cerrar_popup_tutorial() {
    $("#popup_tutorial_pedido").fadeOut();
    $("html").css({ 'overflow-y': "auto" });
    $(".imagen_tutorial").animate({ 'opacity': "1" });
    window.clearInterval(fnMovimientoTutorial);
    numImagen = 1;
}

function CrearDialogs() {

    $("#divMensajeCUV").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 364,
        height: 158,
        draggable: true,
        title: "Importante"
    });

    $("#divConfirmEliminarTotal").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        draggable: true,
        title: "",
        open: function (event, ui) {
            $("body").addClass("overflow_hidden");
        },
        close: function (event, ui) {
            HideDialog("divConfirmEliminarTotal");
        },
        create: function (event, ui) {
            $("#divConfirmEliminarTotal").parent().addClass("pop_up_eliminar");
        },
    });

    $('.close_buttom_alerta_alerta').click(function () {
        HideDialog("divConfirmEliminarTotal");
        return false;
    });

    $("#divObservacionesPROL").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        draggable: true,
        width: 600,
        close: function (event, ui) {
            HideDialog("divObservacionesPROL");
        }
    });

    $("#divConfirmValidarPROL").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 550,
        draggable: true,
        close: function (event, ui) {
            HideDialog("divConfirmValidarPROL");
        }
    });
    $("#divConfirmValidarPROL2").dialog({
	    autoOpen: false,
	    resizable: false,
	    modal: true,
	    closeOnEscape: true,
	    width: 550,
	    draggable: true,
	    close: function (event, ui) {
		    HideDialog("divConfirmValidarPROL");
	    }
    });

    $("#divReservaSatisfactoria").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true,
    });

    $("#divReservaSatisfactoria2").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true,
    });

    $("#divReservaSatisfactoria3").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 400,
        draggable: true
    });

    $("#divBackOrderModificado").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: false,
        width: 400,
        draggable: true
    });

    $("#divVistaPrevia").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 350,
        draggable: false,
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        }
    });

    $("#divProductoSugerido").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 500,
        height: 300,
        draggable: true,
        title: "PRODUCTOS SUGERIDOS"
    });
}

function MostrarInformacionCliente(clienteId) {
    $("#hdnClienteID_").val(clienteId);
    var nomCli = $("#ddlClientes option:selected").text();
    var monto = $("#hdfTotalCliente").val();

    $(".pMontoCliente").css("display", "none");

    if ($("#hdnClienteID_").val() != "-1") {
        $(".pMontoCliente").css("display", "block");
        $("#spnNombreCliente").html(nomCli + " :");
        $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
    }
}

function ValidarStockEstrategia() {
    var resultado;

    var success = false;
    var message = "";

    var CUV = $("#txtCUV").val();
    $("#hdCuvRecomendado").val(CUV);
    $("#btnAgregar").attr("disabled", "disabled");

    if ($("#hdTipoOfertaSisID").val() == constConfiguracionOfertaLiquidacion) {
        resultado = {
            success: false,
            message: mensajeNoAgregarLiquidacion
        };
        return resultado;
    }

    var cantidadSol = $("#txtCantidad").val();
    var pprecio = $("#txtPrecioR").val();

    var param = {
        CUV: CUV,
        PrecioUnidad: pprecio,
        Cantidad: cantidadSol,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        esCuponNuevas: cuvEsCuponNuevas,
        Descripcion: $("#txtDescripcionProd").val()
    };

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/ValidarStockEstrategia",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        async: false,
        success: function (datos) {
            if (checkTimeout(datos)) {
                success = datos.result;
                message = datos.message;
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                resultado = false;
            }
        }
    });

    resultado = {
        success: success,
        message: message
    };

    return resultado;
}

function ActualizarMontosPedido(formatoTotal, total, formatoTotalCliente) {

    if (total != undefined)
        $("#hdfTotal").val(total);

    if (formatoTotalCliente != undefined)
        $("#hdfTotalCliente").val(formatoTotalCliente);
}

function ArmarDetallePedidoPaginador(data) {
    return SetHandlebars("#paginador-template", data);
}

function ArmarDetallePedido(array) {
    return SetHandlebars("#producto-template", array);
}

function mostrarSimplificacionCUV() {
    var clase = $("#divListadoPedido").find(".icon-advertencia").length;
    $(".datos_simplificacionCUV").Visible(clase > 0);

    var icoCell = $("#divListadoPedido").find(".icon-mobile").length;
    $(".datos_para_movil").Visible(icoCell > 0);
}

function ValidarCUV() {
    if ($("#hdfCUV").val() != "" && $("#txtCUV").val() != "") {
        if ($("#txtCUV").val() != $("#hdfCUV").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        if ($("#txtCUV").val().length !== 5) {
            $("#txtCantidad").val("");
            $("#hdfCUV").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtDescripcionProd").val("");
            $("#btnAgregar").attr("disabled", "disabled");
            $("#divMensaje").text("");
            $("#txtPrecioR").val("");
            $("#hdfPrecioUnidad").val("");
        }

    }
}

function ValidarDescripcion() {
    if ($("#hdfDescripcionProd").val() != "" && $("#txtDescripcionProd").val() != "") {
        if ($("#txtDescripcionProd").val() != $("#hdfDescripcionProd").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un producto válido.");
            $("#btnAgregar").attr("disabled", "disabled");
        }
    } else {
        $("#txtCantidad").val("");
        $("#hdfCUV").val("");
        $("#txtCUV").val("");
        $("#hdfDescripcionProd").val("");
        $("#btnAgregar").attr("disabled", "disabled");
        $("#divMensaje").text("");
    }
}

//function PreValidarCUV(event) {

//    event = event || window.event;

//    if (event.keyCode == 13) {
//        if ($("#btnAgregar")[0].disabled == false) {
//            PedidoRegistroModule.AgregarProductoListadoPasePedido();
//        }
//    }
//}

function SeleccionarContenido(control) {
    control.select();
}

function PedidoFailure(param) {
    AbrirMensaje("Ocurrió un error. Por favor, vuelva a realizar la acción.");
}

function ValidarCliente() {
    if ($("#hdfClienteDescripcion").val() != "" && $("#txtClienteDescripcion").val() != "") {
        if ($("#txtClienteDescripcion").val() != $("#hdfClienteDescripcion").val()) {
            $("#divMensaje").text("Ud. debe seleccionar un cliente válido.");
        }
    } else {
        $("#hdfClienteDescripcion").val("");
        $("#hdfClienteID").val("0");
        $("#divMensaje").text("");
    }
}

function ValidarClienteFocus(event) {
    event = event || window.event;

    if (event.keyCode == 9) {
        if ($("#btnAgregar")[0].disabled == true) {
            if (event.preventDefault)
                event.preventDefault();
            else
                event.returnValue = false;
            $("#txtCUV").focus();
        }
    }
}

var ClienteDetalleOK = null;
var ClienteDetalleCANCEL = null;
var flagClienteDetalle = false;

function showClienteDetalle(cliente, pClienteDetalleOK, pClienteDetalleCANCEL) {
    if (gTipoUsuario == "2") {
        var mesg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
        $("#dialog_MensajePostulante #tituloContenido").text("LO SENTIMOS");
        $("#dialog_MensajePostulante #mensajePostulante").text(mesg);
        $("#dialog_MensajePostulante").show();
        return false;
    }

    if (cliente == null) {
        cliente = {};
        var NombreCliente = jQuery.trim($("#txtClienteDescripcion").val());
        if (NombreCliente.length > 0) cliente.NombreCliente = NombreCliente;
    }

    flagClienteDetalle = true;

    AbrirSplash();

    $.ajax({
        type: "GET",
        dataType: "html",
        cache: false,
        url: baseUrl + "Cliente/Detalle",
        data: cliente,
        success: function (data) {
            CerrarSplash();

            $("#divDetalleCliente").html(data);
            $("#divAgregarCliente").show();

            if ($.isFunction(pClienteDetalleOK)) {
                ClienteDetalleOK = pClienteDetalleOK;
            }
            else {
                ClienteDetalleOK = function (cliente) {
                    $("#hdfClienteID").val(cliente.ClienteID);
                    $("#hdnClienteID_").val(cliente.ClienteID);
                    $("#txtClienteDescripcion").val(cliente.Nombre);
                    $("#hdfClienteDescripcion").val(cliente.Nombre);
                };
            }

            ClienteDetalleCANCEL = null;
            if ($.isFunction(pClienteDetalleCANCEL)) ClienteDetalleCANCEL = pClienteDetalleCANCEL;
        },
        error: function (xhr, ajaxOptions, error) {
            CerrarSplash();
            flagClienteDetalle = false;
        }
    });
}

function Tabular(event) {
    event = event || window.event;

    if (event.keyCode == 9) {
        if (event.preventDefault)
            event.preventDefault();
        else
            event.returnValue = false;
        $("#txtCUV").focus();
    }
}

function PedidoOnSuccess() {

    $("#divObservaciones").html("");
    $("#hdnDescripcionEstrategia").val("");
    $("#hdnDescripcionLarga").val("");
    $("#hdnDescripcionProd").val("");

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#txtCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtPrecioR").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val($("#hdfClienteDescripcion").val());
    $("#btnAgregar").attr("disabled", "disabled");

    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#ddlClientes").val($("#hdnClienteID2_").val());
    $("#hdnClienteID_").val($("#hdnClienteID2_").val());

    CalcularTotal();
    $("#txtCUV").focus();

    InfoCommerceGoogleProductoRecomendados();
}

function cierreCarouselEstrategias() {
    $("#cierreCarousel").hide();
}

function limpiarInputsPedido() {
    $("#txtCUV").val("");
    $("#txtPrecioR").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val("");
    $("#txtCUV").focus();
}

function PedidoOnSuccessSugerido(model) {

    $("#divObservaciones").html("");
    $("#hdnDescripcionEstrategia").val("");
    $("#hdnDescripcionLarga").val("");
    $("#hdnDescripcionProd").val("");

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#txtCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtPrecioR").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val($("#hdfClienteDescripcion").val());
    $("#btnAgregar").attr("disabled", "disabled");

    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#ddlClientes").val($("#hdnClienteID2_").val());
    $("#hdnClienteID_").val($("#hdnClienteID2_").val());

    CalcularTotal();
    $("#txtCUV").focus();
}

function AbrirSplash() {
    waitingDialog({});
}

function CerrarSplash() {
    mostrarSimplificacionCUV();
    closeWaitingDialog();
}

function BuscarByCUV(CUV) {
    CUV = $.trim(CUV);
    if (CUV === $("#hdfCUV").val()) return false;

    cuvbuscado = CUV;

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/FindByCUV",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ CUV: CUV }),
        async: true,
        cache: false,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) {
                return false;
            }

            $("#divObservaciones").html("");

            if (data[0].MarcaID != 0) {
                TrackingJetloreSearch(CUV, $("#hdCampaniaCodigo").val());
                $("#hdTipoOfertaSisID").val(data[0].TipoOfertaSisID);
                $("#hdConfiguracionOfertaID").val(data[0].ConfiguracionOfertaID);
                $("#hdTipoEstrategiaID").val(data[0].TipoEstrategiaID);
                cuvEsCuponNuevas = data[0].EsCuponNuevas;
                ObservacionesProducto(data[0]);
                $("#hdMetodoBusqueda").val("Por código");
                $("#hdfCUV").val("");
                if (data[0].ObservacionCUV != null && data[0].ObservacionCUV != "") {
                    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>" + data[0].ObservacionCUV + "</div></div>");
                }
                //INI HD-3908
                _flagNueva = (data[0].FlagNueva == "1") ? true : false;
                $("#hdfCodigoPalanca").val(data[0].CodigoPalanca);
                $("#hdfCampaniaID").val(data[0].CampaniaID);
                //FIN HD-3908
                CargarProductosRecomendados(data[0]);

            } else {
                $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>" + data[0].CUV + "</div></div>");
                if (data[0].TieneSugerido != 0) ObtenerProductosSugeridos(CUV);
            }
        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                if (data.message == "" || data.message === undefined) {
                    location.href = baseUrl + "Login/SesionExpirada";
                }
            }
        }
    });

}

function ObtenerProductosSugeridos(CUV) {
    var item = {
        CUV: CUV
    };

    $(".js-slick-prev-h").remove();
    $(".js-slick-next-h").remove();
    $("#divCarruselSugerido.slick-initialized").slick("unslick");

    $("#divCarruselSugerido").html('<div style="text-align: center;">Actualizando Productos Destacados<br><img src="' + urlLoad + '" /></div>');

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Estrategia/ObtenerProductosSugeridos",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(item),
        async: true,
        cache: false,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) {
                return false;
            }
            $.each(data, function (index, item) {
                item.posicion = index + 1;
            });
            var lista = data;

            if (lista.length <= 0) {
                return false;
            }

            $("#divCarruselSugerido").html("");

            BloquearPantallaPedidoByPopupSugerido('none');
            $("#divProductoAgotadoFinal").fadeIn(230);

            SetHandlebars("#js-CarruselSugerido", lista, "#divCarruselSugerido");

            $.each($("#divCarruselSugerido .sugerido"), function (index, obj) {
                var selector = $(obj).find(".nombre_producto_sugerido b");
                var descripcion = selector.text().trim();
                var wd = descripcion.length;
                if (wd <= 50) {
                    selector.html(descripcion);
                }
                else {

                    var descripcionNueva = descripcion.substring(0, 50);
                    descripcionNueva = descripcionNueva + "...";
                    selector.html(descripcionNueva);
                }
            });

            $("#divObservaciones").html("");

            $("#divCarruselSugerido").slick({
                infinite: true,
                vertical: false,
                slidesToShow: 2,
                slidesToScroll: 1,
                autoplay: false,
                centerMode: false,
                centerPadding: "0",
                tipo: "p",
                prevArrow: '<a class="previous_ofertas-popup js-slick-prev-h"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                nextArrow: '<a class="previous_ofertas-popup next js-slick-next-h"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }).on("beforeChange", function (event, slick, currentSlide, nextSlide) {
                var accion;
                if (nextSlide == 0 && currentSlide + 1 == arrayProductosSugeridos.length) {
                    accion = "next";
                } else if (currentSlide == 0 && nextSlide + 1 == arrayProductosSugeridos.length) {
                    accion = "prev";
                } else if (nextSlide > currentSlide) {
                    accion = "next";
                } else {
                    accion = "prev";
                }
                var posicionEstrategia, recomendado, arraySugerido;
                if (accion == "prev") {
                    var posicionPrimerActivo = $($("#divCarruselSugerido").find(".slick-active")[0]).find(".hdPosicionSugerido").val();
                    posicionEstrategia = posicionPrimerActivo == 1 ? arrayProductosSugeridos.length - 1 : posicionPrimerActivo - 2;
                    recomendado = arrayProductosSugeridos[posicionEstrategia];
                    arraySugerido = [];

                    var impresionSugerido = {
                        'name': recomendado.Descripcion,
                        'id': recomendado.CUV,
                        'price': recomendado.PrecioCatalogoString,
                        'brand': recomendado.DescripcionMarca,
                        'category': "NO DISPONIBLE",
                        'variant': (recomendado.DescripcionEstrategia == "" || recomendado.DescripcionEstrategia == null) ? "Estándar" : recomendado.DescripcionEstrategia,
                        'list': "Productos de reemplazo - Pedido",
                        'position': recomendado.posicion
                    };

                    arraySugerido.push(impresionSugerido);

                    dataLayer.push({
                        'event': "productImpression",
                        'ecommerce': {
                            'impressions': arraySugerido
                        }
                    });
                    dataLayer.push({
                        'event': "virtualEvent",
                        'category': "Ingresa tu pedido",
                        'action': "Productos de reemplazo",
                        'label': "Ver anterior"
                    });
                } else if (accion == "next") {
                    var posicionUltimoActivo = $($("#divCarruselSugerido").find(".slick-active").slice(-1)[0]).find(".hdPosicionSugerido").val();
                    posicionEstrategia = arrayProductosSugeridos.length == posicionUltimoActivo ? 0 : posicionUltimoActivo;
                    recomendado = arrayProductosSugeridos[posicionEstrategia];
                    arraySugerido = [];

                    var impresionSugerido = {
                        'name': recomendado.Descripcion,
                        'id': recomendado.CUV,
                        'price': recomendado.PrecioCatalogoString,
                        'brand': recomendado.DescripcionMarca,
                        'category': "NO DISPONIBLE",
                        'variant': (recomendado.DescripcionEstrategia == "" || recomendado.DescripcionEstrategia == null) ? "Estándar" : recomendado.DescripcionEstrategia,
                        'list': "Productos de reemplazo - Pedido",
                        'position': recomendado.posicion
                    };

                    arraySugerido.push(impresionSugerido);

                    dataLayer.push({
                        'event': "productImpression",
                        'ecommerce': {
                            'impressions': arraySugerido
                        }
                    });
                    dataLayer.push({
                        'event': "virtualEvent",
                        'category': "Ingresa tu pedido",
                        'action': "Productos de reemplazo",
                        'label': "Ver siguiente"
                    });
                }
            });

            $("#divCarruselSugerido").prepend($(".js-slick-prev-h"));
            $("#divCarruselSugerido").prepend($(".js-slick-next-h"));
            TagManagerCarruselSugeridosInicio(data);

        },
        error: function (data, error) {
            CerrarSplash();
            if (checkTimeout(data)) {
                if (data.message == "" || data.message === undefined) {
                    location.href = baseUrl + "Login/SesionExpirada";
                }
            }
        }
    });
}

function TagManagerCarruselSugeridosInicio(data) {
    arrayProductosSugeridos = data;
    var arraySugeridos = [];

    arraySugeridos.push({
        'name': data[0].Descripcion,
        'id': data[0].CUV,
        'price': data[0].PrecioCatalogoString,
        'brand': data[0].DescripcionMarca,
        'category': "NO DISPONIBLE",
        'variant': (data[0].DescripcionEstrategia == null || data[0].DescripcionEstrategia == "") ? "Estándar" : data[0].DescripcionEstrategia,
        'list': "Productos de reemplazo - Pedido",
        'position': data[0].posicion
    });

    if (data.length > 1) {
        arraySugeridos.push({
            'name': data[1].Descripcion,
            'id': data[1].CUV,
            'price': data[1].PrecioCatalogoString,
            'brand': data[1].DescripcionMarca,
            'category': "NO DISPONIBLE",
            'variant': (data[1].DescripcionEstrategia == null || data[1].DescripcionEstrategia == "") ? "Estándar" : data[1].DescripcionEstrategia,
            'list': "Productos de reemplazo - Pedido",
            'position': data[1].posicion
        });
    }

    dataLayer.push({
        'event': "productImpression",
        'ecommerce': {
            'impressions': arraySugeridos
        }
    });
}

function CambiarCliente(elem) {
    var rows = $($('[data-paginacion="rows"]')[0]).val() || 10;
    CargarDetallePedido(1, rows);
}

function ObservacionesProducto(item) {

    $("#hdfEsBusquedaSR").val(false);
    $("#hdfEstrategiaId").val(0);
    if (item.EstrategiaID > 0) {
        $("#hdfEsBusquedaSR").val(true);
        $("#hdfEstrategiaId").val(item.EstrategiaID);
        $("#btnAgregar").removeAttr("disabled");
    }
    if (item.TipoOfertaSisID != "1707") {
        if (item.TieneStock == true) {
            if (item.TieneSugerido != 0) {
                $("#divObservaciones").html("");

                $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'><span class='icono_advertencia_notificacion'></span>Lo sentimos, este producto está agotado.</div></div>");

                $("#btnAgregar").attr("disabled", "disabled");
                ObtenerProductosSugeridos(item.CUV);
            } else {
                $("#divObservaciones").html("");
                if (item.EsExpoOferta == true) {
                    $("#divObservaciones").html("<div class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Producto de ExpoOferta.</div></div>");
                }
                if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
                    if (!item.TieneRDC)
                        $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>" + mensajeCUVOfertaEspecial + "</div></div>");
                }
                if (!IsNullOrEmpty(item.MensajeCUV)) AbrirMensaje(item.MensajeCUV, "IMPORTANTE");

                $("#btnAgregar").removeAttr("disabled");
            }
        } else {

            $("#divObservaciones").html("<div id='divProdRevista' class='noti mensaje_producto_noExiste'><div class='noti_message red_texto_size'>Lo sentimos, este producto está agotado.</div></div>");
            $("#btnAgregar").attr("disabled", "disabled");
            if (item.TieneSugerido != 0)
                ObtenerProductosSugeridos(item.CUV);
            else {
                IngresoFAD(item);
            }
        }
    }

    $("#txtCUV").val(item.CUV);
    $("#hdfCUV").val(item.CUV);
    $("#hdfDescripcionCategoria").val(item.DescripcionCategoria);
    $("#hdfDescripcionEstrategia").val(item.DescripcionEstrategia);
    $("#hdfDescripcionMarca").val(item.DescripcionMarca);
    $("#hdfIndicadorMontoMinimo").val(item.IndicadorMontoMinimo);
    $("#hdfMarcaID").val(item.MarcaID);
    $("#txtCantidad").val("1");
    $("#hdfPrecioUnidad").val(item.PrecioCatalogo);

    $("#txtPrecioR").val(DecimalToStringFormat(item.PrecioCatalogo));

    $("#txtDescripcionProd").val(item.Descripcion.split("|")[0]);
    $("#hdfDescripcionProd").val(item.Descripcion.split("|")[0]);
    $("#hdFlagNueva").val(item.FlagNueva);
    $("#hdTipoEstrategiaID").val(item.TipoEstrategiaID);
    $("#hdEsOfertaIndependiente").val(item.EsOfertaIndependiente);
    $("#OfertaTipoNuevo").val("");
    $("#hdEsDuoPerfecto").val(item.EsDuoPerfecto);
    $("#hdTipoEstrategiaCodigo").val(item.CodigoEstrategia);

    $("#txtCantidad").removeAttr("disabled");
    if (item.FlagNueva == 1) {
        $("#txtCantidad").attr("disabled", "disabled");
        var pedidosData = $("#divListadoPedido").find("input[id^='hdfFlagNueva']");

        pedidosData.each(function (indice, valor) {
            if (valor.value == 1) {
                var OfertaTipoNuevo = "".concat($("#divListadoPedido").find("input[id^='hdfCampaniaID']")[indice].value, ";",
                    $("#divListadoPedido").find("input[id^='hdfPedidoId']")[indice].value, ";",
                    $("#divListadoPedido").find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                    $("#divListadoPedido").find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                    $("#divListadoPedido").find("input[id^='hdfCUV']")[indice].value, ";",
                    $("#divListadoPedido").find("input[id^='txtLPTempCant']")[indice].value, ";",
                    $("#hdnPagina").val(), ";",
                    $("#hdnClienteID2_").val());

                $("#OfertaTipoNuevo").val(OfertaTipoNuevo);
                return;
            }
        });
        $("#btnAgregar").focus();
    }
    else $("#txtCantidad").focus();
    $("#divMensaje").text("");

    if (item.TipoOfertaSisID == "1707") {
        if (!sesionEsShowRoom) {
            $("#txtDescripcionProd").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtPrecioR").val("");
            $("#txtCantidad").val("");
            $("#divMensaje").text("");
            $("#txtCUV").focus();
        }
    }
}

function IngresoFAD(producto) {
    var item = {
        CUV: producto.CUV,
        PrecioUnidad: producto.PrecioCatalogo
    };

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/IngresoFAD",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            //
        },
        error: function (data, error) { }
    });
}

function Ignorar(tipo) {
    if (tipo == 1)
        $("#divProdRevista").remove();
    else
        $("#divProdComplementario").remove();
}

function HorarioRestringido(mostrarAlerta) {

    mostrarAlerta = typeof mostrarAlerta !== "undefined" ? mostrarAlerta : true;
    var horarioRestringido = false;
    $.ajaxSetup({
        cache: false
    });
    jQuery.ajax({
        type: "GET",
        url: baseUrl + "Pedido/EnHorarioRestringido",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (mostrarAlerta == true)
                        AbrirMensaje(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) { }
    });
    return horarioRestringido;
}

var currentInputEdit = null;
var currentInputClienteID = null;
var currentInputClienteNombre = null;
var currentClienteEdit = null;
var currentClienteCreate = null;

function CargarAutocomplete() {
    var listaCampo = $(".classClienteNombre");
    if (listaCampo.length === 0)
        return false;

    $.each(listaCampo, function (indexCampo, array) {

        $(array).focus(function () {
            if (HorarioRestringido())
                this.blur();
        });

        $(array).autocomplete({
            source: baseUrl + "Pedido/AutocompleteByClienteListado",
            minLength: 4,
            select: function (event, ui) {
                if (ui.item.ClienteID != 0) {
                    $(this).val(ui.item.Nombre);

                    var rowElement = $(this).closest(".contenido_ingresoPedido");
                    currentInputClienteID = $(rowElement).find(".hdfLPCli");
                    currentInputClienteNombre = $(rowElement).find(".hdfLPCliDes");

                    $(currentInputClienteID).val(ui.item.ClienteID);
                    $(currentInputClienteNombre).val(ui.item.Nombre);

                    currentInputEdit = $(this);
                    currentClienteEdit = null;

                    if (ui.item.TieneTelefono == 0) {
                        currentClienteEdit = ui.item;

                        showClienteDetalle(ui.item, function (cliente) {
                            $(currentInputClienteID).val(cliente.ClienteID);
                            $(currentInputClienteNombre).val(cliente.Nombre);
                            $(currentInputEdit).val(cliente.Nombre);

                            $(currentInputEdit).blur();

                        }, function () {
                            CargarDetallePedido();
                        });
                    }
                }

                isShown = false;
                event.preventDefault();
                return false;
            }
        }).data("autocomplete")._renderItem = function (ul, item) {
            ul.mouseover(function () {
                isShown = true;
            }).mouseout(function () {
                isShown = false;
            });
            return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a>" + item.Nombre + "</a>")
                .appendTo(ul);
        };

    });
}

function CalcularTotal() {
    $("#sSimbolo").html($("#hdfSimbolo").val());
    $("#sSimbolo_minimo").html($("#hdfSimbolo").val());
}

function MostrarProductoAgregado(imagen, descripcion, cantidad, total) {
    if (imagen == "") {
        $(".info_pop_liquidacion").addClass("info_pop_liquidacion_sinimagen");
        $("#contenedorProductoAgregado").hide();
    } else {
        $(".info_pop_liquidacion").removeClass("info_pop_liquidacion_sinimagen");
        $("#imgProductoAgregado").attr("src", imagen);
        $("#contenedorProductoAgregado").show();
    }
    $("#nombreProductoAgregado").text(descripcion);
    $("#cantidadProductoAgregado").text(cantidad);
    $("#totalProductoAgregado").text(total);
}

function CerrarProductoAgregado() {
    $("#pop_liquidacion").hide();
}

function ValidDeletePedido(campaniaId, pedidoId, pedidoDetalleId, tipoOfertaSisId, cuv, cantidad, clienteId, cuvReco, esBackOrder, setId, esElecMultipleNuevas) {


    ValidDeleteElectivoNuevas(
        cuv,
        esElecMultipleNuevas,
        function () { DeletePedido(campaniaId, pedidoId, pedidoDetalleId, tipoOfertaSisId, cuv, cantidad, clienteId, cuvReco, esBackOrder, setId); }
    )
}

function ValidDeleteElectivoNuevas(cuv, esElecMultipleNuevas, fnDelete) {
    if (!$.isFunction(fnDelete)) fnDelete = function () { };

    if (!esElecMultipleNuevas) fnDelete(false);
    else messageConfirmacionDuoPerfecto(mensajeElecMultipleEliminar, function () { fnDelete(true); });
}

function messageConfirmacionDuoPerfecto(message, fnAceptar) {
    message = $.trim(message);
    if (message == "") return false;

    $('#divMensajeConfDuoPerfecto .divTexto p').html(message);
    $('#divMensajeConfDuoPerfecto').dialog('open');
    if ($.isFunction(fnAceptar)) {
        $('#divMensajeConfDuoPerfecto .btnMensajeAceptar').off('click');
        $('#divMensajeConfDuoPerfecto .btnMensajeAceptar').on('click', fnAceptar);
    }
}

function DeletePedido(campaniaId, pedidoId, pedidoDetalleId, tipoOfertaSisId, cuv, cantidad, clienteId, cuvReco, esBackOrder, setId) {
    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        TipoOfertaSisID: tipoOfertaSisId,
        CUV: cuv,
        Cantidad: cantidad,
        ClienteID_: clienteId,
        CUVReco: cuvReco,
        EsBackOrder: esBackOrder == "true",
        setId: setId
    };

    AbrirSplash();
    if (HorarioRestringido()) {
        CerrarSplash();
        return;
    }

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "PedidoRegistro/DeleteTransaction",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            CerrarSplash();
            
            if (!checkTimeout(data)) return false;
            if (data.success != true) {
                btnSalirTlpDelete(window.event, pedidoDetalleId, setId);
                messageInfoError(data.message);
                
                return false;
            }

            AbrirSplash();
            CargarDetallePedido();

            if (tipoOfertaSisId != "0") {
                cierreCarouselEstrategias();
                CargarCarouselEstrategias();
            }

            MostrarBarra(data);

            var ActualizaGananciasLoad = typeof ActualizaGanancias === 'function';
            if (ActualizaGananciasLoad) {
                ActualizaGanancias(data);
            }

            $("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
            microefectoPedidoGuardado();
            TrackingJetloreRemove(cantidad, $("#hdCampaniaCodigo").val(), cuv);


            AnalyticsPortalModule.MarcarRemoveFromCart(data, cantidad);

            CerrarSplash();

            OfertaDelDiaModule.CargarODDEscritorio();
            ProcesarActualizacionMostrarContenedorCupon();

            if (!data.EsAgregado) {
                var localStorageModule = new LocalStorageModule();
                localStorageModule.ActualizarCheckAgregado($.trim(data.data.EstrategiaId), campaniaId, data.data.TipoEstrategiaCodigo, false);
            }

            ActualizarLocalStoragePalancas(data.data.CUV, false);
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                btnSalirTlpDelete(window.event, pedidoDetalleId, setId);
                HideDialog("divVistaPrevia");
                CerrarSplash();
            }
        }
    });
}

function AceptarBackOrder(campaniaId, pedidoId, pedidoDetalleId, clienteId) {
    if (ReservadoOEnHorarioRestringido(true)) {
        return false;
    }

    var param = {
        CampaniaID: campaniaId,
        PedidoID: pedidoId,
        PedidoDetalleID: pedidoDetalleId,
        ClienteID_: clienteId
    };

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/AceptarBackOrder",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        async: true,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data)) return false;
            if (data.success != true) {
                AbrirMensaje(data.message);
                return false;
            }

            AbrirSplash();
            CargarDetallePedido();
            CerrarSplash();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                HideDialog("divVistaPrevia");
                CerrarSplash();
            }
        }
    });
}

function CargandoProductos() {
    $("#tbobyDetallePedido").html('<tr><td colspan="7"><div style="text-align: center;">Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></td></tr>');
}

function MostrarEliminarPedidoTotal() {
    var total = parseFloat($("#sTotal").html());
    if (total != 0) {
        showDialog("divConfirmEliminarTotal");
    }
}

function EliminarPedidoTotalSi() {

    EliminarPedidoTotalNo();
    EliminarPedido();
}

function EliminarPedidoTotalNo() {
    HideDialog("divConfirmEliminarTotal");
}

function ActualizarModeloPaginar(ClienteID) {
    CalcularTotal();
    $("#ddlClientes").val(ClienteID);
    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#hdnClienteID_").val(ClienteID);

    var nomCli = $("#ddlClientes option:selected").text();
    var monto = $("#hdfTotalCliente").val();

    $(".pMontoCliente").css("display", "none");

    if ($("#hdnClienteID_").val() != "-1") {
        $(".pMontoCliente").css("display", "block");
        $("#spnNombreCliente").html(nomCli + " :");
        $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
    }
}

function SaveDeleteAnalytics(descripcion, cuv, price, brand, category, variant, quantity) {
    if (variant == null || $.trim(variant) == "") {
        variant = "Estándar";
    }
    if (category == null || $.trim(category) == "") {
        category = "Sin Categoría";
    }
    dataLayer.push({
        'event': "removeFromCart",
        'ecommerce': {
            'remove': {
                'products': [{
                    'name': descripcion.replace(/&#39;/g, "'"),
                    'id': cuv,
                    'price': price,
                    'brand': brand.replace(/&#39;/g, "'"),
                    'category': category,
                    'variant': variant,
                    'quantity': parseInt(quantity)
                }]
            }
        }
    });
}

function EjecutarPROL() {
    AbrirSplash();
    if (!EsValidoReservar()) {
        CerrarSplash();
        return;
    }

    EjecutarServicioPROL();
}

function EsValidoReservar() {
    if (!EsValidoMontoTotalReserva()) return false;
    if (ReservadoOEnHorarioRestringido(true)) return false;

    return true;
}

function EsValidoMontoTotalReserva() {
    var total = parseFloat($("#hdfTotal").val());
    if (total != 0) return true;

    MostrarPopupErrorReserva(mensajePedidoVacio, true);
    if ($("#hdfEstadoPedido").val() == 1) EliminarPedido();
    return false;
}

function EjecutarServicioPROL() {
	
    PedidoProvider
        .PedidoEjecutarServicioProlPromise()
        .done(function (response) {
            CerrarSplash();
            if (!checkTimeout(response)) return;
            if (!response.success) {
                MostrarPopupErrorReserva(mensajeErrorReserva, false);
                return;
            }

            if (response.mensajeCondicional) {
                AbrirMensajeImagen(response.mensajeCondicional);
            }

            //Marcación Analytics
            arrayProductosGuardadoExito = response;
            AnalyticsPortalModule.MarcarGuardaTuPedido();

            if (RespuestaEjecutarServicioPROL(response.data)) return;

            MostrarMensajeProl(response, function () { return CumpleOfertaFinalMostrar(response); });
        })
        .fail(function (data, error) {
            CerrarSplash();
            MostrarPopupErrorReserva(mensajeSinConexionReserva, true);
        });
}

function EjecutarServicioPROLSinOfertaFinal() {

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/EjecutarServicioPROL",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            CerrarSplash();
            if (!checkTimeout(response)) return;
            if (!response.success) {
                MostrarPopupErrorReserva(mensajeErrorReserva, false);
                return;
            }

            if (RespuestaEjecutarServicioPROL(response.data, false)) return;

            MostrarMensajeProl(response, function () { return false; });
        },
        error: function (data, error) {
            CerrarSplash();
            MostrarPopupErrorReserva(mensajeSinConexionReserva, true);
        }
    });
}

function RespuestaEjecutarServicioPROL(data, inicio) {

    if (data.ErrorProl) {
        MostrarPopupErrorReserva(data.ListaObservacionesProl[0].Descripcion, data.AvisoProl);
        return true;
    }
    var mensajeBloqueante = true;

    if (!data.ZonaValida) {
        showDialog("divReservaSatisfactoria3");
    }
    else if (!data.ValidacionInteractiva) {
        var objDiv = $("#divNoValInteractiva");
        objDiv.find(".spnMensajeNoValInteractiva").html(data.MensajeValidacionInteractiva);
        objDiv.show();
    }
    else {
        mensajeBloqueante = false;

        if (data.ObservacionRestrictiva) {
            CrearPopupObservaciones(data, inicio);
        }
        else {
            $('#divMensajeObservacionesPROL').data('prop-NotExito', data.ObservacionRestrictiva);
            ArmarPopupObsReserva("¡Lo lograste! Tu pedido fue guardado con éxito", "");
        }

    }

    AlmacenarRespuestaReservaEnHidden(data);
    ActualizarObjMontosTotales(data);
    ActualizarBtnGuardar(data);
    CargarDetallePedido(null, null, false);
    return mensajeBloqueante;
}

function CrearPopupObservaciones(data, inicio) {
    inicio = inicio == null || inicio == undefined ? true : inicio;
    var html = "<ul>";
    var msgDefault = "<li>Tu pedido tiene observaciones, por favor revísalo.</li>";
    var msgDefaultCont = 0;

    if (data.ListaObservacionesProl.length == 0) {
        html += msgDefault;
    }
    else {
        $.each(data.ListaObservacionesProl, function (index, item) {
            if (data.CodigoIso == "BO" || data.CodigoIso == "MX") {
                if (item.Caso == 6 || item.Caso == 8 || item.Caso == 9 || item.Caso == 10) {
                    item.Caso = 105;
                }
            }

            if (item.Caso == 95 || item.Caso == 105 || (item.Caso == 0 && inicio)) {
                html += "<li>" + item.Descripcion + "</li>";
                return;
            }

            if (msgDefaultCont == 0) html += html == msgDefault ? "" : msgDefault;
            msgDefaultCont++;
        });
    }
    html += "</ul>";

    ArmarPopupObsReserva(data.EsDiaProl ? "Importante" : "Aviso", html);
}

function AlmacenarRespuestaReservaEnHidden(data) {
    $("#hdfAccionPROL").val(data.Prol);
    $("#hdfReserva").val(data.Reserva);
    $("#hdfModificaPedido").val(data.EsModificacion);
    $("#hdfZonaValida").val(data.ZonaValida);
    $("#hdMontoAhorroCatalogo").val(data.MontoAhorroCatalogo);
    $("#hdMontoAhorroRevista").val(data.MontoAhorroRevista);
    $("#hdMontoDescuento").val(data.MontoDescuento);
    $("#hdMontoEscala").val(data.MontoEscala);
}

function ActualizarObjMontosTotales(data) {
    $("#spnMontoGanancia").html(data.FormatoMontoGanancia);
    if (parseFloat(data.MontoDescuento) > 0) {
        $("#divMontosEscalaDescuentoTexto").html(
            '<p class="monto_descuento">'
            + '<span class="display: inline-block;">DESCUENTO</span><span class="icon-advertencia"></span>:'
            + '</p>'
            + '<p class="monto_montodescuento">MONTO DESCUENTO :</p>'
        ).show();

        $("#divMontosEscalaDescuento").html(
            '<p class="monto_descuento">'
            + '<b>' + variablesPortal.SimboloMoneda + ' <span class="num" id="spnMontoDescuento">' + data.FormatoMontoDescuento + '</span></b>'
            + '</p>'
            + '<p class="monto_montodescuento">'
            + '<b>' + variablesPortal.SimboloMoneda + ' <span class="num" id="spnMontoEscala">' + data.FormatoTotalConDescuento + '</span></b>'
            + '</p>'
        ).show();
    }
    else {
        $("#divMontosEscalaDescuentoTexto").html("").hide();
        $("#divMontosEscalaDescuento").html("").hide();
    }
}

function ActualizarBtnGuardar(data) {
    var tooltips = data.ProlTooltip.split("|");
    $(".tooltip_importanteGuardarPedido")[0].children[0].innerHTML = tooltips[0];
    $(".tooltip_importanteGuardarPedido")[0].children[1].innerHTML = tooltips[1];
    $("#btnValidarPROL").val(data.Prol);
}

function MostrarMensajeProl(response, fnOfertaFinal) {
    var cumpleOferta = fnOfertaFinal(response);
    if (cumpleOferta) return;

    if (!response.data.Reserva) {
        ShowPopupObservacionesReserva();
        return;
    }

    EjecutarAccionesReservaExitosa(response);
}

function EjecutarAccionesReservaExitosa(response) {
    if (response.flagCorreo == "1") EnviarCorreoPedidoReservado();
    $("#dialog_divReservaSatisfactoria").show();
    var ultimoDiaFacturacion = response.UltimoDiaFacturacion || false;
    
    if (ultimoDiaFacturacion) {
	    RedirigirPedidoValidado(); //Redirige PEDIDO VALIDADO
    } else {
	    location.reload();
    }
}

function EliminarPedido() {
    AbrirSplash();
    if (ReservadoOEnHorarioRestringido(true)) {
        CerrarSplash();
        return;
    }

    var listaDetallePedido = [];
    var campania = $("#hdCampaniaCodigo").val();

    $.each($("#tbobyDetallePedido > .contenido_ingresoPedido"), function (index, value) {
        var cuv = $(value).attr("data-cuv");
        var cantidad = $(value).find(".liquidacion_rango_cantidad_pedido").val();

        var detalle = {
            count: cantidad,
            deal_id: cuv,
            option_id: campania
        };

        listaDetallePedido.push(detalle);
    });

    var item = {};
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "PedidoRegistro/DeleteAll",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (!checkTimeout(data)) {
                CerrarSplash();
                return false;
            }

            if (data.success != true) {

                //INI HD-3693
                //messageInfoError(data.message);
                //CerrarSplash();
                var msjBloq = validarpopupBloqueada(data.message);
                if (msjBloq != "") { alert_msg_bloqueadas(msjBloq); }
                else {
                    messageInfoError(data.message);
                    CerrarSplash();
                }
                //FIN HD-3693
                return false;
            }

            TrackingJetloreRemoveAll(listaDetallePedido);
            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaEliminarPedidoCompleto(data.ListaMarcaciones);

            MostrarBarra(data);
            CerrarSplash();

            ActualizarLocalStoragePalancas("todo", false);

            location.href = baseUrl + "Pedido/Index";
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CerrarSplash();
            }
        }
    });
}

function EjecutarPROL2() {
    HideDialog("divConfirmValidarPROL");
    EjecutarPROL();
}

function AbrirModal(tipo) {
    switch (tipo) {
        case 1:
            showDialog("divFaltantesAnunciados");
            break;
        case 2:
            showDialog("divOfertasWeb");
            break;
    }
}

function CancelarObsInformativas() {
    if ($("#hdfModificaPedido").val() != "True") {
        AbrirSplash();
        jQuery.ajax({
            type: "POST",
            url: baseUrl + "Pedido/PedidoValidadoDeshacerReserva?Tipo=PI",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            async: true,
            success: function (data) {
                if (checkTimeout(data)) {
                    if (data.success == true) {
                        HideDialog("divObservacionesPROL");
                        CerrarSplash();
                    } else {
                        CerrarSplash();
                        AbrirMensaje(data.message);
                    }
                }
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    CerrarSplash();
                    AbrirMensaje("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
                }
            }
        });
    } else {
        HideDialog("divObservacionesPROL");
    }
}

function CalcularTotalPedido(Total, Total_Minimo) {
    var paisColombia = "4";
    if (paisColombia == viewBagPaisID) {
        Total = Total.replace(/\,/g, "");
        Total = parseFloat(Total).toFixed(0);
        $("#sTotal").html(SeparadorMiles(Total));
        $("#hdfTotal").val(SeparadorMiles(Total));
        $("#spPedidoWebAcumulado").text(variablesPortal.SimboloMoneda + " " + SeparadorMiles(Total));
    } else {
        Total = parseFloat(Total.replace(",", ""));
        $("#sTotal").html(parseFloat(Total).toFixed(2));
        $("#hdfTotal").val(parseFloat(Total).toFixed(2));
        $("#spPedidoWebAcumulado").text(variablesPortal.SimboloMoneda + " " + parseFloat(Total).toFixed(2));
    }
}

function ValidarUpdate(PedidoDetalleID, FlagValidacion, rowElement) {
    var txtLPCant = $(rowElement).find(".txtLPCant");
    var txtLPTempCant = $(rowElement).find(".txtLPTempCant");
    var CliDes = $(rowElement).find(".txtLPCli").val();
    var CliDesVal = $(rowElement).find(".hdfLPCliDes").val();
    var Cantidad = $(txtLPCant).val();
    var CantidadAnti = $(txtLPTempCant).val();
    var ClienteAnti = $(rowElement).find(".hdfLPTempCliDes").val();

    if (FlagValidacion == "1") {
        if (CantidadAnti == Cantidad)
            return false;
    } else {
        if (ClienteAnti == CliDes)
            return false;
    }

    if (Cantidad.length == 0) {
        AbrirMensaje("Por favor ingrese una cantidad válida.");
        return false;
    }

    if (Cantidad == 0) {
        AbrirMensaje("Por favor ingrese una cantidad mayor a cero.");
        return false;
    }

    if (CliDes.length != 0 && CliDes != CliDesVal) {
        AbrirMensaje("Por favor ingrese un cliente válido.");
        return false;
    }

    return true;
}

function UpdateConCantidad(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CantidadModi, setId, rowElement) {
    var txtLPCant = $(rowElement).find(".txtLPCant");
    var txtLPTempCant = $(rowElement).find(".txtLPTempCant");

    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion, rowElement);
    if (!val) {
        return false;
    }

    var CliID = $(rowElement).find(".hdfLPCli").val();
    var CliDes = $(rowElement).find(".txtLPCli").val();
    var DesProd = $(rowElement).find(".lblLPDesProd").html();

    var PrecioUnidad = $(rowElement).find(".hdfLPPrecioU").val();
    if (CliDes.length == 0) {
        CliID = 0;
    }

    var Cantidad = CantidadModi;
    var Unidad = $(rowElement).find(".hdfLPPrecioU").val();
    var Total = DecimalToStringFormat(parseFloat(Cantidad * Unidad));
    var ClienteID_ = $("#ddlClientes").val();
    $(rowElement).find(".lblLPImpTotal").html(Total);
    $(rowElement).find(".lblLPImpTotalMinimo").html(Total);
    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        ClienteDescripcion: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: ClienteID_,
        SetId: setId
    };

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/Update",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CerrarSplash();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                messageInfoError(data.message);
                return false;
            }

            if ($(rowElement).find(".txtLPCli").val().length == 0) {
                $(rowElement).find(".hdfLPCliDes").val($("#hdfNomConsultora").val());
                $(rowElement).find(".txtLPCli").val($("#hdfNomConsultora").val());
            }
            $(txtLPTempCant).val($(txtLPCant).val());

            var nomCli = $("#ddlClientes option:selected").text();
            var monto = data.Total_Cliente;

            $(".pMontoCliente").css("display", "none");

            if (data.ClienteID_ != "-1") {
                $(".pMontoCliente").css("display", "block");
                $("#spnNombreCliente").html(nomCli + " :");
                $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
            }

            CalcularTotalPedido(data.Total, data.Total_Minimo);

            var prevTotal = mtoLogroBarra;
            MostrarBarra(data);
            showPopupNivelSuperado(data.DataBarra, prevTotal);

            $("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
            microefectoPedidoGuardado();

        },
        error: function (data, error) {
            CerrarSplash();
        }
    });
}

function UpdateCliente(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, setId, rowElement) {
    var txtLPCant = $(rowElement).find(".txtLPCant");
    var txtLPTempCant = $(rowElement).find(".txtLPTempCant");

    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion, rowElement);
    if (!val) return false;

    var CliID = $(rowElement).find(".hdfLPCli").val();
    var CliDes = $(rowElement).find(".txtLPCli").val();
    var Cantidad = $(txtLPCant).val();
    var CantidadAnti = $(txtLPTempCant).val();
    var DesProd = $(rowElement).find(".lblLPDesProd").html();
    var ClienteID_ = $("#ddlClientes").val();

    var PrecioUnidad = $(rowElement).find(".hdfLPPrecioU").val();
    if (CliDes.length == 0) {
        CliID = 0;
    }

    var Unidad = $(rowElement).find(".hdfLPPrecioU").val();
    var Total = DecimalToStringFormat(parseFloat(Cantidad * Unidad));
    $(rowElement).find(".lblLPImpTotal").html(Total);
    $(rowElement).find(".lblLPImpTotalMinimo").html(Total);
    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: Cantidad,
        PrecioUnidad: PrecioUnidad,
        Nombre: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: ClienteID_,
        SetId: setId
    };

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "PedidoRegistro/UpdateTransaction",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            CerrarSplash();

            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                var errorCliente = data.errorCliente || false;
                if (!errorCliente) {
                    messageInfoError(data.message);
                }
                else {
                    messageInfoError(data.message, null, function () {
                        showClienteDetalle(currentClienteEdit, function (cliente) {
                            currentInputClienteID.val(cliente.ClienteID);
                            currentInputClienteNombre.val(cliente.Nombre);
                            currentInputEdit.val(cliente.Nombre);

                            currentInputEdit.blur();
                        }, function () {
                            if (currentInputEdit != null) currentInputEdit.focus();
                        });
                    });
                }
                return false;
            }

            if ($(rowElement).find(".txtLPCli").val().length == 0) {
                $(rowElement).find(".hdfLPCliDes").val($("#hdfNomConsultora").val());
                $(rowElement).find(".txtLPCli").val($("#hdfNomConsultora").val());
            }

            $(txtLPTempCant).val($(txtLPCant).val());
            $(rowElement).find(".hdfLPCliIni").val($(rowElement).find(".hdfLPCli").val());

            var nomCli = $("#ddlClientes option:selected").text();
            var monto = data.Total_Cliente;

            $(".pMontoCliente").css("display", "none");

            if (data.ClienteID_ != "-1") {
                $(".pMontoCliente").css("display", "block");
                $("#spnNombreCliente").html(nomCli + " :");
                $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
            }

            $("#hdfTotal").val(data.Total);
            $("#spPedidoWebAcumulado").text(variablesPortal.SimboloMoneda + " " + data.TotalFormato);

            var totalUnidades = parseInt($("#pCantidadProductosPedido").html());
            totalUnidades = totalUnidades - parseInt(CantidadAnti) + parseInt(Cantidad);
            $("#pCantidadProductosPedido").html(totalUnidades);

            var prevTotal = mtoLogroBarra;
            MostrarBarra(data);
            showPopupNivelSuperado(data.DataBarra, prevTotal);
            if (data.modificoBackOrder) {
                showDialog("divBackOrderModificado");
            }

            if (data.mensajeCondicional) {
                AbrirMensajeImagen(data.mensajeCondicional);
            }

            CargarDetallePedido();

            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
                TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);
        },
        error: function (data, error) {
            CerrarSplash();
        }
    });
}

function BlurF(event, CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, setId) {
    var rowElement = $(event.target).closest(".contenido_ingresoPedido");

    if (flagClienteDetalle) return true;
    if (isShown)
        return true;

    var cliAnt = $(rowElement).find(".hdfLPCliIni").val();
    var cliNue = $(rowElement).find(".hdfLPCli").val();

    if ($(rowElement).find(".txtLPCli").val() == "" && cliAnt > 0) cliNue = 0;

    if (cliAnt == cliNue) {
        $(rowElement).find(".txtLPCli").val($(rowElement).find(".hdfLPCliDes").val());
        return true;
    }

    UpdateCliente(CampaniaID, PedidoID, PedidoDetalleID, FlagValidacion, CUV, setId, rowElement);
}

function InfoCommerceGoogleProductoRecomendados() {
    var cantidadProductosRecomendado = $("#hdCantItemRecomendado").val();
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val();

    if (cantidadProductosRecomendado == undefined || cadListaRecomendados == undefined) {
        return false;
    }

    var listaRecomendados = JSON.parse(cadListaRecomendados);
    var arrayEstrategiaRecomendado = [];
    if (parseInt(cantProductosLoad) < parseInt(cantidadProductosRecomendado)) {
        var posProductoEstrategia = 0;
        var variantcadEstrategia = "";
        var categoriacadEstrategia = "";
        $.each(listaRecomendados, function (index, item) {
            if (item.CUV2 != "00000") {
                posProductoEstrategia += 1;
                if (item.DescripcionEstrategia == null || item.DescripcionEstrategia == "") {
                    variantcadEstrategia = "Estándar";
                } else {
                    variantcadEstrategia = item.DescripcionEstrategia;
                }
                if (item.DescripcionCategoria == null || item.DescripcionCategoria == "") {
                    categoriacadEstrategia = "Sin Categoría";
                } else {
                    categoriacadEstrategia = item.DescripcionCategoria;
                }
                arrayEstrategiaRecomendado.push(
                    {
                        name: item.DescripcionCUV2,
                        id: item.CUV2,
                        price: item.Precio2.toString(),
                        brand: item.DescripcionMarca,
                        category: categoriacadEstrategia,
                        variant: variantcadEstrategia,
                        list: "Productos destacados (actualizado) - Pedido",
                        position: posProductoEstrategia
                    });
            }
        });

        if (arrayEstrategiaRecomendado != null) {
            if (arrayEstrategiaRecomendado.length > 0) {
                dataLayer.push({
                    'event': "productImpression",
                    'ecommerce': {
                        'impressions': arrayEstrategiaRecomendado
                    }
                });
            }
        }
    }
}

function InfoCommerceGoogleDestacadoPreviousCarrusel() {
    if ($.parseJSON(arregloProductos) != null) {
        if ($.parseJSON(arregloProductos).length > 3) {
            var jsonArray = $.parseJSON(arregloProductos);
            var posicionTotal = jsonArray.length - 1;

            if (jsonArray.length > 0) {
                if (posicionFinalPantalla == 0) {
                    posicionFinalPantalla = posicionTotal;
                } else {
                    posicionFinalPantalla -= 1;
                }

                if (posicionInicial == 0) {
                    posicionInicial = posicionTotal;
                } else {
                    posicionInicial -= 1;
                }

                dataLayer.push({
                    'event': "productImpression",
                    'ecommerce': {
                        'impressions': jsonArray[posicionInicial]
                    }
                });
            }
        }
    }
}

function InfoCommerceGoogleDestacadoNextCarrusel() {
    if ($.parseJSON(arregloProductos) != null) {
        if ($.parseJSON(arregloProductos).length > 3) {
            var jsonArray = $.parseJSON(arregloProductos);
            var posicionTotal = jsonArray.length - 1;

            if (jsonArray.length > 0) {
                if (posicionFinalPantalla == posicionTotal) {
                    posicionFinalPantalla = 0;
                } else {
                    posicionFinalPantalla += 1;
                }

                if (posicionInicial == posicionTotal) {
                    posicionInicial = 0;
                } else {
                    posicionInicial += 1;
                }

                dataLayer.push({
                    'event': "productImpression",
                    'ecommerce': {
                        'impressions': jsonArray[posicionFinalPantalla]
                    }
                });
            }
        }
    }
}

function CambioPagina(obj) {
    var rpt = paginadorAccionGenerico(obj);
    if (rpt.page == undefined) {
        return false;
    }

    CargarDetallePedido(rpt.page, rpt.rows);
    return true;
}

function CerrarProductoAgotados() {
    $("#divProductoAgotado").hide();
    $("#producto-faltante-busqueda-cuv").val("");
    $("#producto-faltante-busqueda-descripcion").val("");
}

function CargarProductoAgotados(identificador) {

    var filtro = identificador == undefined ? 0 : identificador;

    if (filtro == 1)
        CargarFiltrosProductoAgotados();

    var data =
        {
            cuv: $("#producto-faltante-busqueda-cuv").val(),
            descripcion: $("#producto-faltante-busqueda-descripcion").val(),
            categoria: $("#ddlCategoriaProductoAgotado").val() == null ? "" : $("#ddlCategoriaProductoAgotado").val(),
            revista: $("#ddlCatalogoRevistaProductoAgotado").val() == "" ? "" : $("#ddlCatalogoRevistaProductoAgotado option:selected").text()
        };

    AbrirSplash();
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/GetProductoFaltante",
        dataType: "json",
        data: data,
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) return false;

            CerrarSplash();
            if (response.result) {
                SetHandlebars("#productos-faltantes-template", response.data, "#tblProductosFaltantes");

                if (response.data.Detalle.length == 0)
                    $("#tblProductosFaltantes table").find("#tfoot").removeClass("hidden");
                else
                    $("#tblProductosFaltantes table").find("#tfoot").addClass("hidden");

                $("#divProductoAgotado").show();
            }
            else alert(response.data);
        },
        error: function (data, error) { AjaxError(data); }
    });
}

function CargarFiltrosProductoAgotados() {
    $("#ddlCategoriaProductoAgotado").find("option").remove();
    $("#ddlCatalogoRevistaProductoAgotado").find("option").remove();

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/GetFiltrosProductoFaltante",
        dataType: "json",
        data: {},
        async: true,
        success: function (response) {
            if (!checkTimeout(response)) return false;
            if (response.result) {
                $("#ddlCategoriaProductoAgotado").CreateSelected(response.data, "CodigoCategoria", "DescripcionCategoria");
                $("#ddlCatalogoRevistaProductoAgotado").CreateSelected(response.data1, "CodigoCatalogo", "Descripcion");
            }
            else alert(response.data);
        },
        error: function (data, error) { AjaxError(data); }
    });
}

$.fn.CreateSelected = function (array, val, text, etiqueta, index) {
    var obj = this.selector;
    try {
        $(obj).find("option").remove();
        if (index === undefined || index == false) {
            if (etiqueta === undefined)
                $(obj).append('<option value="" selected="selected"> -- Seleccione --</option>');
            else
                $(obj).append('<option value="0" selected="selected"> -- ' + etiqueta + " --</option>");
        }

        $.each(array, function (i, item) {
            //var objtemp = item;
            $(obj).append('<option value="' + item[val] + '">' + item[text] + "</option>");
        });
    } catch (e) {
        toastr.error(e.message.toString(), Basetitle);
    }

};

function AjaxError(data) {
    CerrarSplash();
    if (checkTimeout(data)) AbrirMensaje(data.message);
}

function HidePopupEstrategiasEspeciales() {
}

function MostrarDetalleGanancia() {
    var div = $("#detalleGanancia");
    div[0].children[0].innerHTML = $("#hdeCabezaEscala").val();
    div[0].children[1].children[0].innerHTML = $("#hdeLbl1Ganancia").val();
    div[0].children[2].children[0].innerHTML = $("#hdeLbl2Ganancia").val();
    div[0].children[5].children[0].innerHTML = $("#hdePieEscala").val();

    $("#popupGanancias").fadeIn(200);
}

function AnalyticsBannersInferiores(obj) {

    var option = obj.id || 0
    if (option === 0) return;
    var strLabel = "";
    switch (option) {
        case "1": //descontinuados
            strLabel = "Productos descontinuados";
            break;
        case "3": // liquidaciones web
            strLabel = "Liquidaciones Web";
            break;
        case "4": //productos agotados
            strLabel = "Productos agotados";
            break;
    }
    if (!(typeof AnalyticsPortalModule === 'undefined'))
        AnalyticsPortalModule.MarcaBannersInferioresDescontinuados(strLabel);

}

function AnalyticsBannersInferioresImpression() {
    var promotionsBajos = [];
    $(".contenedor_banners li").each(function (index) {
        var $this = $(this);
        promotionsBajos.push({
            id: $this.attr("data-id"),
            name: $this.attr("data-name"),
            position: $this.attr("data-position")
        });
    });
    if (promotionsBajos.length > 0) {
        dataLayer.push({
            'event': "promotionView",
            'ecommerce': {
                'promoView': {
                    'promotions': promotionsBajos
                }
            }
        });
    }
}

function AnalyticsGuardarValidar(response) {
    var arrayEstrategiasAnalytics = [];
    var accion = $("#hdAccionBotonProl").val();

    response.pedidoDetalle = response.pedidoDetalle || [];
    $.each(response.pedidoDetalle, function (index, value) {
        var estrategia = {
            'name': value.name,
            'id': value.id,
            'price': $.trim(value.price),
            'brand': value.brand,
            'category': "NO DISPONIBLE",
            'variant': value.variant == "" ? "Estándar" : value.variant,
            'quantity': value.quantity
        };
        arrayEstrategiasAnalytics.push(estrategia);
    });

    dataLayer.push({
        'event': "productCheckout",
        'action': accion == "guardar" ? "Guardar" : "Validar",
        'label': response.mensajeAnalytics,
        'ecommerce': {
            'checkout': {
                'actionField': {
                    'step': accion == "guardar" ? 1 : 2,
                    'option': response.mensajeAnalytics
                },
                'products': arrayEstrategiasAnalytics
            }
        }
    });
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== "undefined" ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: "GET",
        url: urlReservadoOEnHorarioRestringido,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (!data.success) {
                restringido = false;
                return false;
            }
            
            if (data.pedidoReservado) {
                if (mostrarAlerta == true) {
                    CerrarSplash();
                    AbrirPopupPedidoReservado(data.message, "1");
                }
                else if (data.UltimoDiaFacturacion) { //TESLA-7 REDIRECCIONA SOLO SI ES ULTIMO DIA, CIERRE FACTURACION 
                    AbrirSplash();
                    location.href = urlValidadoPedido;
                }
            }
            //INI HD-3693
            //else if (mostrarAlerta == true) AbrirMensaje(data.message);
            else if (mostrarAlerta == true) {
                var msjBloq = validarpopupBloqueada(data.message);
                if (msjBloq != "") { alert_msg_bloqueadas(msjBloq); }
                else AbrirMensaje(data.message);
            }
            //FIN HD-3693
        },
        error: function (error, x) {
            AbrirMensaje("Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.");
        }
    });
    return restringido;
}

function ConfirmarModificar() {
    waitingDialog({});
    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/PedidoValidadoDeshacerReserva?Tipo=PV",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    dataLayer.push({
                        'event': "virtualEvent",
                        'category': "Ecommerce",
                        'action': "Modificar Pedido",
                        'label': "(not available)"
                    });
                    location.href = baseUrl + "Pedido/Index";
                }
                else {
                    closeWaitingDialog();
                    messageInfoError(data.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
    return false;
}

function ProcesarActualizacionMostrarContenedorCupon() {
    if (paginaOrigenCupon) {
        if (cuponModule) {
            cuponModule.actualizarContenedorCupon();
        }
    }
}

function closeDialogObservacionesProl() {

    var notExitoFromProl = $('#divMensajeObservacionesPROL').data('prop-NotExito');

    if (!notExitoFromProl)
        if (!(typeof AnalyticsPortalModule === 'undefined'))
            AnalyticsPortalModule.MarcaGuardarPedidoExito(arrayProductosGuardadoExito);


    HideDialog("divObservacionesPROL");

}

function ArmarPopupObsReserva(titulo, mensaje) {
    $("#divTituloObservacionesPROL").html(titulo);
    $("#divMensajeObservacionesPROL").html(mensaje);
}

function MostrarPopupErrorReserva(mensajePedido, esAviso) {

    mostrarAlerta = typeof mostrarAlerta !== "undefined" ? mostrarAlerta : true;

    if (esAviso) ArmarPopupObsReserva("Aviso", mensajePedido);
    else ArmarPopupObsReserva("Error", "ERROR: " + mensajePedido);
    ShowPopupObservacionesReserva();
}

function ShowPopupObservacionesReserva() {
    showDialogSinScroll("divObservacionesPROL");
}

function RedirigirPedidoValidado() {
    setTimeout(function () {
        AbrirSplash();
        location.href = baseUrl + "Pedido/PedidoValidado";
    }, 3000);
}

function InsertarDemandaTotalReemplazoSugerido(cuvSugerido, precio, cantidad, esAceptado) {
    var _cuvprecio = esAceptado == true ? precio : DecimalToStringFormat($("#txtPrecioR").val());
    waitingDialog({});
    var model =
        {
            CUV: cuvbuscado,
            CUVSugerido: cuvSugerido,
            PrecioUnidad: _cuvprecio,
            Cantidad: cantidad,
            CuvEsAceptado: esAceptado
        };

    jQuery.ajax({
        type: "POST",
        url: urlInsertarDemandaTotalReemplazoSugerido,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(model),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success) {
                    if (!esAceptado) closeWaitingDialog();
                }
                else closeWaitingDialog();
            }
            else {
                closeWaitingDialog();
                messageInfoError(data.message);
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            if (checkTimeout(data)) {
                alert("Ocurrió un error al ejecutar la acción. Por favor inténtelo de nuevo.");
            }
        }
    });
}

var PedidoProvider = function () {
    "use strict";
    var _pedidoEjecutarServicioProlPromise = function () {
        var dfd = jQuery.Deferred();

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "Pedido/EjecutarServicioPROL",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            async: true,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };
    return {
        PedidoEjecutarServicioProlPromise: _pedidoEjecutarServicioProlPromise
    };
}();

function BloquearPantallaPedidoByPopupSugerido(valor) {
    $('.pedido_ingreso_c2').css('pointer-events', valor);
    $('.content_T_T').css('pointer-events', valor);
    $('#divListaEstrategias').css('pointer-events', valor);
}

function CargarProductosRecomendados(item) {
    ProductoRecomendadoModule.ObtenerProductos(item.CodigoCatalago, item.EstrategiaIDSicc, item.CUV, item.CodigoProducto);

}

function ModificarPedido() {
	showDialog("divConfirmValidarPROL2");
}

function CerrarDialogo(dialog) {
	HideDialog(dialog);
}

function PedidosPendientesPorAprobar() {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickBotonPedidosPendientes('Click Botón', 'Pedidos por aprobar');
    }
    window.location.href = '/ConsultoraOnline/Pendientes';
}
