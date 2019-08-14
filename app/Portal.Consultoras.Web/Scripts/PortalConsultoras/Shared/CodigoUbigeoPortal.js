
if (!jQuery) { throw new Error("CodigoUbigeoPortal.js requires jQuery"); }

var CodigoUbigeoPortal = (function () {
    var _texto = {
        notavaliable: "(not available)",
        contenedor: "Contenedor",
        contenedorHome: "Contenedor - Inicio"
    };

    var estructuraUbigeo = {
        Guion: '--',
        Dispositivo: {
            Desktop: '01',
            Mobile: '02'
        },
        Pagina: {
            LandingHerramientasVenta: '00',
            Home: '01',
            Pedido: '02',
            LandingLiquidacion: '03',
            Buscador: '04',
            LandingShowroom: '05',
            LandingGnd: '06',
            LandingOfertasParaTi: '07',
            Contenedor: '08',
            Otras: '09',
            LandingBuscador: '10',
            LandingGanadoras: '11',
            ArmaTuPack: '12',
            MisCatalogosRevista:'13'
        },
        SeccionFuncional: {
            OfertasParaTi: '00',
            Showroom: '01',
            Lanzamientos: '02',
            OfertaDelDia: '03',
            OfertaFinal: '04',
            GND: '05',
            Liquidacion: '06',
            ProductoSugerido: '07',
            HerramientasVenta: '08',
            Banners: '09',
            Digitado: '10',
            CatalogoLbel: '11',
            CatalogoEsika: '12',
            CatalogoCyzone: '13',
            Ganadoras: '14',
            Grilla: '15',
            ArmatuPack: '16',
            ResumenBelcorp : "17"
        },
        Seccion: {
            Carrusel: '01',
            Ficha: '02',
            Banner: '03',
            DesplegableBuscador: '04',
            CarruselVerMas: '05',
            BannerSuperior: '06',
            SubCampania: '07',
            Recomendados: '08',
            FichaResumida: '09'
        },
        SubSeccion: {

        }

    };

    var textos = {
        Dispositivo: [
            { Codigo: "--", Texto: "" },
            { Codigo: "01", Texto: "" },
            { Codigo: "02", Texto: "" }
        ],
        Pagina: [
            { Codigo: "--", Texto: "" },
            { Codigo: "00", Texto: "" },
            { Codigo: "01", Texto: "Home" },
            { Codigo: "02", Texto: "Carrito de Compras" },
            { Codigo: "03", Texto: "" },
            { Codigo: "04", Texto: "Showroom" },
            { Codigo: "05", Texto: "" },
            { Codigo: "06", Texto: "" },
            { Codigo: "07", Texto: "" },
            { Codigo: "08", Texto: "Inicio" },
            { Codigo: "09", Texto: "Otras Paginas" },
            { Codigo: "10", Texto: "" },
            { Codigo: "11", Texto: "" },
            { Codigo: "12", Texto: "Arma tu Pack" }

        ],
        SeccionFuncional: [
            { Codigo: "--", CodigoPalanca: "--", Texto: "" },
            { Codigo: "00", CodigoPalanca: "RD", Texto: "Ofertas Para Ti" },
            { Codigo: "01", CodigoPalanca: "SR", Texto: "Showroom" },
            { Codigo: "02", CodigoPalanca: "LAN", Texto: "Lanzamientos" },
            { Codigo: "03", CodigoPalanca: "ODD", Texto: "Oferta del Día" },
            { Codigo: "04", CodigoPalanca: "OF", Texto: "" },
            { Codigo: "05", CodigoPalanca: "GND", Texto: "GND" },
            { Codigo: "06", CodigoPalanca: "", Texto: "Liquidaciones Web" },
            { Codigo: "07", CodigoPalanca: "", Texto: "" },
            { Codigo: "08", CodigoPalanca: "HV", Texto: "Herramientas de Venta" },
            { Codigo: "09", CodigoPalanca: "", Texto: "" },
            { Codigo: "10", CodigoPalanca: "", Texto: "" },
            { Codigo: "11", CodigoPalanca: "", Texto: "" },
            { Codigo: "12", CodigoPalanca: "", Texto: "" },
            { Codigo: "13", CodigoPalanca: "", Texto: "" },
            { Codigo: "14", CodigoPalanca: "LMG", Texto: "Más Ganadoras" },
            { Codigo: "15", CodigoPalanca: "", Texto: "", Desc: "Grilla" },
            { Codigo: "16", CodigoPalanca: "ATP", Texto: "Arma tu Pack", Desc: "Arma tu Pack" }

        ],
        Seccion: [
            { Codigo: "01", Texto: "" },
            { Codigo: "02", Texto: "Detalle de Producto" },
            { Codigo: "03", Texto: "" },
            { Codigo: "04", Texto: "" },
            { Codigo: "05", Texto: "Detalle de Producto - Ver más sets" },
            { Codigo: "06", Texto: "" },
            { Codigo: "08", Texto: "Recomendados" },
            { Codigo: "09", Texto: "Ficha Resumida" }
        ],
        SubSeccion: [

        ]
    };

    var maestroCodigoUbigeo = {
        GuionPedidoGuionFichaResumida: estructuraUbigeo.Guion + estructuraUbigeo.Pagina.Pedido + estructuraUbigeo.Guion + estructuraUbigeo.SeccionFuncional.OfertasParaTi, //"--02--00",
        GuionContenedorArmaTuPackGuion: "--0816--",
        GuionContenedorArmaTuPack: "--12----",
        GuionCarritoComprasGuionFichaResumida: "--02--09",

        /*RevistaDigitalMobileCatalogoSeccion = 2401*/
        MobileRevistaDigitalMobileCatalogoSeccion: estructuraUbigeo.Dispositivo.Mobile + estructuraUbigeo.Pagina.MisCatalogosRevista + estructuraUbigeo.SeccionFuncional.OfertasParaTi + estructuraUbigeo.Guion,
        DesktopRevistaDigitalMobileCatalogoSeccion: estructuraUbigeo.Dispositivo.Desktop + estructuraUbigeo.Pagina.MisCatalogosRevista + estructuraUbigeo.SeccionFuncional.OfertasParaTi + estructuraUbigeo.Guion,

        /*RevistaDigitalMobileHomeSeccion = 2101*/
        MobileRevistaDigitalHomeSeccion: estructuraUbigeo.Dispositivo.Mobile + estructuraUbigeo.Pagina.Home + estructuraUbigeo.SeccionFuncional.OfertasParaTi + estructuraUbigeo.Guion,
        DesktopRevistaDigitalHomeSeccion: estructuraUbigeo.Dispositivo.Desktop + estructuraUbigeo.Pagina.Home + estructuraUbigeo.SeccionFuncional.OfertasParaTi + estructuraUbigeo.Guion,

        /*RevistaDigitalMobileHomeSeccion = 2101*/
        MobileRevistaDigitalResumenBelcorp: estructuraUbigeo.Dispositivo.Mobile + estructuraUbigeo.Pagina.Home + estructuraUbigeo.SeccionFuncional.ResumenBelcorp + estructuraUbigeo.Guion,
        DesktopRevistaDigitalResumenBelcorp: estructuraUbigeo.Dispositivo.Desktop + estructuraUbigeo.Pagina.Home + estructuraUbigeo.SeccionFuncional.ResumenBelcorp + estructuraUbigeo.Guion,

        /*RevistaDigitalDesktopPedidoSeccion = 1201*/
        MobilePedidoRevistaDigital: estructuraUbigeo.Dispositivo.Mobile + estructuraUbigeo.Pagina.Pedido + estructuraUbigeo.SeccionFuncional.OfertasParaTi + estructuraUbigeo.Guion,
        DesktopPedidoRevistaDigital: estructuraUbigeo.Dispositivo.Desktop + estructuraUbigeo.Pagina.Pedido + estructuraUbigeo.SeccionFuncional.OfertasParaTi + estructuraUbigeo.Guion

    }


    var getEstructuraSegunCodigoUbigeo = function (codigo) {
        var origenEstructura = {};

        if (typeof codigo === "object") {
            origenEstructura = codigo || {};
        }
        else {
            origenEstructura.CodigoUbigeoPortal = codigo || "";
        }

        origenEstructura.CodigoUbigeoPortal = (origenEstructura.CodigoUbigeoPortal || "").toString().trim();
        origenEstructura.CodigoPalanca = (origenEstructura.CodigoPalanca || "").toString().trim();

        var codigoUbigeoPortal = origenEstructura.CodigoUbigeoPortal;

        origenEstructura.Dispositivo = (origenEstructura.Pagina || codigoUbigeoPortal.substring(0, 2)).toString().trim();
        origenEstructura.Pagina = (origenEstructura.Pagina || codigoUbigeoPortal.substring(2, 4)).toString().trim();
        origenEstructura.SeccionFuncional = (origenEstructura.SeccionFuncional || codigoUbigeoPortal.substring(4, 6)).toString().trim();
        origenEstructura.Seccion = (origenEstructura.Seccion || codigoUbigeoPortal.substring(6, 8)).toString().trim();

        return origenEstructura;
    }

    var getTextoContenedorSegunOrigen = function (origenEstructura) {

        origenEstructura.CodigoPalanca = origenEstructura.CodigoPalanca || "";
        var contendor =
            origenEstructura.Pagina == estructuraUbigeo.Pagina.Contenedor
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingBuscador
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingGanadoras
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingGnd
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingHerramientasVenta
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingLiquidacion
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingOfertasParaTi
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.ArmaTuPack
            || origenEstructura.Pagina == estructuraUbigeo.Pagina.LandingShowroom
            || origenEstructura.Seccion == estructuraUbigeo.Seccion.Ficha
            || origenEstructura.Seccion == estructuraUbigeo.Seccion.CarruselVerMas
            || origenEstructura.CodigoPalanca != "";

        if (contendor) {
            return _texto.contenedor;
        }

        return "";
    }

    var getTextoPaginaSegunOrigen = function (origenEstructura) {

        var obj = textos.Pagina.find(function (element) {
            return element.Codigo == origenEstructura.Pagina;
        });

        if (obj == undefined) {
            return "";
        }

        return obj.Texto || "";
    }

    var getTextoPalancaSegunOrigen = function (origenEstructura) {

        var obj = textos.SeccionFuncional.find(function (element) {
            return element.Codigo == origenEstructura.SeccionFuncional;
        });

        if (obj == undefined && origenEstructura.CodigoPalanca != "") {
            obj = textos.SeccionFuncional.find(function (element) {
                return element.CodigoPalanca == origenEstructura.CodigoPalanca;
            });
        }

        if (obj == undefined) {
            return "";
        }

        return obj.Texto || "";
    }

    var getTextoSeccionSegunOrigen = function (origenEstructura) {

        var obj = textos.Seccion.find(function (element) {
            return element.Codigo == origenEstructura.Seccion;
        });

        if (obj == undefined) {
            return "";
        }

        return obj.Texto || "";
    }

    var getTextoSegunCodigoUbigeo = function (origenEstructura) {

        origenEstructura = getEstructuraSegunCodigoUbigeo(origenEstructura);
        var contendor = getTextoContenedorSegunOrigen(origenEstructura);
        var pagina = getTextoPaginaSegunOrigen(origenEstructura);
        var seccionFuncional = getTextoPalancaSegunOrigen(origenEstructura);
        var seccion = getTextoSeccionSegunOrigen(origenEstructura);

        var separador = " - ";
        var texto = contendor;

        texto += texto != ""
            ? ((pagina != "" ? separador : "") + pagina)
            : pagina;

        texto += texto != ""
            ? ((seccionFuncional != "" ? separador : "") + seccionFuncional)
            : seccionFuncional;
        texto += texto != ""
            ? ((seccion != "" ? separador : "") + seccion)
            : seccion;

        return texto;
    }

    return {
        MaestroCodigoUbigeo: maestroCodigoUbigeo,
        EstructuraUbigeo: estructuraUbigeo,
        GetEstructuraSegunCodigo: getEstructuraSegunCodigoUbigeo,
        GetTextoSegunCodigo: getTextoSegunCodigoUbigeo
    }
})();