
if (!jQuery) { throw new Error("CodigoUbigeoPortal.js requires jQuery"); }

var CodigoOrigenPedidoWeb = (function () {

    var codigoTipoEstrategia = ConstantesModule.TipoEstrategia;

    var origenPedidoWebEstructura = {
        Dimension: 7,
        Dispositivo: {
            Desktop: '1',
            Mobile: '2'
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
            ArmaTuPackDetalle: '13',
            LandingDuoPerfecto: '14',
            LandingPackNuevas: '15',
            DuoPerfecto: '16',
            PackNuevas: '17',
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
            PackNuevas: '17'
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
            CatalogoPendienteDeAprobar: '11',
            CarruselUpselling: '15',
            FichaUpselling: '16',
        }
    };

    var diccionarioTipoEstrategiaPalanca = [
        { codigo: codigoTipoEstrategia.OfertaParaTi, Palanca: origenPedidoWebEstructura.Palanca.OfertasParaTi },
        { codigo: codigoTipoEstrategia.PackNuevas, Palanca: origenPedidoWebEstructura.Palanca.PackNuevas },
        { codigo: codigoTipoEstrategia.Lanzamiento, Palanca: origenPedidoWebEstructura.Palanca.Lanzamientos },
        { codigo: codigoTipoEstrategia.OfertasParaMi, Palanca: origenPedidoWebEstructura.Palanca.OfertasParaTi },
        { codigo: codigoTipoEstrategia.PackAltoDesembolso, Palanca: origenPedidoWebEstructura.Palanca.OfertasParaTi },
        { codigo: codigoTipoEstrategia.OfertaDelDia, Palanca: origenPedidoWebEstructura.Palanca.OfertaDelDia },
        { codigo: codigoTipoEstrategia.GuiaDeNegocioDigitalizada, Palanca: origenPedidoWebEstructura.Palanca.GND },
        { codigo: codigoTipoEstrategia.HerramientasVenta, Palanca: origenPedidoWebEstructura.Palanca.HerramientasVenta },
        { codigo: codigoTipoEstrategia.ShowRoom, Palanca: origenPedidoWebEstructura.Palanca.Showroom },
        { codigo: codigoTipoEstrategia.MasGanadoras, Palanca: origenPedidoWebEstructura.Palanca.Ganadoras },
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

    var getOrigenModelo = function (codigoOrigenPedido) {
        try {
            var origenEstructura = {};

            codigoOrigenPedido = $.trim(codigoOrigenPedido);

            origenEstructura.Dispositivo = codigoOrigenPedido.substring(0, 1).trim();
            origenEstructura.Pagina = codigoOrigenPedido.substring(1, 3).trim();
            origenEstructura.Palanca = codigoOrigenPedido.substring(3, 5).trim();
            origenEstructura.Seccion = codigoOrigenPedido.substring(5, 7).trim();

            return origenEstructura;

        } catch (e) {
            //
        }
    };


    return {
        CodigoEstructura: origenPedidoWebEstructura,
        MaestroCodigoOrigen: maestroCodigoOrigen,
        GetOrigenModelo: getOrigenModelo,
        DiccionarioTipoEstrategia: diccionarioTipoEstrategiaPalanca
    }
})();