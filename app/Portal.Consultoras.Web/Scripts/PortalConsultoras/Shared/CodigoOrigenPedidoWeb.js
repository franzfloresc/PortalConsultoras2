
if (!jQuery) { throw new Error("CodigoUbigeoPortal.js requires jQuery"); }

var CodigoOrigenPedidoWeb = (function () {

    var codigoTipoEstrategia = ConstantesModule.TipoEstrategia;

    var origenPedidoWebEstructura = {
        IncorrectoDispositivo: "0",
        Incorrecto: "99",
        Dimension: 7,
        Dispositivo: {
            Desktop: '1',
            Mobile: '2',
            Chatbot: '3',
            AppConsultora: '4',
            AppMaquillador: '5'
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
            Maquillador: '12',
            ArmaTuPackDetalle: '13',
            LandingDuoPerfecto: '14',
            LandingPackNuevas: '15',
            LandingOfertaDelDia: '16',
            LandingCategoria: '17',
            CaminoBrillante: '18',
            Ficha: '19'
        },
        Palanca: {
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
            ArmaTuPack: '15',
            DuoPerfecto: '16',
            PackNuevas: '17',
            EscogeTuRegalo: '18',
            OfertasEspeciales: '19'
        },
        Seccion: {
            Carrusel: '01',
            Ficha: '02',
            Banner: '03',
            DesplegableBuscador: '04',
            CarruselVerMas: '05',
            BannerSuperior: '06',
            SubCampania: '07',
            Recomendado: '08',
            RecomendadoFicha: '09',
            AppCatalogoPendienteDeAprobar: '10',
            CatalogoDigitalPendienteDeAprobarCliente: '11',
            AppMaquilladorPendienteDeAprobarCliente: '12',
            CatalogoDigitalPendienteDeAprobarProducto: '13',
            AppMaquilladorPendienteDeAprobarProducto: '14',
            CarruselUpselling: '15',
            FichaUpselling: '16',
            CarruselCrossSelling: '18',
            FichaCrossSelling: '19',
            CarruselSugeridos: '20',
            FichaSugeridos: '21'
        }
    };

    var diccionarioTipoEstrategiaPalanca = [
        { codigo: codigoTipoEstrategia.OfertaParaTi, Palanca: origenPedidoWebEstructura.Palanca.OfertasParaTi },
        { codigo: codigoTipoEstrategia.PackNuevas, Palanca: origenPedidoWebEstructura.Palanca.PackNuevas },
        { codigo: codigoTipoEstrategia.ArmaTuPack, Palanca: origenPedidoWebEstructura.Palanca.ArmaTuPack },
        { codigo: codigoTipoEstrategia.Lanzamiento, Palanca: origenPedidoWebEstructura.Palanca.Lanzamientos },
        { codigo: codigoTipoEstrategia.OfertasParaMi, Palanca: origenPedidoWebEstructura.Palanca.OfertasParaTi },
        { codigo: codigoTipoEstrategia.PackAltoDesembolso, Palanca: origenPedidoWebEstructura.Palanca.OfertasParaTi },
        { codigo: codigoTipoEstrategia.OfertaDelDia, Palanca: origenPedidoWebEstructura.Palanca.OfertaDelDia },
        { codigo: codigoTipoEstrategia.GuiaDeNegocioDigitalizada, Palanca: origenPedidoWebEstructura.Palanca.GND },
        { codigo: codigoTipoEstrategia.HerramientasVenta, Palanca: origenPedidoWebEstructura.Palanca.HerramientasVenta },
        { codigo: codigoTipoEstrategia.IncentivosProgramaNuevas, Palanca: origenPedidoWebEstructura.Palanca.PackNuevas },
        { codigo: codigoTipoEstrategia.ShowRoom, Palanca: origenPedidoWebEstructura.Palanca.Showroom },
        { codigo: codigoTipoEstrategia.MasGanadoras, Palanca: origenPedidoWebEstructura.Palanca.Ganadoras },
        { codigo: codigoTipoEstrategia.ProgramaNuevasRegalo, Palanca: origenPedidoWebEstructura.Palanca.EscogeTuRegalo },
        { codigo: codigoTipoEstrategia.DuoPerfecto, Palanca: origenPedidoWebEstructura.Palanca.DuoPerfecto }
    ];


    var maestroCodigoOrigen = {
        MobileArmaTuPackFicha: origenPedidoWebEstructura.Dispositivo.Mobile
            + origenPedidoWebEstructura.Pagina.ArmaTuPackDetalle
            + origenPedidoWebEstructura.Palanca.ArmaTuPack
            + origenPedidoWebEstructura.Seccion.Ficha,
        
        DesktopArmaTuPackFicha: origenPedidoWebEstructura.Dispositivo.Desktop
            + origenPedidoWebEstructura.Pagina.ArmaTuPackDetalle
            + origenPedidoWebEstructura.Palanca.ArmaTuPack
            + origenPedidoWebEstructura.Seccion.Ficha
    };

    var getOrigenModelo = function (origen) {
        try {

            var origenEstructura = {};

            if (typeof origen === "object") {
                origenEstructura = origen || {};
            }
            else {
                origenEstructura.OrigenPedidoWeb = origen || "";
            }

            origenEstructura.OrigenPedidoWeb = (origenEstructura.OrigenPedidoWeb || "").toString().trim();
            origenEstructura.CodigoPalanca = (origenEstructura.CodigoPalanca || "").toString().trim();
            
            var codigoOrigenPedido = origenEstructura.OrigenPedidoWeb;

            origenEstructura.Dispositivo = (origenEstructura.Dispositivo || codigoOrigenPedido.substring(0, 1)).toString().trim();
            origenEstructura.Pagina = (origenEstructura.Pagina || codigoOrigenPedido.substring(1, 3)).toString().trim();
            origenEstructura.Palanca = (origenEstructura.Palanca || codigoOrigenPedido.substring(3, 5)).toString().trim();
            origenEstructura.Seccion = (origenEstructura.Seccion || codigoOrigenPedido.substring(5, 7)).toString().trim();
            
            if (origenEstructura.Palanca == "" && origenEstructura.CodigoPalanca != "") {
                origenEstructura.Palanca = _getIdPalancaSegunCodigo(origenEstructura.CodigoPalanca);
            }
            
            return origenEstructura;

        } catch (e) {
            //
        }
    };

    var getOrigenCambioSegunTipoEstrategia = function (origenPedidoWeb, codigoEstrategia) {

        var origenModelo = getOrigenModelo(origenPedidoWeb);
        if (origenModelo.Seccion == origenPedidoWebEstructura.Seccion.CarruselUpselling ||
            origenModelo.Seccion == origenPedidoWebEstructura.Seccion.CarruselCrossSelling ||
            origenModelo.Seccion == origenPedidoWebEstructura.Seccion.CarruselSugeridos) {
            var _objTipoPalanca = diccionarioTipoEstrategiaPalanca.find(function (x) {
                return x.codigo === codigoEstrategia
            }) || {};

            origenModelo.Palanca = _objTipoPalanca.Palanca || origenPedidoWebEstructura.Incorrecto;
        }

        return origenModelo.Dispositivo + origenModelo.Pagina + origenModelo.Palanca + origenModelo.Seccion;
    };

    return {
        CodigoEstructura: origenPedidoWebEstructura,
        MaestroCodigoOrigen: maestroCodigoOrigen,
        GetOrigenModelo: getOrigenModelo,
        GetCambioSegunTipoEstrategia: getOrigenCambioSegunTipoEstrategia,
        DiccionarioTipoEstrategia: diccionarioTipoEstrategiaPalanca
    }
})();