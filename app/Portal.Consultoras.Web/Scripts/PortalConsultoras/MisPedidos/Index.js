﻿var slidetime = 1000;
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
        $('#lblcampania')[0].innerHTML=campId;
        if (campId == "") return false;
        
        var pedidoId = pop.attr("data-idpedido") || 0;

        $("[data-popup='ingresado']").find("[data-selectcamp]").html("");
        $("[data-popup='facturado']").find("[data-selectcamp]").html("");
        $.each($(".content_datos_mispedidos [data-campnro]"), function (ind, tag) {
            var tagCam = $(tag);
            var estadoCamp = tagCam.parent().attr("data-estado") || "";
            var pedidoIdCamp = tagCam.parent().attr("data-idpedido") || 0;
            estadoCamp = estadoCamp.toLowerCase();
            estadoCamp = estadoCamp[0];
            estadoCamp = estadoCamp == "i" ? "[data-popup='ingresado']" : estadoCamp == "f" ? "[data-popup='facturado']" : "";
            if (estadoCamp != "") {
                $(estadoCamp).find("[data-selectcamp]").append('<option value="' + tagCam.html() + '" data-campformat="' + tagCam.attr("data-campformat") + '" data-pedidoidformat="'+ pedidoIdCamp +'">C-' + tagCam.attr("data-campnro") + '</option>');
            }
        });
        $("[data-popup='ingresado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6));
        $("[data-popup='facturado']").find("[data-selectcamp]").val(campId.substr(0, 4) + "-" + campId.substr(4, 6));
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
        var canal = $.trim(pop.find(".canal_ingreso").html()).toLowerCase();

        $('#verIngresado').Visible(canal == "web" || canal == "mixto");

        //$('#verIngresado').Visible(canal == "web");
    });

    $('#verIngresado').click(function () {
        $('#lblcampania')[0].innerHTML="";
        var opt = $(this).parent().find("[data-selectcamp]");
        var obj = opt.find("[value='" + opt.val() + "']");
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
        $('[data-popup="facturado"] [data-selectcamp]').val(campFormat);
        
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

        var pedidoFormat = obj.attr("data-pedidoidformat") || 0;
        
        var popup = obj.parents("[data-popup]").attr("data-popup");
        PopupMostrar(popup, campFormat, pedidoFormat);
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
        
        var pedidoId = obj.attr("data-idpedido") || 0;

        var popup = obj.parents("[data-popup]").attr("data-popup");
        PopupMostrar(popup, campFormat, pedidoId);
    });

    CargarEventosTabs();
});

function CargarEventosTabs() {
    $('ul[data-tab="tab"]>li>a[data-tag]').on('click',function (e) {
        e.preventDefault();
        // mostrar el tab correcto
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        var obj = $("[data-tag-html='" + tag + "']");
        $.each(obj, function (ind, objTag) {
            $(objTag).fadeIn(300).show();
        });

        //mantener seleccionado
        $('ul[data-tab="tab"]>li>a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    })
        .on('mouseover',function () { $("#barCursor").css("opacity", "1"); })
        .on('mouseout', function () { $("#barCursor").css("opacity", "0"); });

    $("#barCursor").css("opacity", "0");
    if (!lanzarTabClienteOnline) $('ul[data-tab="tab"]>li>a[data-tag]').first().trigger('click');
}

function CargarFramePedido(campania)
{
    waitingDialog({});
    $('#PopSeguimiento iframe').attr('src', urlPedidos + "&campania=" + campania);
}

function WidthWindow() {
    //$("#cuerpo").css("width", window.innerWidth * 3 + "px");
    //$("[data-div]").css("width", window.innerWidth + "px");
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
    $("html").css({ "overflow": "auto" });
    //$('[data-popup]').hide("slide", { direction: slidedireccion }, slidetime);
    $('[data-popup]').hide();
    //$('[data-popup]').slideUp(slidetime);
    DetalleVisible(true, false);
}

function PopupMostrar(popup, campFormat, pedidoId) {
    PopupCerrarTodos();

    popup = $.trim(popup);
    popup = popup.toLowerCase();
    popup = popup[0];
    $("html").css({ "overflow": "hidden" });
    //$("#divGrilla").find("select[data-cliente]").val(-1);
    if (popup == "f") {
        $('[data-popup="facturado"]').show();
    }
    else if (popup == "i") {
        $('[data-popup="ingresado"]').show();
    }
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
        estado: tipo, // "f"
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
                
                if(data.listaCliente==0)
                {
                    alert("No tiene Pedidos por la Web");
                    return false;
                }
                var facturado = data.ImporteFacturado;
                $('#pedidoPorCliente').attr("data-camp", camp);
                $('#pedidoPorCliente').attr("data-idpedido", pedidoId);
                $('#pedidoPorCliente').empty().html(htmlDiv);
                $("#divGrilla").find(".content_datos_pedidosFacturados").removeClass("content_datos_pedidosFacturados").addClass("content_datos_pedidosIngresados");
                $("[data-div='i']").find("[data-facturadoCabecera]").html(facturado);

                // en caso de facturados tenga, poner fuera del if else
                $("#divGrilla").find("select[data-cliente]").append(new Option("Cliente", -1));
                //$("#divGrilla").find("select[data-cliente]").append(new Option(data.NombreConsultora, 0));
                $.each(data.listaCliente, function (item, cliente) {
                    $("#divGrilla").find("select[data-cliente]").append(new Option(cliente.Nombre, cliente.ClienteID));
                });
                //$("#divGrilla").find("select[data-cliente]").append($("#ddlClientes").html());
                $("#divGrilla").find("select[data-cliente]").val(dataAjax.cliente);
            }
            else if (tipo == "f") {
                $("#divContenidofacturado").empty().html(htmlDiv);
                $("#divContenidofacturado").find('[data-paginacion="rows"]').val(data.PageSize);
                if ($(".content_mis_pedidos").find("[data-camp='" + campania + "']").length == 1) {
                    var parcial = $(".content_mis_pedidos").find("[data-camp='" + campania + "']").find('[data-parcial]').attr("data-parcial");
                    var flete = $(".content_mis_pedidos").find("[data-camp='" + campania + "']").find('[data-flete]').attr("data-flete");
                    var facturado = $(".content_mis_pedidos").find("[data-camp='" + campania + "']").find('[data-facturado]').attr("data-facturado");
                    $("#divContenidofacturado").find("[data-total]").html(parcial);
                    $("#divContenidofacturado").find("[data-flete]").html(flete);
                    $("#divContenidofacturado").find("[data-facturado]").html(facturado);
                    $("#divContenidofacturado").find("[data-facturadoCabecera]").html(facturado);
                }
                $("#divGrilla").find(".content_datos_pedidosIngresados").removeClass("content_datos_pedidosIngresados").addClass("content_datos_pedidosFacturados");
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

            SetHandlebars("#html-detalle-ingresado", data, '#pedidoPorCliente');
            $('#pedidoPorCliente').attr("data-camp", camp);

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

            var htmlDiv = SetHandlebars("#html-detalle-ingresado-detalle", data);

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
    campaniaID = campaniaID || $.trim($(obj).parents("[data-popup]").find("[data-selectcamp]").attr("data-campregresar"));
    campaniaID = campaniaID.replace("-", "");
    var ClienteID = $("#divGrilla").find("select[data-cliente]").val();
    var ClienteID_ = ClienteID.toString() == '-1' ? "" : ClienteID.toString();
    setTimeout(function () { DownloadAttachExcel(campaniaID,ClienteID_) }, 0);
}

function DownloadAttachExcel(CampaniaID,ClienteID) {
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
    var campaniaID = $.trim(popup.find("[data-selectcamp]").val());
    campaniaID = campaniaID.replace("-", "");

    var pedidoId = $.trim(popup.find("[data-selectcamp]").attr("data-selectpedidoid")) || 0;

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