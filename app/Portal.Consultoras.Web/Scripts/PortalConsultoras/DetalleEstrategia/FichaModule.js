var FichaModule = (function (config) {
    "use strict";
    var localStorageModule;
    var _primeraMarca = "";
    var _ultimaMarca = "";
    var _esMultimarca = false;
    var _estrategia;

    var _config = {
        palanca: config.palanca || "",
        origen: config.origen || "",
        tieneSession: config.tieneSession || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlObtenerComponentes: config.urlObtenerComponentes
    };

    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _codigoPalanca = ConstantesModule.CodigosPalanca;
    var _constantePalanca = ConstantesModule.ConstantesPalanca;

    var _elementos = {
        idDataEstrategia: "#data-estrategia",
        dataClicked: "[data-clicked]",
        dataChange: "[data-change]",
        dataSelected: "[data-select-area]",
        idPlantillaProductoLanding: "#producto-landing-template",
        divCarruselSetsProductosRelacionados: "#divOfertaProductos",
        divSetsProductosRelacionados: "#set_relacionados",
        footerPage: ".footer-page",
        estrategiaBreadcrumb: "#estrategia-breadcrumb",
        marca: "#marca"
    };

    var _atributos = {
        dataEstrategia: "data-estrategia",
        dataClicked: "[data-clicked]",
        dataChange: "[data-change]",
        dataSelected: "[data-select-area]"
    };

    var _seccionesFichaProducto = {
        //EtiquetaLanzamientos: "#EtiquetaLanzamientos",
        ImagenDeFondo: "#ImagenDeFondo",
        //DescripcionAdicional: "#DescripcionAdicional",
        ContenidoProducto: "#ContenidoProducto",
        CarruselProducto: "#CarruselProducto",
        //EtiquetaOdd: "#EtiquetaOdd",
        //SloganLanzamientos: "#SloganLanzamientos",
        //ContenedoFotoReferencial: "#contenedor_foto_referencial",
        ContenedoFichaEtiquetas: "#contenedor_ficha_etiquetas",
        Contenedor_redes_sociales: "#Contenedor_redes_sociales",
        //EtiquetaPackNuevas: "#EtiquetaPackNuevas"
        //SloganPackNuevas: "#SloganPackNuevas",
        ImagenProducto: "#FichaImagenProducto",
        dvContenedorAgregar: "#dvContenedorAgregar"
    };

    var _tabsFichaProducto = {
        detalleProducto: "#div_ficha_tab1",
        detallePack: "#div_ficha_tab2",
        tipsVenta: "#div_ficha_tab3",
        beneficios: "#div_ficha_tab4",
        video: "#div_ficha_tab5",
    };

    var _seccionesFichaTabProducto = {
        ContenidoProductoDetalleProducto: "#contenido_1",
        ContenidoProductoDetallePack: "#contenido_2",
        ContenidoProductoTipsVenta: "#contenido_3",
        ContenidoProductoBeneficios: "#contenido_4",
        ContenidoProductoVideo: "#contenido_5"
    }

    var _getParamValueFromQueryString = function (queryStringName) {
        queryStringName = queryStringName || "";
        queryStringName = queryStringName.toLowerCase();
        var queryStringValue = "";
        var stringUrlParameters = location.href.toLowerCase().split("?");
        if (stringUrlParameters.length > 1 && queryStringName != "") {
            var arrParameterString = stringUrlParameters[1].split("&");
            $.each(arrParameterString, function (index, stringParameter) {
                var items = stringParameter.split("=");
                var parameterName = $.trim(items[0]);
                var parameterValue = $.trim(items[1]);
                if (parameterName == queryStringName) {
                    queryStringValue = parameterValue;
                    return false;
                }
            });
        }
        return queryStringValue;
    };

    var _eventos =
        {
            clickChange: function () {

            },
            mouseMove: function () {

            },
            mouseLeaveSelectArea: function () {

            }
        };

    var _bindingEvents = function () {
        $("body").on("click", _elementos.dataClicked, _eventos.clickChange);

        if (!isMobile()) {
            $(document).on("mousemove", _elementos.dataChange, _eventos.mouseMove);
            $(document).on("mouseleave", _elementos.dataSelected, _eventos.mouseLeaveSelectArea);
        }
    };

    var _crearReloj = function (estrategia) {
        $("#clock").each(function (index, elem) {
            $(elem).FlipClock(estrategia.TeQuedan,
                {
                    countdown: true,
                    clockFace: "HourlyCounter",
                    language: "es-es"
                });
        });
    };

    var _crearTabs = function () {

        for (var i = 1; i <= 5; i++) {

            var FichaTabElement = document.getElementById("ficha_tab_" + i.toString());

            if (FichaTabElement) {

                if (FichaTabElement.checked) {
                    document.getElementById("contenido_" + i.toString()).style.display = "block";
                }

                FichaTabElement.onclick = function (event) {
                    var numID = event.target.getAttribute("data-numTab");

                    for (var j = 1; j <= 5; j++) {
                        document.getElementById("contenido_" + j.toString()).style.display = "none";
                    }

                    document.getElementById("contenido_" + numID.toString()).style.display = "block";
                };

            }
        }

        $("ul.ficha_tabs li a").click(function () {
            $(this).parent().children("ul").slideToggle();
            var clase = $(this).attr("class");
            if (clase == "active") {
                $(this).attr("class", "tab-link");
            }
            else {
                $(this).attr("class", "active");
            }
        });
    };

    var _promiseObternerComponentes = function (params) {
        var dfd = $.Deferred();

        $.ajax({
            type: "POST",
            url: _config.urlObtenerComponentes,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: false,
            cache: false,
            success: function (data) {
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _verificarVariedad = function (estrategia) {
        if (!IsNullOrEmpty(estrategia.CodigoVariante)) {// && estrategia.CodigoVariante !== ConstantesModule.CodigoVariedad.IndividualVariable
            var param = {
                estrategiaId: estrategia.EstrategiaID,
                campania: _config.campania,
                codigoVariante: estrategia.CodigoVariante,
                codigoEstrategia: estrategia.CodigoEstrategia
            };
            _promiseObternerComponentes(param).done(function (data) {
                estrategia.Hermanos = data.componentes;
                estrategia.EsMultimarca = data.esMultimarca;
                _esMultimarca = data.esMultimarca;
            }).fail(function (data, error) {
                estrategia.Hermanos = [];
                estrategia.EsMultimarca = false;
            });

            return true;
        }
        else {
            estrategia.Hermanos = {};
            estrategia.EsMultimarca = false;
            return false;
        }
    };

    var _actualizarVariedad = function (estrategia) {
        estrategia.Hermanos = estrategia.Hermanos || [];
        if (estrategia.Hermanos.length == 1) {
            if (estrategia.Hermanos[0].Hermanos) {
                if (estrategia.Hermanos[0].Hermanos.length > 0) {
                    estrategia.CodigoVariante = _codigoVariedad.IndividualVariable;
                }
            }
        }
        else if (estrategia.Hermanos.length > 1) {
            if (estrategia.CodigoVariante == _codigoVariedad.IndividualVariable) {
                estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
            }
        }
        else if (estrategia.Hermanos.length == 0) {
            estrategia.CodigoVariante = "";
        }
    };

    var _validarDesactivadoGeneral = function (estrategia) {
        $.each(estrategia.Hermanos, function (index, hermano) {

            if (hermano.Hermanos) {
                if (hermano.Hermanos.length > 0) {
                    estrategia.ClaseBloqueada = "btn_desactivado_general";
                    estrategia.ClaseBloqueadaRangos = "contenedor_rangos_desactivado";
                    estrategia.RangoInputEnabled = "disabled";
                    $("#btnAgregalo").addClass("btn_desactivado_general");
                    $(".content_cantidad_ficha_producto").addClass("btn_desactivado_general");
                    //$(".contenedor_rangos").addClass("contenedor_rangos_desactivado");
                    $(".cantidad_mas_home").attr("data-bloqueada", "contenedor_rangos_desactivado");
                    $(".cantidad_menos_home").attr("data-bloqueada", "contenedor_rangos_desactivado");

                    $("#imgFichaProduMas").attr("data-bloqueada", "contenedor_rangos_desactivado");
                    $("#imgFichaProduMenos").attr("data-bloqueada", "contenedor_rangos_desactivado");



                }
            }
        });
    };

    var _construirSeccionEstrategia = function () {

        var estrategia;
        if (_config.tieneSession === "True") {
            //revisar si se realiza con razor o handlebar para SR y ODD
            estrategia = JSON.parse($(_elementos.idDataEstrategia).attr(_atributos.dataEstrategia));
        }
        else {
            estrategia = localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);
            $(_elementos.idDataEstrategia).attr(_atributos.dataEstrategia, JSON.stringify(estrategia));
        }

        if (estrategia == null) {
            window.location = baseUrl + (isMobile() ? "/Mobile/" : "") + "Ofertas";
            return false;
        }

        if (typeof estrategia.DescripcionCompleta !== "undefined" &&
            estrategia.DescripcionCompleta != null) {
            estrategia.DescripcionCompleta = $.trim(estrategia.DescripcionCompleta);
            var palabrasEstrategiaDescripcion = estrategia.DescripcionCompleta.split(" ");
            var estrategiaBreadcrumb = palabrasEstrategiaDescripcion[0];
            if (!isMobile()) {
                if (palabrasEstrategiaDescripcion.length > 1)
                    estrategiaBreadcrumb += " " + palabrasEstrategiaDescripcion[1];
                if (palabrasEstrategiaDescripcion.length > 2)
                    estrategiaBreadcrumb += " " + palabrasEstrategiaDescripcion[2];
                if (palabrasEstrategiaDescripcion.length > 3) estrategiaBreadcrumb += "...";
            } else {
                if (palabrasEstrategiaDescripcion.length > 1) estrategiaBreadcrumb += "...";
            }

            $(_elementos.estrategiaBreadcrumb).text(estrategiaBreadcrumb);
        }

        $(_elementos.estrategiaBreadcrumb).parent("li").attr("data-opcion", estrategia.DescripcionCompleta.trim());
        _verificarVariedad(estrategia);
        _actualizarVariedad(estrategia);
        _validarDesactivadoGeneral(estrategia);

        SetHandlebars("#detalle_ficha_template", estrategia, "#seccion_ficha_handlebars");

        var imgFondo = "";
        if (isMobile()) {
            imgFondo = estrategia.TipoEstrategiaDetalle.ImgFichaFondoMobile || "";
        }
        else {
            imgFondo = estrategia.TipoEstrategiaDetalle.ImgFichaFondoDesktop || "";

            if (imgFondo != "") {
                $(_seccionesFichaProducto.ContenedoFichaEtiquetas).addClass("contenedor_ficha_etiquetas_Confondo");
            }

            setTimeout(_RenderImg(), 1000);
        }

        if (imgFondo != "") {
            $(_seccionesFichaProducto.ImagenDeFondo).css("background-image", "url('" + imgFondo + "')");
            $(_seccionesFichaProducto.ImagenDeFondo).show();
        }

        _cargarDataCompartir(estrategia);

        if (estrategia.TieneReloj) {
            _crearReloj(estrategia);
            estrategia.ConfiguracionContenedor = estrategia.ConfiguracionContenedor || {};
            SetHandlebars("#ofertadeldia-template-style", estrategia, "#styleRelojOdd");
        }

        //$(_seccionesFichaProducto.ContenedoFotoReferencial).hide();
        //if (estrategia.Hermanos.length > 0)
        //    $(_seccionesFichaProducto.ContenedoFotoReferencial).show();

        if (!isMobile()) {
            _validarSiEsAgregado(estrategia);
        }

        //Handlers bars para el detalle de los tabs de fichas
        _construirSeccionDetalleFichas(estrategia);

        // Se realiza la marcación en analytics de la información de la ficha de un producto.
        var tipoMoneda = AnalyticsPortalModule.FcVerificarTipoMoneda(variablesPortal.SimboloMoneda);
        AnalyticsPortalModule.MarcarVerFichaProducto(tipoMoneda, estrategia.DescripcionCompleta.trim(), estrategia.CUV2.trim(), estrategia.PrecioVenta, estrategia.DescripcionMarca, null, estrategia.CodigoVariante, _config.palanca);
        _estrategia = estrategia;
        if (estrategia.TipoAccionAgregar <= 0) {
            $(_seccionesFichaProducto.dvContenedorAgregar).hide();
        }
        return true;
    };

    var _construirSeccionDetalleFichas = function (estrategia) {

        if (estrategia === null || typeof (estrategia) === "undefined") {
            return false;
        }

        if (estrategia.CodigoEstrategia === _constantePalanca.Lanzamiento) {
            //Construir sección ficha - Video
            if (isMobile()) {
                estrategia.VideoHeight = 218;
                estrategia.TipoEstrategiaDetalle.UrlVideo = estrategia.TipoEstrategiaDetalle.UrlVideoMobile;
            }
            else {
                estrategia.VideoHeight = 415;
                estrategia.TipoEstrategiaDetalle.UrlVideo = estrategia.TipoEstrategiaDetalle.UrlVideoDesktop;
            }

            SetHandlebars("#template-fichadetallevideo", estrategia, "#contenedor-tab-video");

            if (youtubeModule) {
                youtubeModule.Inicializar();
            }
        }
        return true;
    };

    var _RenderImg = function () {

        $(document).ajaxStop(function () {
            var proObj = $(_seccionesFichaProducto.ImagenProducto);
            var proImg = proObj.find("img");

            // medida segun alto
            var proM = proImg.innerHeight();
            var proObjM = proObj.innerHeight();

            if (proM > proObjM) {
                $(proImg).css("height", proObjM + "px");
                $(proImg).css("width", "auto");
            }

            // medida segun ancho
            proM = proImg.innerWidth();
            proObjM = proObj.innerWidth();
            if (proM > proObjM) {
                proM = proObjM / proM;
                $(proImg).css("width", proObjM + "px");
            }

            setTimeout(_resizeBotonAgregar(), 1000);
        });

        //$("header").resize(function () {

        //});


    };

    Handlebars.registerHelper("ifVerificarMarca", function (marca, options) {
        if (_primeraMarca !== marca && _esMultimarca) {
            _primeraMarca = marca;
            return options.fn(this);
        }
    });

    Handlebars.registerHelper("ifVerificarMarcaLast", function (marca, options) {
        if (_esMultimarca) {
            if (_ultimaMarca === "" || _ultimaMarca === marca) {
                _ultimaMarca = marca;
                return options.inverse(this);
            }
            else {
                _ultimaMarca = marca;
                return options.fn(this);
            }
        }
        else {
            if (_ultimaMarca === "") {
                _ultimaMarca = marca;
                return options.inverse(this);
            }
            else return options.fn(this);
        }
    });

    var _ocultarSecciones = function () {
        if (isMobile()) {
            $(_elementos.footerPage).hide();
            $(_elementos.marca).hide();
        }
        //$(_seccionesFichaProducto.SloganLanzamientos).hide();
        //$(_seccionesFichaProducto.EtiquetaOdd).hide();
        //$(_seccionesFichaProducto.EtiquetaLanzamientos).hide();
        //$(_seccionesFichaProducto.EtiquetaPackNuevas).hide();
        //$(_seccionesFichaProducto.SloganPackNuevas).hide();

        if (_codigoPalanca.HerramientasVenta === _config.palanca ||
            _codigoPalanca.OfertasParaMi === _config.palanca ||
            _codigoPalanca.OfertaParaTi === _config.palanca ||
            _codigoPalanca.GuiaDeNegocioDigitalizada === _config.palanca) {
            //$(_seccionesFichaProducto.ImagenDeFondo).css("background-image", "");
            //$(_seccionesFichaProducto.DescripcionAdicional).hide();
            $(_seccionesFichaProducto.ContenidoProducto).hide();
            //$(_seccionesFichaProducto.CarruselProducto).hide();
            //if (_codigoPalanca.HerramientasVenta === _config.palanca) {
            //    $(_seccionesFichaProducto.Contenedor_redes_sociales).hide();
            //}
        }
        else if (_codigoPalanca.Lanzamiento == _config.palanca) {
            //$(_seccionesFichaProducto.EtiquetaLanzamientos).show();
            //$(_seccionesFichaProducto.ImagenDeFondo).show();
            //$(_seccionesFichaProducto.DescripcionAdicional).show();
            $(_seccionesFichaProducto.ContenidoProducto).show();
            //$(_seccionesFichaProducto.CarruselProducto).show();
            //$(_seccionesFichaProducto.SloganLanzamientos).show();
        }
        else if (_codigoPalanca.ShowRoom == _config.palanca) {
            //$(_seccionesFichaProducto.EtiquetaLanzamientos).hide();
            //$(_seccionesFichaProducto.ImagenDeFondo).css("background-image", "");
            //$(_seccionesFichaProducto.DescripcionAdicional).hide();
            $(_seccionesFichaProducto.ContenidoProducto).hide();
            //$(_seccionesFichaProducto.CarruselProducto).show();
        }
        else if (_codigoPalanca.OfertaDelDia == _config.palanca) {
            //$(_seccionesFichaProducto.EtiquetaOdd).show();
        }
        else if (_codigoPalanca.PackNuevas == _config.palanca) {
            //$(_seccionesFichaProducto.EtiquetaLanzamientos).hide();
            //$(_seccionesFichaProducto.ImagenDeFondo).css("background-image", "");
            //$(_seccionesFichaProducto.DescripcionAdicional).hide();
            $(_seccionesFichaProducto.ContenidoProducto).hide();
            //$(_seccionesFichaProducto.CarruselProducto).hide();
            //$(_seccionesFichaProducto.SloganLanzamientos).hide();
            //$(_seccionesFichaProducto.EtiquetaPackNuevas).show();
            //$(_seccionesFichaProducto.Contenedor_redes_sociales).hide();
            //$(_seccionesFichaProducto.SloganPackNuevas).show();
        }

        //var etiquetaOddEstaOculta = $(_seccionesFichaProducto.EtiquetaOdd).is(":hidden");
        //var etiquetaLanzamientosEstaOculta = $(_seccionesFichaProducto.EtiquetaLanzamientos).is(":hidden");
        //if (etiquetaOddEstaOculta && etiquetaLanzamientosEstaOculta)
        //$(_seccionesFichaProducto.ContenedoFichaEtiquetas).show();
        //else
        //$(_seccionesFichaProducto.ContenedoFichaEtiquetas).show();
    };

    var _ocultarTabs = function () {
        var estrategia = localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);

        $(_tabsFichaProducto.detalleProducto).hide();
        $(_tabsFichaProducto.detallePack).hide();
        $(_tabsFichaProducto.tipsVenta).hide();
        $(_tabsFichaProducto.beneficios).hide();
        $(_tabsFichaProducto.video).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoDetalleProducto).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoDetallePack).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoTipsVenta).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoBeneficios).hide();
        $(_seccionesFichaTabProducto.ContenidoProductoVideo).hide();


        if (_codigoPalanca.ShowRoom === _config.palanca ||
            ConstantesModule.ConstantesPalanca.Lanzamiento === _config.palanca) {
            $(_tabsFichaProducto.tipsVenta).show();
        }

        if (_codigoPalanca.Lanzamiento === _config.palanca) {
            if (estrategia.TipoEstrategiaDetalle.UrlVideoDesktop && !isMobile()) {
                $(_tabsFichaProducto.video).show();
                $(_seccionesFichaTabProducto.ContenidoProductoVideo).show();
            }
            if (estrategia.TipoEstrategiaDetalle.UrlVideoMobile && isMobile()) {
                $(_tabsFichaProducto.video).show();
                $(_seccionesFichaTabProducto.ContenidoProductoVideo).show();
            }
        }
    };

    var _validarSiEsAgregado = function (estrategia) {
        if (estrategia.IsAgregado) {
            $("#ContenedorAgregado").show();
        }
    };

    var _fijarFooterCampaniaSiguiente = function () {
        if (isMobile()) {
            var $elemento = $(".content_inscribirte");
            if ($elemento.length != 0) {
                var $redesSociales = $((_seccionesFichaProducto.Contenedor_redes_sociales));
                $redesSociales.find(".share").css("margin-bottom", "200px");
            }
        }
    }

    var _cargarDataCompartir = function (estrategia) {
        if (isMobile()) {
            var $redesSociales = $((_seccionesFichaProducto.Contenedor_redes_sociales));
            if ($redesSociales.length > 0) {
                $redesSociales.find(".CUV").val(estrategia.CUV2);
                $redesSociales.find(".rsFBRutaImagen").val(variablesPortal.ImgUrlBase + estrategia.FotoProducto01);
                $redesSociales.find(".rsWARutaImagen").val(variablesPortal.ImgUrlBase + estrategia.FotoProducto01);
                $redesSociales.find(".MarcaID").val(estrategia.MarcaID);
                $redesSociales.find(".MarcaNombre").val(estrategia.DescripcionMarca);
                $redesSociales.find(".Nombre").val(estrategia.DescripcionCompleta);
                $redesSociales.find(".ProductoDescripcion").val(estrategia.DescripcionDetalle);
                $redesSociales.find(".Palanca").val(_config.palanca);
            }
        }
    }

    // Método que realiza la marcación en analytics de tonos en el combo de seleccion de tonos.
    var _marcarCambiaColorCombo = function () {
        var producto = _estrategia.DescripcionCompleta;
        var contenedorTonos = $(".content_tonos_select").children(".content_tono_elegido");
        $(contenedorTonos).each(function (index, element) {
            $(this).click(function () {
                var tono = $(this).attr("data-tono-nombre");
                AnalyticsPortalModule.MarcarCambiaColorCombo(producto, tono);
            });
        });
    }

    // Método que realiza la marcación en analytics de tonos en el cuadrado de seleccion de tonos.
    var _marcarCambiaColorCuadro = function () {
        var producto = _estrategia.DescripcionCompleta;
        var contenedorTonos = $(".content_tonos_maquillaje").children(".content_tono_detalle");
        $(contenedorTonos).each(function (index, element) {
            $(this).click(function () {
                var tono = $(this).attr("data-tono-nombre");
                AnalyticsPortalModule.MarcarCambiaColorCuadro(producto, tono);
            });
        });
    }

    // Método que realiza la marcación en analytics de un producto al presionar el boton agregar.
    var _marcarAgregaProductoCarro = function () {
        $("#btnAgregalo").click(function () {
            var cantidad = $(".txt_cantidad_pedido").val() || "";
            cantidad = cantidad == "" ? 0 : parseInt(cantidad);
            var tipoMoneda = AnalyticsPortalModule.FcVerificarTipoMoneda(variablesPortal.SimboloMoneda);
            AnalyticsPortalModule.MarcarAgregaProductoCarro(tipoMoneda, _estrategia.DescripcionCompleta.trim(), _estrategia.PrecioVenta, _estrategia.DescripcionMarca, _estrategia.CUV2.trim(), null, _estrategia.CodigoVariante, cantidad, _config.palanca);
        });
    }

    var _marcarFichaBreadcrumb = function () {
        $(".breadcumbs").children("li").each(function (index, element) {
            $(this).click(function () {
                var opcion = $(this).attr("data-opcion");
                AnalyticsPortalModule.MarcarFichaBreadcrumb(opcion);
            });
        });
    }

    var _resizeBotonAgregar = function () {
        var dvFoto = $("#dvSeccionFoto");
        var dvRedesSociales = $("#Contenedor_redes_sociales");
        var dvFichaEtiqueta = $("#contenedor_ficha_etiquetas");
        var dvDetalle = $("#dvSeccionDetalle");

        if (dvFoto.length && dvRedesSociales.length) {

            dvDetalle.removeClass("ficha_detalle_cuerpo");
            dvDetalle.css("height", "");
            var dvFotoHeight = dvFoto.innerHeight();
            var dvFichaEtiquetaHeight = dvFichaEtiqueta.innerHeight();
            var dvDetalleHeight = dvDetalle.innerHeight();
            var dvIzquierdoHeight = dvFotoHeight + 45; // 45 es por el padding del padre.
            var dvDerechoHeight = dvDetalleHeight + dvFichaEtiquetaHeight;
            if (dvIzquierdoHeight > dvDerechoHeight) {
                var dvRedesSocialesHeight = dvRedesSociales.innerHeight();
                var diferenciaHeight = dvIzquierdoHeight - dvFichaEtiquetaHeight;
                dvDetalle.removeClass("ficha_detalle_cuerpo");
                dvDetalle.height(diferenciaHeight);
            }
            else {
                dvDetalle.addClass("ficha_detalle_cuerpo");
            }
        }
    }

    var _prevenirScrollFixed = function () {
        if (isMobile()) {
            setTimeout(function () {
                var dvContentMobile = $("#contentmobile");
                var dvFixed = $("#idMensajeBloqueado > div");
                if (dvFixed.length == 0) {
                    dvFixed = $("#dvContenedorAgregar");
                }

                if (dvContentMobile.length && dvFixed.length) {
                    var dvContentMobileHeight = dvContentMobile.height();
                    var dvFixedHeight = dvFixed.innerHeight();
                    var height = dvContentMobileHeight + dvFixedHeight + 20;
                    dvContentMobile.height(height);
                }
            }, 1000);
        }
    }

    function Inicializar() {

        localStorageModule = LocalStorageModule();
        _construirSeccionEstrategia();
        _ocultarSecciones();
        _bindingEvents();
        _crearTabs();
        _ocultarTabs();
        _fijarFooterCampaniaSiguiente();
        _marcarCambiaColorCombo();
        _marcarCambiaColorCuadro();
        _prevenirScrollFixed();
        _marcarAgregaProductoCarro();
        //_marcarSwipeCarrusel();
        _marcarFichaBreadcrumb();
    }

    return {
        Inicializar: Inicializar
    };
});

//Funcion temporal hasta estandarizar RevistaDigital.js
function RDPageInformativa() {
    window.location = (isMobile() ? "/Mobile/" : "") + baseUrl + 'revistadigital/Informacion';
}
