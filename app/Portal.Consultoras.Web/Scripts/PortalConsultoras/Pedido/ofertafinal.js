var tipoOrigen = tipoOrigen || "";// 1: escritorio      2: mobile

function MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar) {
    var aux = "of";
    if (tipoOrigen == "2") {
        aux = "h";
    }

    $('.js-slick-prev-' + aux).remove();
    $('.js-slick-next-' + aux).remove();
    $('#divCarruselOfertaFinal.slick-initialized').slick('unslick');

    $('#divCarruselOfertaFinal').html('<div style="text-align: center;">Actualizando Productos de Oferta Final<br><img src="' + urlLoad + '" /></div>');

    SetHandlebars("#ofertaFinal-template", cumpleOferta.productosMostrar, "#divCarruselOfertaFinal");


    if (tipoOrigen == "2") {
        $("#popupOfertaFinal").show();
        $('#divCarruselOfertaFinal').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p', // popup
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev-h" style="left: 0.5%; top: 7%;"><img src="/Content/Images/mobile/Esika/previous_ofertas_home.png" style="width:100%; height:auto;" /></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next-h" style="right: 0.5%; top: 7%;"><img src="/Content/Images/mobile/Esika/next.png" style="width:100%; height:auto;" /></a>'
        });
    }
    else {
        $("#divOfertaFinal").show();
        $('#divCarruselOfertaFinal').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            centerMode: false,
            centerPadding: '0',
            tipo: 'p', // popup
            prevArrow: '<a class="previous_ofertas js-slick-prev-of" style="left:-10%;" ><img src="/Content/Images/Esika/previous_ofertas_home.png" style="width:100%; height:auto;" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas next js-slick-next-of" style="right:-9.7%;"><img src="/Content/Images/Esika/next.png" style="width:100%; height:auto;" alt="" /></a>'
        });
    }
    $('#divCarruselOfertaFinal').prepend($(".js-slick-prev-" + aux));
    $('#divCarruselOfertaFinal').prepend($(".js-slick-next-" + aux));
    
    CargandoValoresPopupOfertaFinal(tipoPopupMostrar, cumpleOferta.montoFaltante, cumpleOferta.porcentajeDescuento);
    
    var contenedorMostrarInicial = $(".content_item_carrusel_ofertaFinal.slick-active")[0];
    var cuvMostrado = $(contenedorMostrarInicial).find(".hdOfertaFinalCuv").val();
    AgregarOfertaFinalLog(cuvMostrado, 0, tipoOfertaFinal_Log, gap_Log);
}

function CargandoValoresPopupOfertaFinal(tipoPopupMostrar, montoFaltante, porcentajeDescuento) {

    var formatoMontoFaltante = DecimalToStringFormat(montoFaltante);
    var montoMinimo = DecimalToStringFormat(parseFloat($("#hdMontoMinimo").val()));

    $('#spCabeceraMontominimo').hide();

    if (tipoPopupMostrar == 1) {
        $("#divIconoOfertaFinal").removeClass("icono_exclamacion");
        $("#divIconoOfertaFinal").addClass("icono_aprobacion");
        $("#spnTituloOfertaFinal").html("RESERVASTE TU<b>&nbsp;PEDIDO CON ÉXITO!</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $("#spnMensajeOfertaFinal").html("&nbsp;para conseguir " + porcentajeDescuento + "% DSCTO y ganar más esta campaña.");
        if (viewBagPaisID == 3) {
            $("#spnSubTituloOfertaFinal").html("Alcanza el " + porcentajeDescuento + "% DSCTO con estas ofertas que tenemos solo para ti");
        } else if (viewBagPaisID == 11) {
            $("#spnSubTituloOfertaFinal").html("Alcanza el " + porcentajeDescuento + "% DSCTO con estos productos que tenemos para ti");
        }
    }
    else {
        $("#divIconoOfertaFinal").removeClass("icono_aprobacion");
        $("#divIconoOfertaFinal").addClass("icono_exclamacion");
        $("#spnTituloOfertaFinal").html("TODAVÍA<b>&nbsp;TE FALTA UN POCO...</b>");
        $("#spnMontoFaltanteOfertaFinal").html(formatoMontoFaltante);
        $('#spMontoMinimoCabecera').html(montoMinimo);
        $('#spCabeceraMontominimo').show();
        $("#spnMensajeOfertaFinal").html("&nbsp;para poder pasar tu pedido.");
        if (viewBagPaisID == "3") {
            $("#spnSubTituloOfertaFinal").html("Completa tu pedido con estas ofertas que tenemos solo para ti");
        } else if (viewBagPaisID == "11") {
            $("#spnSubTituloOfertaFinal").html("Completa tu pedido con estos productos que tenemos para ti");
        }
    }
    if (tipoOrigen == "2") 
        $("#popupOfertaFinal").show();
    else
        $("#divOfertaFinal").show();
}

function CumpleOfertaFinalMostrar(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var cumpleOferta = CumpleOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
    if (cumpleOferta.resultado) {
        MostrarPopupOfertaFinal(cumpleOferta, tipoPopupMostrar);
    }
    return cumpleOferta;
}

function CumpleOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var resultado = false;
    var productosMostrar = new Array();
    var montoFaltante = 0;
    var porcentajeDescuento = 0;

    var tipoOfertaFinal = $("#hdOfertaFinal").val();
    var esOfertaFinalZonaValida = $("#hdEsOfertaFinalZonaValida").val();
    var esFacturacion = $("#hdEsFacturacion").val();

    if (tipoOfertaFinal == "1" || tipoOfertaFinal == "2")
        resultado = true;

    if (resultado) {
        if (esFacturacion == "True" && esOfertaFinalZonaValida == "True")
            resultado = true;
        else
            resultado = false;
    }

    if (resultado) {
        var cumpleParametria = CumpleParametriaOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl);
        if (cumpleParametria.resultado) {
            montoFaltante = cumpleParametria.montoFaltante;
            porcentajeDescuento = cumpleParametria.porcentajeDescuento;
            var productoOfertaFinal = ObtenerProductosOfertaFinal(tipoOfertaFinal);
            var listaProductoOfertaFinal = productoOfertaFinal.lista;
            var limite = productoOfertaFinal.limite;

            if (listaProductoOfertaFinal != null) {
                var contador = 0;
                $.each(listaProductoOfertaFinal, function (index, value) {
                    if (value.PrecioCatalogo >= montoFaltante && value.PrecioCatalogo > cumpleParametria.precioMinimoOfertaFinal) {
                        productosMostrar.push(value);
                        contador++;
                        //return false;

                        if (contador >= limite)
                            return false;
                    }
                });

                if (productosMostrar.length == 0) {
                    resultado = false;
                } else {
                    resultado = true;
                }
            } else {
                resultado = false;
            }
        }
        else
            resultado = false;
    }

    return {
        resultado: resultado,
        productosMostrar: productosMostrar,
        montoFaltante: montoFaltante,
        porcentajeDescuento: porcentajeDescuento
    };
}

function CumpleParametriaOfertaFinal(monto, tipoPopupMostrar, codigoMensajeProl, listaObservacionesProl) {
    var resultado = false;
    var montoFaltante = 0;
    var porcentajeDescuento = 0;
    var precioMinimoOfertaFinal = 0;

    //Escala
    if (tipoPopupMostrar == 1) {
        var esConsultoraNueva = $("#hdEsConsultoraNueva").val();
        if (esConsultoraNueva == "False") {
            if (codigoMensajeProl == "00") {
                var escalaDescuento = null;
                var escalaDescuentoSiguiente = null;

                $.each(listaEscalaDescuento, function (index, value) {
                    if (value.MontoHasta >= monto) {
                        escalaDescuento = value;

                        if (index <= listaEscalaDescuento.length - 1) {
                            escalaDescuentoSiguiente = listaEscalaDescuento[index + 1];
                        } else {
                            escalaDescuentoSiguiente = null;
                        }

                        return false;
                    }
                });

                if (escalaDescuento == null) {
                    resultado = false;
                } else {
                    
                    escalaDescuento.MontoHasta = Math.ceil(escalaDescuento.MontoHasta);

                    var diferenciaMontoEd = escalaDescuento.MontoHasta - monto;
                    var parametriaEd = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "E" + escalaDescuento.PorDescuento) : null;

                    if (parametriaEd != null && parametriaEd.length != 0) {
                        if (parametriaEd[0].MontoDesde <= diferenciaMontoEd && parametriaEd[0].MontoHasta >= diferenciaMontoEd) {
                            montoFaltante = diferenciaMontoEd;
                            porcentajeDescuento = escalaDescuentoSiguiente.PorDescuento;
                            precioMinimoOfertaFinal = parametriaEd[0].PrecioMinimo;
                            tipoOfertaFinal_Log = "E" + escalaDescuentoSiguiente.PorDescuento;
                            gap_Log = montoFaltante;
                            resultado = true;
                        } else {
                            resultado = false;
                        }
                    } else {
                        resultado = false;
                    }
                }
            }
        }
    } else {
        //Monto Minimo y Maximo
        if (codigoMensajeProl == "01") {
            if (listaObservacionesProl.length == 1) {
                var tipoError = listaObservacionesProl[0].Caso;

                if (tipoError == 95) {
                    //var mensajePedido = listaObservacionesProl[0].Descripcion || "";
                    var mensajeCUV = listaObservacionesProl[0].CUV;

                    if (mensajeCUV == "XXXXX") {
                        var montoMinimo = parseFloat($("#hdMontoMinimo").val());
                        var diferenciaMonto = montoMinimo - monto;

                        var parametria = listaParametriaOfertaFinal != null ? listaParametriaOfertaFinal.Find("TipoParametriaOfertaFinal", "MM") : null;

                        if (parametria != null && parametria.length != 0) {
                            if (parametria[0].MontoDesde <= diferenciaMonto && parametria[0].MontoHasta >= diferenciaMonto) {
                                montoFaltante = diferenciaMonto;
                                precioMinimoOfertaFinal = parametria[0].PrecioMinimo;

                                tipoOfertaFinal_Log = "MM";
                                gap_Log = montoFaltante;                                

                                resultado = true;
                            } else {
                                resultado = false;
                            }
                        } else {
                            resultado = false;
                        }
                    } else {
                        resultado = false;
                    }
                } else {
                    resultado = false;
                }
            }
            else {
                resultado = false;
            }
        }
    }

    return {
        resultado: resultado,
        montoFaltante: montoFaltante,
        porcentajeDescuento: porcentajeDescuento,
        precioMinimoOfertaFinal: precioMinimoOfertaFinal
    };
}

function ObtenerProductosOfertaFinal(tipoOfertaFinal) {
    var item = { tipoOfertaFinal: tipoOfertaFinal };

    var lista = null;
    var limite = 0;

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'Pedido/ObtenerProductosOfertaFinal',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: false,
        cache: false,
        success: function (response) {
            if (checkTimeout(response)) {
                if (response.success) {
                    lista = response.data;
                    limite = response.limiteJetlore;
                } else {
                    lista = null;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                //alert_msg(data.message);
                lista = null;
                //CerrarSplash();
            }
        }
    });

    return {
        lista: lista,
        limite: limite
    };
}
