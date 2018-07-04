var FichaModule = (function (config) {
    'use strict';
    var localStorageModule;
    
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
    
    var _crearCarruseles = function() {
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



    var _mostrarSetRelacionados = function () {
         
        $(_elementos.divSetsProductosRelacionados).fadeOut();

        var platform = !isMobile() ? 'desktop' : 'mobile';
        var cuv = _config.cuv; 
        var campaniaId =  _config.campania; 

        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return false;
        }

        if (platform != 'mobile')
            return false;


        var str = LocalStorageListado("LANLista" + campaniaId, '', 1) || '';

        if (str === '') {
            return false;
        }

        var data = {
            lista: JSON.parse(str).response.listaLan
        };

        var setRelacionados = [];
        var codigoProducto = '';
        $.each(data.lista, function (index, lanzamiento) {
            if (cuv === lanzamiento.CUV2) {
                codigoProducto = lanzamiento.CodigoProducto;
                return false;
            }
        });

        $.each(data.lista, function (index, lanzamiento) {
            if (cuv != lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                setRelacionados.push(lanzamiento);
            }
        });
        if (setRelacionados.length == 0) {
            return false;
        }
        data.lista = setRelacionados;
        console.log(data);
        SetHandlebars(_elementos.idPlantillaProductoLanding, data, _elementos.divCarruselSetsProductosRelacionados);
        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

        var slickArrows = {
            'mobile': {
                prev: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-left: 0%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-right:0%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        var widthDimamico = !isMobile();

        $(_elementos.divCarruselSetsProductosRelacionados + '.slick-initialized').slick('unslick');
        $(_elementos.divCarruselSetsProductosRelacionados).not('.slick-initialized').slick({
            dots: false,
            infinite: true,
            speed: 260,
            slidesToShow: 2,
            slidesToScroll: 1,
            variableWidth: widthDimamico,
            prevArrow: slickArrows[platform].prev,
            nextArrow: slickArrows[platform].next,
            responsive: [
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1,
                        infinite: true
                    }
                }
            ]
        });

        $(_elementos.divSetsProductosRelacionados).fadeIn();
    };


    var _verificarVariedad = function (estrategia) {
        if (!IsNullOrEmpty(estrategia.CodigoVariante)) {
            var componentes;
            var param = {
                estrategiaId: estrategia.EstrategiaID,
                campania: _config.campania,
                codigoVariante: estrategia.CodigoVariante
            };
            
            _promiseObternerComponentes(param).done(function (data) {
                componentes = data.componentes;
            }).fail(function (data, error) {
                componentes = {};
            });
            
            return componentes;
        } else return {};
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
            window.location = (isMobile() ? "/Mobile/" : "") + "Ofertas";
            return false;
        }

        estrategia.Hermanos = _verificarVariedad(estrategia);
        actualizarVariedad(estrategia);
        SetHandlebars("#detalle_ficha_template", estrategia, "#seccion_ficha_handlebars");
        return true;
        
    };

    var actualizarVariedad = function (estrategia) {
        if (estrategia.Hermanos.length == 1) {
            if (estrategia.Hermanos[0].Hermanos) {
                if (estrategia.Hermanos[0].Hermanos.length > 0) {
                    estrategia.CodigoVariante = ConstantesModule.CodigoVariedad.IndividualVariable;
                }
            }
        }
    };

    Handlebars.registerHelper('agruparLista', function (componentes, IdMarca, options) {
        var data = componentes;
        var results = '';
        data.forEach((item) => {
            if (item.IdMarca == IdMarca) {
                results += options.fn(item);
            }
        });
        return results;
    });

    Handlebars.registerHelper('ifVerificarMarca', function (componentes, IdMarca, options) {
        var data = componentes;
        var selected = false;

        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            if (item.IdMarca == IdMarca) {
                return options.fn(this);
            }
        }
    });
    
    function Inicializar() {
        localStorageModule = LocalStorageModule();
        _construirSeccionEstrategia();
        _bindingEvents();
        _crearReloj();
        _crearTabs();
        _crearCarruseles();
        _mostrarSetRelacionados();
    }

    return {
        Inicializar: Inicializar
    };
});