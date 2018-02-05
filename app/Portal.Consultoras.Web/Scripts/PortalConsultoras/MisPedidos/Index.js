var slidetime = 1000;
var slidedireccion = "left";
var slidedireccionInversa = "right";

$(document).ready(function () {
    WidthWindow();

    $('#PopSeguimiento iframe').on('load', function () {
        $('#PopSeguimiento').show();
        closeWaitingDialog();
    });

    $("[data-accion='detalle']").click(function () {
        $(window).scrollTop(0);
        var btn = $(this);
        var pop = (btn.parents("[data-camp]") || "");
        if (pop == "") return false;
        var campId = pop.attr("data-camp") || "";
        $('#lblcampania')[0].innerHTML = campId;
        if (campId == "") return false;

        var pedidoId = pop.attr("data-idpedido") || 0;

        $("[data-popup='ingresado']").find("[data-selectcamp]").html("");
        $("[data-popup='facturado']").find("[data-selectcamp]").html("");
        $.each($(".content_datos_mispedidos [data-campnro]"), function (ind, tag) {
            var tagCam = $(tag);
            var itemCanal = tagCam.parent().find('.canal_ingreso').html().toUpperCase();
            var estadoCamp = tagCam.parent().attr("data-estado") || "";
            var pedidoIdCamp = tagCam.parent().attr("data-idpedido") || 0;
            estadoCamp = estadoCamp.toLowerCase();
            estadoCamp = estadoCamp[0];
            estadoCamp = estadoCamp == "i" ? "[data-popup='ingresado']" : estadoCamp == "f" ? "[data-popup='facturado']" : "";

            if (estadoCamp != "") {
                var option = $('<option>')
                    .val(tagCam.html() + '-' + pedidoIdCamp)
                    .attr('data-campformat', tagCam.attr('data-campformat'))
                    .attr('data-pedidoidformat', pedidoIdCamp)
                    .attr('data-canal', itemCanal)
                    .html('C-' + tagCam.attr("data-campnro") + ' ' + itemCanal);

                $(estadoCamp).find("[data-selectcamp]").append(option);
            }
        });
        $("[data-popup='ingresado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6) + '-' + pedidoId);
        $("[data-popup='facturado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6) + '-' + pedidoId);
        $("[data-popup='ingresado']").find("[data-selectcamp]").attr("data-selectpedidoid", pedidoId);
        $("[data-popup='facturado']").find("[data-selectcamp]").attr("data-selectpedidoid", pedidoId);

        var estado = pop.attr("data-estado") || "";
        estado = estado.toLowerCase()[0];
        if (estado == "") return false;
        DetalleVisible(false);
        $("#divGrilla").find("select[data-cliente]").val(-1);

        PopupMostrar(estado, campId, pedidoId);
        $("#regresarFacturado").Visible(estado == "f");
        $('[data-popup="ingresado"] [data-selectcamp]').Visible(estado == "i");
        BotonVerIngresadosSetVisible();
    });

    $('#verIngresado').click(function () {
        $('#lblcampania')[0].innerHTML = "";
        var obj = $(this).parent().find("[data-selectcamp] option:selected");
        var campFormat = obj.attr("data-campformat") || "";
        var pedidoIdFormat = obj.attr("data-pedidoidformat") || 0;
        if (campFormat == "") return false;
        $('[data-popup="ingresado"] [data-selectcamp]').attr("data-campregresar", campFormat);
        $('[data-popup="ingresado"] [data-selectcamp]').attr("data-selectpedidoid", pedidoIdFormat);
        $('[data-popup="facturado"] [data-selectcamp]').attr("data-selectpedidoid", pedidoIdFormat);
        $('[data-popup="ingresado"] [data-selectcamp]').hide();
        $("#divGrilla").find("select[data-cliente]").val(-1);
        campFormat = campFormat.replace("-", "");
        PopupMostrar("i", campFormat, pedidoIdFormat);
        $('#lblcampania')[0].innerHTML = $('[data-popup="ingresado"] [data-selectcamp]')[0].dataset.campregresar;
    });

    $('#regresarFacturado').click(function () {
        var obj = $(this).parent().find("[data-selectcamp]");
        var campFormat = obj.attr("data-campregresar") || "";
        if (campFormat == "") return false;

        var pedidoIdFormat = obj.attr("data-selectpedidoid") || 0;
        $('[data-popup="ingresado"] [data-selectcamp]').attr("data-campregresar", "");
        $('[data-popup="ingresado"] [data-selectcamp]').show();

        $("#divGrilla").find("select[data-cliente]").val(-1);
        campFormat = campFormat.replace("-", "");
        PopupMostrar("f", campFormat, pedidoIdFormat);
    });

    $('[data-accion="close"]').click(function () {
        var btn = $(this);
        var pop = (btn.parents("[data-popup]") || "");
        if (pop == "") return false;

        var estado = pop.attr("data-popup") || "";
        if (estado.toUpperCase() == "FACTURADO" || estado.toUpperCase() == "INGRESADO") {
            PopupCerrarTodos();
        }
        else {
            return false;
        }
        DetalleVisible(true);
    });

    $("body").on("click", ".acordion_titulo > [data-acordion]", function (e) {
        e.preventDefault();
        $(window).scrollTop(0);

        var obj = $(this).parent();
        var contenido = obj.next(".acordion_contenido");
        var display = contenido.css("display");
        PopupDetalleClienteCerrarTodos();

        $("#pedidoPorCliente [data-cliente] .paginador_pedidos").hide();

        if (display == "none") {
            contenido.slideDown(200, function () {
                contenido.animate({ "opacity": "1" }, 200, "swing");
            });
            obj.addClass("acordion_abierto");

            CargarDetalleIngresadoCliente($(this));

        } else {
            contenido.slideUp(200);
            obj.removeClass("acordion_abierto");
        }

    });

    $("body").on("click", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion == "back" || accion == "next") {
            CambioPagina(obj);
        }

    });

    $("body").on("change", "[data-paginacion]", function (e) {
        e.preventDefault();
        var obj = $(this);
        var accion = obj.attr("data-paginacion");
        if (accion == "page" || accion == "rows") {
            CambioPagina(obj);
        }
    });

    $("body").on("change", "[data-selectcamp]", function (e) {
        e.preventDefault();
        var obj = $("[data-selectcamp] option:selected");
        var campFormat = obj.attr("data-campformat") || "";
        if (campFormat == "") return false;
        campFormat = campFormat.replace("-", "");

        var pedidoFormat = obj.attr("data-pedidoidformat") || 0;

        var popup = obj.parents("[data-popup]").attr("data-popup");
        PopupMostrar(popup, campFormat, pedidoFormat);
        BotonVerIngresadosSetVisible();
    });

    $("body").on("change", "select[data-cliente]", function (e) {
        e.preventDefault();

        var obj = $(this);
        var campFormat = obj.attr("data-camp") || "";
        if (campFormat == "") return false;

        campFormat = campFormat.replace("-", "");
        var pedidoId = obj.attr("data-idpedido") || 0;
        var popup = obj.parents("[data-popup]").attr("data-popup");
        PopupMostrar(popup, campFormat, pedidoId);
    });

    CargarEventosTabs();
});

function CargarEventosTabs() {
    $('ul[data-tab="tab"]>li>a[data-tag]').on('click', function (e) {
        e.preventDefault();
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        var obj = $("[data-tag-html='" + tag + "']");
        $.each(obj, function (ind, objTag) {
            $(objTag).fadeIn(300).show();
        });

        $('ul[data-tab="tab"]>li>a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    })
        .on('mouseover', function () { $("#barCursor").css("opacity", "1"); })
        .on('mouseout', function () { $("#barCursor").css("opacity", "0"); });

    $("#barCursor").css("opacity", "0");
    if (!lanzarTabClienteOnline) $('ul[data-tab="tab"]>li>a[data-tag]').first().trigger('click');
}

function CargarFramePedido(campania, nroPedido) {
    waitingDialog({});
    $('#PopSeguimiento iframe').attr('src', urlPedidos + "&campania=" + campania + "&nroPedido=" + nroPedido);
}

function WidthWindow() {
}

function CambioPagina(obj) {
    var par = obj.parents('[data-paginacion="block"]');
    var camp = par.attr("data-camp");
    var pedidoId = par.attr("data-idpedido") || 0;
    var rpt = paginadorAccionGenerico(obj);

    if (rpt.page == undefined) {
        return false;
    }

    var estado = par.attr("data-estado") || "";
    estado = estado.toLowerCase();
    estado = estado[0];

    CargarDetalleFacturado(camp, rpt.page, rpt.rows, estado, pedidoId);

}

function PopupCerrarTodos() {
    $("html").css({ "overflow": "auto" });
    $('[data-popup]').hide();
    DetalleVisible(true, false);
}

function PopupMostrar(popup, campFormat, pedidoId) {
    PopupCerrarTodos();

    popup = $.trim(popup);
    popup = popup.toLowerCase();
    popup = popup[0];
    $("html").css({ "overflow": "hidden" });
    if (popup == "f") $('[data-popup="facturado"]').show();
    else if (popup == "i") $('[data-popup="ingresado"]').show();
    else {
        $("html").css({ "overflow": "auto" });
        return false;
    }
    DetalleVisible(false);
    CargarDetalleFacturado(campFormat, null, null, popup, pedidoId);
}

function DetalleVisible(accion, popup) {
    if (accion) {
        if (popup) {
            PopupCerrarTodos();
        }
    }
}

function PopupDetalleClienteCerrarTodos() {
    $('#pedidoPorCliente [data-contenido]').hide();
    $('#pedidoPorCliente [data-cliente]').removeClass("acordion_abierto");
}

function CargarDetalleFacturado(camp, page, rows, tipo, pedidoId) {
    waitingDialog();
    tipo = tipo || "f";
    pedidoId = pedidoId || 0;
    tipo = tipo[0].toLowerCase();
    var dataAjax = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || 10,
        CampaniaId: camp,
        cliente: $("#divGrilla").find("select[data-cliente]").val() || -1,
        estado: tipo,
        pedidoId: pedidoId
    };
    $("#divContenidofacturado").empty();
    $("#pedidoPorCliente").empty();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisPedidos/ConsultarPedidoWebDetallePorCamaniaPorCliente',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(dataAjax),
        async: true,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            var htmlDiv = SetHandlebars("#html-detalle-facturado", data);
            var campania = data.CampaniaId;
            if (tipo == "i") {
                if (data.listaCliente == 0) {
                    alert("No tiene Pedidos por la Web");
                    return false;
                }
                var facturado = data.ImporteFacturado;
                $('#pedidoPorCliente').attr("data-camp", camp);
                $('#pedidoPorCliente').attr("data-idpedido", pedidoId);
                $('#pedidoPorCliente').empty().html(htmlDiv);
                $("#divGrilla").find(".content_datos_pedidosFacturados").removeClass("content_datos_pedidosFacturados").addClass("content_datos_pedidosIngresados");
                $("[data-div='i']").find("[data-facturadoCabecera]").html(facturado);
                $("#pedidoPorCliente").find('.info_extra_Validado').Visible(dataAjax.cliente == -1);

                // en caso de facturados tenga, poner fuera del if else
                $("#divGrilla").find("select[data-cliente]").append(new Option("Cliente", -1));
                $.each(data.listaCliente, function (item, cliente) {
                    $("#divGrilla").find("select[data-cliente]").append(new Option(cliente.Nombre, cliente.ClienteID));
                });
                $("#divGrilla").find("select[data-cliente]").val(dataAjax.cliente);
            }
            else if (tipo == "f") {
                $("#divContenidofacturado").empty().html(htmlDiv);
                $("#divContenidofacturado").find('[data-paginacion="rows"]').val(data.PageSize);

                var fila = $(".content_mis_pedidos").find("[data-camp='" + campania + "'][data-idpedido='" + pedidoId + "']")
                if (fila.length == 1) {
                    var parcial = fila.find('[data-parcial]').attr("data-parcial");
                    var flete = fila.find('[data-flete]').attr("data-flete");
                    var facturado = fila.find('[data-facturado]').attr("data-facturado");
                    $("#divContenidofacturado").find("[data-total]").html(parcial);
                    $("#divContenidofacturado").find("[data-flete]").html(flete);
                    $("#divContenidofacturado").find("[data-facturado]").html(facturado);
                    $("#divContenidofacturado").find("[data-facturadoCabecera]").html(facturado);
                }
                $("#divGrilla").find(".content_datos_pedidosIngresados").removeClass("content_datos_pedidosIngresados").addClass("content_datos_pedidosFacturados");
            }

        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function CargarDetalleIngresado(camp, page, rows) {
    waitingDialog();
    $('#pedidoPorCliente').empty();
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || 10,
        CampaniaId: camp
    }
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisPedidos/ConsultarPedidoWebDetallePorCamania',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(obj),
        async: true,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            SetHandlebars("#html-detalle-ingresado", data, '#pedidoPorCliente');
            $('#pedidoPorCliente').attr("data-camp", camp);

            // mostarar el primero
            var primer = $(".acordion_titulo > [data-acordion]")[0];
            if (primer) {
                $(primer).click();
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });

}

function CargarDetalleIngresadoCliente(tag, camp, page, rows) {
    var obj = tag.parents(".acordion_titulo");
    var cliente = $(obj).attr("data-cliente");
    if (cliente < 0) return false;

    $("#pedidoPorCliente [data-contenido='" + cliente + "']").empty();

    var objDet = $(obj).parent().find("[data-contenido='" + cliente + "']");
    if (!objDet) return false;

    var camp = $(obj).parent().attr("data-camp");

    waitingDialog();
    var dataAjax = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || 10,
        CampaniaId: camp,
        cliente: cliente,
        estado: "i"
    }
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisPedidos/ConsultarPedidoWebDetallePorCamaniaPorCliente',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(dataAjax),
        async: true,
        success: function (data) {
            closeWaitingDialog();
            if (!checkTimeout(data)) {
                return false;
            }

            var htmlDiv = SetHandlebars("#html-detalle-ingresado-detalle", data);

            $("#pedidoPorCliente [data-contenido='" + cliente + "']").empty().html(htmlDiv);
            if (data.RecordCount > 0) {
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos [data-paginacion='page']").val(data.CurrentPage);
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos [data-paginacion='pageCount']").html(data.PageCount);
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos [data-paginacion='rows']").val(data.PageSize);
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos").show();
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
        }
    });
}

function ExportExcel(obj) {
    waitingDialog();
    var campaniaID = $.trim($(obj).parents("[data-popup]").find("[data-selectcamp] option:selected").attr('data-campformat'));
    campaniaID = campaniaID || $.trim($(obj).parents("[data-popup]").find("[data-selectcamp]").attr("data-campregresar"));
    campaniaID = campaniaID.replace("-", "");
    var ClienteID = $("#divGrilla").find("select[data-cliente]").val();
    var ClienteID_ = ClienteID.toString() == '-1' ? "" : ClienteID.toString();
    setTimeout(function () { DownloadAttachExcel(campaniaID, ClienteID_) }, 0);
}

function DownloadAttachExcel(CampaniaID, ClienteID) {
    if (checkTimeout()) {
        var content = baseUrl + "MisPedidos/ExportarExcel?" +
            "vCampaniaID=" + CampaniaID +
            "&vClienteID=" + ClienteID;

        var iframe_ = document.createElement("iframe");
        iframe_.style.display = "none";
        iframe_.setAttribute("src", content);

        if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
            iframe_.onreadystatechange = function () {
                switch (this.readyState) {
                    case "loading":
                        waitingDialog({});
                        break;
                    case "complete":
                    case "interactive":
                    case "uninitialized":
                        closeWaitingDialog();
                        break;
                    default:
                        closeWaitingDialog();
                        break;
                }
            };
        }
        else {
            // Si es Firefox o Chrome
            $(iframe_).ready(function () {
                closeWaitingDialog();
            });
        }
        document.body.appendChild(iframe_);
    }
}

function ExportExcelFacturado(obj) {
    waitingDialog();
    var popup = $(obj).parents("[data-popup]");
    var campaniaID = $.trim(popup.find("[data-selectcamp] option:selected").attr('data-campformat'));
    campaniaID = campaniaID.replace("-", "");
    var pedidoId = $.trim(popup.find("[data-selectcamp] option:selected").attr("data-pedidoidformat")) || 0;

    var TotalParcial = popup.find("[data-total]").html();
    var Flete = popup.find("[data-flete]").html();
    var TotalFacturado = popup.find("[data-facturado]").html();

    setTimeout(function () { DownloadAttachExcelFacturado(campaniaID, TotalParcial, Flete, TotalFacturado, pedidoId); }, 0);
}

function DownloadAttachExcelFacturado(CampaniaID, TotalParcial, Flete, TotalFacturado, pedidoId) {
    if (checkTimeout()) {
        var content = baseUrl + "MisPedidos/ExportarExcelFacturado?" +
            "vCampaniaID=" + CampaniaID +
            "&vTotalParcial=" + TotalParcial +
            "&vFlete=" + Flete +
            "&vTotalFacturado=" + TotalFacturado +
            "&vPedidoId=" + pedidoId;

        var iframe_ = document.createElement("iframe");
        iframe_.style.display = "none";
        iframe_.setAttribute("src", content);

        if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) { // Si es Internet Explorer
            iframe_.onreadystatechange = function () {
                switch (this.readyState) {
                    case "loading":
                        waitingDialog({});
                        break;
                    case "complete":
                    case "interactive":
                    case "uninitialized":
                        closeWaitingDialog();
                        break;
                    default:
                        closeWaitingDialog();
                        break;
                }
            };
        }
        else {
            // Si es Firefox o Chrome
            $(iframe_).ready(function () {
                closeWaitingDialog();
            });
        }
        document.body.appendChild(iframe_);
    }
}

function Imprimir() {
    window.print();
}

function Percepcion() {
    $(".popup_Percepcion").slideDown(slidetime);

    $(".btn_cerrar_popupPercepcion").click(function () {
        $(".popup_Percepcion").slideUp(slidetime);
    });
}

function BotonVerIngresadosSetVisible() {
    var canal = $("[data-selectcamp] option:selected").attr('data-canal');
    $('#verIngresado').Visible(canal == "WEB" || canal == "MIXTO");
}