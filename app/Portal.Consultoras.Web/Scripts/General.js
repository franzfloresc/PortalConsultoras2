﻿
var formatDecimalPais = formatDecimalPais || new Object();

jQuery(document).ready(function () {
    CreateLoading();

    $("body").on("click", "[data-compartir]", function (e) {
        CompartirRedesSociales(e);
    });
});
(function ($) {
    $.fn.Readonly = function (val) {
        if (val != undefined || val != null) {
            $(this).attr('readonly', val);
        }
        else {
            var viene = $(this).attr('readonly');
            $(this).attr('readonly', viene == undefined);
        }
    };

    $.fn.Disabled = function (val) {
        if (val != undefined || val != null) {
            $(this).attr('disabled', val);
        }
        else {
            var viene = $(this).attr('disabled');
            $(this).attr('disabled', viene == undefined);
        }
    };
    $.fn.Visible = function (val) {
        if (val != undefined || val != null) {
            if (val) {
                $(this).show();
            }
            else {
                $(this).hide();
            }
        }
    };
    $.fn.Checked = function (val) {
        val = val || $(this).is(":checked");
        if (val) {
            $(this).removeAttr('checked');
        }
        else {
            $(this).attr('checked', 'checked');
        }
    };

    Clone = function (obj) {
        if (obj == null || typeof (obj) != 'object')
            return obj;
        var temp = obj.constructor();
        for (var key in obj) {
            temp[key] = Clone(obj[key]);
        }
        return temp;
    };

    //"Hello {name}".format({ name: 'World' })
    //"Hello {0}".format({ 0: 'World' })
    String.prototype.format = function (args) {
        var newStr = this;
        for (var key in args) {
            newStr = newStr.replace('{' + key + '}', args[key]);
        }
        return newStr;
    };

    String.prototype.ReplaceAll = function (oldTxt, newTxt) {
        var newStr = this;
        do {
            newStr = newStr.replace(oldTxt, newTxt);
        } while (newStr.indexOf(oldTxt) >= 0);
        return newStr;
    };

    String.prototype.CodificarHtmlToAnsi = function () {
        var newStr = this;
        var ansi = new Array('Á', 'á', 'É', 'é', 'Í', 'í', 'Ó', 'ó', 'Ú', 'ú', '<', '>', "'");
        var html = new Array('&#193;', '&#225;', '&#201;', '&#233;', '&#205;', '&#237;', '&#211;', '&#243;', '&#218;', '&#250;', '&lt;', '&gt;', '&#39;');
        for (var i = 0; i < html.length; i++) {
            newStr = newStr.ReplaceAll(html[i], ansi[i]);
        }
        return newStr;
    };

    Right = function (str, n) {
        if (n <= 0)
            return "";
        else if (n > String(str).length)
            return str;
        else {
            var iLen = String(str).length;
            return String(str).substring(iLen, iLen - n);
        }
    };

    Left = function (str, n) {
        if (n <= 0)
            return "";
        else if (n > String(str).length)
            return str;
        else
            return String(str).substring(0, n);
    };

    Array.prototype.Find = function (campo, valor) {
        var array = new Array();
        var campoVal = $.trim(campo);
        if (campoVal == "") {
            $.each(this, function (index, item) {
                if (item == valor) {
                    try {
                        array.push(Clone(item));
                    } catch (e) {
                        array.push(item);
                    }
                }
            });
            return array;
        }
        $.each(this, function (index, item) {
            if (typeof (campo) == "string") {
                if (item[campo] == valor) {
                    try {
                        array.push(Clone(item));
                    } catch (e) {
                        array.push(item);
                    }
                }
            }
            else if (typeof (campo) == "object") {
                if (JSON.stringify(item) == JSON.stringify(campo)) {
                    try {
                        array.push(Clone(item));
                    } catch (e) {
                        array.push(item);
                    }
                }
            }

        });
        return array;
    };
    HandlebarsRegisterHelper = function () {
        if (typeof (Handlebars) != "undefined") {

            Handlebars.registerHelper('if_eq', function (a, b, opts) {
                if (a == b) {
                    return opts.fn(this);
                } else {
                    return opts.inverse(this);
                }
            });

            Handlebars.registerHelper('iff', function (a, operator, b, opts) {
                var bool = false;
                switch (operator) {
                    case '==':
                        bool = a == b;
                        break;
                    case '!=':
                        bool = a != b;
                        break;
                    case '>':
                        bool = a > b;
                        break;
                    case '<':
                        bool = a < b;
                        break;
                    case 'Contains':
                        bool = a.indexOf(b) >= 0;
                        break;
                    case 'ContainsArray':
                        var array = (JSON.parse(b) instanceof Array) ? JSON.parse(b) : [b];
                        bool = array.Find(null, a).length > 0;
                        break;
                    default:
                        throw "Unknown operator " + operator;
                }

                return bool ? opts.fn(this) : opts.inverse(this);
            });

            Handlebars.registerHelper('IsNullOrEmpty', function (a, operator, opts) {
                var bool = false;
                var optsx = opts == undefined ? operator : opts; // caso #IsNullOrEmpty campo
                operator = opts == undefined ? '==' : (operator || '==');
                opts = optsx;
                switch (operator) {
                    case '==':
                        bool = $.trim(a) == "";
                        break;
                    case '!=':
                        bool = $.trim(a) != "";
                        break;
                    default:
                        throw "Unknown operator " + operator;
                }

                return bool ? opts.fn(this) : opts.inverse(this);
            });

            Handlebars.registerHelper('Replace', function (cadena, oldValue, newValue, opts) {
                cadena = cadena || "";
                cadena = cadena.ReplaceAll(oldValue, newValue);
                return new Handlebars.SafeString(cadena).string;
            });

            Handlebars.registerHelper('Split', function (cadena, separador, pos, opts) {
                cadena = cadena || "";
                var listCade = cadena.split(separador);
                pos = pos || 0;
                if (pos >= 0) {
                    pos = pos >= listCade.length ? listCade.length - 1 : pos < 0 ? 0 : pos;
                    return new Handlebars.SafeString(listCade[pos]);
                }
                return new Handlebars.SafeString("");
            });

            Handlebars.registerHelper('JSON2string', function (context) {
                return JSON.stringify(context);
            });

            Handlebars.registerHelper('UpperCase', function (context) {
                return context.toUpperCase();
            });

            Handlebars.registerHelper('DecimalToStringFormat', function (context) {
                return DecimalToStringFormat(context);
            });

            Handlebars.registerHelper('DateTimeToStringFormat', function (context) {
                if (context != null && context != '') {
                    var dateString = context.substr(6);
                    var currentTime = new Date(parseInt(dateString));
                    var month = currentTime.getMonth() + 1;
                    var day = currentTime.getDate();
                    var year = currentTime.getFullYear();
                    var date = (day < 10 ? "0" + day : day) + "/" + (month < 10 ? "0" + month : month) + "/" + year;
                    return date;
                } else {
                    return "Fomato Incorrecto";
                }
            });
        }
    }

    SetHandlebars = function (idTemplate, data, idHtml) {
        if (!Handlebars.helpers.iff)
            HandlebarsRegisterHelper();

        if ($(idTemplate).length == 0) {
            return false;
        }

        var source = $(idTemplate).html();
        var template = Handlebars.compile(source);
        var htmlDiv = template(data);
        idHtml = $.trim(idHtml);
        if (idHtml == "") return htmlDiv;
        $(idHtml).html(htmlDiv);
        return "";
    }

    SetFormatDecimalPais = function (miles, decimal, decimalCantidad) {
        if (miles != undefined && decimal == undefined && decimalCantidad == undefined) {
            var listaDatos = miles.split("|");
            if (listaDatos.length < 2)
                return new Object();

            miles = listaDatos.length > 0 ? listaDatos[0] : "";
            decimal = listaDatos.length > 1 ? listaDatos[1] : "";
            decimalCantidad = listaDatos.length > 2 ? listaDatos[2] : "";
        }


        formatDecimalPais = formatDecimalPais || new Object();
        formatDecimalPais.miles = miles || ",";
        formatDecimalPais.decimal = decimal || ".";
        formatDecimalPais.decimalCantidad = decimalCantidad || 2;
    }

    IsDecimalExist = function (p_decimalNumber) {
        var l_boolIsExist = true;

        if (p_decimalNumber % 1 == 0)
            l_boolIsExist = false;

        return l_boolIsExist;
    }

    DecimalToStringFormat = function (monto, noDecimal) {
        formatDecimalPais = formatDecimalPais || new Object();
        noDecimal = noDecimal || false;
        var decimal = formatDecimalPais.decimal || ".";
        var decimalCantidad = noDecimal ? 0 : formatDecimalPais.decimalCantidad;
        var miles = formatDecimalPais.miles || ",";

        monto = monto || 0;
        var montoOrig = parseFloat($.trim(monto)) == NaN ? "0" : $.trim(monto);

        decimalCantidad = parseInt(decimalCantidad) == NaN ? 0 : parseInt(decimalCantidad);

        var pEntera = $.trim(parseInt(montoOrig));
        var pDecimal = $.trim((parseFloat(montoOrig) - parseFloat(pEntera)).toFixed(decimalCantidad));
        pDecimal = pDecimal.length > 1 ? pDecimal.substring(2) : "";
        pDecimal = decimalCantidad > 0 ? (decimal + pDecimal) : "";

        // recorremos la parte entera para poner el separador
        var pEnteraFinal = "";
        do {
            var x = pEntera.length;
            var sub = pEntera.substring(x, x - 3);
            pEnteraFinal = (pEntera == sub ? sub : (miles + sub)) + pEnteraFinal;
            pEntera = pEntera.substring(x - 3, 0);

        } while (pEntera.length > 0);

        return pEnteraFinal + pDecimal;
    }

    $(document).scroll(function () {
        try {
            $(".loadingScreenWindow").css("top", (($(window).height() / 2) + $(document).scrollTop() - $(".loadingScreenWindow").height()) + "px");
        } catch (e) { }        
    });
    
    RemoverRepetidos = function (lista, campo) {
        campo = $.trim(campo);
        var newLista = new Array();
        var arrAux = new Array();
        $.each(lista, function (ind, item) {
            arrAux = new Array();
            if (campo != "") {
                arrAux = newLista.Find(campo, item[campo]);
            }
            else {
                arrAux = newLista.Find(item)
            }
            if (arrAux.length == 0) {
                try {
                    newLista.push(Clone(item));
                } catch (e) {
                    newLista.push(item);
                }
            }
        });

        return newLista;
    };

})(jQuery);

function showDialog(dialogId) {
    $("#" + dialogId).dialog("open");
    $("#ui-datepicker-div").css("z-index", "9999");
    return false;
}
function HideDialog(dialogId) {
    $("#" + dialogId).dialog("close");
    return false;
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function CreateLoading() {
    $("#loadingScreen").append("<div class='loadingScreen-titulo'></div>");
    $("#loadingScreen").append("<div class='loadingScreen-mensaje'></div>");

    $("#loadingScreen").dialog({
        autoOpen: false,
        dialogClass: "loadingScreenWindow",
        closeOnEscape: false,
        draggable: false,
        width: 350,
        minHeight: 50,
        modal: true,
        buttons: {},
        resizable: false,
        //create: function (event, ui) {
        //    $("html").css({ overflow: 'hidden' })
        //},
        //beforeClose: function (event, ui) {
        //    $("html").css({ overflow: 'auto' })
        //}
    });
    $("#loadingScreen").parent().find(".ui-dialog-titlebar").hide();
}

function waitingDialog(waiting) {
    if (!$("#loadingScreen")) {
        $(document.body).append('<div id="loadingScreen"></div>');
    }
    else if ($("#loadingScreen").length == 0) {
        $(document.body).append('<div id="loadingScreen"></div>');
    }

    if (!$("#loadingScreen").hasClass('ui-dialog-content')) {
        if ($("#loadingScreen").attr("data-dialog") != "1") {
            CreateLoading();
            $("#loadingScreen").attr("data-dialog", "1");
        }
    }
    waiting = waiting || {};
    $("#loadingScreen").find(".loadingScreen-titulo").html(waiting.title && '' != waiting.title ? waiting.title : 'Cargando');
    $("#loadingScreen").find(".loadingScreen-mensaje").html(waiting.message && '' != waiting.message ? waiting.message : 'Espere, por favor...');
    try {
        $("#loadingScreen").dialog("open");
    }
    catch (err) {

    }
}
function closeWaitingDialog() {
    try { $("#loadingScreen").dialog('close'); }
    catch (err) {
    }

}

function compare_dates(fecha, fecha2) {

    var xMonth = fecha.substring(3, 5);
    var xDay = fecha.substring(0, 2);
    var xYear = fecha.substring(6, 10);
    var yMonth = fecha2.substring(3, 5);
    var yDay = fecha2.substring(0, 2);
    var yYear = fecha2.substring(6, 10);
    if (xYear > yYear) {
        return (true)
    }
    else {
        if (xYear == yYear) {
            if (xMonth > yMonth) {
                return (true)
            }
            else {
                if (xMonth == yMonth) {
                    if (xDay > yDay)
                        return (true);
                    else
                        return (false);
                }
                else
                    return (false);
            }
        }
        else
            return (false);
    }
}

function IsValidUrl(value) {
    var matcher = /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/gi;

    var match = value.match(matcher)
    if (match)
        return true;
    else
        return false;
}

function isInt(n) {
    var patron = /^[0-9]+$/;
    var isn = patron.test(n);
    return isn;
    //return +n === n && !(n % 1);
}

// valida si ha ocurrido un timeout durante una llamada ajax
function checkTimeout(data) {

    if (data) {
        if (data.responseText) {
            if ((data.responseText.indexOf('<input type="hidden" id="PaginaLogin" />') > -1) || (data.responseText.indexOf('<input type="hidden" id="PaginaSesionExpirada" />') > -1) || (data.responseText === '"_Logon_"'))
                thereIsStillTime = false;
        }
        else {
            if (data == "_Logon_")
                thereIsStillTime = false;
        }

        if (!thereIsStillTime) {
            //window.location.href = "/Login/SesionExpirada";
            
            var message = "Tu sesión ha finalizado por inactividad. Por favor, ingresa nuevamente.";
            if (ViewBagEsMobile == 1) {/*1 Desktop, 2 Mobile*/
                $('#dialog_SesionMainLayout #mensajeSesionSB2_Error').html(message);
                $('#dialog_SesionMainLayout').show();
        }
            else {
                $('#popupInformacionSB2SesionFinalizada').find('#mensajeInformacionSB2_SesionFinalizada').text(message);
                $('#popupInformacionSB2SesionFinalizada').show();
    }
        }
    }
    else {
        // validar si se perdio la sesion
        checkUserSession();
    }
    return thereIsStillTime;
}

/*EPD-180*/
function checkUserSession() {
    var res = -1;
    
    $.ajax({
        url: '/Login/CheckUserSession',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            res = data.Exists;
        }
    });

    //alert(res);
    if (res == 0) {
        window.location.href = '/Login/SesionExpirada';
    }
}
/*EPD-180*/

// paginacion
function paginadorAccionGenerico(obj) {
    var accion = obj.attr("data-paginacion");
    var padre = obj.parents('[data-paginacion="block"]');
    var paginaActual = padre.find("[data-paginacion='page']").val() || 1;
    var paginaActualCambio = padre.find("[data-paginacion='page']").val() || 1;
    var rows = padre.find("[data-paginacion='rows'] > option:selected").val() || 0;
    var pageCount = padre.find("[data-paginacion='pageCount']").html() || 0;
    var recordCount = padre.find("[data-paginacion='recordCount']").html() || 0;

    pageCount = parseInt(pageCount, 10);
    paginaActual = parseInt(paginaActual, 10);

    pageCount = pageCount <= 0 ? 1 : pageCount;
    paginaActual = paginaActual <= 0 ? 1 : paginaActual;

    var rpt = new Object();
    rpt.estado = 0;

    if (accion === "back") {
        if (paginaActual === 1) {
            return rpt;
        }
        paginaActual = paginaActual - 1;
    }
    else if (accion === "next") {
        if (paginaActual === pageCount) {
            return rpt;
        }
        paginaActual = paginaActual + 1;
    }
    else if (accion === "page") {
        if (paginaActualCambio <= 0 || paginaActualCambio >= pageCount) {
            var inicio = padre.find("[data-paginacion='page']").attr("data-val");
            padre.find("[data-paginacion='page']").val(inicio);
            return rpt;
        }
    }
    else if (accion === "rows") {
        //if (paginaActual === 1) {
        //    var rowsInicial =padre.find("[data-paginacion='rows']").attr("data-val") || 0;
        //    if (recordCount <= rowsInicial && rowsInicial < rows) {
        //        padre.find("[data-paginacion='rows']").attr("data-val", rows);
        //        return rpt;
        //    }
        //}
        paginaActual = 1;
    }

    paginaActual = paginaActual > pageCount ? pageCount : paginaActual;

    rpt.estado = 1;
    rpt.rows = rows;
    rpt.accion = accion;
    rpt.page = paginaActual;
    return rpt;
}
//R2116-INICIO

function ActualizarGanancia(data) {
    data = data || new Object();
    data.CantidadProductos = data.CantidadProductos || "";
    data.TotalPedidoStr = data.TotalPedidoStr || "";

    // Los Montos resumen de pedido
    $("[data-ganancia]").html(data.MontoGananciaStr || "");
    $("[data-ganancia2]").html(vbSimbolo + " " + data.MontoGananciaStr || "");
    $("[data-pedidocondescuento]").html(DecimalToStringFormat(data.TotalPedido - data.MontoDescuento));
    //$("[data-montodescuento]").html(vbSimbolo + (data.MontoDescuento == 0 ? " " : " -") + data.MontoDescuentoStr);
    $("[data-montodescuento]").html(vbSimbolo + " " + data.MontoDescuentoStr);
    $("[data-pedidototal]").html(vbSimbolo + " " + data.TotalPedidoStr);
    $("[data-cantidadproducto]").html(data.CantidadProductos);
    $("[data-montoahorrocatalogo]").html(vbSimbolo + " " + data.MontoAhorroCatalogoStr);
    $("[data-montoahorrorevista]").html(vbSimbolo + " " + data.MontoAhorroRevistaStr);

    $(".num-menu-shop").html(data.CantidadProductos);
    $(".js-span-pedidoingresado").html(data.TotalPedidoStr);

    setTimeout(function () {
        $('.num-menu-shop').addClass('microefecto_color');
        $('[data-cantidadproducto]').parent().addClass('microefecto_color');
        $('[data-pedidocondescuento]').parent().addClass('microefecto_color');
        $('#lblProductosResumen').addClass('microefecto_color');
        $('#lblTotalResumen').addClass('microefecto_color');
        setTimeout(function () {
            $('.num-menu-shop').removeClass('microefecto_color');
            $('[data-cantidadproducto]').parent().removeClass('microefecto_color');
            $('[data-pedidocondescuento]').parent().removeClass('microefecto_color');
            $('#lblProductosResumen').removeClass('microefecto_color');
            $('#lblTotalResumen').removeClass('microefecto_color');
        }, 5000);
    }, 500);
}

FuncionesGenerales = {
    containsObject: function (obj, array) {
        var i;
        for (i = 0; i < array.length; i++) {
            if (array[i] === obj) {
                return true;
            }
        }

        return false;
    },
    ValidarSoloNumeros: function (e) {
        var tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 8) return true;
        var patron = /[0-9]/;
        var te = String.fromCharCode(tecla);
        return patron.test(te);
    },

    ValidarSoloNumerosAndSpecialCharater: function (e) {
        var tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 8) return true;
        var patron = /[0-9-\-]/;
        var te = String.fromCharCode(tecla);
        return patron.test(te);
    },
    GetDataForm: function (form) {
        var that = $(form);
        var url = that.attr('action');
        var type = that.attr('method');
        var data = {};

        that.find('[name]').each(function (index, value) {
            var that = $(this);
            var name = that.attr('name');
            var value = that.val();

            if (that.attr('type') == 'radio') {
                if (that.is(':checked')) {
                    if (data[name] == null) {
                        data[name] = value;
                    }
                }
            }
            if (that.attr('type') == 'checkbox') {
                if (that.is(':checked')) {
                    if (data[name] == null) {
                        data[name] = value;
                    }
                }
            } else {
                if (data[name] == null) {
                    data[name] = value;
                }
            }
        });

        var obj = {
            url: url,
            type: type,
            data: data
        };

        return obj;
    }
};
//R2116-FIN

function InsertarLogDymnamo(pantallaOpcion, opcionAccion, esMobile, extra) {
    data = {
        'Fecha': '',
        'Aplicacion': userData.aplicacion,
        'Pais': userData.pais,
        'Region': userData.region,
        'Zona': userData.zona,
        'Seccion': userData.seccion,
        'Rol': userData.rol,
        'Campania': userData.campana,
        'Usuario': userData.codigoConsultora,
        'PantallaOpcion': pantallaOpcion,
        'OpcionAccion': opcionAccion,
        'DispositivoCategoria': esMobile ? 'MOBILE' : 'WEB',
        'DispositivoID': '',
        'Version': '2.0',
        'Extra': extra
    }
    if (urlLogDynamo != "") {
        jQuery.ajax({
            type: "POST",
            async: true,
            crossDomain: true,
            url: urlLogDynamo,
            dataType: "json",
            data: data,
            success: function (result) { console.log(result); },
            error: function (x, xh, xhr) { console.log(x); }
        });
    }
}

function InfoCommerceGoogleDestacadoProductClick(name, id, category, variant, position) {

    if (variant == null || variant == "") {
        variant = "Estándar";
    }
    if (category == null || category == "") {
        category = "Sin Categoría";
    }

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': 'Productos destacados', 'action': 'click' },
                'products': [{
                    'name': name,
                    'id': id,
                    'category': category,
                    'variant': variant,
                    'position': position
                }]
            }
        }
    });
};

// Pedido Rechazado
function MensajeEstadoPedido() {
    xMensajeEstadoPedido(false);
    if (mostrarBannerRechazo != 'True' || cerrarRechazado == '1') return false;

    xMensajeEstadoPedido(true);
    MostrarMensajePedidoRechazado();
    return true;
}

function xMensajeEstadoPedido(estado) {
    var url = location.href.toLowerCase();
    var esMobile = url.indexOf("/mobile/") > 0;
    var esBienvenida = url.indexOf("/bienvenida") > 0;

    if (estado) {
    var wheight = $(window).innerHeight();
        $("#bloquemensajesPedido").show();//.slideDown("slow", function () { });
        ResizeMensajeEstadoPedido();
        var wtop = $("#bloquemensajesPedido").height();

        if (esMobile) {
            $("[data-content]").animate({ "top": wtop + "px" });
            $(".footer-page").animate({ "top": wtop + "px" });
            $(".oscurecer_animacion").css({ "display": "none" });
        }
        else {
            if (esBienvenida) {
                $(".oscurecer_animacion").css({ "top": wtop + "px", "height": wheight + "px" });
                //$("[data-content]").animate({ "top": wtop + "px" });               
            }
            else {
                $(".oscurecer_animacion").css({ "display": "none" });
                $("#bloquemensajesPedido").slideDown("slow", function () { });
                wtop = $("header").height();
                $(".ubicacion_web").animate({ "margin-top": (wtop + 22) + "px" });
            }
        }
    }
    else {
        $("#bloquemensajesPedido").slideUp();
        if (esMobile) {
            $("[data-content]").animate({ "top": "0px" });
            $(".footer-page").animate({ "top": "0px" });
        }
        else {
            if (esBienvenida) {                
                if (mostrarBannerRechazo != 'True' || cerrarRechazado == '1') $("[data-content]").animate({ "top": "0px" });
                else $("[data-content]").animate({ "top": "64px" });
            }
            else $(".ubicacion_web").animate({ "margin-top": "83px" });
        }
    }
}

function ResizeMensajeEstadoPedido() {

    $("#bloquemensajesPedido").css("height", "");
    $("#bloquemensajesPedido > div").css("height", "");
    $("#bloquemensajesPedido .mensajes_estadoPedido").css("width", "");

    var wt = $(window).width() - ($("#bloquemensajesPedido .icono_cerrar_mensaje").width() + $("#bloquemensajesPedido .icono_estadoPedido").width());
    var pad = parseInt($.trim($("#bloquemensajesPedido .bloque_mensajesPedido").css("padding-left")).replace("px", "")) + parseInt($.trim($("#bloquemensajesPedido .bloque_mensajesPedido").css("padding-right")).replace("px", ""));
    wt = wt - pad;
    var wtx = $("#bloquemensajesPedido .mensajes_estadoPedido").width();
    if (wtx > wt) {
        $("#bloquemensajesPedido .mensajes_estadoPedido").css("width", (wt - 13) + "px");
    }

    var ht = $("#bloquemensajesPedido").height() - 22;
    var htx = $("#bloquemensajesPedido .mensajes_estadoPedido").height();
    if (htx > ht) {
        $("#bloquemensajesPedido").css("height", (htx + 22) + "px");
        $("#bloquemensajesPedido > div").css("height", (htx + 22) + "px");
    }
    else {
        $("#bloquemensajesPedido").css("height", (ht + 22) + "px");
        $("#bloquemensajesPedido > div").css("height", (ht + 22) + "px");
    }

    if (htx == 38) {

        $("#bloquemensajesPedido .mensajes_estadoPedido").css("padding-top", (9) + "px");
        $("#bloquemensajesPedido .icono_estadoPedido").css("padding-top", (5) + "px");
    }
}

function cerrarMensajeEstadoPedido() {
    $.ajax({
        type: 'Post',
        url: baseUrl + 'Bienvenida/CerrarMensajeEstadoPedido',
        data: '',
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            cerrarRechazado = data || '0';
            MensajeEstadoPedido();
        },
        error: function (data, error) {
            cerrarRechazado = '0';
        }
    });
}

function MostrarMensajePedidoRechazado() {
    if (location.pathname.toLowerCase().indexOf("/bienvenida") >= 0) {
        $(".oscurecer_animacion").delay(3000).fadeOut(1500);
    }
    else {
        // $(".oscurecer_animacion").hide();
        $("[data-content]").removeClass("oscurecer_animacion");
    }
}

// FIN Pedido Rechazado


// Compartir Face y WS

function CompartirRedesSociales(e) {
    var obj = $(e.target);
    var tipoRedes = $.trim($(obj).parents("[data-compartir]").attr("data-compartir"));
    if (tipoRedes == "") tipoRedes = $.trim($(obj).attr("data-compartir"));
    if (tipoRedes == "") return false;

    var padre = obj.parents("[data-item]");
    var article = $(padre).find("[data-compartir-campos]").eq(0);

    var label = $(article).find(".rs" + tipoRedes + "Mensaje").val();
    var ruta = $(article).find(".rs" + tipoRedes + "Ruta").val();

    if (label != "") {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Ofertas Showroom',
            'action': 'Compartir ' + tipoRedes,
            'label': label,
            'value': 0
        });
    }

    if (ruta == "") return false;

    CompartirRedesSocialesInsertar(article, tipoRedes, ruta);
}

function CompartirRedesSocialesAbrirVentana(id, tipoRedes, ruta, texto) {
    id = $.trim(id);
    if (id == "0" || id == "")
        return false;
    ruta = $.trim(ruta);
    if (ruta == "") return false;

    ruta = ruta.replace('[valor]', id);

    if (tipoRedes == "FB") {
        var popWwidth = 570;
        var popHeight = 420;
        var left = (screen.width / 2) - (popWwidth / 2);
        var top = (screen.height / 2) - (popHeight / 2);
        var url = "http://www.facebook.com/sharer/sharer.php?u=" + ruta;
        window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
    } else if (tipoRedes == "WA") {
        ruta = ruta.ReplaceAll('/', '%2F');
        ruta = ruta.ReplaceAll(":", "%3A");
        ruta = ruta.ReplaceAll("?", "%3F");
        ruta = ruta.ReplaceAll("=", "%3D");

        if (texto != "")
            texto = texto + " - ";
        texto = texto.ReplaceAll("/", '%2F');
        texto = texto.ReplaceAll(":", "%3A");
        texto = texto.ReplaceAll("?", "%3F");
        texto = texto.ReplaceAll("=", "%3D");
        texto = texto.ReplaceAll(" ", "%32");
        texto = texto.ReplaceAll("+", "%43");
    }

    return "whatsapp://send?text=" + texto + ruta;
}

function CompartirRedesSocialesInsertar(article, tipoRedes, ruta) {
    //AbrirLoad();

    //Capturando valores
    var _rutaImagen = $.trim($(article).find(".rs" + tipoRedes + "RutaImagen").val());
    var _mensaje = $.trim($(article).find(".rs" + tipoRedes + "Mensaje").val());
    var _nombre = $.trim($(article).find(".Nombre").val());
    var _marcaID = $.trim($(article).find(".MarcaID").val());
    var _marcaDesc = $.trim($(article).find(".MarcaNombre").val());
    var _descProd = $.trim($(article).find(".ProductoDescripcion").val());
    var _vol = $.trim($(article).find(".Volumen").val());
    var _palanca = $.trim($(article).find(".Palanca").val());

    var pcDetalle = _rutaImagen + "|" + _marcaID + "|" + _marcaDesc + "|" + _nombre;
    if (_palanca == "FAV") {
        pcDetalle += "|" + _vol + "|" + _descProd;
    }

    var Item = {
        mCUV: $(article).find(".CUV").val(),
        mPalanca: _palanca,
        mDetalle: pcDetalle,
        mApplicacion: tipoRedes
    };

    jQuery.ajax({
        type: 'POST',
        url: "/CatalogoPersonalizado/InsertarProductoCompartido",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(Item),
        success: function (response) {
            //CloseLoading();
            if (checkTimeout(response)) {
                if (response.success) {
                    CompartirRedesSocialesAbrirVentana(response.data.id, tipoRedes, ruta, _mensaje);
                } else {
                    window.messageInfo(response.message);
                }
            }
            //CerrarLoad();
        },
        error: function (response, error) {
            //CloseLoading();
            if (checkTimeout(response)) {
                console.log(response);
            }
        }
    });
}

function CompartirWsp(UrlBase, objParameter) {
    var _id = InsertarProductoCompartido(objParameter, 'W');
    UrlBase = UrlBase.replace("[valor]", _id);

    UrlBase = UrlBase.ReplaceAll('/', '%2F');
    UrlBase = UrlBase.ReplaceAll(":", "%3A");
    UrlBase = UrlBase.ReplaceAll("?", "%3F");
    UrlBase = UrlBase.ReplaceAll("=", "%3D");

    return "whatsapp://send?text=" + UrlBase;
}

function CompartirFacebook(urlBase, objParameter) {
    urlBase = $.trim(urlBase);
    if (urlBase == "") 
        return false;
    
    var _id = InsertarProductoCompartido(objParameter, 'F');
    if ($.trim(_id) == "0" || $.trim(_id) == "")
        return false;
    
    urlBase = urlBase.replace('[valor]', _id);

    var popWwidth = 570;
    var popHeight = 420;
    var left = (screen.width / 2) - (popWwidth / 2);
    var top = (screen.height / 2) - (popHeight / 2);
    var url = "http://www.facebook.com/sharer/sharer.php?u=" + urlBase;

    window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
}

function InsertarProductoCompartido(objParameter, app) {
    //Capturando valores
    var _rutaImagen = objParameter.RutaImagen;
    var _marcaID = $.trim(objParameter.MarcaID);
    var _marcaDesc = $.trim(objParameter.MarcaDesc);
    var _nombre = $.trim(objParameter.NombrePro);
    var _vol = $.trim(objParameter.Volumen);
    var _descProd = $.trim(objParameter.DescProducto);

    var pcDetalle = _rutaImagen + "|" + _marcaID + "|" + _marcaDesc + "|" + _nombre;
    if (objParameter.Palanca == "FAV") {
        pcDetalle += "|" + _vol + "|" + _descProd;
    }

    var ID = 0;
    var Item = {
        mCUV: objParameter.Cuv,
        mPalanca: objParameter.Palanca,
        mDetalle: pcDetalle,
        mApplicacion: app
    };

    jQuery.ajax({
        type: 'POST',
        url: "/CatalogoPersonalizado/InsertarProductoCompartido",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(Item),
        async: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    var datos = response.data;
                    ID = datos.id;
                } else {
                    window.messageInfo(response.message);
                }
            }
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                console.log(response);
            }
        }
    });
    return ID;
}

// Compartir Face
