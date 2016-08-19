$(document).ready(function () {

    $("[data-accion='detalle']").click(function () {
        PopupCerrarTodos();
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
            var estadoCamp = tagCam.parent().attr("data-estado")
            $("[data-popup='ingresado']").find("[data-selectcamp]").append('<option value="' + tagCam.html() + '" data-campformat="' + tagCam.attr("data-campformat") + '">C-' + tagCam.attr("data-campnro") + '</option>');
            if (estadoCamp == "FACTURADO") {
                $("[data-popup='facturado']").find("[data-selectcamp]").append('<option value="' + tagCam.html() + '" data-campformat="' + tagCam.attr("data-campformat") + '">C-' + tagCam.attr("data-campnro") + '</option>');
            }
        });
        $("[data-popup='ingresado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6));
        $("[data-popup='facturado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6));

        var estado = pop.attr("data-estado") || "";
        estado = estado.toUpperCase();
        if (estado == "FACTURADO") {
            $(".popup_pedidosFacturados").slideDown(300);
            CargarDetalleFacturado(campId);
        }
        else if (estado == "INGRESADO") {
            $(".popup_pedidosIngresados").slideDown(300);
            
            CargarDetalleIngresado(campId);
        }
        else {
            return false;
        }
        $(".fondo_f9f9f9").animate({ "margin-top": "-141px" }, 500);

    });

    $('[data-accion="close"]').click(function () {
        var btn = $(this);
        var pop = (btn.parents("[data-popup]") || "");
        if (pop == "") return false;
        
        var estado = pop.attr("data-popup") || "";
        if (estado.toUpperCase() == "FACTURADO" || estado.toUpperCase() == "INGRESADO") {
            $(pop).slideUp(300);
        }
        else {
            return false;
        }
        $(".fondo_f9f9f9").animate({ "margin-top": "0px" }, 500);
    });
    
    //$(".acordion_titulo").first().addClass("acordion_abierto");
    //$(".acordion_abierto .titulo_nombreCliente .icono_despliegue_acordion").css({ "background-position": "center bottom" });

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
        //.parents("[data-popup]");
        var campFormat = obj.attr("data-campformat") || "";
        //var camp = obj.attr("data-optcamp") || "";
        if (campFormat == "") return false;
        campFormat = campFormat.replace("-", "");
        var popup = obj.parents("[data-popup]").attr("data-popup");
        popup = popup.toUpperCase();
        if (popup == "FACTURADO") {
            $(".popup_pedidosFacturados").slideDown(300);
            CargarDetalleFacturado(campFormat);
        }
        else if (popup == "INGRESADO") {
            $(".popup_pedidosIngresados").slideDown(300);
            CargarDetalleIngresado(campFormat);
        }
        //if ($(".content_mis_pedidos").find("[data-campformat='" + campFormat + "']").length == 1) {
        //    $(".content_mis_pedidos").find("[data-campformat='" + campFormat + "']").parent().find('[data-accion="detalle"]').click();
        //}
    });
});

function CambioPagina(obj) {
    var par = obj.parents('[data-paginacion="block"]');
    var camp = par.attr("data-camp");
    //var cliente = par.attr("data-cliente");
    var estado = par.attr("data-estado");

    var rpt = paginadorAccionGenerico(obj);

    if (rpt.page == undefined) {
        return false;
    }

    if (estado == 'facturado') {
        CargarDetalleFacturado(camp, rpt.page, rpt.rows);
    }
    else if (estado == 'ingresado') {
        CargarDetalleIngresadoCliente(par, camp, rpt.page, rpt.rows);
    }
}

function PopupCerrarTodos() {
    $('[data-popup]').slideUp(300);
    $(".fondo_f9f9f9").animate({ "margin-top": "0px" }, 500);
}

function PopupDetalleClienteCerrarTodos() {
    $('#pedidoPorCliente [data-contenido]').hide();
    $('#pedidoPorCliente [data-cliente]').removeClass("acordion_abierto");
}

function CargarDetalleFacturado(camp, page, rows) {
    waitingDialog();
    $("#divContenidofacturado").empty();
    var dataAjax = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || 10,
        CampaniaId: camp,
        cliente: -1,
        estado: "f"
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

            var source = $("#html-detalle-facturado").html();
            var template = Handlebars.compile(source);
            var htmlDiv = template(data);

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
    $("#pedidoPorCliente [data-contenido='" + cliente + "']").empty();

    var obj = tag.parents(".acordion_titulo");
    var cliente = $(obj).attr("data-cliente");
    if (cliente < 0) return false;

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

    $(".popup_Percepcion").slideDown(300);
    $(".fondo_f9f9f9").animate({ "margin-top": "-141px" }, 500);

    $(".btn_cerrar_popupPercepcion").click(function () {

        $(".popup_Percepcion").slideUp(300);
        $(".fondo_f9f9f9").animate({ "margin-top": "0px" }, 500);

    });

}