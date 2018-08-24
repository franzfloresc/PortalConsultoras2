/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/handlebars.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
/// <reference path="../../../Scripts/implements/youtube.js" />

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onEstrategiaLoaded");
registerEvent.call(opcionesEvents, "onOptionSelected");

var variablesPortal = variablesPortal || {};

var FichaModule = (function (config) {
    "use strict";

    var _localStorageModule;
    var _primeraMarca = "";
    var _ultimaMarca = "";
    var _esMultimarca = false;

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
        hdCampaniaCodigo: {
            id: "#hdCampaniaCodigo"
        },
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
        video: "#div_ficha_tab5"
    };

    var _seccionesFichaTabProducto = {
        ContenidoProductoDetalleProducto: "#contenido_1",
        ContenidoProductoDetallePack: "#contenido_2",
        ContenidoProductoTipsVenta: "#contenido_3",
        ContenidoProductoBeneficios: "#contenido_4",
        ContenidoProductoVideo: "#contenido_5"
    }

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

    var _fijarFooterCampaniaSiguiente = function() {
        if (isMobile()) {
            var $elemento = $(".content_inscribirte");
            if ($elemento.length !== 0) {
                var $redesSociales = $((_seccionesFichaProducto.Contenedor_redes_sociales));
                $redesSociales.find(".share").css("margin-bottom", "200px");
            }
        }
    };

    var _ocultarTabs = function () {
        var estrategia = _localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);

        $(_seccionesFichaProducto.ContenidoProducto).hide();
        //
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

        var showTabContainer = false;
        if (_codigoPalanca.ShowRoom === _config.palanca ||
            ConstantesModule.ConstantesPalanca.Lanzamiento === _config.palanca) {
            showTabContainer = true;
        }

        if (_codigoPalanca.Lanzamiento === _config.palanca) {
            if (estrategia.TipoEstrategiaDetalle.UrlVideoDesktop && !isMobile()) {
                $(_tabsFichaProducto.video).show();
                $(_seccionesFichaTabProducto.ContenidoProductoVideo).show();
                showTabContainer = true;
            }
            if (estrategia.TipoEstrategiaDetalle.UrlVideoMobile && isMobile()) {
                $(_tabsFichaProducto.video).show();
                $(_seccionesFichaTabProducto.ContenidoProductoVideo).show();
                showTabContainer = true;
            }
        }

        if (showTabContainer) $(_seccionesFichaProducto.ContenidoProducto).show();

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
            var $this = $(this);
            $this.parent().children("ul").slideToggle();
            var clase = $this.attr("class");
            if (clase === "active") {
                $this.attr("class", "tab-link");
            }
            else {
                $this.attr("class", "active");
            }
        });
    };

    var _eventos = {
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

    var _ocultarSecciones = function () {
        if (isMobile()) {
            $(_elementos.footerPage).hide();
            $(_elementos.marca).hide();
        }

        if (_codigoPalanca.HerramientasVenta === _config.palanca ||
            _codigoPalanca.OfertasParaMi === _config.palanca ||
            _codigoPalanca.OfertaParaTi === _config.palanca ||
            _codigoPalanca.GuiaDeNegocioDigitalizada === _config.palanca ||
            _codigoPalanca.OfertaDelDia === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).hide();
        }
        else if (_codigoPalanca.Lanzamiento === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).show();
        }
        else if (_codigoPalanca.ShowRoom === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).hide();
        }
        else if (_codigoPalanca.OfertaDelDia === _config.palanca) {
        }
        else if (_codigoPalanca.PackNuevas === _config.palanca) {
            $(_seccionesFichaProducto.ContenidoProducto).hide();
        }
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

    var _obtenerCampaniaActual = function () {
        var campaniaActual = 0;
        var strCampaniaActual = $(_elementos.hdCampaniaCodigo.id).val();
        if (!$(_elementos.hdCampaniaCodigo.id) ||
            $.trim(strCampaniaActual) === "" ||
            isNaN(strCampaniaActual)) return campaniaActual;

        campaniaActual = parseInt(strCampaniaActual);

        return campaniaActual;
    }


    var _getComponentesAndUpdateEsMultimarca = function (estrategia) {
        if (!IsNullOrEmpty(estrategia.CodigoVariante)) {
            var param = {
                estrategiaId: estrategia.EstrategiaID,
                cuv2: estrategia.CUV2,
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
        }
        else {
            estrategia.Hermanos = [];
            estrategia.EsMultimarca = false;
        }
        //
        estrategia.esCampaniaSiguiente = estrategia.CampaniaID !== _obtenerCampaniaActual();
        $.each(estrategia.Hermanos, function (idx, hermano) {
            hermano = estrategia.Hermanos[idx];
            hermano.esCampaniaSiguiente = estrategia.esCampaniaSiguiente;
        });
    };

    var _actualizarCodigoVariante = function (estrategia) {
        estrategia.Hermanos = estrategia.Hermanos || [];

        if (estrategia.Hermanos.length === 1) {
            if (estrategia.Hermanos[0].Hermanos) {
                if (estrategia.Hermanos[0].Hermanos.length > 0) {
                    if (estrategia.Hermanos[0].FactorCuadre === 1) {
                        estrategia.CodigoVariante = _codigoVariedad.IndividualVariable;
                    }
                }
            }
        }
        else if (estrategia.Hermanos.length > 1) {
            if (estrategia.CodigoVariante === _codigoVariedad.IndividualVariable) {
                estrategia.CodigoVariante = _codigoVariedad.ComuestaFija;
            }
        }
        else if (estrategia.Hermanos.length === 0) {
            estrategia.CodigoVariante = "";
        }
    };

    var _getEstrategia = function () {
        var estrategia;

        if (_config.tieneSession === "True") {
            estrategia = JSON.parse($(_elementos.idDataEstrategia).attr(_atributos.dataEstrategia));
        }
        else {
            estrategia = _localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);
        }

        if (typeof estrategia !== "undefined" && estrategia !== null) {
            _getComponentesAndUpdateEsMultimarca(estrategia);
            _actualizarCodigoVariante(estrategia);
            estrategia.ClaseBloqueada = "btn_desactivado_general";
            estrategia.ClaseBloqueadaRangos = "contenedor_rangos_desactivado";
            estrategia.RangoInputEnabled = "disabled";
        }

        return estrategia;
    };

    var _setEstrategiaBreadcrumb = function (estrategia) {
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
    };

    var _validarDesactivadoGeneral = function (estrategia) {
        $.each(estrategia.Hermanos, function (index, hermano) {
            if (hermano.Hermanos && hermano.Hermanos.length > 0) {
                EstrategiaAgregarModule.DeshabilitarBoton();
            }
        });
    };

    var _renderImg = function () {
        _renderImgFin();
        $(document).ajaxStop(function () {
            _renderImgFin();
        });
    };

    var _renderImgFin = function () {

        var proObj = $(_seccionesFichaProducto.ImagenProducto);
        var proImg = proObj.find("img");

        // medida segun alto
        var proM = proImg.innerHeight();
        var proObjM = proObj.innerHeight();

        $(proImg).css("height", "");
        $(proImg).css("width", "");

        if (proM > proObjM) {
            $(proImg).css("height", proObjM + "px");
            $(proImg).css("width", "auto");
        }

        // medida segun ancho
        proM = proImg.innerWidth();
        proObjM = proObj.innerWidth();
        if (proM > proObjM) {
            $(proImg).css("width", proObjM + "px");
        }

        setTimeout(_resizeBotonAgregar(), 1000);
    };
    
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
    };

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

    var _validarSiEsAgregado = function (estrategia) {
        if (estrategia.IsAgregado) {
            $("#ContenedorAgregado").show();
        }
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

    var _construirSeccionEstrategia = function () {
        var estrategia = _getEstrategia();

        if (estrategia == null) {
            window.location = baseUrl + (isMobile() ? "/Mobile/" : "") + "Ofertas";
            return false;
        }

        $(_elementos.idDataEstrategia).attr(_atributos.dataEstrategia, JSON.stringify(estrategia));
        _setEstrategiaBreadcrumb(estrategia);
        SetHandlebars("#detalle_ficha_template", estrategia, "#seccion_ficha_handlebars");
        if (estrategia.esCampaniaSiguiente) _validarDesactivadoGeneral(estrategia);

        if (estrategia.TipoAccionAgregar <= 0) {
            $(_seccionesFichaProducto.dvContenedorAgregar).hide();
        }
        
        opcionesEvents.applyChanges("onEstrategiaLoaded", estrategia);

        var imgFondo = "";
        if (isMobile()) {
            imgFondo = estrategia.TipoEstrategiaDetalle.ImgFichaFondoMobile || "";
        }
        else {
            imgFondo = estrategia.TipoEstrategiaDetalle.ImgFichaFondoDesktop || "";

            if (imgFondo !== "") {
                $(_seccionesFichaProducto.ContenedoFichaEtiquetas).addClass("contenedor_ficha_etiquetas_Confondo");
            }

            setTimeout(_renderImg(), 1000);
        }

        if (imgFondo !== "") {
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
        //var tipoMoneda = AnalyticsPortalModule.FcVerificarTipoMoneda(variablesPortal.SimboloMoneda);
        //AnalyticsPortalModule.MarcarVerFichaProducto(tipoMoneda, estrategia.DescripcionCompleta.trim(), estrategia.CUV2.trim(), estrategia.PrecioVenta, estrategia.DescripcionMarca, null, estrategia.CodigoVariante, _config.palanca);
        return true;
    };

    function Inicializar() {
        
        _localStorageModule = LocalStorageModule();
        _construirSeccionEstrategia();
        _ocultarSecciones();
        _bindingEvents();
        _crearTabs();
        _ocultarTabs();
        _fijarFooterCampaniaSiguiente();
        
    }

    return {
        Inicializar: Inicializar
    };
});

//Funcion temporal hasta estandarizar RevistaDigital.js
var baseUrl = baseUrl || "";
function RDPageInformativa() {
    window.location = (isMobile() ? "/Mobile/" : "") + baseUrl + "revistadigital/Informacion";
}