var slidetime = 1000;
var slidedireccion = "left";
var slidedireccionInversa = "right";

$(document).ready(function () {
    
    WidthWindow();

    $("[data-accion='detalle']").click(function () {
        $(window).scrollTop(0);
        var btn = $(this);
        var pop = (btn.parents("[data-camp]") || "");
        if (pop == "") return false;
        var campId = pop.attr("data-camp") || "";
        if (campId == "") return false;

        $("[data-popup='ingresado']").find("[data-selectcamp]").html("");
        $("[data-popup='facturado']").find("[data-selectcamp]").html("");
        $.each($(".content_datos_mispedidos [data-campnro]"), function (ind, tag) {
            var tagCam = $(tag);
            var estadoCamp = tagCam.parent().attr("data-estado") || "";
            estadoCamp = estadoCamp.toLowerCase();
            estadoCamp = estadoCamp[0];
            estadoCamp = estadoCamp == "i" ? "[data-popup='ingresado']" : estadoCamp == "f" ? "[data-popup='facturado']" : "";
            if (estadoCamp != "") {
                $(estadoCamp).find("[data-selectcamp]").append('<option value="' + tagCam.html() + '" data-campformat="' + tagCam.attr("data-campformat") + '">C-' + tagCam.attr("data-campnro") + '</option>');
            }
        });
        $("[data-popup='ingresado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6));
        $("[data-popup='facturado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6));

        var estado = pop.attr("data-estado") || "";
        estado = estado.toLowerCase()[0];
        if (estado == "") return false;
        DetalleVisible(false);
        PopupMostrar(estado, campId);
        $("#regresarFacturado").Visible(estado == "f");
        $('[data-popup="ingresado"] [data-selectcamp]').Visible(estado == "i");
        var canal = $.trim(pop.find(".canal_ingreso").html()).toLowerCase();
        $('#verIngresado').Visible(canal == "web");
    });

    $('#verIngresado').click(function () {
        var opt = $(this).parent().find("[data-selectcamp]");
        var obj = opt.find("[value='" + opt.val() + "']");
        var campFormat = obj.attr("data-campformat") || "";
        if (campFormat == "") return false;
        $('[data-popup="ingresado"] [data-selectcamp]').attr("data-campregresar", campFormat);
        $('[data-popup="ingresado"] [data-selectcamp]').hide();
        $("#divGrilla").find("select[data-cliente]").val(-1);
        campFormat = campFormat.replace("-", "");
        PopupMostrar("i", campFormat);
    });
    
    $('#regresarFacturado').click(function () {
        var obj = $(this).parent().find("[data-selectcamp]");
        var campFormat = obj.attr("data-campregresar") || "";
        if (campFormat == "") return false;
        $('[data-popup="ingresado"] [data-selectcamp]').attr("data-campregresar", "");
        $('[data-popup="ingresado"] [data-selectcamp]').show();
        $('[data-popup="facturado"] [data-selectcamp]').val(campFormat);
        $("#divGrilla").find("select[data-cliente]").val(-1);
        campFormat = campFormat.replace("-", "");
        PopupMostrar("f", campFormat);
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

        // var cliente = $(obj).attr("data-cliente");
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
        var obj = $(this).find("[value='" + $(this).val() + "']");
        var campFormat = obj.attr("data-campformat") || "";
        if (campFormat == "") return false;
        campFormat = campFormat.replace("-", "");
        var popup = obj.parents("[data-popup]").attr("data-popup");
        PopupMostrar(popup, campFormat);
        //if ($(".content_mis_pedidos").find("[data-campformat='" + campFormat + "']").length == 1) {
        //    $(".content_mis_pedidos").find("[data-campformat='" + campFormat + "']").parent().find('[data-accion="detalle"]').click();
        //}
    });
    
    $("body").on("change", "select[data-cliente]", function (e) {
        e.preventDefault();
        var obj = $(this);//.find("[value='" + $(this).val() + "']");
        var campFormat = obj.attr("data-camp") || "";
        if (campFormat == "") return false;
        campFormat = campFormat.replace("-", "");
        var popup = obj.parents("[data-popup]").attr("data-popup");
        PopupMostrar(popup, campFormat);
    });
});

function WidthWindow() {
    //$("#cuerpo").css("width", window.innerWidth * 3 + "px");
    //$("[data-div]").css("width", window.innerWidth + "px");
}

function CambioPagina(obj) {
    var par = obj.parents('[data-paginacion="block"]');
    var camp = par.attr("data-camp");

    var rpt = paginadorAccionGenerico(obj);

    if (rpt.page == undefined) {
        return false;
    }
    
    var estado = par.attr("data-estado") || "";
    estado = estado.toLowerCase();
    estado = estado[0];

    CargarDetalleFacturado(camp, rpt.page, rpt.rows, estado);

    //var estado = par.attr("data-estado") || "";
    //estado = estado.toLowerCase();
    //estado = estado[0];
    //if (estado == 'f') {
    //    CargarDetalleFacturado(camp, rpt.page, rpt.rows);
    //}
    //else if (estado == 'i') {
    //    CargarDetalleIngresadoCliente(par, camp, rpt.page, rpt.rows);
    //}
}

function PopupCerrarTodos() {
    //$('[data-popup]').hide("slide", { direction: slidedireccion }, slidetime);
    $('[data-popup]').hide();
    //$('[data-popup]').slideUp(slidetime);
    DetalleVisible(true, false);
}

function PopupMostrar(popup, campFormat) {
    PopupCerrarTodos();

    popup = $.trim(popup);
    popup = popup.toLowerCase();
    popup = popup[0];
    if (popup == "f") {
        $(".popup_pedidosFacturados").show();
        //CargarDetalleFacturado(campFormat);
    }
    else if (popup == "i") {
        $(".popup_pedidosIngresados").show();
        //CargarDetalleIngresado(campFormat);
    }
    else {
        return false;
    }
    DetalleVisible(false);
    CargarDetalleFacturado(campFormat, null, null, popup);
}

function DetalleVisible(accion, popup) {
    if (accion) {
        if (popup) {
            PopupCerrarTodos();
        }
        $("#contenidoGrilla").show();
        //$(".fondo_f9f9f9").animate({ "margin-top": "0px" }, 500);
    }
    else {
        $("#contenidoGrilla").hide();
        //$(".fondo_f9f9f9").animate({ "margin-top": "-141px" }, 500);
    }
}

function PopupDetalleClienteCerrarTodos() {
    $('#pedidoPorCliente [data-contenido]').hide();
    $('#pedidoPorCliente [data-cliente]').removeClass("acordion_abierto");
}

function CargarDetalleFacturado(camp, page, rows, tipo) {
    waitingDialog();
    tipo = tipo || "f"
    tipo = tipo[0].toLowerCase();
    var dataAjax = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || 10,
        CampaniaId: camp,
        cliente: $("#divGrilla").find("select[data-cliente]").val() || - 1,
        estado: tipo // "f"
    }
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

            var source = $("#html-detalle-facturado").html();
            var template = Handlebars.compile(source);
            var htmlDiv = template(data);
            if (tipo == "i") {
                $('#pedidoPorCliente').attr("data-camp", camp);
                $('#pedidoPorCliente').empty().html(htmlDiv);
                $("#divGrilla").find(".content_datos_pedidosFacturados").removeClass("content_datos_pedidosFacturados").addClass("content_datos_pedidosIngresados");
            }
            else if (tipo == "f") {
                $("#divContenidofacturado").empty().html(htmlDiv);
                $("#divContenidofacturado").find('[data-paginacion="rows"]').val(data.PageSize);
                var campania = data.CampaniaId;
                if ($(".content_mis_pedidos").find("[data-camp='" + campania + "']").length == 1) {
                    var parcial = $(".content_mis_pedidos").find("[data-camp='" + campania + "']").find('[data-parcial]').attr("data-parcial");
                    var flete = $(".content_mis_pedidos").find("[data-camp='" + campania + "']").find('[data-flete]').attr("data-flete");
                    var facturado = $(".content_mis_pedidos").find("[data-camp='" + campania + "']").find('[data-facturado]').attr("data-facturado");
                    $("#divContenidofacturado").find("[data-total]").html(parcial);
                    $("#divContenidofacturado").find("[data-flete]").html(flete);
                    $("#divContenidofacturado").find("[data-facturado]").html(facturado);
                }
                $("#divGrilla").find(".content_datos_pedidosIngresados").removeClass("content_datos_pedidosIngresados").addClass("content_datos_pedidosFacturados");
            }

            var cienteId = $("#divGrilla").find("select[data-cliente]").attr("data-val");
            //var ddlCliente = Clone($("#ddlClientes"));
            //$.each(ddlCliente.find("option"), function (ind, item) {
            //    $("#divGrilla").find("select[data-cliente]").append($(item));
            //});
            $("#divGrilla").find("select[data-cliente]").append(new Option("Cliente", -1));
            $("#divGrilla").find("select[data-cliente]").append(new Option(data.NombreConsultora, 0));                   
            $("#divGrilla").find("select[data-cliente]").append($("#ddlClientes").html());
            $("#divGrilla").find("select[data-cliente]").val(cienteId);
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
            }
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

            var source = $("#html-detalle-ingresado").html();
            var template = Handlebars.compile(source);
            var htmlDiv = template(data);

            $('#pedidoPorCliente').attr("data-camp", camp);
            $('#pedidoPorCliente').empty().html(htmlDiv);

            // mostarar el primero
            var primer = $(".acordion_titulo > [data-acordion]")[0];
            if (primer) {
                $(primer).click();
            }

            //$("[data-popup='ingresado']").find("[data-selectcamp]").val(camp.substr(0, 4) + "-" + camp.substr(4, 6));

        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
            }
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

            var source = $("#html-detalle-ingresado-detalle").html();
            var template = Handlebars.compile(source);
            var htmlDiv = template(data);

            $("#pedidoPorCliente [data-contenido='" + cliente + "']").empty().html(htmlDiv);
            if (data.RecordCount > 0) {
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos [data-paginacion='page']").val(data.CurrentPage);
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos [data-paginacion='pageCount']").html(data.PageCount);
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos [data-paginacion='rows']").val(data.PageSize);
                $("#pedidoPorCliente [data-cliente='" + cliente + "'] .paginador_pedidos").show();
            }
            //$("#pedidoPorCliente").find('[data-paginacion="rows"]').val(data.PageSize);

        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
            }
            closeWaitingDialog();
        }
    });
}

function ExportExcel(obj) {
    waitingDialog();
    var campaniaID = $.trim($(obj).parents("[data-popup]").find("[data-selectcamp]").val());
    campaniaID = campaniaID.replace("-", "");
    _gaq.push(['_trackEvent', 'Pedido Web Ingresado', 'Botón Excel']);
    setTimeout(function () { DownloadAttachExcel(campaniaID) }, 0);
}

function DownloadAttachExcel(CampaniaID) {
    if (checkTimeout()) {
        var content = baseUrl + "MisPedidos/ExportarExcel?" +
            "vCampaniaID=" + CampaniaID;

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
    var campaniaID = $.trim(popup.find("[data-selectcamp]").val());
    campaniaID = campaniaID.replace("-", "");
    var TotalParcial = popup.find("[data-total]").html();
    var Flete = popup.find("[data-flete]").html();
    var TotalFacturado = popup.find("[data-facturado]").html();

    _gaq.push(['_trackEvent', 'Pedido Web Facturado', 'Botón-Excel']);
    setTimeout(function () { DownloadAttachExcelFacturado(campaniaID, TotalParcial, Flete, TotalFacturado) }, 0);
}

function DownloadAttachExcelFacturado(CampaniaID, TotalParcial, Flete, TotalFacturado) {
    if (checkTimeout()) {
        var content = baseUrl + "MisPedidos/ExportarExcelFacturado?" +
            "vCampaniaID=" + CampaniaID +
            "&vTotalParcial=" + TotalParcial +
            "&vFlete=" + Flete +
            "&vTotalFacturado=" + TotalFacturado

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
    _gaq.push(['_trackEvent', 'Pedido Web Ingresado', 'Botón- Impriimir']);
    window.print();
}

function Percepcion() {

    //jquery.ajax({
    //    type: 'post',
    //    url: baseurl + 'mispedidos/listarpercepciones',
    //    datatype: 'json',
    //    contenttype: 'application/json; charset=utf-8',
    //    data: json.stringify(item),
    //    async: true,
    //    success: function (data) {
    //        if (checktimeout(data)) {
    //        }
    //    },
    //    error: function (data, error) {
    //        if (checktimeout(data)) {
    //            //alert_msg(data.message);
    //        }
    //    }
    //});

    $(".popup_Percepcion").slideDown(slidetime);
    //$(".fondo_f9f9f9").animate({ "margin-top": "-141px" }, 500);

    $(".btn_cerrar_popupPercepcion").click(function () {

        $(".popup_Percepcion").slideUp(slidetime);
        //$(".fondo_f9f9f9").animate({ "margin-top": "0px" }, 500);

    });

}