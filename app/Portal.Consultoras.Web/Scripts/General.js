
var formatDecimalPais = formatDecimalPais || new Object();
var finishLoadCuponContenedorInfo = false;
var belcorp = belcorp || {};
belcorp.settings = belcorp.settings || {}
belcorp.settings.uniquePrefix = "/g/";

jQuery(document).ready(function () {
    CreateLoading();

    redimensionarMenusTabs();


    $("header").resize(function () {
        LayoutMenu();
    });

    if (typeof (tokenPedidoAutenticoOk) !== 'undefined') {
        GuardarIndicadorPedidoAutentico();
    }

    if (isMobile()) {
        var posibleGuid = getMobilePrefixUrl().substring(belcorp.settings.uniquePrefix.length);
        if (FuncionesGenerales.IsGuid(posibleGuid)) {
            $.ajaxSetup({
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("guid", posibleGuid);
                }
            });

            $.ajaxPrefilter(function (options) {
                if (!options.beforeSend) {
                    options.beforeSend = function (xhr) {
                        xhr.setRequestHeader("guid", posibleGuid);
                    }
                }
            });
        }
    }

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

    $.fn.CleanWhitespace = function () {
        var textNodes = this.contents().filter(
            function () { return (this.nodeType == 3 && !/\S/.test(this.nodeValue)); })
            .remove();
        return this;
    }

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

    String.prototype.SubStrToMax = function (max, removeStrFinLength, strFin) {
        if (this.length <= max) return this;

        strFin = IfNull(strFin, '') == '' ? '...' : strFin;
        var removeLength = IfNull(removeStrFinLength, false) ? strFin.length : 0;
        return this.substr(0, max - removeLength) + strFin;
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

    if (!String.prototype.startsWith) {
        String.prototype.startsWith = function (stringBuscada, posicion) {
            posicion = posicion || 0;
            return this.indexOf(stringBuscada, posicion) === posicion;
        };
    }

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
                var ret = false;

                switch (b) {
                    case undefined:
                    case null:
                        ret = typeof a == "boolean";
                        bool = ret ? a : false;
                        ret = true;
                        break;
                    default: break;
                }

                if (ret)
                    return bool ? operator.fn(this) : operator.inverse(this);


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
                var optsx = opts == undefined ? operator : opts;
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

            Handlebars.registerHelper('EscapeSpecialChars', function (textoOrigen) {
                textoOrigen = textoOrigen.replace(/'/g, "\\'");
                return new Handlebars.SafeString(textoOrigen);
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

            Handlebars.registerHelper('Trim', function (cadena) {
                cadena = $.trim(cadena);
                return new Handlebars.SafeString(cadena);
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
            
            Handlebars.registerHelper('ImgSmall', function (imgOriginal) {
                var urlRender = ImgUrlRender(imgOriginal, variablesPortal.ExtensionImgSmall);
                return new Handlebars.SafeString(urlRender);
            });

            // por si en un futuro se puede utilizar
            //Handlebars.registerHelper('ImgMedium', function (imgOriginal) {
            //    var urlRender = ImgUrlRender(imgOriginal, variablesPortal.ExtensionImgMedium);
            //    return new Handlebars.SafeString(urlRender);
            //});
            
            Handlebars.registerHelper('ImgUrl', function (imgOriginal) {
                var urlRender = ImgUrlRender(imgOriginal);
                return new Handlebars.SafeString(urlRender);
            });
            
            Handlebars.registerHelper('SimboloMoneda', function () {
                var simbMon = variablesPortal.SimboloMoneda || "";
                return new Handlebars.SafeString(simbMon);
            });
        }
    }

    SetHandlebarsHtml = function (urlTemplate, modelo, idHtml) {
        if (!Handlebars.helpers.iff)
            HandlebarsRegisterHelper();

        if ($.trim(urlTemplate) == "" || $.trim(idHtml) == "") {
            return false;
        }
        
        jQuery.get(urlTemplate, function (dataTemplate) {
            dataTemplate = $.trim(dataTemplate);

            if (dataTemplate == "") {
                return false;
            }

            if (dataTemplate.substr(0, 2) == "/*") {
                dataTemplate = dataTemplate.substr(2, dataTemplate.length - 2);
            }

            if (dataTemplate.substr(dataTemplate.length - 2, 2) == "*/") {
                dataTemplate = dataTemplate.substr(0, dataTemplate.length - 2);
            }

            var template = Handlebars.compile(dataTemplate);
            var htmlDiv = template(modelo);
            idHtml = $.trim(idHtml);
            if (idHtml == "") return htmlDiv;
            $(idHtml).html(htmlDiv);
        });

        return "";

    }
    SetHandlebars = function (idTemplate, data, idHtml) {                                               
        if (!Handlebars.helpers.iff)
            HandlebarsRegisterHelper();

        if ($(idTemplate).length === 0 || typeof data === "undefined") {

            return false;
        }

        var source = $(idTemplate).html();
        var template = Handlebars.compile(source);
        var htmlDiv = template(data);
        idHtml = typeof idHtml === "string" ? $.trim(idHtml) : idHtml;
        if (idHtml == "" || $(idHtml).length === 0) return htmlDiv;
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
        var decimalCantidad = noDecimal ? 0 : (formatDecimalPais.decimalCantidad || 0 );
        var miles = formatDecimalPais.miles || ",";

        monto = monto || 0;
        var montoOrig = isNaN($.trim(monto)) ? "0" : $.trim(monto);

        decimalCantidad = isNaN(decimalCantidad) ? 0 : parseInt(decimalCantidad);

        var pEntera = $.trim(parseInt(montoOrig));
        var pDecimal = $.trim((parseFloat(montoOrig) - parseFloat(pEntera)).toFixed(decimalCantidad));
        pDecimal = pDecimal.length > 1 ? pDecimal.substring(2) : "";
        pDecimal = decimalCantidad > 0 ? (decimal + pDecimal) : "";

        var pEnteraFinal = "";
        do {
            var x = pEntera.length;
            var sub = pEntera.substring(x, x - 3);
            pEnteraFinal = (pEntera == sub ? sub : (miles + sub)) + pEnteraFinal;
            pEntera = pEntera.substring(x - 3, 0);

        } while (pEntera.length > 0);

        return pEnteraFinal + pDecimal;
    }

    IsNullOrEmpty = function (texto) { return texto == null || texto === ''; }

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
                arrAux = newLista.Find(item);
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

function redimensionarMenusTabs() {
    var total_menu_contenedor = $(".bc_para_ti-menu ul li").size();

    if (total_menu_contenedor > 2) {
        $('.bc_para_ti-menu ul li').addClass('fix_menu_tabs_mobil_3');
    }
    else {
        $('.bc_para_ti-menu ul li').addClass('fix_menu_tabs_mobil_2');
    }
}

function ImgUrlRender(imgOriginal, tipo) {
    imgOriginal = $.trim(imgOriginal);
    if (imgOriginal === '') {
        return imgOriginal;
    }

    var urlRender = imgOriginal;
    var listaCadena = imgOriginal.split('.');
    if (listaCadena.length > 1) {
        var ext = listaCadena[listaCadena.length - 1];
        urlRender = imgOriginal.substr(0, imgOriginal.length - ext.length - 1);
        tipo = $.trim(tipo);
        urlRender = urlRender + tipo + '.' + ext;
    }

    if (imgOriginal.startsWith('http')) {
        return urlRender;
    }

    urlRender = variablesPortal.ImgUrlBase + urlRender;

    return urlRender;
}

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
        resizable: false
    });
    $("#loadingScreen").parent().find(".ui-dialog-titlebar").hide();
}


function printElement(selector) {
    var element = document.querySelector(selector);
    if (!element) {
        return;
    }
    var printContents = element.innerHTML;
    var originalContents = document.body.innerHTML;

    document.body.innerHTML = printContents;
    window.print();
    document.body.innerHTML = originalContents;
}

function waitingDialog(waiting) {
    try {
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

function AbrirLoad(opcion) {
    try {
        if (isMobile()) {
            ShowLoading(opcion);
        }
        else {
            waitingDialog(opcion);
        }
    } catch (e) {

    }
}

function CerrarLoad(opcion) {
    try {
        if (isMobile()) {
            CloseLoading(opcion);
        }
        else {
            closeWaitingDialog();
        }
    } catch (e) {

    }
}

function AbrirMensaje(mensaje, titulo, fnAceptar, tipoIcono) {
    try {
        mensaje = $.trim(mensaje);
        if (mensaje == "") {
            CerrarLoad();
            return false;
        }
        titulo = titulo || "MENSAJE";
        var CONS_TIPO_ICONO = { ALERTA: 1, CHECK: 2 };
        var isUrlMobile = isMobile();
        if (isUrlMobile > 0) {
            $('.icono_alerta').hide();
            if (tipoIcono == CONS_TIPO_ICONO.ALERTA) {
                $('.icono_alerta.exclamacion_icono_mobile').show();
            }
            if (tipoIcono == CONS_TIPO_ICONO.CHECK) {
                $('.icono_alerta.check_icono_mobile').show();
            }
            if (tipoIcono == undefined || tipoIcono == null) {
                $('.icono_alerta.exclamacion_icono_mobile').show();
            }
            $('#mensajeInformacionvalidado').html(mensaje);
            $('#popupInformacionValidado').show();
            $('#popupInformacionValidado #bTagTitulo').html(titulo);

            if ($.isFunction(fnAceptar)) {
                var botonesCerrar = $('#popupInformacionValidado .btn_ok_mobile,.cerrar_popMobile');
                botonesCerrar.off('click');
                botonesCerrar.on('click', fnAceptar);
            }
        }
        else {
            $('#alertDialogMensajes .terminos_title_2').html(titulo);
            $('#alertDialogMensajes .pop_pedido_mensaje').html(mensaje);
            $('#alertDialogMensajes').dialog('open');

            $('.ui-dialog .ui-button').off('click');
            $('.ui-dialog .ui-icon-closethick').off('click');

            $('.ui-dialog .ui-button').on('click', function () {
                $('#alertDialogMensajes').dialog('close');
                if ($.isFunction(fnAceptar)) fnAceptar();
            });

            $('.ui-dialog .ui-icon-closethick').on('click', function () {
                $('#alertDialogMensajes').dialog('close');
                if ($.isFunction(fnAceptar)) fnAceptar();
            });

            $('.ui-dialog .ui-button').focus();
        }
        CerrarLoad();
    } catch (e) {

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
    var match = value.match(matcher);
    return match;
}

function isMobile() {
    var isUrlMobile = $.trim(location.href.replace("#", "/") + "/").toLowerCase().indexOf("/mobile/") > 0 ||
        $.trim(location.href).toLowerCase().indexOf("/g/") > 0;
    return isUrlMobile;
}

function getMobilePrefixUrl() {
    var uniquePrefix = belcorp.settings.uniquePrefix;
    var currentUrl = $.trim(location.href).toLowerCase();
    var uniqueIndexOfUrl = currentUrl.indexOf(uniquePrefix);
    var isUniqueUrl = uniqueIndexOfUrl > 0;
    return isUniqueUrl ? currentUrl.substring(uniqueIndexOfUrl, uniqueIndexOfUrl + uniquePrefix.length + 36) : "/mobile";
}

function isPagina(pagina) {
    pagina = $.trim(pagina).toLowerCase();
    if (pagina == "") return false;
    return ("/" + $.trim(location.href).ReplaceAll(":", "/") + "/").toLowerCase().indexOf("/" + pagina + "/") > 0;
}

function isHome() {
    var isUrl = ($.trim(location.href) + "/").toLowerCase().indexOf("/bienvenida/") > 0;
    return isUrl;
}

function isInt(n) {
    var patron = /^[0-9]+$/;
    var isn = patron.test(n);
    return isn;
}

function checkTimeout(data) {
    var thereIsStillTime = true;

    if (data) {
        var evalText = data.responseText ? data.responseText : data;
        if (jQuery.type(evalText) === "string") {
            if ((evalText.indexOf('<input type="hidden" id="PaginaLogin" />') > -1) || (evalText.indexOf('<input type="hidden" id="PaginaSesionExpirada" />') > -1) || (evalText == '"_Logon_"'))
                thereIsStillTime = false;
        }

        if (!thereIsStillTime) {

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
        checkUserSession();
    }
    return thereIsStillTime;
}

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

    if (res == 0) {
        window.location.href = '/Login/SesionExpirada';
    }
}

function paginadorAccionGenerico(obj) {
    var accion = obj.attr("data-paginacion");
    var padre = obj.parents('[data-paginacion="block"]');
    var paginaActual = padre.find("[data-paginacion='page']").val() || 1;
    var paginaActualCambio = padre.find("[data-paginacion='page']").val() || 1;
    var rows = padre.find("[data-paginacion='rows'] > option:selected").val() || 0;
    var pageCount = padre.find("[data-paginacion='pageCount']").html() || 0;

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
        paginaActual = 1;
    }

    paginaActual = paginaActual > pageCount ? pageCount : paginaActual;

    rpt.estado = 1;
    rpt.rows = rows;
    rpt.accion = accion;
    rpt.page = paginaActual;
    return rpt;
}

function ActualizarGanancia(data) {
    data = data || new Object();
    data.CantidadProductos = data.CantidadProductos || "";
    data.TotalPedidoStr = data.TotalPedidoStr || "";

    $("[data-ganancia]").html(data.MontoGananciaStr || "");
    $("[data-ganancia2]").html(variablesPortal.SimboloMoneda + " " + data.MontoGananciaStr || "");
    $("[data-pedidocondescuento]").html(DecimalToStringFormat(data.TotalPedido - data.MontoDescuento));
    $("[data-montodescuento]").html(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(data.MontoDescuentoStr));
    $("[data-pedidototal]").html(variablesPortal.SimboloMoneda + " " + data.TotalPedidoStr);
    $("[data-cantidadproducto]").html(data.CantidadProductos);
    $("[data-montoahorrocatalogo]").html(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(data.MontoAhorroCatalogoStr));
    $("[data-montoahorrorevista]").html(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(data.MontoAhorroRevistaStr));

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
    ValidarSoloDecimalPositivo: function (event, element, validarDecimal) {
        event = event || window.event;
        var charCode = event.which || event.keyCode;
        if (charCode == 8 || charCode == 13 || (validarDecimal ? (element.value.indexOf('.') == -1 ? charCode == 46 : false) : false))
            return true;
        else if ((charCode < 48) || (charCode > 57))
            return false;
        return true;
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

        that.find('[name]').each(function (index, evalue) {
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
    },
    MaxLengthCheck: function (object, cantidadMaxima) {
        if (object.value.length > cantidadMaxima)
            object.value = object.value.slice(0, cantidadMaxima);
    },
    IsGuid: function (input) {
        var guidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
        return guidRegex.test(input);
    }
};

function InsertarLogDymnamo(pantallaOpcion, opcionAccion, esMobile, extra) {
    var dataNueva = {
        'Fecha': new Date().getTime(),
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
    };
    if (urlLogDynamo != "") {
        jQuery.ajax({
            type: "POST",
            async: true,
            crossDomain: true,
            url: urlLogDynamo + "Api/LogUsabilidad",
            dataType: "json",
            data: dataNueva,
            success: function (result) { },
            error: function (x, xh, xhr) { }
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
}

function MensajeEstadoPedido() {
    xMensajeEstadoPedido(false);
    if (mostrarBannerRechazo != 'True' || cerrarRechazado == '1') return false;

    xMensajeEstadoPedido(true);
    MostrarMensajePedidoRechazado();
    return true;
}

function xMensajeEstadoPedido(estado) {
    if (estado) {
        $("#bloquemensajesPedido").show();
        ResizeMensajeEstadoPedido();
    }
    else {
        $("#bloquemensajesPedido").hide();
    }
    LayoutHeader();
}

function LayoutHeader() {
    LayoutHeaderFin();
    $(document).ajaxStop(function () {
        LayoutHeaderFin();
    });
}

function LayoutHeaderFin() {
    var wtop = $("header").innerHeight();
    $("[data-content]").css("margin-top", (wtop) + "px");
}

function LayoutMenu() {
    LayoutMenuFin();
    $(document).ajaxStop(function () {
        LayoutMenuFin();
    });
}

function LayoutMenuFin() {

    if (typeof menuModule !== "undefined")
        menuModule.Resize();

    // validar si sale en dos lineas
    var idMenus = "#ulNavPrincipal-0 > li";

    if ($(idMenus).length == 0) {
        return false;
    }

    $(".wrapper_header").css("max-width", "");
    $(".wrapper_header").css("width", "");
    $(".logo_esika").css("width", "");
    $(".menu_esika_b").css("width", "");
    $(idMenus).css("margin-left", "0px");
    $(".menu_new_esika").css("width", "");

    var wt = $(".wrapper_header").width();
    var wl = $(".logo_esika").innerWidth();
    var wr = $(".menu_esika_b").innerWidth() + 1;
    $(".wrapper_header").css("max-width", wt + "px");
    $(".wrapper_header").css("width", wt + "px");

    wl = Math.min(wl, 100);
    $(".logo_esika").css("width", wl + "px");
    $(".menu_esika_b").css("width", wr + "px");

    wt = wt - wl - wr;
    $(".menu_new_esika").css("width", wt + "px");

    var h = $(".wrapper_header").height();

    if (h > 61) {
        $(idMenus + " a").css("font-size", "9px");
    }

    wr = 0;
    $.each($(idMenus), function (ind, menupadre) {
        wr += $(menupadre).innerWidth();
    });

    if (wt == wr) {
        $(idMenus + " a").css("font-size", "9px");
        wr = 0;
        $.each($(idMenus), function (ind, menupadre) {
            wr += $(menupadre).innerWidth();
        });
    }

    if (wt < wr) {
        $(idMenus + " a").css("font-size", "10.5px");
    }
    else if (wt > wr) {
        wr = (wt - wr) / $(idMenus).length;
        wr = parseInt(wr * 10) / 10;
        wr = Math.min(wr, 20);

        $.each($(idMenus), function (ind, menupadre) {
            if (ind > 0 && ind + 1 < $(idMenus).length) {
                $(menupadre).css("margin-left", wr + "px");
            }
        });
    }

    // caso no entre en el menu
    // poner en dos renglones
    if ($(".wrapper_header").height() > 61) {
        console.log("menu en mas de una linea");
    }

    LayoutHeader();

    if (typeof menuModule !== "undefined")
        menuModule.Resize();
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

function cerrarMensajePostulante() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Bienvenida/CerrarMensajePostulante',
        cache: false,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            if (response.success) {
                $('#bloquemensajesPostulante').hide();
                LayoutHeader();
            }
        },
        error: function (response) { }
    });
}

function MostrarMensajePedidoRechazado() {
    if (location.pathname.toLowerCase().indexOf("/bienvenida") >= 0) {
        $(".oscurecer_animacion").delay(3000).fadeOut(1500);
    }
    else {
        $("[data-content]").removeClass("oscurecer_animacion");
    }
}

function AbrirPopup(ident) {
    $(ident).show();
    $('body').css({ 'overflow-x': 'hidden' });
    $('body').css({ 'overflow-y': 'hidden' });
}

function CerrarPopup(ident) {
    $(ident).hide();
    $('body').css({ 'overflow-y': 'auto' });
    $('body').css({ 'overflow-x': 'auto' });
    $('body').css({ 'overflow': 'auto' });
}

function ModificarPedido2(pTipo) {
    if (pTipo == '2') {
        if (_ModificacionPedidoProl == "0") ConfirmarModificarPedido();
        else $("#divConfirmModificarPedido").modal("show");
    }
    else {
        if (_ModificacionPedidoProl === "0")
            ConfirmarModificar2();
        else
            showDialog("divConfirmValidarPROL");
        return false;
    }
}

function ConfirmarModificar2() {
    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/PedidoValidadoDeshacerReserva?Tipo=PV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Ecommerce',
                        'action': 'Modificar Pedido',
                        'label': '(not available)'
                    });
                    closeWaitingDialog();
                    $('#dialog_PedidoReservado').hide();
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

function ConfirmarModificarPedido() {
    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlDeshacerReservaPedidoReservado2 + '?Tipo=PV',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    CloseLoading();
                    $('#popupInformacion2').hide();
                } else {
                    CloseLoading();
                    messageInfoError(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
                messageInfo("Ocurrió un problema de conectividad. Por favor inténtelo mas tarde.");
            }
        }
    });
}

function AbrirPopupPedidoReservado(pMensaje, pTipoOrigen) {
    if (pTipoOrigen == '2' || pTipoOrigen == '21') { //mobile | 21 -> Showroom
        if (ViewIndicadorGPRSB == '0') {
            $('#popupInformacion2 #mensajeInformacion2').html(pMensaje);
            $('#popupInformacion2').show();
        } else {
            messageInfoError(pMensaje);
        }
    }
    else {
        if (ViewIndicadorGPRSB == '0') {
            $('#dialog_PedidoReservado #mensajePedidoReservado_Error').html(pMensaje);
            $('#dialog_PedidoReservado').show();
        } else {
            messageInfoError(pMensaje);
        }
    }
}

function OcultarMenu(codigo) {
    MostrarMenu(codigo, 0);
}

function MostrarMenu(codigo, accion) {
    codigo = $.trim(codigo);
    if (codigo == "")
        return false;

    var idMenus = "#ulNavPrincipal-0";
    var menu = $(idMenus).find("[data-codigo='" + codigo + "']");
    menu = menu.length == 0 ? $(idMenus).find("[data-codigo='" + codigo.toLowerCase() + "']") : menu;
    menu = menu.length == 0 ? $(idMenus).find("[data-codigo='" + codigo.toUpperCase() + "']") : menu;

    if (menu.length == 0) {
        // puede implementarse para los iconos de la parte derecha
        return false;
    }
    if (accion == 0) {
        $(menu).addClass("oculto");
    }
    else {
        $(menu).removeClass("oculto");
    }

    LayoutMenu();

}

function FuncionEjecutar(functionHide) {
    functionHide = $.trim(functionHide);
    if (functionHide != "") {
        if (functionHide[functionHide.length - 1] != ")") {
            functionHide = functionHide + "()";
        }
        setTimeout(functionHide, 100);
    }
}

function IfNull(input, replaceNull) {
    return input == null ? replaceNull : input;
}

function odd_desktop_google_analytics_promotion_click() {
    if ($('#divOddCarruselDetalle').length > 0 && $("#odd_simbolo_ver_ofertas").html() === "+") {
        var id = $('#divOddCarruselDetalle').find(".estrategia-id-odd").val();
        var name = "Oferta del día - " + $('#divOddCarruselDetalle').find(".nombre-odd").val();
        var creative = $('#divOddCarruselDetalle').find(".nombre-odd").val() + " - " + $('#divOddCarruselDetalle').find(".cuv2-odd").val();

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                    {
                        'id': id,
                        'name': name,
                        'position': 'Banner Superior Home - 1',
                        'creative': creative
                    }]
                }
            }
        });

        odd_desktop_google_analytics_product_impresion();
    }
}

function odd_desktop_google_analytics_promotion_click_verofertas() {
    if ($('#divOddCarruselDetalle').length > 0 && $("#odd_simbolo_ver_ofertas").html() === "+") {
        var id = $('#banner-odd').find(".estrategia-id-odd").val();
        var name = "Oferta del día - " + $('#banner-odd').find(".nombre-odd").val();
        var creative = $('#banner-odd').find(".nombre-odd").val() + " - " + $('#banner-odd').find(".cuv2-odd").val();
        var origenOdd = OrigenDesktopODD;
        var positionName = origenOdd == 1 ? 'Banner Superior Home - 1' : origenOdd == 2 ? 'Banner Superior Pedido - 1' : "";

        dataLayer.push({
            'event': 'promotionClick',
            'ecommerce': {
                'promoClick': {
                    'promotions': [
                    {
                        'id': id,
                        'name': name,
                        'position': positionName,
                        'creative': creative
                    }]
                }
            }
        });

        odd_desktop_google_analytics_product_impresion();
    }
}

function odd_desktop_google_analytics_product_impresion(data, NameContenedor) {
    var carrusel = $("[data-odd-tipoventana='carrusel']");
    var detalle = $("[data-odd-tipoventana='detalle']");
    var listaOferta = data == undefined ? null : data;
    var impresions = new Array();
    var divs = new Array();
    var div1;
    if (carrusel.length > 0 && carrusel.is(":visible")) {
        div1 = $(carrusel).find("[data-item-position = 0]")[0];
        var div2 = $(carrusel).find("[data-item-position = 1]")[0];
        var div3 = $(carrusel).find("[data-item-position = 2]")[0];

        if (div1 != undefined) { divs.push(div1); }
        if (div2 != undefined) { divs.push(div2); }
        if (div3 != undefined) { divs.push(div3); }

        $(divs).each(function (index, div) {
            impresions.push({
                'name': $(div).find("[data-item-campos]").find(".nombre-odd").val(),
                'id': $(div).find("[data-item-campos]").find(".cuv2-odd").val(),
                'price': $(div).find("[data-item-campos]").find(".precio-odd").val(),
                'brand': $(div).find("[data-item-campos]").find(".marca-descripcion-odd").val(),
                'category': 'No disponible',
                'variant': $(div).find("[data-item-campos]").find(".tipoestrategia-descripcion-odd").val(),
                'list': 'Oferta del día',
                'position': index + 1
            });
        });
    }
    if (detalle.length > 0 && detalle.is(":visible")) {
         div1 = $(detalle).find("[data-item-position = 0]");
        if (div1 != null) { divs.push(div1); }
        $(divs).each(function (index, div) {
            impresions.push({
                'name': $(div).find("[data-item-campos]").find(".nombre-odd").val(),
                'id': $(div).find("[data-item-campos]").find(".cuv2-odd").val(),
                'price': $(div).find("[data-item-campos]").find(".precio-odd").val(),
                'brand': $(div).find("[data-item-campos]").find(".marca-descripcion-odd").val(),
                'category': 'No disponible',
                'variant': $(div).find("[data-item-campos]").find(".tipoestrategia-descripcion-odd").val(),
                'list': 'Oferta del día',
                'position': index + 1
            });
        });
    }

    if (listaOferta != null || listaOferta != undefined) {
        var NameList = NameContenedor == "#OfertaDelDia" ? "Oferta del día - Banner" : NameContenedor == "#OfertasDelDiaOfertas" ? "Oferta del día - Detalle Slider" : "";
        if (NameContenedor == "#OfertaDelDia") {
            NameList = "Oferta del día - Banner";

            impresions.push({
                'name': listaOferta.NombreOferta,
                'id': listaOferta.CUV2,
                'price': listaOferta.PrecioOferta,
                'brand': listaOferta.DescripcionMarca,
                'category': 'No disponible',
                'variant': listaOferta.TipoEstrategiaDescripcion,
                'list': NameList,
                'position': 1
            });
        }
        else if (NameContenedor == "#OfertasDelDiaOfertas") {
            NameList = "Oferta del día - Detalle Slider";
            if (listaOferta.ListaOfertas.length > 1) {
                NameList = "Oferta del día - Slider Productos";
                var lstOferta = data ? data.ListaOfertas : [];
                $.each(lstOferta, function (index, item) {
                    impresions.push({
                        'name': item.NombreOferta,
                        'id': item.CUV2,
                        'price': item.PrecioOferta,
                        'brand': item.DescripcionMarca,
                        'category': 'No disponible',
                        'variant': item.TipoEstrategiaDescripcion,
                        'list': NameList,
                        'position': index + 1
                    });
                });
            }

            impresions.push({
                'name': listaOferta.NombreOferta,
                'id': listaOferta.CUV2,
                'price': listaOferta.PrecioOferta,
                'brand': listaOferta.DescripcionMarca,
                'category': 'No disponible',
                'variant': listaOferta.TipoEstrategiaDescripcion,
                'list': NameList,
                'position': 1
            });
        }
    }

    if (impresions.length > 0) {
        dataLayer.push({ 'event': 'productImpression', 'ecommerce': { 'impressions': impresions } });
    }
}

function odd_desktop_google_analytics_addtocart(tipo, element) {
    var id, name, price, marca, variant, quantity, dimension16, listname;
    if (tipo == "banner") {
        id = $('#banner-odd').find(".cuv2-odd").val();
        name = $('#banner-odd').find(".nombre-odd").val();
        price = $('#banner-odd').find(".precio-odd").val();
        marca = $('#banner-odd').find(".marca-descripcion-odd").val();
        variant = $('#banner-odd').find(".tipoestrategia-descripcion-odd").val();
        quantity = 1;
        dimension16 = "Oferta del día - Banner";
        listname = "Oferta del día - Banner";
    }
    if (tipo == "list") {
        id = $('#divOddCarrusel').find("[data-item-position=" + element + "]").find(".cuv2-odd").val();
        name = $('#divOddCarrusel').find("[data-item-position=" + element + "]").find(".nombre-odd").val();
        price = $('#divOddCarrusel').find("[data-item-position=" + element + "]").find(".precio-odd").val();
        marca = $('#divOddCarrusel').find("[data-item-position=" + element + "]").find(".marca-descripcion-odd").val();
        variant = $('#divOddCarrusel').find("[data-item-position=" + element + "]").find(".tipoestrategia-descripcion-odd").val();
        quantity = $('#divOddCarrusel').find("[data-item-position=" + element + "]").find(".txtcantidad-odd").val();
        dimension16 = "Oferta del día - Detalle";
        listname = "Oferta del día - Slider Productos";
    }
    if (tipo == "detail") {
        id = $('#divOddCarruselDetalle').find("[data-item-position=" + element + "]").find(".cuv2-odd").val();
        name = $('#divOddCarruselDetalle').find("[data-item-position=" + element + "]").find(".nombre-odd").val();
        price = $('#divOddCarruselDetalle').find("[data-item-position=" + element + "]").find(".precio-odd").val();
        marca = $('#divOddCarruselDetalle').find("[data-item-position=" + element + "]").find(".marca-descripcion-odd").val();
        variant = $('#divOddCarruselDetalle').find("[data-item-position=" + element + "]").find(".tipoestrategia-descripcion-odd").val();
        quantity = $('#divOddCarruselDetalle').find("[data-item-position=" + element + "]").find(".txtcantidad-odd").val();
        dimension16 = "Oferta del día - Detalle";
        listname = "Oferta del día - Detalle Slider";
    }

    if (variant == "") { variant = "Estándar"; }

    quantity = parseInt(quantity);

    var fechaAddToCart = Date.now();
    var dimension15 = fechaAddToCart - fechaMostrarBanner;
    if (dimension15 != 0)
        dimension15 = (dimension15 / 1000);

    dimension15 = parseInt(dimension15);

    var data = {
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': listname },
                'products': [{
                    'name': name,
                    'price': price,
                    'brand': marca,
                    'id': id,
                    'category': 'No disponible',
                    'variant': variant,
                    'quantity': quantity,
                    'metric1': dimension15,
                    'dimension16': dimension16
                }]
            }
        }
    }

    dataLayer.push(data);
}

function odd_mobile_google_analytics_addtocart() {

    var element = $("#OfertasDiaMobile").find(".slick-current").attr("data-slick-index");
    var id = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".cuv2-odd").val();
    var name = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".nombre-odd").val();
    var price = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".precio-odd").val();
    var marca = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".MarcaNombre").val();
    var variant = $('#OfertasDiaMobile').find("[data-slick-index=" + element + "]").find(".DescripcionEstrategia").val();
    var quantity = $('#pop_oferta_mobile').find("#txtCantidad").val();
    if (variant == "")
        variant = "Oferta del Día";
    dataLayer.push({
        'event': 'addToCart',
        'ecommerce': {
            'add': {
                'actionField': { 'list': 'Oferta del día' },
                'products': [{
                    'name': name,
                    'price': price,
                    'brand': marca,
                    'id': id,
                    'category': 'No disponible',
                    'variant': variant,
                    'quantity': quantity,
                    'dimension15': '100',
                    'dimension16': 'Oferta del día - Detalle'
                }]
            }
        }
    });
}

function odd_google_analytics_product_click(name, id, price, brand, variant, position, listName) {
    if (variant == null || variant == "")
        variant = "Estándar";

    dataLayer.push({
        'event': 'productClick',
        'ecommerce':
        {
            'click':
            {
                'actionField': { 'list': listName },
                'products':
                [{
                    'name': name,
                    'id': id,
                    'price': price,
                    'brand': brand,
                    'category': 'No disponible',
                    'variant': variant,
                    'position': position
                }]
            }
        }
    });
}

function GuardarIndicadorPedidoAutentico() {
    if (tokenPedidoAutenticoOk == 0) {
        if (typeof (Storage) !== 'undefined') {
            var itemSBTokenPedido = localStorage.getItem('SBTokenPedido');

            if (typeof (itemSBTokenPedido) === 'undefined' || itemSBTokenPedido === null) {

                var data2 = { 'accion': 2 };
                jQuery.ajax({
                    type: 'POST',
                    url: '/Pedido/GuardarIndicadorPedidoAutentico',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(data2),
                    success: function (response) {
                        if (response.success) {
                            localStorage.setItem('SBTokenPais', IsoPais);
                            localStorage.setItem('SBTokenPedido', response.message);
                        }
                    },
                    error: function (response) { }
                });
            } else {

                var accion = 3;
                var tp = localStorage.getItem('SBTokenPais');
                if (tp !== IsoPais) {
                    accion = 2;
                }

                var data3 = { 'accion': accion, 'codigo': itemSBTokenPedido };
                jQuery.ajax({
                    type: 'POST',
                    url: '/Pedido/GuardarIndicadorPedidoAutentico',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(data3),
                    success: function (response) {
                        if (response.success) {
                            if (accion == 2) {
                                localStorage.setItem('SBTokenPais', IsoPais);
                                localStorage.setItem('SBTokenPedido', response.message);
                            }
                        }
                    },
                    error: function (response) { }
                });
            }
        }
    }
}

function EnviarCorreoPedidoReservado() {
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/EnviarCorreoPedidoReservado',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        cache: false
    });
}

function AbrirPopupFade(ident) {
    $(ident).fadeIn();
    $('body').css({ 'overflow-x': 'hidden' });
    $('body').css({ 'overflow-y': 'hidden' });
}

function CerrarPopupFade(ident) {
    $(ident).fadeOut();
    $('body').css({ 'overflow-y': 'auto' });
    $('body').css({ 'overflow-x': 'auto' });
    $('body').css({ 'overflow': 'auto' });
}

function set_local_storage(data, key) {
    var value = JSON.stringify(data);
    localStorage.setItem(key, value);
}

function get_local_storage(key) {
    var value = localStorage.getItem(key);
    value = JSON.parse(value);
    return value;
}

function limpiar_local_storage() {
    if (typeof (Storage) !== 'undefined') {
        var itemSBTokenPais = localStorage.getItem('SBTokenPais');
        var itemSBTokenPedido = localStorage.getItem('SBTokenPedido');

        localStorage.clear();

        if (typeof (itemSBTokenPais) !== 'undefined' && itemSBTokenPais !== null) {
            localStorage.setItem('SBTokenPais', itemSBTokenPais);
        }

        if (typeof (itemSBTokenPedido) !== 'undefined' && itemSBTokenPedido !== null) {
            localStorage.setItem('SBTokenPedido', itemSBTokenPedido);
        }
    }
}

function _validartieneMasVendidos() {
    if (tieneMasVendidos === 0 || tieneMasVendidos === 1) {
        set_local_storage(tieneMasVendidos, "tieneMasVendidos");
        return tieneMasVendidos;
    }
    else {
        var xvalor = get_local_storage("tieneMasVendidos");
        return xvalor;
    }
}

var _actualizarModelMasVendidosPromise = function (model) {
    var d = $.Deferred();
    var promise = $.ajax({
        type: 'POST',
        url: '/OfertasMasVendidos/ActualizarModel',
        data: JSON.stringify(model),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false
    });
    promise.done(function (response) {
        d.resolve(response);
    })
    promise.fail(d.reject);

    return d.promise();
}

Object.defineProperty(Object.prototype, "in", {
    value: function () {
        for (var i = 0; i < arguments.length; i++)
            if (arguments[i] == this) return true;
        return false;
    },
    enumerable: false,
    writable: true
});
var registerEvent = function (eventName) {
    var self = this;
    self[eventName] = self[eventName] || {};
    self[eventName].callBacks = [];
    self[eventName].subscribe = function (cb) {
        if (!!cb && typeof cb == "function") {
            self[eventName].callBacks.push(cb);
            return;
        }
        
    }

    self[eventName].emit = function (args) {
        self[eventName].callBacks.forEach(function (cb) {
            cb.call(undefined, args);
        });
    }

    self.subscribe = function (event, cb) {
        if (!!event) {
            if (self[event]) {
                self[event].subscribe(cb);
                return;
            }
        }
    }

    self.applyChanges = function (event, args) {
        if (self[event]) {
            self[event].callBacks.forEach(function (cb) {
                cb.call(undefined, args);
            });
        }
    }
}

function EstablecerLazyCarrusel(elementoHtml) {
    if (!$(elementoHtml).length) {
        return false;
    }
    var listaImagenes = $(elementoHtml).find("img[data-img-lazy='1']");

    $.each(listaImagenes, function (index, value) {
        var rutaImagen = $(value).attr("src");

        if (typeof rutaImagen !== typeof undefined && rutaImagen !== false) {
            $(value).attr("data-lazy", rutaImagen);
            $(value).removeAttr("src");
        }
        else {
            rutaImagen = $(value).attr("data-src");
            if (typeof rutaImagen !== typeof undefined && rutaImagen !== false) {
                $(value).attr("data-lazy", rutaImagen);
                $(value).removeAttr("data-src");
            }
        }

    });

}

function EstablecerAccionLazyImagen(nombreAtributo, withTimeout) {
    //Si se requiere esperar un momento, withTimeout = true
    if (withTimeout == undefined || withTimeout == null)
        withTimeout = true;

    if (nombreAtributo == undefined || nombreAtributo == null || nombreAtributo == "")
        return;

    if (withTimeout)
        setTimeout(function () {
            $(nombreAtributo).lazy();
        }, 500);
    else
        $(nombreAtributo).lazy();
}

function EstablecerAccionLazyImagenAll(nombreAtributo) {
    if (nombreAtributo == undefined || nombreAtributo == null || nombreAtributo == "")
        return;

    $(nombreAtributo).lazy({
        delay: 0
    });
}

function CuponPopupCerrar() {
    $('#Cupon3').hide();

    $.ajax({
        type: 'POST',
        url: baseUrl + 'Cupon/PopupCerrar',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
        },
        error: function (data, error) {
        }
    });
}