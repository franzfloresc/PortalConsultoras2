var arrayOfertasParaTi = [];

var AutocompleteLastLI = null;
var AutocompleteClick = false;
var existeCUV = false;
var mensajeParametrizableCuv = '';
var cuvbuscado = "";
var precioCuvBuscado = "";

var belcorp = belcorp || {};
belcorp.pedido = belcorp.pedido || {};
belcorp.pedido.initialize = function () {
    registerEvent.call(this, "onProductoAgregado");
}

$(document).ready(function () {
    ValidarKitNuevas();

    $('#txtClienteNombre').click(function (e) {
        if ($(this).prop('disabled')) return;

        if ($(".ui-autocomplete").css("display") == "none") {
            AutocompleteClick = true;
            $(this).autocomplete("search", "");
            $(".ui-autocomplete").css({ "z-index": "2000" });
        }
        else {
            $(this).autocomplete('close');
        }
    });
    $('#txtClienteNombre').keyup(function (e) {
        if (e.keyCode == 8) {
            if ($.trim($(this).val()) == "") $("#txtClienteId").val("0");
        }
    });

    $("#txtClienteNombre").css("background-image", "url('" + urlImagenListaCliente + "')");
    $('#txtClienteNombre').autocomplete({
        minLength: 0,
        autoFocus: true,
        open: function (event, ui) {
            $('#txtClienteNombre').attr("placeholder", "Buscar...");
        },
        close: function (event, ui) {
            $('#txtClienteNombre').attr("placeholder", "Cliente");
        },
        focus: function (event, ui) {
            if (AutocompleteLastLI != null) AutocompleteLastLI.removeClass("ui-state-focus");

            AutocompleteLastLI = $(event.currentTarget).find("a.ui-state-focus").parent();
            AutocompleteLastLI.addClass("ui-state-focus");

            return false;
        },
        select: function (event, ui) {
            $("#txtClienteId").val("0");

            if (ui.item.cliente.ClienteID == -1) {
                $("#txtClienteNombre").val("");

                if (gTipoUsuario == '2') {
                    var msgg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
                    $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(msgg);
                    $('#popupInformacionSB2Error').show();
                    return false;
                }

                showClienteDetalle(null);

                return false;
            }
            else if (ui.item.cliente.ClienteID != 0) {
                $.each(lstClientes, function (key, cliente) {
                    if (cliente.ClienteID == ui.item.cliente.ClienteID && cliente.TieneTelefono == 0) {
                        showClienteDetalle(cliente);
                        return false;
                    }
                });
            }

            $("#txtClienteId").val(ui.item.cliente.ClienteID);
        },
        search: function (oEvent, oUi) {
            var sValue = $(oEvent.target).val();

            if (AutocompleteClick) sValue = "";
            AutocompleteClick = false;

            var lstClientesFiltro = [];
            var lstClientesDefault = [];
            var lstClientesFinal = [];

            $(lstClientes).each(function (iIndex, sElement) {
                if (sElement.ClienteID == 0 || sElement.ClienteID == -1) {
                    lstClientesDefault.push(sElement);
                }
                else {
                    if (sElement.Nombre.toUpperCase().indexOf(sValue.toUpperCase()) > -1) lstClientesFiltro.push(sElement);
                }
            });

            lstClientesFiltro.sort(function (a, b) {
                if (a.Nombre.toUpperCase() < b.Nombre.toUpperCase()) return -1;
                if (b.Nombre.toUpperCase() < a.Nombre.toUpperCase()) return 1;
                return 0;
            });

            lstClientesFinal.push.apply(lstClientesFinal, lstClientesDefault);
            lstClientesFinal.push.apply(lstClientesFinal, lstClientesFiltro);

            $(this).autocomplete('option', 'source', function (request, response) {
                response($.map(lstClientesFinal, function (item) {
                    return {
                        label: item.Nombre,
                        value: item.Nombre,
                        cliente: item
                    }
                }));
            });
        }
    });

    ReservadoOEnHorarioRestringido(false);
    $("#divProductoMantenedor").hide();
    $(".btn_verMiPedido").on("click", function () {
        window.location.href = baseUrl + "Mobile/Pedido/Detalle";
    });

    $("#txtCodigoProducto").on("keyup", function () {
        $('#divMensajeCUV').hide();
        posicion = -1;
        var codigo = $("#txtCodigoProducto").val();

        $("#txtCantidad").removeAttr("disabled");
        $("#divProductoMantenedor").hide();
        $("#divResumenPedido").hide();
        $("#btnAgregarProducto").hide();
        $('#PopSugerido').hide();

        if (codigo == "") {
            if (typeof tieneOPT !== 'undefined' && tieneOPT) {
                VisibleEstrategias(true);
            }
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });
        } else {
            VisibleEstrategias(false);
            $("footer").hide();
        }

        if (codigo.length == 5) {
            $("#txtCodigoProducto").blur();
            BuscarByCUV(codigo);
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
    $("#suma, #resta").click(function (event) {
        if (!ValidarPermiso(this)) {
            event.preventDefault();
            return false;
        }
        var cambio = $(this).attr("id") == "suma" ? +1 : -1;
        var numactual = $("#txtCantidad").val();
        numactual = Number(numactual) + cambio;
        numactual = numactual < 1 ? 1 : numactual > 99 ? 99 : numactual;
        $("#txtCantidad").val(numactual);
    });
    $("#btnAgregarProducto").click(function () {
        
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
        
        AgregarProductoListado();
    });

    $("body").on("click", ".btnAgregarSugerido", function () {
        ShowLoading();

        var divPadre = $(this).parents("[data-item='producto']").eq(0);
        var cuv = $(divPadre).find(".hdSugeridoCuv").val();
        var cantidad = $(divPadre).find(".rango_cantidad_pedido").val();
        var tipoOfertaSisID = $(divPadre).find(".hdSugeridoTipoOfertaSisID").val();
        var configuracionOfertaID = $(divPadre).find(".hdSugeridoConfiguracionOfertaID").val();
        var indicadorMontoMinimo = $(divPadre).find(".hdSugeridoIndicadorMontoMinimo").val();
        var marcaID = $(divPadre).find(".hdSugeridoMarcaID").val();
        var precioUnidad = $(divPadre).find(".hdSugeridoPrecioUnidad").val();
        var descripcionProd = $(divPadre).find(".hdSugeridoDescripcionProd").val();
        var tipoEstrategiaId = $(divPadre).find(".hdTipoEstrategiaID").val();
        var OrigenPedidoWeb = MobilePedidoSugerido;

        if (!isInt(cantidad)) {
            AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
            $(divPadre).find('.rango_cantidad_pedido').val(1);
            CloseLoading();
            return false;
        }
        if (cantidad <= 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
            $(divPadre).find('.rango_cantidad_pedido').val(1);
            CloseLoading();
            return false;
        }

        RegistrarDemandaTotalReemplazoSugerido(cuv, precioUnidad, cantidad, true);

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
            EsSugerido: true
        };

        InsertarProductoSugerido(model);
    });

    $("#linkAgregarCliente").on("click", function () {
        if (gTipoUsuario == '2') {
            var msgg = "Por el momento esta sección no está habilitada, te encuentras en una sesión de prueba. Una vez recibas tu código de consultora, podrás acceder a todos los beneficios de Somos Belcorp.";
            $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(msgg);
            $('#popupInformacionSB2Error').show();
            return false;
        }
        showClienteDetalle(null);
    });

    CargarCarouselEstrategias();

    var CuvEnSession = $.trim($("#hdCuvEnSession").val());
    if (CuvEnSession != "") {
        $("#txtCodigoProducto").val(CuvEnSession);
        $("#txtCodigoProducto").keyup();
    }

    CargarDialogMesajePostulantePedido();

    CargarDetallePedido();
});

var ClienteDetalleOK = null;

function CargarDetallePedido(page, rows) {
    var clienteId = $("#ddlClientes").val() || -1;
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 20,
        clienteId: clienteId
    };

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/CargarDetallePedido',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                var data = response.data;
                ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);
                MostrarBarra(response);
            }
        },
        error: function (response, error) { }
    });
}

function ActualizarMontosPedido(formatoTotal, total, formatoTotalCliente) {
   

    if (total != undefined)
        $("#hdfTotal").val(total);

    if (formatoTotalCliente != undefined)
        $("#hdfTotalCliente").val(formatoTotalCliente);
}

function showClienteDetalle(pcliente) {
    var url = urlClienteDetalle;

    var cliente = pcliente || {};

    ShowLoading();

    $.ajax({
        type: 'GET',
        dataType: 'html',
        cache: false,
        url: url,
        data: cliente,
        success: function (data) {
            CloseLoading();

            $("#divDetalleCliente").html(data);
            $("#divAgregarCliente").modal("show");

            ClienteDetalleOK = function (cliente) {
                $("#txtClienteId").val(cliente.ClienteID);
                $("#txtClienteNombre").val(cliente.Nombre);

                if (pcliente == null && cliente.Insertado) {
                    lstClientes.push(cliente);
                }
                else {
                    $.each(lstClientes, function (ind, cli) {
                        if (cli.ClienteID == cliente.ClienteID) {
                            cli.Nombre = cliente.Nombre;
                            cli.TieneTelefono = 1;
                            return false;
                        }
                    });
                }
            };
        },
        error: function (xhr, ajaxOptions, error) {
            CloseLoading();
        }
    });
}

function CargarDialogMesajePostulantePedido() {
    if (gTipoUsuario == '2' && MensajePedidoMobile == '0') {
        var mesg = "En este momento podrás simular el ingreso de tu pedido.";
        var title = "TE ENCUENTRAS EN UNA SESIÓN DE PRUEBA";
        $('#dialog_MensajePostulante_Pedido #titutloPedido').text(title);
        $('#dialog_MensajePostulante_Pedido #mensajePedido').text(mesg);
        $('#dialog_MensajePostulante_Pedido #btnOk').text('CONTINUAR');
        $('#dialog_MensajePostulante_Pedido').show();
        return false;
    }
}

function CerrarDialogMesajePostulantePedido() {
    $('#dialog_MensajePostulante_Pedido').hide();
    UpdateUsuarioTutoriales();
}

function UpdateUsuarioTutoriales() {
    var item = {
        tipo: '2' // Para mOBILE
    };
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/UpdatePostulanteMensaje',
        data: JSON.stringify(item),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) { },
        error: function (data) { }
    });
    return true;
}

function ValidarPermiso(obj) {
    var permiso = $(obj).attr("disabled") || "";
    if (permiso != "") {
        return false;
    }
    return true;
}

function BuscarByCUV(cuv) {
    if (cuv == $('#hdfCUV').val()) {
        if (productoSugerido) {
            if (productoAgotado) MostrarMensaje("mensajeCUVAgotado");
            else $('#PopSugerido').show();
        }
        else if (existeCUV) {
            if (!IsNullOrEmpty(mensajeParametrizableCuv)) MostrarMensaje("mensajeParametrizableCUV", mensajeParametrizableCuv);
            $("#divProductoMantenedor").show();
            $("#btnAgregarProducto").show();
        }
        return false;
    }
    else mensajeParametrizableCuv = '';

    cuvbuscado = cuv;

    $("#divProductoObservaciones").html('');
    productoSugerido = false;
    ShowLoading();
    
    jQuery.ajax({
        type: 'POST',
        url: urlFindByCUV,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ CUV: cuv }),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }           

            $("#txtCantidad").removeAttr("disabled");
            var item = data[0];
            precioCuvBuscado = item.PrecioCatalogo;

            if (item.MarcaID == 0) {
                MostrarMensaje("mensajeProgramaNuevas", item.CUV);
                existeCUV = false;
                $("#divProductoInformacion").hide();
                $('#hdfCUV').val(cuv);
                $("#divProductoMantenedor").show();
                CloseLoading();
                if (item.TieneSugerido != 0) ObtenerProductosSugeridos(cuv);
                return false;
            }

            existeCUV = true;
            $("#hdTipoOfertaSisID").val(item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(item.ConfiguracionOfertaID);
            $("#hdTipoEstrategiaID").val(item.TipoEstrategiaID);
            
            CloseLoading();
            ObservacionesProducto(item);
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();

                if (data.message == "" || data.message === undefined) {
                    location.href = urlSesionExperirada;
                }
            }
        }
    });
}
function ObservacionesProducto(item) {

	$("#hdfEsBusquedaSR").val(false);
	$("#hdfEstrategiaId").val(0);
	if (item.EstrategiaID > 0) {
		$("#hdfEsBusquedaSR").val(true);
		$("#hdfEstrategiaId").val(item.EstrategiaID);
		
	}

	$("#hdfValorFlagNueva").val(item.FlagNueva);
	if (item.FlagNueva == 1) {
		$("#txtCantidad").attr("disabled", "disabled");
	}

	if (item.TipoOfertaSisID != "1707") {
		if (item.TieneSugerido != 0) {
			ObtenerProductosSugeridos(item.CUV);
			return false;
		}
		if (item.TieneStock === true) {
			if (item.EsExpoOferta == true) MostrarMensaje("mensajeEsExpoOferta");
			if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
				if (!item.TieneRDC) MostrarMensaje("mensajeCUVOfertaEspecial");
			}
			if (!IsNullOrEmpty(item.MensajeCUV)) {
				mensajeParametrizableCuv = item.MensajeCUV;
				MostrarMensaje("mensajeParametrizableCUV", mensajeParametrizableCuv);
			}

			var tipoOferta = $("#hdTipoOfertaSisID").val();
			if (tipoOferta == ofertaLiquidacion) {
				MostrarMensaje("mensajeCUVLiquidacion");
				return false;
			}
		}
		else {
			MostrarMensaje("mensajeCUVAgotado");
			return false;
		}
	}

    $("#hdfCUV").val(item.CUV);
    $("#hdfDescripcionCategoria").val(item.DescripcionCategoria);

    $("#hdfDescripcionEstrategia").val(item.DescripcionEstrategia);
    $("#hdfDescripcionMarca").val(item.DescripcionMarca);
    $("#hdLimiteVenta").val(item.LimiteVenta);

    $("#hdfIndicadorMontoMinimo").val(item.IndicadorMontoMinimo);
    $("#hdfMarcaID").val(item.MarcaID);
    $("#hdfPrecioUnidad").val(item.PrecioCatalogo);
    $("#hdfDescripcionProd").val(item.Descripcion);
    $("#txtCodigoProducto").val(item.CUV);
    $("#txtCantidad").val("1");

    $("#txtCantidad, #suma, #resta").attr("disabled", item.FlagNueva == "1");

    $("#spnPrecio").html(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(item.PrecioCatalogo));

    $("#divNombreProducto").html(item.Descripcion);

    $("#btnAgregarProducto").show();
    $("#btnAgregarProducto").removeAttr("disabled");
    $("#divProductoInformacion").show();
    $("#divProductoMantenedor").show();
}
function IngresoFAD(producto) {
    var item = {
        CUV: producto.CUV,
        PrecioUnidad: producto.PrecioCatalogo
    };

    jQuery.ajax({
        type: 'POST',
        url: urlIngresoFAD,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {

            }
        },
        error: function (data, error) { }
    });
}
function ObtenerEstrategiaCoincidente(cuv) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);

    var estratgiaEncontrada;

    $.each(listaRecomendados, function (index, value) {
        if (cuv === value.CUV2) {
            estratgiaEncontrada = value;
        }
    });

    return estratgiaEncontrada;
}
function ObtenerProductosSugeridos(CUV) {
    $('.js-slick-prev-h').remove();
    $('.js-slick-next-h').remove();
    $('#divCarruselSugerido.slick-initialized').slick('unslick');

    $('#divCarruselSugerido').html('<div style="text-align: center;">Actualizando Productos Destacados<br><img src="' + urlLoad + '" /></div>');
    $("#divProductoInformacion").hide();

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerProductosSugeridos,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ CUV: CUV }),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) { CloseLoading(); return false }
            $('#hdfCUV').val(CUV);
            productoSugerido = true;

            var lista = data;
            if (lista.length <= 0) {
                productoAgotado = true;
                MostrarMensaje("mensajeCUVAgotado");
                CloseLoading();
                return false;
            }
            productoAgotado = false;

            $("#divCarruselSugerido").html('');
            $('#PopSugerido').show();
            SetHandlebars("#js-CarruselSugerido", lista, '#divCarruselSugerido');

            $('#divCarruselSugerido').slick({
                infinite: true,
                vertical: false,
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: false,
                speed: 300,
                prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: -13%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png"></a>',
                nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right: -13%;"><img src="/Content/Images/mobile/Esika/next.png")"/></a>'
            });
            CloseLoading();
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                if (data.message == "" || data.message === undefined) {
                    location.href = baseUrl + "Login/SesionExpirada";
                }
            }
        }
    });
}
function CancelarProductosSugeridos() {
    RegistrarDemandaTotalReemplazoSugerido(null, 0, 1, false);
    $("#txtCodigoProducto").val('');
    $("#txtCodigoProducto").trigger("keyup");
}

function InsertarProductoSugerido(model) {
    ShowLoading();
    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    jQuery.ajax({
        type: 'POST',
        url: urlPedidoInsert,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }
            if (data.success != true) {
                messageInfoError(data.message);
                CloseLoading();
                return false;
            }

            ActualizarGanancia(data.DataBarra);
            var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
            if (existeError == "1") {
                AbrirMensaje("Ocurrió un error al ejecutar la operación.");
                CloseLoading();
                return false;
            }

            CloseLoading();

            $("#divProductoObservaciones").html("");
            VisibleEstrategias(true);
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });
            $('#PopSugerido').hide();

            CargarCarouselEstrategias();
            $("#txtCodigoProducto").val("");
            $("#hdCuvEnSession").val("");
            if (data.modificoBackOrder) messageInfo('Recuerda que debes volver a validar tu pedido.');

            if (belcorp.pedido.applyChanges)
                belcorp.pedido.applyChanges("onProductoAgregado", data);
        },
        error: function (data, error) {
            CloseLoading();
        }
    });
}

function AgregarProductoListado() {
    ShowLoading();
    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    var CUV = $('#hdfCUV').val();
    $("#hdCuvRecomendado").val(CUV);
    $("#btnAgregarProducto").attr("disabled", "disabled");
    $("#btnAgregarProducto").hide();

 

    var Cantidad = $("#txtCantidad").val();

    var param = ({
        MarcaID: 0,
        CUV: CUV,
        PrecioUnidad: $("#hdfPrecioUnidad").val(),
        Descripcion: 0,
        Cantidad: Cantidad,
        IndicadorMontoMinimo: 0,
        TipoOferta: $("#hdTipoEstrategiaID").val()
    });

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (checkTimeout(datos)) {
                if (!datos.result) {
                    MostrarMensaje("mensajeCUVCantidadMaxima", datos.message);
                    CloseLoading();
                } else {
                    InsertarProducto();
                    return true;
                }
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                $("#btnAgregarProducto").show();
                $("#btnAgregarProducto").removeAttr("disabled");
            }
        }
    });
}

function InsertarProducto() {
    
    var esOfertaNueva = $("#hdfValorFlagNueva").val() === "1";
    var urlInsertar = esOfertaNueva ? urlPedidoInsertZe : urlPedidoInsert;
    var model = {};
    if ($("#hdTipoOfertaSisID").val() === "0") {
        $("#hdTipoOfertaSisID").val($("#hdTipoEstrategiaID").val());
    }

    if (!esOfertaNueva) {
        if ($.trim($("#txtClienteNombre").val()) == "") $("#txtClienteId").val("0");

        model = {
            CUV: $("#hdfCUV").val(),
            Cantidad: $("#txtCantidad").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            TipoEstrategiaID: $("#hdTipoEstrategiaID").val(),
            OrigenPedidoWeb: origenPedidoWebMobilePedido,
            MarcaID: $("#hdfMarcaID").val(),
            DescripcionProd: $("#divNombreProducto").html(),
            TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            ConfiguracionOfertaID: $("#hdConfiguracionOfertaID").val(),
            ClienteID: $("#txtClienteId").val(),
            ClienteDescripcion: $("#txtClienteNombre").val()
        };

    } else {
        model = {
            CUV: $("#hdfCUV").val(),
            Cantidad: $("#txtCantidad").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            TipoEstrategiaID: $("#hdTipoEstrategiaID").val(),
            OrigenPedidoWeb: origenPedidoWebMobilePedido,
            MarcaID: $("#hdfMarcaID").val(),
            DescripcionProd: $("#divNombreProducto").html(),
            TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoEstrategiaImagen: 2
        };
	}

	var flag = $("#hdfEsBusquedaSR").val();
	if (flag == "true") {
		urlInsertar = urlPedidoAgregarProducto;
		model.EstrategiaID = $("#hdfEstrategiaId").val();
	}

    jQuery.ajax({
        type: 'POST',
        url: urlInsertar,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }
            if (data.success != true) {
                CloseLoading();
                $("#btnAgregarProducto").removeAttr("disabled", "disabled");
                $("#btnAgregarProducto").show();

                var errorCliente = data.errorCliente || false;
                if (!errorCliente) {
                    messageInfoError(data.message);
                }
                else {
                    $.each(lstClientes, function (ind, cli) {
                        if (cli.ClienteID == $("#txtClienteId").val()) {
                            messageInfoError(data.message, function () {
                                showClienteDetalle(cli);
                            });
                            return false;
                        }
                    });
                }
                return false;
            }

            CloseLoading();

            setTimeout(function () {

            }, 2000);

            ActualizarGanancia(data.DataBarra);
            var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
            if (existeError == "1") {
                $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Ocurrió un error al ejecutar la operación.</div>');
                $("#btnAgregarProducto").show();
                $("#btnAgregarProducto").removeAttr("disabled");
                CloseLoading();
                return false;
            }
            $('#divMensajeCUV').hide();
            $("#divProductoObservaciones").html("");
            $("#divProductoMantenedor").hide();
            $("#btnAgregarProducto").hide();
            VisibleEstrategias(true);
            $("#divResumenPedido").show();
            $("footer").show();
            $(".footer-page").css({ "margin-bottom": "0px" });

            var cuv = $("#hdfCUV").val();
            CargarCarouselEstrategias();

            PedidoOnSuccess();
            if (data.modificoBackOrder) messageInfo('Recuerda que debes volver a validar tu pedido.');

            $("#hdCuvEnSession").val("");
            ProcesarActualizacionMostrarContenedorCupon();
            TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
            dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                    'add': {
                        'actionField': { 'list': 'Estándar' },
                        'products': [{
                            'name': data.data.DescripcionProd,
                            'price': String(data.data.PrecioUnidad),
                            'brand': data.data.DescripcionLarga,
                            'id': data.data.CUV,
                            'category': 'NO DISPONIBLE',
                            'variant': data.data.DescripcionOferta == "" ? "Estándar" : data.data.DescripcionOferta,
                            'quantity': Number(model.Cantidad),
                            'position': 1
                        }]
                    }
                }
            });

            if (belcorp.pedido.applyChanges)
                belcorp.pedido.applyChanges("onProductoAgregado", data);
        },
        error: function (data, error) {
            CloseLoading();
        }
    });

}

function VisibleEstrategias(accion) {
    accion == accion || false;
    if (accion) {
        if ($.trim($('#divListadoEstrategia').html()).length > 0) {
            $("#divListaEstrategias").show();
        }
    }
    else {
        $("#divListaEstrategias").hide();
    }
}

function PedidoOnSuccess() {
    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#hdfCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#spnPrecio").val("");
    $("#divNombreProducto").html("");
    $("#txtCantidad").val("");
    $("#txtCodigoProducto").val("");
    $("#btnAgregarProducto").attr("disabled", "disabled");
    $("#divProductoObservaciones").html("");
}

function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
}
function MostrarMensaje(tipoMensaje, message) {
    var $divMensaje = $('#divMensajeCUV');
    $divMensaje.find("#btnCerrarMensaje").hide();

    switch (tipoMensaje) {
        case "mensajeCUVNoExiste":
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVNoExiste);
            $divMensaje.show();
            break;
        case "mensajeCUVAgotado":
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVAgotado);
            $divMensaje.show();
            break;
        case "mensajeCUVOfertaEspecial":
            $divMensaje.find("#divIcono").attr('class', 'icono_aprobacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVOfertaEspecial);
            $divMensaje.show();
            break;
        case "mensajeCUVLiquidacion":
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html(mensajeCUVLiquidacion);
            $divMensaje.show();
            break;
        case "mensajeEsExpoOferta":
            $divMensaje.find("#divIcono").attr('class', 'icono_exclamacion');
            $divMensaje.find("#divMensaje").html("Producto de ExpoOferta.");
            $divMensaje.show();
            break;
        case "mensajeParametrizableCUV":
            $divMensaje.find("#btnCerrarMensaje").show();
            $divMensaje.find("#divIcono").attr("class", "icono_exclamacion");
            $divMensaje.find("#divMensaje").html(message);
            $divMensaje.show();
            break;
        case "mensajeCUVCantidadMaxima":
        case "mensajeCUVShowRoom":
        case "mensajeProgramaNuevas":
            $divMensaje.find("#divIcono").attr("class", "icono_exclamacion");
            $divMensaje.find("#divMensaje").html(message);
            $divMensaje.show();
            break;
    }
}

function MostrarDetalleGanancia() {
    var div = $('#detalleGanancia');
    div[0].children[0].innerHTML = $('#hdeCabezaEscala').val();
    div[0].children[1].children[0].innerHTML = $('#hdeLbl1Ganancia').val();
    div[0].children[2].children[0].innerHTML = $('#hdeLbl2Ganancia').val();
    div[0].children[5].children[0].innerHTML = $('#hdePieEscala').val();

    $('#popupGanancias').show();
}

function ProcesarActualizacionMostrarContenedorCupon() {
    if (paginaOrigenCupon) {
        if (cuponModule) {
            cuponModule.actualizarContenedorCupon();
        }
    }
}

function RegistrarDemandaTotalReemplazoSugerido(cuvSugerido, precio, cantidad, esAceptado) {
    var _cuvPrecio = esAceptado == true ? precio : precioCuvBuscado;
    ShowLoading();
    var model =
        {
            CUV: cuvbuscado,
            CUVSugerido: cuvSugerido,
            PrecioUnidad: _cuvPrecio,
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
                    if (!esAceptado) CloseLoading();
                }
                else CloseLoading();
            }
            else {
                CloseLoading();
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
