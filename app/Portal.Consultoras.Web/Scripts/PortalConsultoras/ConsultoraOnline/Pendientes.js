var urlDetallePedidoPendiente = "/ConsultoraOnline/DetallePedidoPendiente";
var urlDetallePedidoPendienteClientes = "/ConsultoraOnline/DetallePedidoPendienteClientes";
var listaGana = [];
var gTipoVista = 0;
var vPendientes = [];

$(document).ready(function () {
    cambiaTabs();
    InicializarMotivoRechazo();
	$("#vpMenu .info_cam").remove();
});

function bindElments() {

    $('.btnAccion').click(function (e) {

        var btn = $(this).find('.dark-color');
        if (btn) {
            if (!btn.hasClass('ghost')) {
                $('.btnAccion').find('a').removeClass('ghost');
                $('.btnAccion').find('a').html('Elegir');
                btn.addClass('ghost');
                btn.html('Elegido');
            } else {
                btn.removeClass('ghost');
                btn.html('Elegir');
            }
        }

        if ($('.btnAccion a.ghost').length == $('.ghost a').length) {
            $('#btnAceptarPedido span').removeClass('second-color');
            $('#btnAceptarPedido span').addClass('disabled');
            //$('#btnAceptarPedido span').html('Aceptar Pedido');
        }
        else {
            $('#btnAceptarPedido span').addClass('second-color');
            $('#btnAceptarPedido span').removeClass('disabled');
            //$('#btnAceptarPedido span').html('Aceptar Pedido');
        }

        e.preventDefault();
        return false;
    });


    //$(".btn_verMiPedido").on("click", function () {
    //    window.location.href = baseUrl + "Mobile/Pedido/Detalle";
    //});

    //$('#btnIrPedidoAprobar').click(function () {
    //    document.location.href = urlPendientes;
    //});
    //$('#btnIrPedido').click(function () {
    //    document.location.href = urlPedido;
    //});
}

function AceptarPedidoPendiente() {

    var btn = $('.btnAccion a.ghost')[0];
    var accionTipo = $(btn).parent().data('accion');

    if (btn) {
        var pedido = {
            Accion: 2,
            Dispositivo: glbDispositivo,
            AccionTipo: accionTipo,
            ListaGana: $(btn).parent().data('accion') == 'ingrgana' ? $("#list-ofertas-ganamas").data('listagana') : [],
            OrigenTipoVista: gTipoVista
        }

        waitingDialog();
        $.ajax({
            type: 'POST',
            url: '/ConsultoraOnline/AceptarPedidoPendiente',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(pedido),
            async: true,
            success: function (response) {
                /** Analytics **/

                MarcaAnalyticsClienteProducto($(btn).parent().data('accion') == "ingrgana" ? "Acepto Todo el Pedido - Por Gana+" : "Acepto Todo el Pedido - Por catálogo");
                /** Fin Analytics **/

                closeWaitingDialog();
                if (checkTimeout(response)) {
                    if (response.success) {

                        if ($('#modal-confirmacion')[0]) {
                            //$('#modal-confirmacion').addClass('on');

                            var mensajeConfirmacion = (accionTipo == "ingrgana") ? "Has atendido el pedido por Gana+." : "Has atendido el pedido por Catálogo.";
                            $("#mensajeConfirmacion").html(mensajeConfirmacion);

                            $("#contenedor-paso-2").hide();
                            $("#modal-confirmacion").show();
                            $("body").css('overflow', 'hidden');
                            if (!response.continuarExpPendientes) {
                                $("#btnIrPEdidoAprobar").parent().hide();
                                $("#btnIrPedido").removeClass("ghost");
                                $("#btnIrPedido").removeClass("color-dark");
                                $("#btnIrPedido").addClass("second-color");
                                $("#btnIrPedido").parent().addClass("mx-auto");

                            } else {
                                $("#btnIrPEdidoAprobar").parent().show();
                                $("#btnIrPedido").removeClass("second-color");
                                $("#btnIrPedido").parent().removeClass("mx-auto");
                                $("#btnIrPedido").addClass("ghost");
                                $("#btnIrPedido").addClass("color-dark");
                            }

                            /**  Al visualizar el popup de la confirmación debe enviar los siguiente eventos **/

                            var lstproduct = [];

                            var listProductos = [];
                            var pedidoSessionJson = JSON.parse(response.PedidosSesion);

                            if (response.ListaGana !== null) {
                                listProductos = response.ListaGana || [];
                            } else {
                                listProductos = pedidoSessionJson[0].DetallePedido || [];
                            }
                            if (listProductos.length > 0) {
                                listProductos.forEach(function (product) {
                                    var itemProduct = {};
                                    if ($(btn).parent().data('accion') == "ingrgana") {  //por Gana+
                                        itemProduct = {
                                            "id": product.CUV2,
                                            "name": product.DescripcionCUV2,
                                            "price": product.PrecioString,
                                            "brand": product.DescripcionMarca,
                                            "category": "(not available)",
                                            "variant": "Estándar",
                                            "quantity": product.Cantidad
                                        };
                                    } else {        //Por Catálogo
                                        itemProduct = {
                                            "id": product.CUV,
                                            "name": product.Producto,
                                            "price": product.PrecioTotal.toFixed(2),
                                            "brand": product.Marca,
                                            "category": "(not available)",
                                            "variant": "Estándar",
                                            "quantity": product.Cantidad
                                        };
                                    }

                                    lstproduct.push(itemProduct);

                                });

                                AnalyticsMarcacionPopupConfirmacion($(btn).parent().data('accion') === "ingrgana" ? "Por Gana+" : "Por catálogo", lstproduct);
                            }
                        } else {
                            $('#popuplink').click();
                        }
                        CargarResumenCampaniaHeader(true);
                        return false;
                    } else {
                        if (response.code == 1) {
                            AbrirMensaje(response.message);
                        } else if (response.code == 2) {
                            //$('#MensajePedidoReservado').text(response.message);
                            //$('#AlertaPedidoReservado').show();
                            AbrirMensaje(response.message);
                        }
                    }
                }
            },
            error: function (data, error) {
                closeWaitingDialog();
                if (checkTimeout(data)) {
                    AbrirMensaje(
                        "Ocurrió un error inesperado al momento de aceptar el pedido. Consulte con su administrador del sistema para obtener mayor información");
                }
            }
        });

    } else {
        var $MensajeTolTip = $("[data-tooltip=\"mensajepedidopaso2\"]");
        $MensajeTolTip.show();
        setTimeout(function () { $MensajeTolTip.hide(); }, 2000);

        MarcaAnalyticsClienteProducto("Alerta: Debes elegir como atender el pedido para aprobarlo");
    }

}
function AnalyticsMarcacionPopupConfirmacion(strTipo, prod) {
    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickTabPedidosPendientes("Pop up Pedido Aprobado", strTipo);

        //var products = [];

        AnalyticsPortalModule.ClickVistaAddToCardPedidoPendiente(strTipo, prod);
    }
}
function cargarGaleria() {
    $('.conGanaMas').slick({
        arrows: true,
        mobileFirst: true,
        infinite: false,
        centerPadding: '40px',
        slidesToShow: 2,
        prevArrow: '<a class="btn btn-circle left white-color" href="#"><</a>',
        nextArrow: '<a class="btn btn-circle right white-color" href="#">></a>'
        // slidesToShow: 2.3
    });

    $('.conCatalogo').slick({
        arrows: true,
        mobileFirst: true,
        infinite: false,
        centerPadding: '40px',
        // slidesToShow: 2
        slidesToShow: 2.3,
        prevArrow: '<a class="btn btn-circle left white-color" href="#"><</a>',
        nextArrow: '<a class="btn btn-circle right white-color" href="#">></a>'
    });
}

function DetallePedidoPendienteClientes(cuv) {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickBotonTabVistaProducto('In Tab Vista Producto - Click Botón', 'Confirmar Clientes');
    }
    DetallePedidoPendienteClientesService(cuv);
}

function DetallePedidoPendienteClientesVerMas(cuv) {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickBotonTabVistaProducto('In Tab Vista Producto - Click Botón', 'Ver más');
    }
    DetallePedidoPendienteClientesService(cuv);
}

function DetallePedidoPendienteClientesService(cuv) {
    $("body").css('overflow', 'hidden');
    var obj = {
        cuv: cuv
    }
    $.ajax({
        type: 'POST',
        url: urlDetallePedidoPendienteClientes,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {

            console.log(response);
            if (response.success) {
                console.log(response);

                var cuvx = response.CUVx || "";
                $.each(response.data.ListaPedidos, function (index, value) {
                    value.CUVx = cuvx;
                });

                var objenviar = {
                    ListaPedidos: response.data.ListaPedidos,
                    Productox: response.Productox,
                    CUVx: cuvx
                }
                SetHandlebars("#template-paso-1-Clientes", objenviar, "#Paso1-Clientes");
                $(".modal-fondo").show();
                $('#Paso1-Clientes').show();
                gTipoVista = 2;
            } else {
                $("body").css('overflow', 'auto');
            }
        },
        error: function (error) {
            $("body").css('overflow', 'auto');
            //modal - confirmacion
            //CloseLoading();
            //messageInfo("Ocurrió un Error pedido pendiente cliente");
            console.log(error);
        }
    });
}

function DetallePedidoPendiente(ids) {
    console.log(JSON.stringify(ids));
    //console.log(JSON.stringify(cuv));
    $("body").css('overflow', 'hidden');
    var obj = {
        ids: ids
    }
    $.ajax({
        type: 'POST',
        url: urlDetallePedidoPendiente,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (response.success) {
                console.log(response);
                SetHandlebars("#template-paso-1-Producto", response.data, "#Paso1-Productos");
                $('#Paso1-Productos').show();
                $('.modal-fondo').show();
                gTipoVista = 1;
            } else {
                $("body").css('overflow', 'auto');
            }
        },
        error: function (error) {
            $("body").css('overflow', 'auto');
            //CloseLoading();
            //messageInfo("Ocurrió un Error pedido pendiente cliente");
            console.log(error);
        }
    });
}

function MostrarMensajedeRechazoPedido(cuv) {
    var mensaje = '#' + cuv;
    $(mensaje).show();
    MarcaAnalyticsClienteProducto("Eliminar");
}

function OcultarMensajedeRechazoPedido(cuv) {
    var mensaje = '#' + cuv;
    $(mensaje).hide();

    MarcaAnalyticsClienteProducto("¿Quieres eliminar este pedido? - No, gracias");
    //document.location.href = urlPedido;
}

function AceptarPedidoProducto(id) {
    //var texto = '#texto_' + id;
    var aceptado = '#aceptar_' + id;
    if ($(aceptado).hasClass("ghost")) {
        //$(texto).removeClass('text-white');
        //$(texto).addClass('ghost');
        $(aceptado).removeClass('ghost');
        $(aceptado).text('Aceptar');
    }
    else {
        //$(texto).removeClass('text-black');
        //$(texto).addClass('text-white');
        $(aceptado).addClass('ghost');
        $(aceptado).text('Aceptado');

        //Marca Analytics
        MarcaAnalyticsClienteProducto("Aceptado");
    }

}

function RenderizarPendientes(Pendientes) {

    $.each(Pendientes.ListaProductos, function (index, value) {
        value.MasDeDosClientes = false;
        if (value.ListaClientes.length > 2) {
            value.MasDeDosClientes = true;
            value.ListaClientes = value.ListaClientes.slice(0, 1);
        }
    });

    SetHandlebars("#template-vpcpContent", Pendientes, "#vpcpContent");
}

function MotivoRechazoSolicitudPedidoPend(pedidoId) {
    $('#rechazarTodo').hide();
    $('#MotivosRechazo').removeClass('hide');
    $('#MotivosRechazo').css('display', 'block');
    $('#hdPedidoId').val(pedidoId);    
}

function SeRechazoConExito() {
    $('#MotivosRechazo-Paso1').css('display', 'none');
    $('#MotivosRechazo-Paso2').css('display', 'flex');
    setTimeout(function () {
        CerrarModalMotivosRechazo();
    }, 6000);
}

function CerrarModalMotivosRechazo() {
    if ($('#MotivosRechazo-Paso2').is(':visible')) {
        $('#hdPedidoId').val('');
        $('#hdMotivoRechazoId').val('');
        $('#txtOtroMotivo').val('');
        $('#MotivosRechazo-Paso1').css('display', '');
        $('#MotivosRechazo-Paso2').css('display', 'none');
        $('[name="motivoRechazo"]').prop('checked', false);
        $('#OtroMotivo').prop('checked', false);
        $('#OtroMotivo').trigger("change");
        $('#MotivosRechazo').hide();

        $('#rechazarTodop').addClass('hide');
        $("#Paso1-Productos").hide();
        $('body').removeClass('visible');
        $(".modal-fondo").hide();
        //document.location.href = '/ConsultoraOnline/Pendientes';

        var Pendientes = JSON.parse(vPendientes) || [];
        RenderizarPendientes(Pendientes);
        cambiaTabs();


    } else {
        $('#MotivosRechazo').fadeOut(100);
    }
}

function OcultarMotivoRechazoPedidoPend() {
    $('#MotivosRechazo').addClass('hide');
    $('#MotivosRechazo').css('display', 'none');
}

function RechazarSolicitudCliente(pedidoId, idMotivoRechazo, razonMotivoRechazo) {    
    var obj = {
        pedidoId: pedidoId,
        motivoRechazoId: idMotivoRechazo,
        motivoRechazoTexto: razonMotivoRechazo
    };

    MarcaAnalyticsClienteProducto('¿Desea Rechazar todos los pedidos de tus clientes? - Sí, rechazar');

    //ShowLoading();
    AbrirLoad();    
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/RechazarSolicitudCliente",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        success: function (response) {
            //CloseLoading();
            CerrarLoad();
            if (response.success) {
                //$('#rechazarTodop').addClass('hide');
                //$("#Paso1-Productos").hide();
                //$('body').removeClass('visible');
                //$(".modal-fondo").hide();
                ////document.location.href = '/ConsultoraOnline/Pendientes';

                //var Pendientes = JSON.parse(response.Pendientes) || [];
                //RenderizarPendientes(Pendientes);
                //cambiaTabs();
                vPendientes = response.Pendientes;
                SeRechazoConExito();
            }
            else {
                AbrirMensaje(response.message,'Error');
            }
        },
        error: function (err) {
            //CloseLoading();
            CerrarLoad()
            console.log(err);
        }
    });
}

function ActualizarPendientes() {
    //ShowLoading();
    AbrirLoad();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/ActualizarPendientes",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            //CloseLoading();
            CerrarLoad();
            if (response.success) {

                //document.location.href = '/ConsultoraOnline/Pendientes';

                var Pendientes = JSON.parse(response.Pendientes) || [];

                RenderizarPendientes(Pendientes);
                cambiaTabs();

            }
            else {
                alert(response.message);
            }
        },
        error: function (err) {
            //CloseLoading();
            CerrarLoad();
            console.log(err);
        }
    });
}

function RechazarSolicitudClientePorCuv(cuv) {
    var obj = {
        cuv: cuv
    };

    MarcaAnalyticsClienteProducto('¿Desea Rechazar todos los pedidos de tus clientes? - Sí, rechazar');
    //ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/RechazarSolicitudClientePorCuv",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        success: function (response) {
            /*CloseLoading*/
            if (response.success) {
                $('#rechazarTodo').addClass('hide');
                $('#Paso1-Clientes').hide();

                CerrarPopupConfirmacion();

                //document.location.href = '/ConsultoraOnline/Pendientes';

                //var Pendientes = JSON.parse(response.Pendientes) || [];

                //$.each(Pendientes.ListaProductos, function (index, value) {
                //    value.MasDeDosClientes = false;
                //    if (value.ListaClientes.length > 2) {
                //        value.MasDeDosClientes = true;
                //        value.ListaClientes = value.ListaClientes.slice(0, 1);
                //    }
                //});

                //SetHandlebars("#template-vpcpContent", Pendientes, "#vpcpContent");
            }
            else {
                alert(response.message);
            }
        },
        error: function (err) {
            //CloseLoading();
            console.log(err);
        }
    });

}

function ContinuarPedido() {
    var lstDetalle = [];
    //ShowLoading();

    var $paso1 = "";
    if ($('#Paso1-Clientes').css('display') == 'block') {
        $paso1 = $('#Paso1-Clientes');
    } else {
        $paso1 = $('#Paso1-Productos');
    }

    $paso1.find('.pedidos').each(function () {

        if ($(this).find('a[id*="aceptar_"]').hasClass('ghost')) {
            //$(aceptado).addClass('active');
            var pedidoId = $(this).find(".pedidoId").val();
            var cuv = $(this).find(".cuv").val();
            //var cantidad = $(this).find(".cantidad").val();
            var cantNew = $(this).find('[data-cantNew]').val();

            var detalle = {
                PedidoId: pedidoId,
                CUV: cuv,
                Cantidad: cantNew
            }
            lstDetalle.push(detalle);
        }
    });

    var obj = {
        lstDetalle: lstDetalle,
        tipoVista: gTipoVista
    };

    if (lstDetalle.length > 0) {
        $.ajax({
            type: "POST",
            url: "/ConsultoraOnline/ContinuarPedidos",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            //data: JSON.stringify(lstDetalle),
            data: JSON.stringify(obj),
            success: function (response) {
                //CloseLoading();
                if (response.success) {
                    //marcacion analytics de Continuar

                    MarcaAnalyticsClienteProducto('Continuar');

                    $('#Paso1-Clientes').hide();
                    $('#Paso1-Productos').hide();

                    var newListaCatalogo = [];
                    if (response.result.ListaCatalogo && response.result.ListaCatalogo.length > 0) {
                        $.each(response.result.ListaCatalogo, function (index, item) {
                            for (var i = 0; i < item.Cantidad; i++) {
                                newListaCatalogo.push(item);
                            }
                        });
                    }

                    response.result.ListaCatalogo = newListaCatalogo;

                    SetHandlebars("#template-paso-2", response.result, "#contenedor-paso-2");
                    if (response.result.ListaGana.length == 0) {
                        $('.porGanaMas').hide();
                    }
                    else {
                        if (response.result.GananciaGana <= 0) {
                            $('[data-ganancia-gana]').hide();
                        }
                    }

                    $('#contenedor-paso-2').show();
                    cargarGaleria()
                    bindElments();
                    return false;
                }
                else {
                    alert(response.message);
                }
            },
            error: function (err) {
                //CloseLoading();
                console.log(err);
            }
        });
    }
    else {
        //CloseLoading();
        //Lanzar analytics cuando se muestra este mensaje.
        MarcaAnalyticsClienteProducto('Alerta: Debes aceptar un pedido mínimo');

        var $MensajeTolTip = $("[data-tooltip=\"mensajepedido\"]");
        $MensajeTolTip.show();
        setTimeout(function () { $MensajeTolTip.hide(); }, 2000);
    }
}

function EliminarSolicitudDetalle(pedidoId, cuv, origen) {
    var obj = {
        pedidoId: pedidoId,
        cuv: cuv
    }

    var pedidos = [];
    var cuvs = [];

    //ShowLoading();
    $.ajax({
        type: "POST",
        url: "/ConsultoraOnline/EliminarSolicitudDetalle",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        success: function (response) {
            //CloseLoading();
            if (response.success) {                
                var eliminoPedidoCompleto = true;
                // ocultar div

                MarcaAnalyticsClienteProducto('¿Quiere eliminar este pedido? - Sí, eliminar');

                //Ajax
                var Pendientes = JSON.parse(response.Pendientes) || [];
                $.each(Pendientes.ListaPedidos, function (index, value) {
                    pedidos.push(value.PedidoId.toString());
                    $.each(value.DetallePedido, function (index, value) {
                        cuvs.push(value.CUV.toString());
                    });
                    if (value.PedidoId.toString() == pedidoId.toString()) {
                        eliminoPedidoCompleto = false
                    }
                });

                if (eliminoPedidoCompleto) {
                    //ShowLoading();
                    //window.location.href = '/ConsultoraOnline/Pendientes';
                    //return false;
                }

                if (origen == 'C') {
                    var idCuv = '#vc_pedido_' + cuv;
                    if (pedidos.indexOf(pedidoId) < 0) {
                        $('#Paso1-Productos').hide();
                        $(".modal-fondo").hide();
                        $("body").css('overflow', 'auto');
                    }
                    else $(idCuv).hide();
                }
                else if (origen == 'P') {
                    var idPedido = '#vp_pedido_' + pedidoId;
                    if (cuvs.indexOf(cuv) < 0) {
                        $('#Paso1-Clientes').hide();
                        $(".modal-fondo").hide();
                        $("body").css('overflow', 'auto');
                    }
                    else $(idPedido).hide();
                }

                RenderizarPendientes(Pendientes);
                cambiaTabs();
            }
            else {
                alert(response.message);
            }
        },
        error: function (err) {
            //CloseLoading();
            console.log(err);
        }
    });

}

function RechazarTodo() {
    $('#rechazarTodop').removeClass('hide');
    $('#rechazarTodo').removeClass('hide');
    MarcaAnalyticsClienteProducto("Rechazar Todo");
}
function RechazarTodoConfirmado() {
    $('#rechazarTodop').addClass('hide');
    $('#rechazarTodo').addClass('hide');
    MarcaAnalyticsClienteProducto('¿Desea Rechazar todos los pedidos de tus clientes? - No, gracias');

}
function MarcaAnalyticsClienteProducto(label) {
    var textAction = isTabOptionSelected() == 1
        ? "Vista por Cliente - Pop up Paso 1" : isTabOptionSelected() == 2 ? "Vista por Producto - Pop up Paso 1" : isTabOptionSelected() == 3
            ? "Vista por Cliente - Pop up Paso 2" : isTabOptionSelected() == 4 ? "Vista por Producto - Pop up Paso 2" : "";

    if (textAction !== "") {
        if (!(typeof AnalyticsPortalModule === 'undefined')) {
            AnalyticsPortalModule.ClickTabPedidosPendientes(textAction, label);
        }
    }
}
function CerrarPopupConfirmacion() {

    MarcaAnalyticsClienteProducto("Cerrar Pop up");

    $("#modal-confirmacion").hide();
    $("#Paso1-Productos").hide();
    $("#Paso1-Clientes").hide();
    $("#rechazarTodop").hide();
    $("#contenedor-paso-2").hide();
    $(".modal-fondo").hide();
    $("body").css('overflow', 'auto');
    ActualizarPendientes();

}

$("body").on('change', ".ValidaValor", function (e) {
    var $input = $(this);
    var previousVal = $input.val();

    if (previousVal == 0) {

        $input.val(1);
    }
});

function cambiaTabs() {
    $(".tab-panel").hide();
    var SelectorOpen = $("#vpcp").find(".active").attr('href');
    $(SelectorOpen).show();
};
function isTabOptionSelected() {
    //return 0 cuando no debe, 1 cuando es cliente y 2 cuando es producto.
    var isShowPopup = $(".modal-fondo").css("display") === "block" ? true : false; //Verifica si esta en el Popup

    if (isShowPopup) {
        //Verifica que este seleccinado el tab Cliente o Producto
        var isClienteOrProducto = $("#Paso1-Productos").css("Display") == "block" ? true : $("#Paso1-Clientes").css("Display") === "block" ? true : false;
        if (isClienteOrProducto) {
            var selectorOpen = $("#vpcp").find(".active").attr('href') || "";
            return selectorOpen.indexOf("cliente") > 0 ? 1 : 2;
        }
        var isClienteOrProductoPaso2 = $("#contenedor-paso-2").css("Display") == "block" ? true : false;
        if (isClienteOrProductoPaso2) {
            var selectorOpen2 = $("#vpcp").find(".active").attr('href') || "";
            return selectorOpen2.indexOf("cliente") > 0 ? 3 : 4;
        }
    }
    return 0;
}

$("#vpcp li a").click(function () {
    $("#vpcp li a").removeClass('active');
    $(this).addClass('active');

    $(".tab-panel").hide();
    var activeTab = $(this).attr('href');
    console.log(activeTab);
    $(activeTab).fadeIn();
    return false;
});

function PedidosPendientesVistaCliente() {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickTabPedidosPendientes('Click Tab', 'Vista por Cliente');
    }
}

function PedidosPendientesVistaProducto() {

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        AnalyticsPortalModule.ClickTabPedidosPendientes('Click Tab', 'Vista por Producto');
    }
}
function InicializarMotivoRechazo() {

    var btnContinuar = $('#btnConfirmaMotivo');
    var checkOtroMotivo = $('#OtroMotivo');
    var txtOtroMotivo = $('#txtOtroMotivo');
    var rdoMotivos = $('[name="motivoRechazo"]');
    var hdMotivoRechazoId = $('#hdMotivoRechazoId');


    if (checkOtroMotivo.length) {
        checkOtroMotivo.change(function () {
            if ($('#OtroMotivo:checkbox:checked').length) {
                $('[name="motivoRechazo"]').prop('checked', false);
                txtOtroMotivo.prop('style', 'display:block');
                btnContinuar.removeClass('btn__sb--disabled');
                hdMotivoRechazoId.val(checkOtroMotivo.val());
            } else {
                txtOtroMotivo.prop('style', 'display:none !important');
                btnContinuar.addClass('btn__sb--disabled');
            }
        });

        checkOtroMotivo.trigger("change");
    }


    rdoMotivos.change(function () {
        console.log('change motivo rechazo');
        if (rdoMotivos.is(':checked')) {
            if (checkOtroMotivo.length) {
                checkOtroMotivo.prop('checked', false);
                checkOtroMotivo.trigger("change");
            }

            btnContinuar.removeClass('btn__sb--disabled');
        }
        hdMotivoRechazoId.val($('[name="motivoRechazo"]:checked').val());
    });

    btnContinuar.click(function (e) {        
        var idPedido = $('#hdPedidoId').val().trim();
        var idMotivoRechazo = hdMotivoRechazoId.val().trim();
        var razonMotivoRechazo = (idMotivoRechazo == '11') ? txtOtroMotivo.val().trim() : '';

        RechazarSolicitudCliente(idPedido, idMotivoRechazo, razonMotivoRechazo);
    });


}
function CerrarMotivoRechazo() {
    $('#MotivosRechazo').fadeOut(100);
    $('#rechazarTodo').show();
}
