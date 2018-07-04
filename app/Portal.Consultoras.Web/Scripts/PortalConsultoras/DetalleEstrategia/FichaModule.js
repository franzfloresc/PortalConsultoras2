var FichaModule = (function (config) {
    'use strict';
    var localStorageModule;
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
    
    var _elementos = {
        idDataEstrategia: "#data-estrategia",
        dataClicked: "[data-clicked]",
        dataChange: "[data-change]",
        dataSelected: "[data-select-area]",
        idPlantillaProductoLanding: "#producto-landing-template",
        divCarruselSetsProductosRelacionados: "#divOfertaProductos",
        divSetsProductosRelacionados: "#set_relacionados"
    };

    var _atributos = {
        dataEstrategia: "data-estrategia",
        dataClicked: "[data-clicked]",
        dataChange: "[data-change]",
        dataSelected: "[data-select-area]"
    };

    var _seccionesFichaProducto = {
        EtiquetaLanzamientos: "#EtiquetaLanzamientos",
        ImagenDeFondo: "#ImagenDeFondo",
        DescripcionAdicional: "#DescripcionAdicional",
        ContenidoProducto: "#ContenidoProducto",
        CarruselProducto: "#CarruselProducto",
        EtiquetaOdd: "#EtiquetaOdd"
    }

    var _tabsFichaProducto = {
        detalleProducto: "#div_ficha_tab1",
        detallePack: "#div_ficha_tab2",
        tipsVenta: "#div_ficha_tab3",
        beneficios: "#div_ficha_tab4",
        video: "#div_ficha_tab5",
    }

    var _getParamValueFromQueryString = function (queryStringName) {
        queryStringName = queryStringName || '';
        queryStringName = queryStringName.toLowerCase();
        var queryStringValue = '';
        var stringUrlParameters = location.href.toLowerCase().split('?');
        if (stringUrlParameters.length > 1 && queryStringName != '') {
            var arrParameterString = stringUrlParameters[1].split('&');
            $.each(arrParameterString, function (index, stringParameter) {
                var items = stringParameter.split('=');
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
            $(document).on("mouseleave",_elementos.dataSelected, _eventos.mouseLeaveSelectArea);
        }
    };
    
    var _crearReloj = function() {
        $("#clock").each(function (index, elem) {
            $(elem).FlipClock(50000,
                {
                    countdown: true,
                    clockFace: 'HourlyCounter',
                    language: 'es-es',
                });
        });
    };
    
    var _crearTabs = function () {

        for (var i = 1; i <= 5; i++) {

            var FichaTabElement = document.getElementById("ficha_tab_" + i.toString());

            if (FichaTabElement)
            {

                if (FichaTabElement.checked) {
                document.getElementById("contenido_" + i.toString()).style.display = "block";
                }

                FichaTabElement.onclick = function (event) {
                var numID = event.target.getAttribute('data-numTab');

                for (var j = 1; j <= 5; j++) {
                    document.getElementById("contenido_" + j.toString()).style.display = "none";
                }

                document.getElementById("contenido_" + numID.toString()).style.display = "block";
            };

         }
        }

        if (!window.videoKey) {
            $('#tabVideo').hide();
        }

        $('ul.ficha_tabs li').click(function () {
            $(this).children('ul').slideToggle();
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
        if (!IsNullOrEmpty(estrategia.CodigoVariante) && estrategia.CodigoVariante !== ConstantesModule.CodigoVariedad.ComuestaFija) {
            var param = {
                estrategiaId: estrategia.EstrategiaID,
                campania: _config.campania,
                codigoVariante: estrategia.CodigoVariante
            };
            _promiseObternerComponentes(param).done(function(data) {
                estrategia.Hermanos = data.componentes;
                estrategia.EsMultimarca = data.esMultimarca;
                _esMultimarca = data.esMultimarca;
            }).fail(function(data, error) {
                estrategia.Hermanos = {};
                estrategia.EsMultimarca = false;
            });

            return true;
        } else {
            estrategia.Hermanos = {};
            estrategia.EsMultimarca = false;
            return false;
        }
    }
    
    var _actualizarVariedad = function (estrategia) {
        if (estrategia.Hermanos.length == 1) {
            if (estrategia.Hermanos[0].Hermanos) {
                if (estrategia.Hermanos[0].Hermanos.length > 0) {
                    estrategia.CodigoVariante = ConstantesModule.CodigoVariedad.IndividualVariable;
                }
            }
        }
    };
    var _validarDesactivadoGeneral = function (estrategia) {
        $.each(estrategia.Hermanos, function (index, hermano) {
            if (hermano.Hermanos) {
                if (hermano.Hermanos.length > 0) {
                    estrategia.ClaseBloqueada = "btn_desactivado_general";
                    $("#btnAgregarProducto").addClass("btn_desactivado_general");
                }
            }
        });
    };
    
    var _construirSeccionEstrategia = function () {
 
        var estrategia;
        if (_config.tieneSession === "True") {
            //revisar si se realiza con razor o handle bar para SW y ODD
            estrategia = JSON.parse($(_elementos.idDataEstrategia).attr(_atributos.dataEstrategia));
        } else {
            estrategia = localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);
            $(_elementos.idDataEstrategia).attr(_atributos.dataEstrategia, JSON.stringify(estrategia));
        }

        if (estrategia == null) {
            window.location = baseUrl + (isMobile() ? "/Mobile/" : "") + "Ofertas";
            return false;
        }
        
        _verificarVariedad(estrategia);
        _actualizarVariedad(estrategia);
        _validarDesactivadoGeneral(estrategia);
        if (estrategia.CodigoEstrategia) {
            _crearReloj();
        }
        _ocultarSecciones(estrategia.CodigoEstrategia);
        _ocultarTabs(estrategia.CodigoEstrategia);

        console.log(estrategia);
        SetHandlebars("#detalle_ficha_template", estrategia, "#seccion_ficha_handlebars");
       
        if (!isMobile()) {
            _validarSiEsAgregado(estrategia);
        }
        
        return true;
    };

    Handlebars.registerHelper('ifVerificarMarca', function (marca, options) {
        if (_primeraMarca !== marca && _esMultimarca) {
            _primeraMarca = marca;
            return options.fn(this);
        }
    });

    Handlebars.registerHelper('ifVerificarSlogan', function (CodigoEstrategia, Slogan, options) {
        if (CodigoEstrategia == ConstantesModule.ConstantesPalanca.Lanzamiento && Slogan.length > 0) {
            return options.fn(this);
        }
    });
    
    Handlebars.registerHelper('ifVerificarMarcaLast', function (marca, options) {
        if (_esMultimarca) {
            if (_ultimaMarca === "" || _ultimaMarca === marca) {
                _ultimaMarca = marca;
                return options.inverse(this);
            } else {
                _ultimaMarca = marca;
                return options.fn(this);
            }
        } else {
            if (_ultimaMarca === "") {
                _ultimaMarca = marca;
                return options.inverse(this);
            }
            else  return options.fn(this);
        }
    });

    var _ocultarSecciones = function () {
        if (_codigoPalanca.HerramientasVenta === _config.palanca
            || _codigoPalanca.OfertasParaMi === _config.palanca
            || _codigoPalanca.OfertaParaTi === _config.palanca
            || _codigoPalanca.GuiaDeNegocioDigitalizada === _config.palanca) {

            $(_seccionesFichaProducto.EtiquetaLanzamientos).hide();
            $(_seccionesFichaProducto.ImagenDeFondo).hide();
            $(_seccionesFichaProducto.DescripcionAdicional).hide();
            $(_seccionesFichaProducto.ContenidoProducto).hide();
            $(_seccionesFichaProducto.CarruselProducto).hide();
        } else if ( _codigoPalanca.ConstantesPalanca.Lanzamiento == CodigoEstrategia
            || _codigoPalanca.ConstantesPalanca.ShowRoom == CodigoEstrategia) {

            $(_seccionesFichaProducto.EtiquetaLanzamientos).show();
            $(_seccionesFichaProducto.ImagenDeFondo).show();
            $(_seccionesFichaProducto.DescripcionAdicional).show();
            $(_seccionesFichaProducto.ContenidoProducto).show();
            $(_seccionesFichaProducto.CarruselProducto).show();
        }
        else if (_codigoPalanca.OfertaDelDia == CodigoEstrategia) {
            $(_seccionesFichaProducto.EtiquetaOdd).show();
        }
    }

    var _ocultarTabs = function (CodigoEstrategia) {
        $(_tabsFichaProducto.detalleProducto).hide();
        $(_tabsFichaProducto.detallePack).hide();
        $(_tabsFichaProducto.tipsVenta).hide();
        $(_tabsFichaProducto.beneficios).hide();
        $(_tabsFichaProducto.video).hide();

        if (ConstantesModule.ConstantesPalanca.ShowRoom == CodigoEstrategia
            || ConstantesModule.ConstantesPalanca.Lanzamiento == CodigoEstrategia) {
            $(_tabsFichaProducto.tipsVenta).show();
        }

        if (ConstantesModule.ConstantesPalanca.Lanzamiento == CodigoEstrategia) {
            $(_tabsFichaProducto.video).show();
        }
    };

   

    var _validarSiEsAgregado = function (estrategia) {
        if (estrategia.IsAgregado) {
            $("#ContenedorAgregado").show();
        }
    }
    
    function Inicializar() {
        localStorageModule = LocalStorageModule();
        _construirSeccionEstrategia();
        _ocultarSecciones();
        _bindingEvents();
        //_crearReloj();
        _crearTabs();
        _crearCarruseles();
    }

    var _crearCarruseles = function () {
        $("#carrusel").not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            infinite: true,
            vertical: false,
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow:
                '<a class="contenedor_flecha_carrusel flecha_izquierda_carrusel js-slick-prev slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_izquierda_carrusel"></div></a>',
            nextArrow:
                '<a class="contenedor_flecha_carrusel flecha_derecha_carrusel js-slick-next slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_derecha_carrusel"></div></a>'
        });

        $("#carrusel_tonos").not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            infinite: true,
            vertical: false,
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow:
                '<a class="contenedor_flecha_carrusel flecha_izquierda_carrusel js-slick-prev slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_carrusel_tonos dibujar_flecha_izquierda_carrusel"></div></a>',
            nextArrow:
                '<a class="contenedor_flecha_carrusel flecha_derecha_carrusel js-slick-next slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_carrusel_tonos dibujar_flecha_derecha_carrusel"></div></a>'
        });
    };

    return {
        Inicializar: Inicializar
    };
});