var CarruselModule = (function (config) {
    'use strict';

    var setCarruselMarcacionAnalytics = []; //Elementos en el carrusel de la ficha para ser marcados cuando el usuario visualiza y rota sobre los elementos
    var setCarruselCuv = [];  //Representa el casillero de un CUV del carrusel

    var _config = {
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlDataCarrusel: config.urlDataCarrusel || ""
    };

    var _elementos = {
        idPlantillaProducto: config.idPlantillaProducto,
        divCarruselContenedor: config.divCarruselContenedor,
        idTituloCarrusel: config.idTituloCarrusel,
        divCarruselProducto: config.divCarruselProducto,
        dataLazy: config.dataLazy || "img[data-lazy-seccion-revista-digital]"
    };

    var _variable = {
        cantidadProdCarrusel: 0
    };

    var _promiseObternerDataCarrusel = function (params) {
        var dfd = $.Deferred();
        $.ajax({
            type: "POST",
            url: _config.urlDataCarrusel,
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

    var _cargarDatos = function () {

        var setRelacionados = [];

        var cuv = _config.cuv;
        var campaniaId = _config.campania;

        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return setRelacionados;
        }

        var str = LocalStorageListado("LANLista" + campaniaId, "", 1) || "";

        if (str === '') {
            return setRelacionados;
        }

        var lista = JSON.parse(str).response.listaLan;
        var codigoProducto = "";

        $.each(lista, function (index, lanzamiento) {
            if (cuv === lanzamiento.CUV2) {
                codigoProducto = lanzamiento.CodigoProducto;
                return false;
            }
        });

        $.each(lista, function (index, lanzamiento) {
            if (cuv != lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                lanzamiento.ImagenURL = "";
                setRelacionados.push(lanzamiento);
            }
        });

        return setRelacionados;
    }

    var _mostrarSlicks = function () {

        var platform = !isMobile() ? 'desktop' : 'mobile';

        var slickArrows = {
            'mobile': {
                prev: '<a class="carrusel_fechaprev_mobile" href="javascript:void(0);"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="carrusel_fechanext_mobile" href="javascript:void(0);"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        var widthDimamico = !isMobile();

        $(_elementos.divCarruselProducto).fadeIn();

        if ((widthDimamico && _variable.cantidadProdCarrusel > 2) || !widthDimamico) {

            $(_elementos.divCarruselProducto + '.slick-initialized').slick('unslick');
            $(_elementos.divCarruselProducto).not('.slick-initialized').slick({
                dots: false,
                infinite: true,
                speed: 260,
                slidesToShow: 2,
                slidesToScroll: 1,
                variableWidth: widthDimamico,
                prevArrow: slickArrows[platform].prev,
                nextArrow: slickArrows[platform].next,
                //centerMode: true,
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
        }

        EstablecerAccionLazyImagen(_elementos.divCarruselProducto + " " + _elementos.dataLazy);
    }

    var _ocultarElementos = function () {
        $(_elementos.divCarruselProducto).fadeOut();
    }

    var _mostrarTitulo = function () {

        var titulo = '';

        if (_config.palanca == ConstantesModule.CodigosPalanca.Lanzamiento) {
            titulo = 'SET DONDE ENCUENTRAS EL PRODUCTO';
        }
        else if (_config.palanca == ConstantesModule.CodigosPalanca.ShowRoom) {
            titulo = 'VER MÁS SETS EXCLUSIVOS PARA TI';
        }
        else if (_config.palanca == ConstantesModule.CodigosPalanca.OfertaDelDia) {
            titulo = 'VER MÁS OFERTAS ¡SOLO HOY!';
        }

        $(_elementos.idTituloCarrusel).html(titulo);
    }
    var _mostrarCarrusel = function () {

        var data = {
            lista: []
        };

        if (_config.palanca == ConstantesModule.CodigosPalanca.Lanzamiento) {
            data.lista = _cargarDatos();
        }
        else if (
            (_config.palanca == ConstantesModule.CodigosPalanca.ShowRoom)
            || (_config.palanca == ConstantesModule.CodigosPalanca.OfertaDelDia)
            || (_config.palanca == ConstantesModule.CodigosPalanca.PackNuevas)
        ) {

            var param = { cuvExcluido: _config.cuv, palanca: _config.palanca }

            _promiseObternerDataCarrusel(param).done(function (response) {

                if (response) {
                    if (response.success) {
                        data.lista = response.data;
                    }
                }

            });
        }

        if (data.lista.length > 0) {
            _variable.cantidadProdCarrusel = data.lista.length;
            SetHandlebars(_elementos.idPlantillaProducto, data, _elementos.divCarruselProducto);
            _mostrarTitulo();
            _mostrarSlicks();
        }
        _ocultarCarrusel(data);
    };
    var _ocultarCarrusel = function (data) {
        if (typeof data != "undefined")
        {
            if (Array.isArray(data.lista) && data.lista.length > 0) {
                $(_elementos.divCarruselContenedor).show();
                return;
            }
            else {
                $(_elementos.divCarruselContenedor).hide();
            }
        }
        $(_elementos.divCarruselContenedor).hide();
    }

    var _initSwipeCarrusel = function () {
        _initArraysCarrusel();
        //quita duplicados

        setCarruselMarcacionAnalytics = multiDimensionalUnico(setCarruselMarcacionAnalytics);
        marcaCuvsActivos();
        //Hace la marcación a analytics
        _marcarSwipeCarrusel();
        _initSlideArrowCarrusel();

    }
    var _initArraysCarrusel = function () {
        var containerItemsSlick = $(".slick-slide");
        $(containerItemsSlick).each(function (index, element) {
            var infoCuvItem = $(element).find("[data-estrategia]").data("estrategia");
            setCarruselMarcacionAnalytics.push([infoCuvItem.CUV2, 0]);
            setCarruselCuv.push(infoCuvItem);
        });

    }
    var _initSlideArrowCarrusel = function () {  ///cuando el usuario hace clic sobre las flechas del carrusel.

        var containerItemsSlick = $(".slick-arrow");
        $(containerItemsSlick).click(function (e) {
            EstablecerAccionLazyImagen(_elementos.divCarruselProducto + " " + _elementos.dataLazy);
            //_initArraysCarrusel();
            _agregaNewCuvActivo();
            setCarruselMarcacionAnalytics = multiDimensionalUnico(setCarruselMarcacionAnalytics);
            marcaCuvsActivos();
            _marcarSwipeCarrusel();
        });
        //quita duplicados
        //setCarruselMarcacionAnalytics = multiDimensionalUnico(setCarruselMarcacionAnalytics);
        //marcaCuvsActivos();
        //Hace la marcación a analytics
        //_marcarSwipeCarrusel();
    }
    function _agregaNewCuvActivo() {
        var containterSlickActive = $(".slick-active");
        $(containterSlickActive).each(function (index, element) {
            var infoCuvItem = $(element).find("[data-estrategia]").data("estrategia");

            if (verificaNuevoCUVParaAnalytic(infoCuvItem))
                setCarruselMarcacionAnalytics.push([infoCuvItem.CUV2, 0]);
        });
    }
    function marcaCuvsActivos() {
        var containterSlickActive = $(".slick-active");
        $(containterSlickActive).each(function (index, element) {
            var infoCuvItem = $(element).find("[data-estrategia]").data("estrategia");
            preparaCUVAnalytic(infoCuvItem);
        });
    }

    //Marca como registrado
    function preparaCUVAnalytic(infoCuvItem) {
        for (var i = 0; i < setCarruselMarcacionAnalytics.length; i++) {
            if (setCarruselMarcacionAnalytics[i][0] == infoCuvItem.CUV2 && setCarruselMarcacionAnalytics[i][1] == 0)
                setCarruselMarcacionAnalytics[i][1] = 1;
        }
    }
    function verificaNuevoCUVParaAnalytic(infoCuvItem) {
        for (var i = 0; i < setCarruselMarcacionAnalytics.length; i++) {
            if (setCarruselMarcacionAnalytics[i][0] == infoCuvItem.CUV2 && setCarruselMarcacionAnalytics[i][1] == 2)
                return false
        }
        return true;
    }
    //quita duplicado
    function multiDimensionalUnico(arr) {
        var unicos = [];
        var itemsFound = {};
        for (var i = 0, l = arr.length; i < l; i++) {
            var stringified = JSON.stringify(arr[i]);
            if (itemsFound[stringified]) { continue; }
            unicos.push(arr[i]);
            itemsFound[stringified] = true;
        }
        return unicos;
    }

    //obtiene el cuv
    function getCuvDeCarrusel(CUV) {
        for (var i = 0; i < setCarruselCuv.length; i++) {
            if (setCarruselCuv[i].CUV2 == CUV)
                return setCarruselCuv[i];
        }
    }
    var _marcarSwipeCarrusel = function () {
        var cuvsAnalytics = [];

        for (var i = 0; i < setCarruselMarcacionAnalytics.length; i++) {
            if (setCarruselMarcacionAnalytics[i][1] == 1) {
                var infoCuv = getCuvDeCarrusel(setCarruselMarcacionAnalytics[i][0]); //obtiene info del cuv

                cuvsAnalytics.push({
                    'name': infoCuv.DescripcionCortada,
                    'id': infoCuv.CUV2,
                    'price': infoCuv.Precio2,
                    'brand': infoCuv.DescripcionMarca,
                    'category': infoCuv.CodigoCategoria,
                    'variant': infoCuv.CodigoVariante,
                    'list': infoCuv.DescripcionCortada + ' - Set productos',
                    'position': i
                });
                setCarruselMarcacionAnalytics[i][1] = 2;
            }
        }

        if (cuvsAnalytics.length > 0) {
            cuvsAnalytics = JSON.stringify(cuvsAnalytics);
            AnalyticsPortalModule.MarImpresionSetProductos(cuvsAnalytics);
        }
    }

    function Inicializar() {
        _ocultarElementos();
        _mostrarCarrusel();
        _initSwipeCarrusel();
    }

    return {
        Inicializar: Inicializar
    };
});