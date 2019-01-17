var listaEscalaDescuento = listaEscalaDescuento || new Array();
var listaMensajeMeta = listaMensajeMeta || new Array();
var dataBarra = dataBarra || new Object();
var belcorp = belcorp || {};
var mtoLogroBarra = 0;
var tpElectivos = {
    premioSelected: null,
    premios : [],
    loadPremios: false,
    hasPremios: false,
    pedidoDetails: []
};
 

belcorp.barra = belcorp.barra || {};
belcorp.barra.settings = belcorp.barra.settings || {};
belcorp.barra.settings = {
    isMobile: isMobile()
}

 

function GetWidthTotalBase() {
    return $("[data-barra-width]").outerWidth();
}

function MostrarBarra(datax, destino) {
    $("#divBarra").hide();
    destino = destino || "2"; // 1: bienvenido  2: pedido
    $("#divBarra #divLimite").html("");
    datax = datax || new Object();
    var data = datax.dataBarra || datax.DataBarra || dataBarra || new Object();
    dataBarra = data;

    ActualizarGanancia(dataBarra);
    if (destino == '2') {
        initCarruselPremios(dataBarra);
        if (datax.data && datax.data.CUV) {
            trySetPremioElectivo(datax.data.CUV);
        }
        savePedidoDetails(datax);
    }

    dataBarra.ListaEscalaDescuento = dataBarra.ListaEscalaDescuento || new Array();
    if (dataBarra.ListaEscalaDescuento.length > 0) {
        listaEscalaDescuento = dataBarra.ListaEscalaDescuento;
        if (dataBarra.redondeo == undefined) {
            $.each(listaEscalaDescuento, function (i, item) {
                if (IsDecimalExist(item.MontoHasta)) {
                    listaEscalaDescuento[i].MontoHasta = Math.ceil(item.MontoHasta);
                } else {
                    listaEscalaDescuento[i].MontoHasta = Math.ceil(item.MontoHasta) + 1;
                }
                listaEscalaDescuento[i].MontoHastaStr = DecimalToStringFormat(listaEscalaDescuento[i].MontoHasta, true);
            });
            dataBarra.redondeo = true;
        }
    }

    dataBarra.ListaMensajeMeta = dataBarra.ListaMensajeMeta || new Array();
    if (dataBarra.ListaMensajeMeta.length > 0) {
        listaMensajeMeta = dataBarra.ListaMensajeMeta;
    }

    dataBarra.MontoMinimo = Math.ceil(dataBarra.MontoMinimo);
    dataBarra.MontoMinimoStr = DecimalToStringFormat(dataBarra.MontoMinimo, true);
    dataBarra.MontoMaximo = Math.ceil(dataBarra.MontoMaximo);
    dataBarra.MontoMaximoStr = DecimalToStringFormat(dataBarra.MontoMaximo, true);
    dataBarra.TippingPoint = Math.ceil(dataBarra.TippingPoint);
    dataBarra.TippingPointStr = DecimalToStringFormat(dataBarra.TippingPoint, true);

    var me = data.MontoEscala;
    var md = data.MontoDescuento;
    var mx = data.MontoMaximo;
    var mn = data.MontoMinimo;
    var tp = data.TippingPoint;
    var mt = data.TotalPedido;
    
    var listaLimite = new Array();

    var widthTotal = GetWidthTotalBase();
    if (widthTotal <= 0)
        return false;

    var wPrimer = 0;
    var vLogro = 0;
    var wMsgFin = 0;
    var wmin = 45;

    if (!(mn == "0,00" || mn == "0.00" || mn == "0")) {
        wPrimer = wmin;
    }
    var textoPunto = '<div style="font-size:12px; font-weight:400; margin-bottom:4px;">{titulo}</div><div style="font-size: 12px;">{detalle}</div>';
    if (mx > 0 && destino == '2') {
        vLogro = mt - md;

        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "M. Mínimo").replace("{detalle}", variablesPortal.SimboloMoneda + " " + data.MontoMinimoStr),
            tipoMensaje: 'MontoMinimo',
            width: wPrimer,
            valor: data.MontoMinimo,
            valorStr: data.MontoMinimoStr
        });

        if (tp > 0 && dataBarra.TippingPointBarra.Active) { //OG
            listaLimite.push({
                nombre: "",
                tipoMensaje: 'TippingPoint',
                valor: data.TippingPoint,
                valorStr: data.TippingPointStr
            });
        }
        
        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "M. Máximo").replace("{detalle}", variablesPortal.SimboloMoneda + " " + data.MontoMaximoStr),
            tipoMensaje: 'MontoMaximo',
            widthR: wmin,
            valor: data.MontoMaximo,
            valorStr: data.MontoMaximoStr
        });
    }
    else {
        if ((mt - md) < mn)
            vLogro = mt - md;
        else
            vLogro = me < mn ? mn : me;

        listaLimite = new Array();
        listaEscalaDescuento = listaEscalaDescuento || new Array();
        var listaEscala = new Array();
        var indDesde = -1;
        $.each(listaEscalaDescuento, function (ind, monto) {
            if (mx > 0 && destino == "1") {
                var desde = indDesde == -1 ? mx : listaEscalaDescuento[indDesde].MontoHasta
                if (mn < monto.MontoHasta && mx >= desde) {
                    monto.MontoDesde = indDesde == -1 ? mn : listaEscalaDescuento[indDesde].MontoHasta;
                    monto.MontoDesdeStr = indDesde == -1 ? data.MontoMinimoStr : listaEscalaDescuento[indDesde].MontoHastaStr;
                    listaEscala.push(monto);
                    indDesde = ind;
                }
            }
            else if (mn < monto.MontoHasta) {
                monto.MontoDesde = indDesde == -1 ? mn : listaEscalaDescuento[indDesde].MontoHasta;
                monto.MontoDesdeStr = indDesde == -1 ? data.MontoMinimoStr : listaEscalaDescuento[indDesde].MontoHastaStr;
                listaEscala.push(monto);
                indDesde = ind;
            }
        });

        if (mx > 0 && destino == "1" && listaEscala.length > 0) {
            listaEscala[listaEscala.length - 1].MontoHasta = mx;
            listaEscala[listaEscala.length - 1].MontoHastaStr = data.MontoMaximoStr;
        }

        var textoPunto2 = '<div style="font-weight: bold;">{titulo}</div><div style="font-size: 11px;">{detalle}</div>';
        var textoApp = '<div>{titulo}</div><div>{detalle}</div>';
        $.each(listaEscala, function (ind, monto) {
            var montox = ind == 0 ? monto : listaEscala[ind - 1];
            listaLimite.push({
                nombre: textoPunto
                    .replace("{titulo}", monto.PorDescuento + "% DSCTO")
                    .replace("{detalle}", (ind == 0 ? "M. Mínimo: " : "") + variablesPortal.SimboloMoneda + " " + (ind == 0 ? data.MontoMinimoStr : montox.MontoHastaStr)),
                nombre2: textoPunto2.replace("{titulo}", monto.PorDescuento + "% {DSCTO}"),
                nombreApp: textoApp
                    .replace("{titulo}", "<span>" + monto.PorDescuento + "</span>" + "% DSCTO")
                    .replace("{detalle}", variablesPortal.SimboloMoneda + " " + (ind === 0 ? data.MontoMinimoStr : montox.MontoHastaStr)),
                width: ind == 0 ? wPrimer : null,
                widthR: ind == listaEscala.length - 1 ? wmin : null,
                tipoMensaje: 'EscalaDescuento',
                valPor: monto.PorDescuento,
                valor: ind == 0 ? data.MontoMinimo : montox.MontoHasta,
                valorStr: ind == 0 ? data.MontoMinimoStr : montox.MontoHastaStr,
                tipo: ind == 0 ? 'min' : ind == listaEscala.length - 1 ? 'max' : 'int',
                MontoDesde: monto.MontoDesde,
                MontoDesdeStr: monto.MontoDesdeStr,
                MontoHasta: monto.MontoHasta,
                MontoHastaStr: monto.MontoHastaStr
            });
        });

        if (listaLimite.length == 0 && mn > 0 && destino == '2') {
            listaLimite.push({
                nombre: textoPunto.replace("{titulo}", "M. Mínimo").replace("{detalle}", variablesPortal.SimboloMoneda + " " + data.MontoMinimoStr),
                tipoMensaje: 'MontoMinimo',
                width: wPrimer,
                valor: data.MontoMinimo,
                valorStr: data.MontoMinimoStr,
                MontoDesde: 0,
                MontoDesdeStr: DecimalToStringFormat(0, true),
                MontoHasta: data.MontoMinimo,
                MontoHastaStr: data.MontoMinimoStr
            });
        }
    }
    mtoLogroBarra = vLogro;

    if (isTippingPointSuperado()) {

        agregarPremioDefault();
    }

    listaLimite = listaLimite || new Array();
    if (listaLimite.length == 0)
        return false;

    var indPuntoLimite = 0;

    listaLimite = listaLimite || new Array();
    $.each(listaLimite, function (ind, limite) {
        if (ind > 0) {
            var valBack = listaLimite[ind - 1].valor;
            if (valBack < vLogro && vLogro < limite.valor) {
                indPuntoLimite = ind;
            }
            else if (vLogro >= limite.valor) {
                indPuntoLimite = ind;
            }
            else if (valBack == vLogro && vLogro > 0) {
                indPuntoLimite = ind;
            }
        }
    });

    var wTotal = widthTotal;
    var vLimite = listaLimite[indPuntoLimite].valor;

    $("#divBarra").show();
    if (!belcorp.barra.settings.isMobile) {
        $("#divBarra #divBarraPosicion").css("width", wTotal);
        $("#divBarra").css("width", wTotal);
    }

    var styleMin = 'style="margin-left: 6px;"';
  
    var htmlPunto = '<div id="punto_{punto}" data-punto="{select}">'
                + '<div class="monto_minimo_barra" style="width:{wText}px">'
                    + '<div style="width:{wText}px;position: absolute; color:#808080; top:-2px;" data-texto>{texto}</div>'
                    //+ '<div class="linea_indicador_barra" {style}></div>' og
                + '</div>'
        + '</div>' 
    + '<div class="linea_indicador_barra" id="barra_{punto}" {style}></div>';//hd-2848

    // quitando esta clase contenedor_tippingPoint se quita el tooltip y el efecto que salta
    var htmlTippintPoint = "";
    var dataTP = dataBarra.TippingPointBarra;

    // si se va ha mostrar el tooltip
    if (dataTP.Active)
    {
        htmlTippintPoint =
            '<div id="punto_{punto}" data-punto="{select}" style="position: relative; top: -51px; z-index: 200;">'
                + '<div class="monto_minimo_barra">'
                    + '<div style="width:{wText}px;position: relative;" data-texto>'
                        + '<div class="{barra_tooltip_class}">'
                            + '<a class="tippingPoint {estado}" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();"></a>'
                            + '{barra_monto}'
                            //+ '{barra_tooltip}'
                        + '</div>'
                        + '<div class="contenedor_circulos microEfecto_regaloPendienteEleccion">'
                            + '<div class="circulo-1 iniciarTransicion"></div>'
                            + '<div class="circulo-2 iniciarTransicion"></div>'
                            + '<div class="circulo-3 iniciarTransicion"></div>'
                        + '</div>'
                    + '</div>'
                    //+ '<div class="linea_indicador_barra"></div>' og 
                + '</div>'
            + '</div>';
        + '<div class="linea_indicador_barra" id="barra_{punto}" {style}></div>';//hd-2848

        htmlTippintPoint = htmlTippintPoint
            .replace('{barra_tooltip_class}', dataTP.ActiveTooltip ? 'contenedor_tippingPoint' : '')
            .replace('{barra_tooltip}',
                dataTP.ActiveTooltip ?
                '<div class="tooltip_regalo_meta_tippingPoint">'
                    + '<div class="tooltip_producto_regalo_img">'
                        + '<img src="' + dataTP.LinkURL + '" alt="Producto de regalo"/>'
                    + '</div>'
                    + '{barra_tooltip_descripcion}'
                + '</div>' :
                ''
            )
            .replace('{barra_monto}',
                dataTP.ActiveMonto ?
                '<div class="monto_meta_tippingPoint">' + variablesPortal.SimboloMoneda + dataBarra.TippingPointStr + '</div>' :
                ''
            )
            .replace('{barra_tooltip_descripcion}',
                dataTP.ActiveMonto ?
                '<div class="tooltip_producto_regalo_descripcion">Llega a <span>' + variablesPortal.SimboloMoneda + dataBarra.TippingPointStr + '</span><br>y llévate de regalo<br><strong>' + dataTP.DescripcionCUV2 + '</strong></div>' :
                '<div class="tooltip_producto_regalo_descripcion"><br> Llévate de regalo<br><strong>' + dataTP.DescripcionCUV2 + '</strong></div>'
            );
    }
   
    var htmlPuntoLimite = '<div id="punto_{punto}" data-punto="{select}">'
                + '<div class="monto_minimo_barra">'
                    //+ '<div class="bandera_marcador" style="margin-top: -6px;"></div>'
                    + '<div style="margin-left: {marl}px;width: {wText}px;position: absolute; color:#808080;" data-texto>{texto}</div>'
                + '</div>'
        + '</div>' 
    //og
        + '<div class="linea_indicador_barra" id="barra_{punto}" {style}></div>';//hd-2848


    if (mx > 0 || destino == '1')
        htmlPuntoLimite = htmlPunto;

    var wTotalPunto = 0;
    $("#divBarra #divBarraLimite").html("");

    $.each(listaLimite, function (ind, limite) {
        var htmlSet = indPuntoLimite == ind && ind > 0 ? vLogro < vLimite ? htmlPuntoLimite : htmlPunto : htmlPunto;
        htmlSet = ind == 1 && indPuntoLimite == 0 && mn == 0 ? htmlPuntoLimite : htmlSet;
        htmlSet = limite.tipoMensaje == 'TippingPoint' ? htmlTippintPoint : htmlSet;

        var selectPunto = "0";
        var wText = ind == 0 ? "130" : "90";
        if (destino == '1') {
            if (vLogro < vLimite) {
                wText = indPuntoLimite - 1 != ind || indPuntoLimite == 0 ? "55" : "130";
                selectPunto = indPuntoLimite - 1 != ind || indPuntoLimite == 0 ? "0" : "1";
            }
            else {
                wText = indPuntoLimite != ind || indPuntoLimite == 0 ? "55" : "130";
                selectPunto = indPuntoLimite != ind || indPuntoLimite == 0 ? "0" : "1";
            }

        }
        var marl = indPuntoLimite == listaLimite.length - 1 ? "-80" : "21";
        if (destino == '1' && indPuntoLimite == 0) {
            wText = wTotal / listaLimite.length
            marl = "0";
        }
        var activo = limite.tipoMensaje == 'TippingPoint' && indPuntoLimite == 1 ? "activo" : "";
        var styleMinx = mn == 0 && ind == 0 ? styleMin : "";
        var nombrePunto = limite.nombre;
        if (destino == '1') {
            if (selectPunto == "0" && indPuntoLimite == 0 && mn == 0) {
                styleMinx = "";
            }
            var txtDscto = "";
            var txtDetalle = "";
            if (vLogro <= vLimite) {
                if (indPuntoLimite == 0) {
                    txtDscto = "";
                    txtDetalle = "DSCTO";
                }
                else {
                    txtDscto = "DSCTO";
                    txtDetalle = indPuntoLimite - 1 != ind ? "" :
                    (variablesPortal.SimboloMoneda + "" + limite.MontoDesdeStr + " a " + variablesPortal.SimboloMoneda + "" + limite.MontoHastaStr);
                }
            }
            else {
                txtDscto = "DSCTO";
                txtDetalle = indPuntoLimite != ind ? "" :
                (variablesPortal.SimboloMoneda + "" + limite.MontoDesdeStr + " a más");
                if (mx > 0 && destino == "1") {
                    txtDetalle = indPuntoLimite != ind ? "" :
                    (variablesPortal.SimboloMoneda + "" + limite.MontoDesdeStr + " a " + variablesPortal.SimboloMoneda + "" + limite.MontoHastaStr);
                }
            }

            nombrePunto = limite.nombre2
            .replace("{DSCTO}", txtDscto)
            .replace("{detalle}", txtDetalle);
        }

        htmlSet = htmlSet
            .ReplaceAll("{punto}", ind)
            .ReplaceAll("{texto}", nombrePunto)
            .ReplaceAll("{wText}", wText)
            .ReplaceAll("{marl}", marl)
            .ReplaceAll("{estado}", activo)
            .ReplaceAll("{style}", styleMinx)
            .ReplaceAll("{select}", selectPunto);

        var objH = $(htmlSet).css("float", 'left');
        $("#divBarra #divBarraLimite").append(objH);

        var wPunto = wText;
        if (!(destino == '1' && indPuntoLimite == 0)) {
            wPunto = $("#punto_" + ind + " [data-texto]").width();
            wPunto += $("#punto_" + ind + " .bandera_marcador").width() || 0;

            if (indPuntoLimite == listaLimite.length - 1 && indPuntoLimite == ind) {
                if (destino == '2' && vLogro < vLimite && mx <= 0) {
                    wPunto = wmin;
                }

                $("#punto_" + ind).css("width", wPunto);
                if (ind == 0 && mn == 0) {
                    $("#punto_" + ind + " .linea_indicador_barra").css("margin-left", "0px;");
                }
            }
        }
        wTotalPunto += wPunto;

    });
    $("#divBarra #divBarraLimite").append("<div class='clear'></div>");

    if (destino == '1') {
        $("#divBarraLimite [data-punto='0']").find("[data-texto]").css("color", "#979797");
        $("#divBarraLimite [data-punto='1']").find("[data-texto]").css("color", "#000000");
        $("#divBarraLimite [data-punto='1']").find("[data-texto]").css("font-weight", "bold");
    }

    if (wTotalPunto > wTotal) {
        var indAux = indPuntoLimite;
        while (indAux > 1) {
            if (indAux - 1 < indPuntoLimite - 1) {
                var wwx = $("#punto_" + (indAux - 1) + " [data-texto]").width();
                wTotalPunto -= wwx;
                $("#punto_" + (indAux - 1)).remove();
                listaLimite.splice(indAux - 1, 1);
                if (wTotalPunto < wTotal) {
                    indAux = 0;
                }
            }
            indAux--;
        }
        if (wTotalPunto > wTotal) {
            indAux = listaLimite.length;
            while (indAux > indPuntoLimite + 1) {
                var wwx = $("#punto_" + (indAux) + " [data-texto]").width();
                wTotalPunto -= wwx;
                $("#punto_" + indAux).remove();
                listaLimite.splice(indAux, 1);
                indAux--;
                if (wTotalPunto < wTotal) {
                    indAux = 0;
                }
            }
        }
    }

    var wAreaMover = widthTotal - wTotalPunto;
    if (destino == "1" && indPuntoLimite == 0) {
        wAreaMover = 0;
    }
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) {
            $("#punto_" + (indPuntoLimite)).css("margin-right", wAreaMover);
        }
        else {
            $("#punto_" + (indPuntoLimite - 1)).css("margin-right", wAreaMover);
        }
    }
    else {
        if (mn > 0) {
            $("#punto_" + indPuntoLimite).css("margin-left", wAreaMover);
        }
        else {
            $("#punto_" + indPuntoLimite).css("margin-right", wAreaMover);
        }
    }

    var wPuntosAnterior = 0;
    indAux = indPuntoLimite;
    while (indAux > 0) {
        if (indAux == 1 && mn == 0 && indPuntoLimite == 1) {
            wPuntosAnterior += 0;
        }
        else {
            wPuntosAnterior += $("#punto_" + (indAux - 1)).width();
        }
        indAux--;
    }
    if (mn > 0) {
        if (vLogro >= vLimite) {
            if (indPuntoLimite > 0) {
                wPuntosAnterior += $("#punto_" + indPuntoLimite).width();
            }
        }
    }
    else {
        if (indPuntoLimite == 1) {
            wPuntosAnterior += $("#punto_" + (indPuntoLimite - 1)).width();
        }
    }

    var wLimite = wAreaMover + wPuntosAnterior;
    var wLimiteAnterior = wPuntosAnterior;
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) {
            wLimite = widthTotal;
            wLimiteAnterior -= parseInt($("#punto_" + (indPuntoLimite) + " >  div").width() / 2, 10);
        }
        else {
            wLimiteAnterior -= wLimiteAnterior <= 0 ? 0 : $("#punto_" + (indPuntoLimite - 1)).width() - parseInt($("#punto_" + (indPuntoLimite - 1) + " >  div").width() / 2, 10);
            if ($("#punto_" + indPuntoLimite).find(".bandera_marcador").length == 0) {
                wLimite += parseInt($("#punto_" + (indPuntoLimite) + " >  div").width() / 2, 10);
            }
        }
    }
    else {
        var indxx = indPuntoLimite == 0 && mn == 0 ? (indPuntoLimite + 1) : indPuntoLimite;
        if ($("#punto_" + indxx).find(".bandera_marcador").length == 0) {
            wLimite += parseInt($("#punto_" + (indxx) + " >  div").width() / 2, 10);
        }
        if (indPuntoLimite == 0 && mn == 0) {
            wLimite += parseInt($("#punto_" + (0)).width(), 10);
        }
    }
    wLimiteAnterior = wLimiteAnterior < 0 ? 0 : wLimiteAnterior;
    wAreaMover = wLimite - wLimiteAnterior;

    listaLimite = listaLimite || new Array();
    $.each(listaLimite, function (ind, limite) {
        if (ind > 0) {
            var valBack = listaLimite[ind - 1].valor;
            if (valBack < vLogro && vLogro < limite.valor) {
                indPuntoLimite = ind;
            }
            else if (vLogro >= limite.valor) {
                indPuntoLimite = ind;
            }
            else if (valBack == vLogro && vLogro > 0) {
                indPuntoLimite = ind;
            }
        }
    });

    var vLimiteAnterior = indPuntoLimite > 0 ? listaLimite[indPuntoLimite - 1].valor : 0;
    var vMover = vLogro - vLimiteAnterior;
    var vDiferencia = listaLimite[indPuntoLimite].valor - vLimiteAnterior;
    var wLogro = wLimiteAnterior;
    wLogro += vDiferencia > 0 ? (vMover * wAreaMover) / vDiferencia : 0;

    if (wLimite == widthTotal) {
        if (vLogro > vLimite) {
            wLogro = widthTotal - 20;
        }
        else if (vLogro == vLimite) {
            wLogro = wLimiteAnterior;
        }
    }

    if (destino == "1") {
        if (indPuntoLimite <= 0 && mn > 0) {
            wLimite = 0;
            wLogro = 0;
        }
    }

    if (listaLimite.length == 1) {
        if (vLogro > vLimite) {
            wLimite = widthTotal;
            wLogro = widthTotal - 20;
        }
    }

    /*hd-2848*/
    if (belcorp.barra.settings.isMobile) {
          wLogro = CalculoLlenadoBarra(); //volver comentar hd-2849
          CalculoPosicionMinimoMaximo();  //volver comentar hd-2849
        
    }
    else
    {
        wLogro = CalculoLlenadoBarraDestokp();
        wLimite = CalculoLlenadoBarraEspacioLimiteDestokp();
    }


    $("#divBarra #divBarraEspacioLimite").css("width", wLimite);
    $("#divBarra #divBarraEspacioLogrado").css("width", wLogro);


    if (destino == "1") {
        return true;
    }

    if (mn == 0 && vLogro == 0 && !belcorp.barra.settings.isMobile) {
        $("#divBarra #divBarraMensajeLogrado").hide();
        return false;
    }
    var tipoMensaje = listaLimite[indPuntoLimite].tipoMensaje;
    tipoMensaje += vLogro >= vLimite ? "Supero" : "";
    if (vLogro < mn) {
        tipoMensaje = "MontoMinimo";
    }

    tipoMensaje += belcorp.barra.settings.isMobile ? 'Mobile' : '';

    var tpRegaloMobileShow = tp > 0 && dataBarra.TippingPointBarra.Active && belcorp.barra.settings.isMobile;
    if (tpRegaloMobileShow && vLogro < tp) {
        tipoMensaje = "TippingPointMobile";
    }

    $('#montoPremioMeta').html(variablesPortal.SimboloMoneda + " " + dataBarra.TippingPointStr);
    if (belcorp.barra.settings.isMobile) {//V&& tp > 0  OG
        cargarMontoBanderasMobile(dataBarra);
    }

    listaMensajeMeta = listaMensajeMeta || new Array();
    var objMsg = listaMensajeMeta.Find("TipoMensaje", tipoMensaje)[0] || new Object();
    objMsg.Titulo = $.trim(objMsg.Titulo);
    objMsg.Mensaje = $.trim(objMsg.Mensaje);

    if (objMsg.Titulo == "" && objMsg.Mensaje == "") {
        $("#divBarra #divBarraMensajeLogrado").hide();
        return false;
    }
    var valPor = listaLimite[indPuntoLimite].valPor || "";
    var valorMonto = variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(parseFloat(vLimite - vLogro));
    var valorMontoEsacalaDescuento = variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(parseFloat(listaLimite[indPuntoLimite].valor - me));
    $("#divBarra #divBarraMensajeLogrado").show();
    $("#divBarra #divBarraMensajeLogrado .mensaje_barra").html(objMsg.Titulo.replace("#porcentaje", valPor).replace("#valor", valorMonto));

    
    if (tpRegaloMobileShow) {
        $('#hrefIconoRegalo').show();

        if (ConfiguradoRegalo == true) {//&& (mtoLogroBarra<=dataBarra.MontoMinimo)
            document.getElementById('divtippingPoint').style.display = 'none';
            document.getElementById('lineaPosicionRegalo').style.display = 'none';
        }
        
        if (vLogro < tp) {
            valorMonto = variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(tp - vLogro);
        }
    } else {
        if (ConfiguradoRegalo == false) $('#hrefIconoRegalo').hide();
    }

    var divBarraMsg = $("#divBarra #divBarraMensajeLogrado .agrega_barra");
    if (sessionStorage.getItem("cuvPack") != null || mx > 0) { 
        divBarraMsg.html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    } else {
        divBarraMsg.html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", (mt < mn ? valorMonto : valorMontoEsacalaDescuento)));
    }

    //$("#divBarra #divBarraMensajeLogrado .agrega_barra").html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", valorMonto)); 
    // OG
    //if (belcorp.barra.settings.isMobile) {
    //    $("#divBarra #divBarraMensajeLogrado .descuento_pedido").html(listaLimite[indPuntoLimite].nombreApp || listaLimite[indPuntoLimite].nombre);
    //}



    $("#divBarraMensajeLogrado").css("width", "");
    var wMsgTexto = $("#divBarra #divBarraMensajeLogrado > div").width() + 1;
    wMsgTexto = wLogro + wMsgTexto >= wTotal ? wTotal : (wLogro + wMsgTexto);
    if (!belcorp.barra.settings.isMobile) {
        $("#divBarra #divBarraMensajeLogrado").css("width", wMsgTexto);
    }


    /*hd-2848*/
    if (dataBarra.TippingPointBarra.InMinimo != null) { 
        ConfiguradoRegalo = dataBarra.TippingPointBarra.InMinimo;
    } 
    

    /*hd-2848*/
    if (!belcorp.barra.settings.isMobile) {
        if (TieneMontoMaximo()) { /// se trata como tipinpoing

            if (dataBarra.TippingPointBarra.Active != null && dataBarra.TippingPointBarra.Active != false) {
                document.getElementById('punto_0').style = '';
                document.getElementById('punto_0').className = 'EscalaDescuento';
                document.getElementById('punto_1').className = 'EscalaDescuento';
                document.getElementById('punto_2').className = 'EscalaDescuento';
            }
            else {


                if (ConfiguradoRegalo == true) {
                    document.getElementById('punto_0').style = '';
                    document.getElementById('punto_0').className = 'EscalaDescuento';
                    document.getElementById('punto_1').className = 'EscalaDescuento';
                    document.getElementById('punto_2').className = 'EscalaDescuento';
                }
                else {
                    document.getElementById('punto_0').style = '';
                    document.getElementById('punto_0').className = 'EscalaDescuento';
                    document.getElementById('punto_1').className = 'EscalaDescuento';
                }

            }

        }
        else {




            for (var x = 0; x < dataBarra.ListaEscalaDescuento.length; x++) {
                if (x==0) {
                    if (document.getElementById('punto_0')) document.getElementById('punto_0').style = '';
                    if (document.getElementById('punto_0')) document.getElementById('punto_0').className = 'EscalaDescuento';
                } else
                {
                    if (document.getElementById('punto_' + x.toString())) document.getElementById('punto_'+x.toString()).className = 'EscalaDescuento';
                  
                }
            }

        }

        CalculoPosicionMinimoMaximoDestokp();
        CalculoPosicionMensajeDestokp();
    }
    


    return true;
}

function cargarMontoBanderasMobile(barra) {
    $('#divMontoMinimo').html(variablesPortal.SimboloMoneda + ' ' + barra.MontoMinimoStr);
    $('#divMontoMaximo').html(variablesPortal.SimboloMoneda + ' ' + barra.MontoMaximoStr);
    var divMontoTp = $('#divtippingPoint');

    if (barra.TippingPointBarra.ActiveMonto) {
        divMontoTp.html(variablesPortal.SimboloMoneda + ' ' + barra.TippingPointStr);
        divMontoTp.show();
    } else {
        divMontoTp.hide();
        $('#lineaPosicionRegalo').hide();
    }
}

function savePedidoDetails(response) {
    if (!response.data) {
        return;
    }

    tpElectivos.pedidoDetails = response.data.ListaDetalleModel || [];
}

function initCarruselPremios(barra) {
    if (tpElectivos.loadPremios) {
        return;
    }

    if (!belcorp.barra.settings.isMobile) {
        $('.btn_seguir_comprando').html('Sigue comprando para llevártelo');
    }

    if (barra.TippingPointBarra && barra.TippingPointBarra.ActivePremioElectivo) {
        tpElectivos.loadPremios = true;
        cargarPremiosElectivos();

        return;
    }

    hidePencilInDetails();
}

function cargarPopupEleccionRegalo(disableCheck) {
    if (!tpElectivos.hasPremios) {
        return;
    }

    var disable = typeof disableCheck === 'boolean' && disableCheck === true;
    if (!disable) {
        checkPremioSelected();
    }

    AbrirPopup('#popupEleccionRegalo');
    setTimeout(function () {
        armarCarouselRegalos();
    }, 150);
}

function isTippingPointSuperado() {
    if (!dataBarra) {
        return false;
    }

    var tp = dataBarra.TippingPoint;
    return tp > 0 &&
        mtoLogroBarra >= tp &&
        dataBarra.TippingPointBarra &&
        dataBarra.TippingPointBarra.ActivePremioElectivo &&
        !tpElectivos.premioSelected;
}

function checkPremioSelected() {
    var details = tpElectivos.pedidoDetails;
    if (!details || details.length === 0) {
        if (tpElectivos.premioSelected) {
            setPremio(null);
        }

        return;
    }

    var detail = getPremioElectivoInDetails(details);
    if (!detail) {
        if (tpElectivos.premioSelected) {
            setPremio(null);
        }

        return;
    }

    if (isCuvSelected(detail.CUV)) {
        return;
    }

    var premio = getPremioByCuv(detail.CUV);

    setPremio(premio);
}

function trySetPremioElectivo(cuv) {
    if (tpElectivos.premioSelected &&
        tpElectivos.premioSelected.CUV2 == cuv) {
        return;
    }

    var premio = getPremioByCuv(cuv);
    if (!premio) {
        return;
    }

    setPremio(premio);
}

function getPremioElectivoInDetails(details) {
    var len = details.length;

    for (var i = 0; i < len; i++) {
        var item = details[i];

        if (item.PremioElectivo) {
            return item;
        }
    }

    return null;
}

function getPremioElectivos() {
    var dfd = jQuery.Deferred();

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/CargarPremiosElectivos",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: true,
        cache: false,    
        success: function(data) {
            dfd.resolve(data);
        },
        error: function(data, error) {
            dfd.reject(data, error);
        }
    });

    return dfd.promise();
}

function getPremiosEstrategia(list) {
    var len = list.length;
    var premios = [];
    for (var i = 0; i < len; i++) {
        var item = list[i];
        if (item.ImagenURL) {
            premios.push(item);
        }
    }

    return premios;
}

function hidePencilInDetails() {
    var style = $('<style>.icono_cambiar_regalo_programaNuevas { display: none; }</style>');
    $('html > head').append(style);
}

function cargarPremiosElectivos() {
    getPremioElectivos()
        .then(function (response) {
            tpElectivos.premios = response.lista;
            var premio = response.selected;
            tpElectivos.premioSelected = premio;
            var premiosMostrar = getPremiosEstrategia(tpElectivos.premios);

            if (isTippingPointSuperado()) {
                agregarPremioDefault();
            }

            if (premiosMostrar.length === 0) {
                hidePencilInDetails();

                return;
            }

            SetHandlebars("#premios-electivos-template", { lista: premiosMostrar }, '#carouselOpcionesRegalo');
            loadCarruselPremiosEvents();

            if (belcorp.barra.settings.isMobile) {
                $('#hrefIconoRegalo').click(cargarPopupEleccionRegalo);
            }

            setPremio(premio);
            tpElectivos.hasPremios = true;

            if (!belcorp.barra.settings.isMobile && !premio) {
                setTimeout(function() {
                    $('#divBarra .contenedor_circulos').show();
                }, 2000);
            }
        });
}

function agregarPremioDefault() {
    var premio = getPremioDefault();
    if (!premio) {
        return;
    }

    AgregarPremio(premio).then(function(data) {
        if (!data) {
            return;
        }

        tpElectivos.premioSelected = premio;
        $('#divBarra .contenedor_circulos').hide();
        //setPremio(premio);
    });
}

function getPremioDefault() {
    var list = tpElectivos.premios;

    for (var i = 0; i < list.length; i++) {
        var item = list[i];

        if (item.CuponElectivoDefault) {
            return item;
        }
    }

    return null;
}

function getElementPremiosByCuv(list, cuv) {
    var len = list.length;
    for (var i = 0; i < len; i++) {
        var element = $(list[i]);
        var currentCuv = element.data('cuv');

        if (currentCuv == cuv) {
            return element;
        }
    }
    return null;
}

function isCuvSelected(cuv) {
    if (!tpElectivos.premioSelected ||
        tpElectivos.premioSelected.CUV2 != cuv)
    {
        return false;
    }
    var element = getElementByCuv(cuv);

    return element && element.hasClass('opcion_regalo_carousel_elegido');
}

function loadCarruselPremiosEvents() {
    $('.btn_elegir_regalo').click(seleccionRegaloProgramaNuevas);
}

function armarCarouselRegalos() {
    var carrusel = $('#carouselOpcionesRegalo');

    if (carrusel[0].slick) {
        return;
    }
    var options;

    if (belcorp.barra.settings.isMobile) {
        options = {
            infinite: true,
            lazyLoad: 'ondemand',
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            speed: 300,
            arrows: false,
            variableWidth: true,
            centerMode: true
        };
    } else {
        options = {
            infinite: false,
            lazyLoad: 'ondemand',
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 300,
            prevArrow: '<a class="ver_anterior_regalo js-slick-prev-h"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="ver_siguiente_regalo next js-slick-next-h"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
        };
    }

    carrusel.slick(options);
}

function seleccionRegaloProgramaNuevas() {
    var regaloProgramaNuevas = $(this);

    var cuv = regaloProgramaNuevas.parents('.opcion_regalo_carousel_programaNuevas').data('cuv');
    var premio = getPremioByCuv(cuv);

    if (!premio) {
        return;
    }

    AgregarPremio(premio)
        .then(function(data) {
            if (!data) {
                return;
            }

            setPremio(premio);
        });
}

function markPremioSelected(premioDiv) {
    var btn = premioDiv.find('.btn_elegir_regalo');
    premioDiv.addClass('opcion_regalo_carousel_elegido');
    btn.fadeOut(100);
    btn.next().fadeIn(150);
}

function getPremioByCuv(cuv) {
    var cantPremios = tpElectivos.premios.length;
    for (var i = 0; i < cantPremios; i++) {
        var item = tpElectivos.premios[i];

        if (item.CUV2 == cuv) {
            return item;
        }
    }

    return null;
}

function getPopupRegalos() {
    return $('#popupEleccionRegalo');
}

function restoreDivPremios() {
    var divCarrusel = getPopupRegalos();
    divCarrusel.find('.opcion_regalo_carousel_programaNuevas').removeClass('opcion_regalo_carousel_elegido');
    divCarrusel.find('.mensaje_regalo_elegido').hide();
    divCarrusel.find('.btn_elegir_regalo').show();
}

function setPremio(premio) {
    tpElectivos.premioSelected = premio;
    restoreDivPremios();
    updateTitlePopupRegalos(premio);
    var btns = getPopupRegalos().find('.btn_elegir_regalo');
    btns.html(premio ? 'Cambiar' : 'Elegir');

    if (!premio) {
        $('#divBarra .contenedor_circulos').show();

        return;
    }

    $('#divBarra .contenedor_circulos').hide();
    selectPremioDivByCuv(tpElectivos.premioSelected.CUV2);
}

function updateTitlePopupRegalos(premio) {
    var msgRegaloDiv = getPopupRegalos().find('.mensaje_titulo_popup_eleccion_regalo');
    msgRegaloDiv.fadeOut(200);

    if (premio) {
        msgRegaloDiv.html('¡Ya elegiste tu regalo!');
    } else {
        msgRegaloDiv.html('¡Puedes elegir tu regalo del Programa de Nuevas ahora!');
    }
    
    msgRegaloDiv.fadeIn(200);
}

function getDivPremios() {
    var container = $('#carouselOpcionesRegalo');
    var slick = container[0].slick;
    if (slick) {
        return slick.$slides || [];
    }

    return container.find('.opcion_regalo_carousel_programaNuevas');
}

function getElementByCuv(cuv) {
    var list = getDivPremios();

    return getElementPremiosByCuv(list, cuv);
}

function selectPremioDivByCuv(cuv) {
    var element = getElementByCuv(cuv);
    if (!element) {
        return false;
    }

    markPremioSelected(element);
    return true;
}

function showPopupNivelSuperado(barra, prevLogro) {
    if (!barra) {
        return;
    }    
    var tippingPoint = barra.TippingPoint || 0;

    if (tippingPoint > 0) {
        if (!barra.TippingPointBarra.Active) {
            return;
        }

        var superaRegalo = tippingPoint <= mtoLogroBarra && tippingPoint > prevLogro;
        if (superaRegalo) {

            var idPopup = '#popupPremio';
            var dvPremio = $(idPopup);
            var btn = dvPremio.find('.btn_escoger_o_cambiar_regalo');
            dvPremio.find('.sub-premio-elect').css('display', tpElectivos.premioSelected || !tpElectivos.hasPremios ? 'none': 'block');
            btn.css('display', !tpElectivos.hasPremios ? 'none': 'block');
            btn.html(tpElectivos.premioSelected ? 'CAMBIAR PRODUCTO': '¡Escoger ahora!');
            AbrirPopup(idPopup);
            setContainerLluvia(idPopup);
            mostrarLluvia();

            return;
        }
    }

    if (!TieneMontoMaximo()) {
        showPopupEscalaSiguiente(barra, prevLogro);
    }
}

function showPopupEscalaSiguiente(dataBarra, prevLogro) {
    if (!dataBarra || !dataBarra.ListaEscalaDescuento) return false;

    var total = mtoLogroBarra;
    var len = dataBarra.ListaEscalaDescuento.length;

    for (var i = 0; i < len; i++) {
        var escala = dataBarra.ListaEscalaDescuento[i];
        if (total >= escala.MontoDesde && total < escala.MontoHasta) {
            if (escala.MontoDesde > prevLogro) {
                var idPopup = '#popupEscalaDescuento';
                var content = escala.PorDescuento + '% de dscto!';
                $(idPopup + ' .porcentaje').html(content);
                
                AbrirPopup(idPopup);
                setContainerLluvia(idPopup);
                mostrarLluvia();

                return true;
                
            }
        }
    }

    return false;
}

function setContainerLluvia(containerId) {
    if (typeof lluviaContainerId !== 'undefined') {
        lluviaContainerId = containerId;
    }
}


var ConfiguradoRegalo;
function CalculoLlenadoBarra() {
    var TippingPointBarraActive = dataBarra.TippingPointBarra.Active;
    var montoMaximo = dataBarra.MontoMaximo;
    var montoTipipoing = dataBarra.TippingPoint;
    var montoActual = mtoLogroBarra;
    var montoMinimo = dataBarra.MontoMinimo;
    var AvancePorcentaje = 0;
    

    if (TieneMontoMaximo())
    { /// se trata como tipinpoing
        if (ConfiguradoRegalo == true) {
            if (montoActual < montoMinimo) {
                AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMinimo);
            }
            else {

                AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);

                //var escala = 0;
                //var lista = dataBarra.ListaEscalaDescuento;
                //for (var i = 0; i < lista.length; i++) {
                //    if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                //        escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                //        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, escala);
                //        break;
                //    }
                //    else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                //        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoActual);
                //    }

                //}


            }

        } else {

            if (TippingPointBarraActive) {
                if (montoActual < montoTipipoing) {
                    AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoTipipoing);
                }
                else
                    AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
            }
            else {
                if (ConfiguradoRegalo == true) {

                    if (montoActual < montoMinimo) {
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMinimo);
                    } else
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
                }
                else {
                    if (montoActual < montoMinimo) {
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMinimo);
                    } else
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);

                }
            }

        }


       
    }
    else
    { /// se trata como escala de descuento

        if (ConfiguradoRegalo == true) {
            if (montoActual < montoTipipoing) {
                AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMinimo);
            }
            else {

                var escala = 0;
                var lista = dataBarra.ListaEscalaDescuento;
                for (var i = 0; i < lista.length; i++) {
                    if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, escala);
                        break;
                    }
                    else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoActual);
                    }

                }


            }

        }
        else {
            //montoMinimo
            if (montoActual < montoTipipoing) {
                AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoTipipoing);
            }
            else {


                    var escala = 0;
                    var lista = dataBarra.ListaEscalaDescuento;
                    for (var i = 0; i < lista.length; i++) {
                        if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                            escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            AvancePorcentaje = CalculoPorcentajeAvance(montoActual, escala);
                            break;
                        }
                        else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                            AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoActual);
                        }

                    }


            }

        }
      
    }
    return AvancePorcentaje;
}
 
function CalculoPosicionMinimoMaximo() {

    var TippingPointBarraActive = dataBarra.TippingPointBarra.Active;
    var montoMaximo = dataBarra.MontoMaximo;
    var montoTipipoing = dataBarra.TippingPoint;
    var montoActual = mtoLogroBarra;
    var montoMinimo = dataBarra.MontoMinimo;
    var AvancePorcentaje = 0;
    //var ConfiguradoRegalo = true;
    //var montoMinimo = dataBarra.MontoMinimo;
    //var montoMaximo = dataBarra.MontoMaximo;
    //var montoTipipoing = dataBarra.TippingPoint;

    var montoActual = mtoLogroBarra; //dataBarra.TotalPedido;

    // var anchoDispositivo = window.innerWidth;
    var anchoBarraPorcentaje = 91.25;//%
    var PosicionMontoMinimo = 0;

    if (TieneMontoMaximo()) { /// se trata como tipinpoing
        if (ConfiguradoRegalo == true)
        {
            if (montoActual < montoMinimo) {

                PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;
                PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('MontoMinimoBloque').style.display = 'block';
                document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('MontoMinimoBloque').style.left = "";
                document.getElementById('MontoMinimoBloque').style.right = '-11px';

                document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";
                document.getElementById('hrefIconoRegalo').style.left = "";
                document.getElementById('hrefIconoRegalo').style.right = '-11px';

                document.getElementById('divtippingPoint').style.left = "";

                document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                document.getElementById('lineaPosicionRegalo').style.right = "";
                document.getElementById('lineaPosicionRegalo').style.display = 'block';

                document.getElementById('MontoMaximoBloque').style.display = "none";


            }
            else {

                PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                PosicionMontoTipipoing = montoMinimo * 100 / montoMaximo;

                document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('MontoMinimoBloque').style.right = '';
                document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                document.getElementById('MontoMinimoBloque').style.display = 'block';


                document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipipoing - 3) + '%';
                document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipipoing) + '%';
                document.getElementById('lineaPosicionRegalo').style.display = 'block';

                document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                document.getElementById('MontoMaximoBloque').style.right = "-14px";
                document.getElementById('MontoMaximoBloque').style.display = "block";

                //document.getElementById('divtippingPoint').style.left = "-20px";
                document.getElementById('divtippingPoint').style.display = 'none';
                document.getElementById('lineaPosicionRegalo').style.display = 'none';

            }
        }
        else
        {
                if (TippingPointBarraActive) {
                    if (montoActual < montoTipipoing) {
                        PosicionMontoMinimo = montoMinimo * 100 / montoTipipoing;
                        PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                        document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('MontoMinimoBloque').style.display = 'block';

                        document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";
                        document.getElementById('hrefIconoRegalo').style.left = "";
                        document.getElementById('hrefIconoRegalo').style.right = '-11px';

                        document.getElementById('divtippingPoint').style.left = "";

                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                        document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                        document.getElementById('lineaPosicionRegalo').style.right = "";
                        document.getElementById('lineaPosicionRegalo').style.display = 'block';
                        document.getElementById('MontoMaximoBloque').style.display = "none";


                    }
                    else {

                        PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                        PosicionMontoTipinpoing = montoTipipoing * 100 / montoMaximo;

                        document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                        document.getElementById('MontoMinimoBloque').style.right = '';
                        document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                        document.getElementById('MontoMinimoBloque').style.display = 'block';


                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipinpoing - 3) + '%';
                        document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                        document.getElementById('lineaPosicionRegalo').style.display = 'block';

                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                        document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                        document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                        document.getElementById('MontoMaximoBloque').style.right = "-14px";
                        document.getElementById('MontoMaximoBloque').style.display = "block";

                        document.getElementById('divtippingPoint').style.left = "-20px";

                    }
                }
                else {
                    if (ConfiguradoRegalo == true) {

                        if (montoActual < montoMinimo) {

                            var PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;


                            //document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('MontoMinimoBloque').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                            document.getElementById('MontoMinimoBloque').style.right = '-13px';

                            document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoMinimo - 4) + '%';
                            document.getElementById('hrefIconoRegalo').style.display = 'block';
                            document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";

                            //document.getElementById('hrefIconoRegalo').style.left = "";


                            //document.getElementById('MontoMaximoBloque').innerHTML = document.getElementById('MontoMinimoBloque').innerHTML;

                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                            //document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                            //document.getElementById('lineaPosicionRegalo').style.right = "";
                            //document.getElementById('MontoMaximoBloque').style.display = "none";


                        }
                        else {

                            var PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                            var PosicionMontoTipipoing = montoTipipoing * 100 / montoMaximo;

                            document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';


                            document.getElementById('MontoMinimoBloque').style.right = '';
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                            document.getElementById('MontoMinimoBloque').style.display = 'block';


                            document.getElementById('hrefIconoRegalo').style.display = 'block';
                            document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoMinimo - 4) + '%';
                            document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoMinimo) + '%';

                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                            document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                            document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                            document.getElementById('MontoMaximoBloque').style.right = "-14px";
                            document.getElementById('MontoMaximoBloque').style.display = "block";

                            //document.getElementById('divtippingPoint').style.left = "-20px";
                        }

                    }
                    else {
                        if (montoActual < montoMinimo) {

                            var PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;

                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('MontoMinimoBloque').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                            document.getElementById('MontoMinimoBloque').style.left = '';
                            document.getElementById('MontoMinimoBloque').style.right = '-13px';  //left = (PosicionMontoMinimo - 8) + '%';
                            document.getElementById('MontoMaximoBloque').style.display = 'none';


                        }
                        else {


                            PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                            PosicionMontoTipipoing = montoTipipoing * 100 / montoMaximo;

                            //document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                            document.getElementById('MontoMinimoBloque').style.right = '';
                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                            document.getElementById('MontoMinimoBloque').style.display = 'block';



                            // document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipipoing - 3) + '%';
                            //document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipipoing) + '%';

                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                            document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                            document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                            document.getElementById('MontoMaximoBloque').style.right = "-14px";
                            document.getElementById('MontoMaximoBloque').style.display = "block";


                        }
                    }
                }
        }

    }
    else { /// se trata como escala de descuento
        if (ConfiguradoRegalo == true)
        {
            if (montoActual < montoTipipoing) {

                PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;
                //PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('MontoMinimoBloque').style.display = 'block';
                document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('MontoMinimoBloque').style.left = '';
                document.getElementById('MontoMinimoBloque').style.right = '-13px';


               // document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";
                document.getElementById('hrefIconoRegalo').style.left = "";
                document.getElementById('hrefIconoRegalo').style.display = 'block';
                document.getElementById('hrefIconoRegalo').style.right = '-12px';


                document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('lineaPosicionRegalo').style.right = "";
                document.getElementById('MontoMaximoBloque').style.display = "none";


            }
            else {
                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('MontoMinimoBloque').style.display = 'block';

                document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                document.getElementById('lineaPosicionMontoMaximo').style.left = "";
                document.getElementById('MontoMaximoBloque').style.display = "block";

               
                var escala = 0;
                var lista = dataBarra.ListaEscalaDescuento;
                for (var i = 0; i < lista.length; i++) {
                    if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        //escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        escala = dataBarra.ListaEscalaDescuento[i].PorDescuento;
                        PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde; 
                        document.getElementById('MontoMinimoBloque').style.right = "";
                        document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';// 
                        document.getElementById('MontoMinimoBloque').style.display = 'block';

                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                        document.getElementById('MontoMaximoBloque').innerHTML = escala + "%  DSCTO";
                        document.getElementById('MontoMaximoBloque').style.top = "5px";
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoMinimo - 4) + '%';
                        document.getElementById('hrefIconoRegalo').style.display = 'block';

                        //if (montoActual > dataBarra.ListaEscalaDescuento[1].MontoDesde) {
                        //    document.getElementById('MontoMinimoBloque').style.display = 'none';
                        //    document.getElementById('lineaPosicionMontoMinimo').style.display = 'None';
                        //}

                        break;
                    }
                    else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                        document.getElementById('MontoMaximoBloque').innerHTML = "";
                    }

                }


                document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                document.getElementById('MontoMaximoBloque').style.right = "-14px";
                document.getElementById('MontoMaximoBloque').style.display = "block";
                if (montoActual >= dataBarra.ListaEscalaDescuento[3].MontoDesde) {
                    document.getElementById('MontoMaximoBloque').style.display = "none";
                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                }


            }
        }
        else
        {

            if (montoTipipoing != 0)
            {

                         if (montoActual < montoTipipoing) {

                    PosicionMontoMinimo = montoMinimo * 100 / montoTipipoing;
                    PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                    document.getElementById('MontoMinimoBloque').style.right = '';
                    document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';

                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                    document.getElementById('MontoMaximoBloque').style.display = 'none';


                    document.getElementById('hrefIconoRegalo').style.left = "";// (PosicionMontoTipipoing - 3) + '%';
                    document.getElementById('hrefIconoRegalo').style.right = '-11px';

                    document.getElementById('lineaPosicionRegalo').style.left = "";
                    document.getElementById('lineaPosicionRegalo').style.right = "0px";
                    //document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipipoing) + '%';
                    document.getElementById('lineaPosicionRegalo').style.display = 'block';

                }
                        else {
                    //---aca toy

                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';

                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "";
                    document.getElementById('MontoMaximoBloque').style.display = "block";


                    var escala = 0;
                    var lista = dataBarra.ListaEscalaDescuento;
                    for (var i = 0; i < lista.length; i++) {
                        if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                            //escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            escala = dataBarra.ListaEscalaDescuento[i].PorDescuento;
                            PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            PosicionMontoTipinpoing = montoTipipoing * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;

                            document.getElementById('MontoMinimoBloque').style.right = "";
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';// 
                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                            document.getElementById('MontoMaximoBloque').innerHTML = escala + "%  DSCTO";
                            document.getElementById('MontoMaximoBloque').style.top = "5px";
                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                            document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                            document.getElementById('lineaPosicionRegalo').style.display = 'block';


                            document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipinpoing - 4) + '%';
                            document.getElementById('hrefIconoRegalo').style.display = 'block';


                            if (montoActual > dataBarra.ListaEscalaDescuento[1].MontoDesde) {
                                document.getElementById('MontoMinimoBloque').style.display = 'none';
                                document.getElementById('lineaPosicionMontoMinimo').style.display = 'None';
                            }

                            break;
                        }
                        else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                            PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            PosicionMontoTipinpoing = montoTipipoing * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;

                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';// 

                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                            document.getElementById('MontoMaximoBloque').innerHTML = "";

                            if (montoActual > dataBarra.ListaEscalaDescuento[1].MontoDesde) {
                                document.getElementById('MontoMinimoBloque').style.display = 'none';
                                document.getElementById('lineaPosicionMontoMinimo').style.display = 'None';
                            }


                        }
                    }

                    if (montoActual > dataBarra.ListaEscalaDescuento[3].MontoDesde) {
                        PosicionMontoTipinpoing = montoTipipoing * 100 / montoActual;
                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipinpoing - 3) + '%';
                        document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                        document.getElementById('lineaPosicionRegalo').style.display = 'block';
                    }


                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                    document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                    document.getElementById('MontoMaximoBloque').style.right = "-14px";
                    document.getElementById('MontoMaximoBloque').style.display = "block";


                    if (montoActual >= dataBarra.ListaEscalaDescuento[3].MontoDesde) {
                        document.getElementById('MontoMaximoBloque').style.display = "none";
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                    }



                }

            }
            else
            {
                        if (montoActual < montoMinimo) {
                            PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;
                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                            document.getElementById('MontoMinimoBloque').style.left = '';
                            document.getElementById('MontoMinimoBloque').style.right = '-11px';
                            document.getElementById('MontoMinimoBloque').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                            document.getElementById('MontoMaximoBloque').style.display = 'none';
                            document.getElementById('hrefIconoRegalo').style.display = 'None';
                            document.getElementById('lineaPosicionRegalo').style.display = 'None';
                        }
                        else {
                            //---aca toy2

                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('MontoMinimoBloque').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMaximo').style.left = "";
                            document.getElementById('MontoMaximoBloque').style.display = "block";


                            var escala = 0;
                            var lista = dataBarra.ListaEscalaDescuento;
                            for (var i = 0; i < lista.length; i++) {
                                if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                                    escala = dataBarra.ListaEscalaDescuento[i].PorDescuento;
                                    PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                          
                                    document.getElementById('MontoMinimoBloque').style.right = "";
                                    document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                                    document.getElementById('MontoMaximoBloque').innerHTML = escala + "%  DSCTO";
                                    document.getElementById('MontoMaximoBloque').style.top = "5px";
                                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                                    document.getElementById('lineaPosicionRegalo').style.display = 'None';
                                    document.getElementById('hrefIconoRegalo').style.display = 'None';

                                    break;
                                }
                                else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                                    PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                                    document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';// 

                                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                                    document.getElementById('MontoMaximoBloque').innerHTML = "";



                                }
                            }


                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                            document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";//anchoBarraPorcentaje + 3 + 
                            //document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                            document.getElementById('MontoMaximoBloque').style.right = "-14px";
                            document.getElementById('MontoMaximoBloque').style.display = "block";


                            if (montoActual >= dataBarra.ListaEscalaDescuento[3].MontoDesde) {
                                document.getElementById('MontoMaximoBloque').style.display = "none";
                                document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                            }

                        }

            }

        }

    }

}

function CalculoLlenadoBarraDestokp() {
    var montoMaximo = dataBarra.MontoMaximo;
    var montoActual = mtoLogroBarra;
    var AvancePorcentaje = 0;


    if (TieneMontoMaximo()) {
        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
    }
    else {
        

        montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length-1].MontoDesde + 500;
        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);

    }

    return AvancePorcentaje;
}

function CalculoLlenadoBarraEspacioLimiteDestokp() {

    var montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length-1].MontoDesde + 500;
    var montoActual = mtoLogroBarra;
    var AvancePorcentaje;
 
    for (var i = 0; i < dataBarra.ListaEscalaDescuento.length; i++) {

        if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {

            var montoMaximo1 = dataBarra.ListaEscalaDescuento[i].MontoDesde;
            AvancePorcentaje = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
            break;
        }

    }

    //if (montoActual < dataBarra.ListaEscalaDescuento[0].MontoDesde) {

    //    var montoMaximo1 = dataBarra.ListaEscalaDescuento[0].MontoDesde;
    //    AvancePorcentaje = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);

    //} else if (montoActual < dataBarra.ListaEscalaDescuento[1].MontoDesde) {

    //    var montoMaximo1 = dataBarra.ListaEscalaDescuento[1].MontoDesde;
    //    AvancePorcentaje = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
    //} else if (montoActual < dataBarra.ListaEscalaDescuento[2].MontoDesde) {

    //    var montoMaximo1 = dataBarra.ListaEscalaDescuento[2].MontoDesde;
    //    AvancePorcentaje = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);

    //} else if (montoActual < dataBarra.ListaEscalaDescuento[3].MontoDesde) {

    //    var montoMaximo1 = dataBarra.ListaEscalaDescuento[3].MontoDesde;
    //    AvancePorcentaje = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
    //}

    return AvancePorcentaje;
}


function CalculoPosicionMinimoMaximoDestokp() {


    var TippingPointBarraActive = dataBarra.TippingPointBarra.Active;
    var montoMaximo = dataBarra.MontoMaximo;
    var montoTipipoing = dataBarra.TippingPoint;
    var montoActual = mtoLogroBarra;
    var montoMinimo = dataBarra.MontoMinimo;
    var PosicionMontoMinimo = 0;

    if (TieneMontoMaximo()) { /// se trata como tipinpoing
        if (ConfiguradoRegalo == true) {

            var AvancePorcentaje0 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
            document.getElementById('barra_0').style.left = AvancePorcentaje0;

            var AvancePorcentajeP0 = (AvancePorcentaje0.substring(0, AvancePorcentaje0.length - 1) * 1 - 7) + '%'
            document.getElementById('punto_0').style.left = AvancePorcentajeP0;


            var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
           if (document.getElementById('barra_1') != null) document.getElementById('barra_1').style.left = AvancePorcentaje1;

            var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 5) + '%'
            document.getElementById('punto_1').style.left = AvancePorcentajeP1;
            document.getElementById('punto_1').firstChild.firstChild.style = "width:90px;position: absolute;";//top: -24px;
            document.getElementById('punto_1').firstChild.firstChild.firstChild.firstChild.nextSibling.style.display = "None";


            document.getElementById('punto_2').style.left = '94%';
            document.getElementById('barra_2').style.left = '99.9%';

        }
        else {
            if (TippingPointBarraActive) {

                var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
                document.getElementById('barra_0').style.left = AvancePorcentaje1;

                var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
                document.getElementById('punto_0').style.left = AvancePorcentajeP1;



                var AvancePorcentaje2 = CalculoPorcentajeAvance(montoTipipoing, montoMaximo);
                if (document.getElementById('barra_1')!=null)  document.getElementById('barra_1').style.left = AvancePorcentaje2;

                var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 6) + '%'
                document.getElementById('punto_1').style.left = AvancePorcentajeP2;



                document.getElementById('punto_2').style.left = '94%';
                document.getElementById('barra_2').style.left = '99.9%';


            }
            else {
                if (ConfiguradoRegalo == true) {
                    var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
                    document.getElementById('barra_0').style.left = AvancePorcentaje1;

                    var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
                    document.getElementById('punto_0').style.left = AvancePorcentajeP1;


                    document.getElementById('punto_1').style.left = '94%';
                    document.getElementById('barra_1').style.left = '99.9%';


                }
                else {
                    // montoMaximo = montoMaximo - 10;
                    //AQUI

                    var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
                    document.getElementById('barra_0').style.left = AvancePorcentaje1;

                    var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
                    document.getElementById('punto_0').style.left = AvancePorcentajeP1;


                    document.getElementById('punto_1').style.left = '94%';
                    document.getElementById('barra_1').style.left = '99.9%';

                }
            }
        }
    }
    else { /// se trata como escala de descuento
        if (ConfiguradoRegalo == true) {


            //var htmleRgaloTipinpoing = ' <div id="punto_4" data-punto="0" class="EscalaDescuento" style="float: left; left: 2.1818%;"><div class="monto_minimo_barra"><div style="width: 90px; position: absolute; " data-texto=""><div class=""><div class="tippingPoint"></div><div class="monto_meta_tippingPoint" style="display: none;">S/.210</div></div></div></div></div>';//top: -24px;
  
          

             
                var htmlTipinpoing = '';
            if (tpElectivos.premioSelected == null) { 
                    //style = "display: block;"                                    
                    htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:2.1818%" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();"></a><div class="monto_meta_tippingPoint">S/.370</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion"  ><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';

                } else {
                    htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:2.1818%" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();"></a><div class="monto_meta_tippingPoint">S/.370</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="display: block;"><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';

                }

                document.getElementById('divBarraLimite').innerHTML = document.getElementById('divBarraLimite').innerHTML + htmlTipinpoing;
             



           


            montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde + 500;


            for (var j = 0; j < dataBarra.ListaEscalaDescuento.length; j++) {

                if (j == 0) {
                    var montoMaximo1 = dataBarra.ListaEscalaDescuento[j].MontoDesde
                    var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                    document.getElementById('barra_0').style.left = AvancePorcentaje1;

                    var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
                    document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                } else if (j == 1) {
                   
                    var montoMaximo2 = dataBarra.ListaEscalaDescuento[1].MontoDesde
                    var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                    document.getElementById('barra_1').style.left = AvancePorcentaje2;

                    var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 8) + '%'
                    document.getElementById('punto_1').style.left = AvancePorcentajeP2;
                }
                else {
                    var montoMaximo3 = dataBarra.ListaEscalaDescuento[j].MontoDesde
                    var AvancePorcentaje3 = CalculoPorcentajeAvance(montoMaximo3, montoMaximo);
                    document.getElementById('barra_'+j.toString()).style.left = AvancePorcentaje3;


                    var AvancePorcentajeP3 = (AvancePorcentaje3.substring(0, AvancePorcentaje3.length - 1) * 1 - 5) + '%'
                    document.getElementById('punto_' + j.toString()).style.left = AvancePorcentajeP3;

                }

            }



            //montoMaximo = dataBarra.ListaEscalaDescuento[3].MontoDesde + 500;

            //var montoMaximo1 = dataBarra.ListaEscalaDescuento[0].MontoDesde
            //var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
            //document.getElementById('barra_0').style.left = AvancePorcentaje1;

            //var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
            //document.getElementById('punto_0').style.left = AvancePorcentajeP1;



            //var montoMaximo2 = dataBarra.ListaEscalaDescuento[1].MontoDesde
            //var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
            //document.getElementById('barra_1').style.left = AvancePorcentaje2;

            //var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 8) + '%'
            //document.getElementById('punto_1').style.left = AvancePorcentajeP2;



            //var montoMaximo3 = dataBarra.ListaEscalaDescuento[2].MontoDesde
            //var AvancePorcentaje3 = CalculoPorcentajeAvance(montoMaximo3, montoMaximo);
            //document.getElementById('barra_2').style.left = AvancePorcentaje3;


            //var AvancePorcentajeP3 = (AvancePorcentaje3.substring(0, AvancePorcentaje3.length - 1) * 1 - 5) + '%'
            //document.getElementById('punto_2').style.left = AvancePorcentajeP3;



            //var montoMaximo4 = dataBarra.ListaEscalaDescuento[3].MontoDesde
            //var AvancePorcentaje4 = CalculoPorcentajeAvance(montoMaximo4, montoMaximo);
            //document.getElementById('barra_3').style.left = AvancePorcentaje4;

            //var AvancePorcentajeP4 = (AvancePorcentaje4.substring(0, AvancePorcentaje4.length - 1) * 1 - 5) + '%'
            //document.getElementById('punto_3').style.left = AvancePorcentajeP4;



        }
        else {

            montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde + 500;


            for (var i = 0; i < dataBarra.ListaEscalaDescuento.length; i++) {

                if (i == 0) {
                    var montoMaximo1 = dataBarra.ListaEscalaDescuento[i].MontoDesde
                    var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                    document.getElementById('barra_0').style.left = AvancePorcentaje1;

                    var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
                    document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                } else {
                    var montoMaximo2 = dataBarra.ListaEscalaDescuento[i].MontoDesde
                    var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                    document.getElementById('barra_'+i.toString()).style.left = AvancePorcentaje2;

                    var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 5) + '%'
                    document.getElementById('punto_' +i.toString()).style.left = AvancePorcentajeP2;

                }

            }
           

            //var montoMaximo1 = dataBarra.ListaEscalaDescuento[0].MontoDesde
            //var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
            //document.getElementById('barra_0').style.left = AvancePorcentaje1;

            //var AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%'
            //document.getElementById('punto_0').style.left = AvancePorcentajeP1;


            //var montoMaximo2 = dataBarra.ListaEscalaDescuento[1].MontoDesde
            //var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
            //document.getElementById('barra_1').style.left = AvancePorcentaje2;

            //var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 5) + '%'
            //document.getElementById('punto_1').style.left = AvancePorcentajeP2;



            //var montoMaximo3 = dataBarra.ListaEscalaDescuento[2].MontoDesde
            //var AvancePorcentaje3 = CalculoPorcentajeAvance(montoMaximo3, montoMaximo);
            //document.getElementById('barra_2').style.left = AvancePorcentaje3;


            //var AvancePorcentajeP3 = (AvancePorcentaje3.substring(0, AvancePorcentaje3.length - 1) * 1 - 5) + '%'
            //document.getElementById('punto_2').style.left = AvancePorcentajeP3;



            //var montoMaximo4 = dataBarra.ListaEscalaDescuento[3].MontoDesde
            //var AvancePorcentaje4 = CalculoPorcentajeAvance(montoMaximo4, montoMaximo);
            //document.getElementById('barra_3').style.left = AvancePorcentaje4;

            //var AvancePorcentajeP4 = (AvancePorcentaje4.substring(0, AvancePorcentaje4.length - 1) * 1 - 5) + '%'
            //document.getElementById('punto_3').style.left = AvancePorcentajeP4;

           

            if (montoTipipoing != 0) {
                 
                    var htmlTipinpoing = '';

                 if (tpElectivos.premioSelected == null) {

                        htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:8%" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();"></a><div class="monto_meta_tippingPoint">S/.370</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" ><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';

                    } else {

                        htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + ' data-punto="0" style="float: left;top:-52px; z-index: 200;left:8%" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();"></a><div class="monto_meta_tippingPoint">S/.370</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="display: block;"><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';

                    }

                    document.getElementById('divBarraLimite').innerHTML = document.getElementById('divBarraLimite').innerHTML + htmlTipinpoing;


                 

               


            }


        }

        //aparicion de bandera
        if (dataBarra.ListaEscalaDescuento.length > 1) {
            if (mtoLogroBarra > dataBarra.ListaEscalaDescuento[0].MontoDesde * 1) {
                document.getElementsByClassName('bandera_marcador')[0].style.display = 'block';
                $(".barra_mensaje_meta_pedido").css('margin-bottom', '51px');
            }

        }
    }

}

function CalculoPosicionMensajeDestokp() {
    document.getElementById('divBarraMensajeLogrado').firstChild.nextSibling.style.float = 'left';
    var montoActual = mtoLogroBarra;
    var montoMaximo = dataBarra.MontoMaximo;


    var AvancePorcentaje;
    if (TieneMontoMaximo()) {
        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
    }
    else {
        montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde + 500;
        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);

    }



    

    if (AvancePorcentaje.substring(0, AvancePorcentaje.length - 1) * 1 > 66) {
        AvancePorcentaje = '67%';
    }

    document.getElementById('divBarraMensajeLogrado').style.marginLeft = AvancePorcentaje;
}

function TieneMontoMaximo() {
    return dataBarra.MontoMaximo != 0 &&
        dataBarra.MontoMaximo != "" &&
        dataBarra.MontoMaximo != null &&
        dataBarra.MontoMaximo.toString().substring(0, 4) != "9999";
}
 
function CalculoPorcentajeAvance(montoActual, montoMaximo) {
    var AvancePorcentaje = (montoActual * 100) / montoMaximo;
    return (AvancePorcentaje) + '%';
}

function tryLoadPedidoDetalle() {
    if (typeof CargarPedido === "function") {
        CargarPedido();
    } else if (typeof CargarDetallePedido === "function") {
        CargarDetallePedido();
    }
}

function AgregarPremio(premio) {
    AbrirLoad();
    var params = {
        //CuvTonos: $.trim(cuvs),
        CUV: $.trim(premio.CUV2),
        Cantidad: 1,
        //TipoEstrategiaID: premio.TipoEstrategiaID,
        //EstrategiaID: $.trim(premio.EstrategiaID),
        //OrigenPedidoWeb: $.trim(origenPedidoWebEstrategia),
        //TipoEstrategiaImagen: 0,
        FlagNueva: $.trim(premio.FlagNueva)
    };

    return InsertarPremio(params);
}

function InsertarPremio(model) {   
    
    return jQuery.ajax({
        type: 'POST',
        url: baseUrl + "Pedido/PedidoInsertar",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: true,
        cache: false
    }).then(function (data) {
        CerrarLoad();

        if (!checkTimeout(data)) {
            return false;
        }

        if (data.success != true) {
            messageInfoError(data.message);
            return false;
        }

        tryLoadPedidoDetalle();

        return data;
    });
};
