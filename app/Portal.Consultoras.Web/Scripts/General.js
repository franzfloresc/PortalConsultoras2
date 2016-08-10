jQuery(document).ready(function () {
    CreateLoading();
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
        var ansi = new Array('Á', 'á', 'É', 'é', 'Í', 'í', 'Ó', 'ó', 'Ú', 'ú');
        var html = new Array('&#193;', '&#225;', '&#201;', '&#233;', '&#205;', '&#237;', '&#211;', '&#243;', '&#218;', '&#250;');
        for (var i = 0; i < html.length; i++) {
            newStr = newStr.replace(html[i], ansi[i]);
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
        $.each(this, function (index, item) {
            if (item[campo] == valor) {                
                array.push(item);
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
                        bool = array.indexOf(a) > -1;
                        break;
                    default:
                        throw "Unknown operator " + operator;
                }

                return bool ? opts.fn(this) : opts.inverse(this);
            });

            Handlebars.registerHelper('IsNullOrEmpty', function (a, operator, opts) {
                var bool = false;
                operator = operator || '==';
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
        }
    }

    SetHandlebars = function (idTemplate, data, idHtml) {
        if (!Handlebars.helpers.iff) 
            HandlebarsRegisterHelper();

        var source = $(idTemplate).html();
        var template = Handlebars.compile(source);
        var htmlDiv = template(data);
        idHtml = $.trim(idHtml);
        if (idHtml == "")  return htmlDiv;
        $(idHtml).html(htmlDiv);
        return "";
    }

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
    catch(err) {
    
    }
}
function closeWaitingDialog() {
    try {
        $("#loadingScreen").dialog('close');
    }
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
    //debugger;
    var thereIsStillTime = true;

    if (data)
    {
        if (data.responseText)
        {
            if ((data.responseText.indexOf("<title>Login</title>") > -1) || (data.responseText.indexOf("<title>Object moved</title>") > -1) || (data.responseText === '"_Logon_"'))
                thereIsStillTime = false;
        }
        else
        {
            if (data == "_Logon_")
                thereIsStillTime = false;
        }

        if (!thereIsStillTime) {
            //window.location.href = "/Login/Timeout";
            //window.location.href = "https://stsqa.somosbelcorp.com/adfs/ls/?wa=wsignout1.0";
            window.location.href = "/SesionExpirada.html";
        }
    }
    else
    {
        //debugger;
        $.ajax({
            url: "/Dummy/",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: false,
            complete: function (result) {
                thereIsStillTime = checkTimeout(result);
            }
        });
    }
    return thereIsStillTime;
}

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
FuncionesGenerales = {
    ValidarSoloNumeros: function(e) {
        var tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 8) return true;
        var patron = /[0-9]/;
        var te = String.fromCharCode(tecla);
        return patron.test(te);
    },

    ValidarSoloNumerosAndSpecialCharater: function(e) {
        var tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 8) return true;
        var patron = /[0-9-\-]/;
        var te = String.fromCharCode(tecla);
        return patron.test(te);
    },
    GetDataForm: function(form) {
        var that = $(form);
        var url = that.attr('action');
        var type = that.attr('method');
        var data = {};

        that.find('[name]').each(function(index, value) {
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

