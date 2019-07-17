var dataEncuesta = {};
var buttonConfirmSurvey = false;

var EncuestaSatisfaccion = (function () {
    var _elementos = {
        bgEncuestaDesktop: ".bg__popup__encuestaSatisfaccion__desktop",
        encuestaSatisfaccion: "#EncuestaSatisfaccion",
        divInconvenienteOSugerencia: "#divInconvenienteOSugerencia",
        estadoEncuestaSatisfaccion: ".encuesta__satisfaccion__estado__enlace",
        motivosCalificacion: ".seccion__encuesta__satisfaccion__motivosCalificacion",
        enlaceCerrarEncuestaSatisfaccion: ".enlace__cerrar__encuesta__satisfaccion",
        txtOtroMotivoCalificacion: "#txtOtroMotivoCalificacion",
        chkOtroMotivoCalificacion:"#chkOtroMotivoCalificacion",
        ListaMotivo: "#ListaMotivo",
        hdfCalificacionId: "#hdfCalificacionId",
        hdfEncuestaId: "#hdfEncuestaId",
        hdfCodigoCampania: "#hdfCodigoCampania",
        numCampania: "#numCampania",
        PopUpEncuesta:"#PopUpEncuesta",
        Paso1: "#Paso1",
        Paso2:"#Paso2",
        btnConfirmar: "#btnConfirmaMotivo"
    };
    var _config = {

    };
    var _funciones = {
        InicializarEventos: function () {
            $(document).on("click", _elementos.enlaceCerrarEncuestaSatisfaccion, _eventos.cerrarEncuestaSatisfaccion);
            $(_elementos.txtOtroMotivoCalificacion).on("keyup", function () {
                _funciones.ValidarSeleccionMotivo();
                if ($(this).val().length === 0 && !buttonConfirmSurvey) {
                    $(_elementos.btnConfirmar).addClass("btn__sb--disabled");
                } else {
                    $(_elementos.btnConfirmar).removeClass("btn__sb--disabled");
                }
            });
            $(_elementos.btnConfirmar).on("click", function () {
                _funciones.GrabarEncuesta(function (result) {
                    if (result.success) {
                        $(_elementos.Paso1).fadeOut(150);
                        $(_elementos.Paso2).fadeIn(200);
                        setTimeout(function () {
                            $(_elementos.PopUpEncuesta).fadeOut(250);
                        }, 2850);
                    } else {
                        $(_elementos.PopUpEncuesta).fadeOut(250);
                    }
                });
            });
            _funciones.ObtenerDataEncuesta(function () {
                if (dataEncuesta.hasOwnProperty("EncuestaCalificacion")) {
                    SetHandlebars("#template-encuesta-calificacion", dataEncuesta.EncuestaCalificacion, "#listaCalificacion");
                    $(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion--ocultar');
                    if (window.matchMedia("(min-width: 992px)").matches) {
                        $(_elementos.bgEncuestaDesktop).addClass("bg__popup__encuestaSatisfaccion__desktop--mostrar");
                    } else {
                        $(_elementos.bgEncuestaDesktop).removeClass("bg__popup__encuestaSatisfaccion__desktop--mostrar");
                    }
                    $(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion--mostrar');
                    
                }
            });
        },
        ObtenerDataEncuesta: function (callbackWhenFinish) {
            var url = urlObtenerDataEncuesta;
            _funciones.callAjax(url, {}, function (d) {
                if (d.mostrarEncuesta) {
                    $(_elementos.hdfEncuestaId).val(d.data.EncuestaId);
                    $(_elementos.hdfCodigoCampania).val(d.data.CodigoCampania);
                    var codigoCampania = d.data.CodigoCampania.substr(4, 6);
                    $(_elementos.numCampania).text("C"+codigoCampania);
                    dataEncuesta = d.data;
                }
                if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                    callbackWhenFinish();
                }
            });
        },
        ObtenerMotivoPorCalificacion: function (el) {
            var calificacionId = parseInt($(el).attr("data-codigo"));
            $(_elementos.hdfCalificacionId).val(calificacionId);
            var tipoCalificacion = parseInt($(el).attr("data-tipocalificacion"));
            if (tipoCalificacion === 2) {
                $(_elementos.Paso1).fadeOut(150);
                $(_elementos.encuestaSatisfaccion).addClass("seccion__encuesta__satisfaccion__expandir");
                _funciones.GrabarEncuesta(function (result) {
                    if (result.success) {
                        $(_elementos.Paso2).fadeIn(200);
                        setTimeout(function () {
                            $(_elementos.PopUpEncuesta).fadeOut(250);
                        }, 2850);
                    } else {
                        $(_elementos.PopUpEncuesta).fadeOut(250);
                    }
                });
            } else {
                //set values
                buttonConfirmSurvey = false;
                $(_elementos.chkOtroMotivoCalificacion).prop("checked", false);
                $(_elementos.divInconvenienteOSugerencia).removeClass("d-flex").addClass("d-none");
                $(_elementos.txtOtroMotivoCalificacion).val("");
                $(_elementos.btnConfirmar).addClass("btn__sb--disabled");
                var $motivo = $(_elementos.motivosCalificacion);
                var arrData = _funciones.ObtenerCalificacionById(calificacionId);

                $motivo.removeClass('seccion__encuesta__satisfaccion__motivosCalificacion--mostrar');
                $motivo.fadeOut(10);

                //filtrar solo los motivos 1
                var arrMotivo = $.grep(arrData[0].EncuestaMotivo, function (mot) {
                    return mot.TipoEncuestaMotivoId === 1;
                });

                SetHandlebars("#template-encuesta-motivo", arrMotivo, "#ListaMotivo");

                if (!$(_elementos.encuestaSatisfaccion).is('.seccion__encuesta__satisfaccion__expandir')) {
                    $(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion__expandir');
                    $(_elementos.btnConfirmar).fadeIn(100);
                }
                $(_elementos.estadoEncuestaSatisfaccion).addClass('encuesta__satisfaccion__disabled');
                $(el).removeClass('encuesta__satisfaccion__disabled');
                $motivo.fadeIn(10);
                $motivo.addClass('seccion__encuesta__satisfaccion__motivosCalificacion--mostrar');
            }
        },
        ObtenerCalificacionById: function (id) {
            var arrCalif = $.grep(dataEncuesta.EncuestaCalificacion, function (cal) {
                return cal.EncuestaCalificacionId === id;
            });
            return arrCalif;
        },
        ObtenerMotivoByCalificacionYTipo: function (calificacionId, tipoMotivoId) {
            var arrCalif = _funciones.ObtenerCalificacionById(calificacionId);
            var arrMotivo = $.grep(arrCalif[0].EncuestaMotivo, function (mot) {
                return mot.TipoEncuestaMotivoId === tipoMotivoId;
            });
            return arrMotivo;
        },
        MostrarOcultarOtro: function (el) {
            var check = $(el).is(":checked");
            if (check)
                $(_elementos.divInconvenienteOSugerencia).removeClass("d-none").addClass("d-flex");
            else {
                $(_elementos.divInconvenienteOSugerencia).removeClass("d-flex").addClass("d-none");
                $(_elementos.txtOtroMotivoCalificacion).val("");
            }
        },
        ActivarODeshabilitarBotonConfirmar: function () {
            _funciones.ValidarSeleccionMotivo();
            if (buttonConfirmSurvey)
                $(_elementos.btnConfirmar).removeClass("btn__sb--disabled");
            else 
                $(_elementos.btnConfirmar).addClass("btn__sb--disabled");
        },
        ValidarSeleccionMotivo: function () {
            var elementsChecks = $(_elementos.ListaMotivo).find("input[type=checkbox]");
            var cantidad = $(_elementos.txtOtroMotivoCalificacion).val().length;
            if (cantidad > 0) {
                buttonConfirmSurvey = true;
                return false;
            }
            elementsChecks.each(function (index, element) {
                if ($(element).is(':checked')) {
                    buttonConfirmSurvey = true;
                    return false;
                } else {
                        buttonConfirmSurvey = false;
                }
            });
        },
        GrabarEncuesta: function (callbackSuccessful) {
            var url = urlGrabarEncuesta;
            var sendData = {
                EncuestaId: parseInt($(_elementos.hdfEncuestaId).val()),
                EncuestaCalificacionId: parseInt($(_elementos.hdfCalificacionId).val()),
                CodigoCampania: $(_elementos.hdfCodigoCampania).val(),
                EncuestaMotivo : _funciones.ObtenerMotivoSeleccionado()
            };
            _funciones.callAjax(url, sendData, function (data) {               
                if (callbackSuccessful && typeof callbackSuccessful === "function") {
                    callbackSuccessful(data);
                }
            });
        },
        ObtenerMotivoSeleccionado: function () {
            var motivoSeleccionado = [];
            var arrMotivoOtro = [];
            var idCalif = parseInt($(_elementos.hdfCalificacionId).val());
            var arrCalif = _funciones.ObtenerCalificacionById(idCalif);
            if (arrCalif[0].TipoCalificacion === 2) {
                arrMotivoOtro = _funciones.ObtenerMotivoByCalificacionYTipo(idCalif, 3);
                if (arrMotivoOtro.length > 0) {
                    var obj = {
                        EncuestaMotivoId: arrMotivoOtro[0].EncuestaMotivoId,
                        Observacion: null
                    }
                    motivoSeleccionado.push(obj);
                }
            }

            $(_elementos.ListaMotivo + " input:checked").each(function () {
                var obj = {
                    EncuestaMotivoId: $(this).attr("name"),
                    Observacion : null
                };
                motivoSeleccionado.push(obj);
            });
            
            if ($(_elementos.txtOtroMotivoCalificacion).val().length > 0) {
                arrMotivoOtro = _funciones.ObtenerMotivoByCalificacionYTipo(idCalif, 2);
                if (arrMotivoOtro.length > 0) {
                    var obj = {
                        EncuestaMotivoId: arrMotivoOtro[0].EncuestaMotivoId,
                        Observacion: $(_elementos.txtOtroMotivoCalificacion).val()
                    }
                    motivoSeleccionado.push(obj);
                }
            }
            return motivoSeleccionado;
        },
        callAjax: function (pUrl, pSendData, callbackSuccessful, callbackError) {
            var sendData = typeof pSendData === "undefined" ? {} : pSendData;
            $.ajax({
                type: "POST",
                url: pUrl,
                beforeSend: function () {
                    waitingDialog();
                },
                complete: function () {
                    closeWaitingDialog();
                },
                data: JSON.stringify(sendData),
                contentType: "application/json; charset=utf-8",
                async: true,
                dataType: "json",
                success: function (result) {
                    if (callbackSuccessful && typeof callbackSuccessful === "function") {
                        callbackSuccessful(result);
                    }
                },
                error: function (msg) {
                    closeWaitingDialog();
                    if (callbackError && typeof callbackError === "function") {
                        callbackError(msg);
                    }
                }
            });
}
    };
    var _eventos = {
        abrirEncuestaSatisfaccionConMotivosCalificacion: function (e) {
            e.preventDefault();
            if (!$(_elementos.encuestaSatisfaccion).is('.seccion__encuesta__satisfaccion__expandir')) {
                $(this).parents(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion__expandir');
                $(_elementos.btnConfirmar).fadeIn(100);
            }
            $(_elementos.estadoEncuestaSatisfaccion).addClass('encuesta__satisfaccion__disabled');
            $(this).removeClass('encuesta__satisfaccion__disabled');
            _funciones.mostrarMotivosCalificacionSegunEstado();
        },
        cerrarEncuestaSatisfaccion: function (e) {
            e.preventDefault();
            $(_elementos.btnConfirmar).fadeOut(100);
            $(_elementos.encuestaSatisfaccion).removeClass('seccion__encuesta__satisfaccion--mostrar');
            $(_elementos.encuestaSatisfaccion).addClass('seccion__encuesta__satisfaccion--ocultar');
        }
    };
    function Inicializar() {
        _funciones.InicializarEventos();
    }
    return {
        Inicializar: Inicializar,
        Funciones: _funciones
    };

})();

$(document).ready(function () {
    EncuestaSatisfaccion.Inicializar();
});