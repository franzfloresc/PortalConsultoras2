
var FichaVerDetalle = (function () {

    var onClickFichaDetalle = function (e) {
        //el objeto e debe ser establecido con target  (e.target)
        var infoCuvItem = EstrategiaAgregarModule.EstrategiaObtenerObj($(e));
        var codigoEstrategia = $.trim(infoCuvItem.CodigoEstrategia);
        var codigoCampania = $.trim(infoCuvItem.CampaniaID);
        var codigoCuv = $.trim(infoCuvItem.CUV2);
        var OrigenPedidoWeb = getOrigenPedidoWebDetalle(infoCuvItem);

        if (!OrigenPedidoWeb) {
            OrigenPedidoWeb = EstrategiaAgregarModule.GetOrigenPedidoWeb($(e));
        }

        OrigenPedidoWeb = CodigoOrigenPedidoWeb.GetCambioSegunTipoEstrategia(OrigenPedidoWeb, codigoEstrategia);

        var UrlDetalle = getPalanca(codigoEstrategia, OrigenPedidoWeb);

        if (UrlDetalle === "" || UrlDetalle === "undefined" || UrlDetalle == null)
            return null;

        if (OrigenPedidoWeb == "" || OrigenPedidoWeb === "undefined" || OrigenPedidoWeb == null)
            OrigenPedidoWeb = "";

        UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;

        if (!(typeof AnalyticsPortalModule === 'undefined')) {
            AnalyticsPortalModule.MarcaVerDetalleProducto(e, OrigenPedidoWeb, UrlDetalle);
        }

        if (typeof LocalStorageListado != 'undefined') {

            var origenModelo = CodigoOrigenPedidoWeb.GetOrigenModelo(OrigenPedidoWeb);
            if (origenModelo.Seccion === CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.CarruselCrossSelling
                || origenModelo.Seccion === CodigoOrigenPedidoWeb.CodigoEstructura.Seccion.CarruselUpselling) {

                var palanca = getPalanca(codigoEstrategia, OrigenPedidoWeb, false);
                var modeloEstrategiaTemporal = {
                    Origen: OrigenPedidoWeb,
                    Cuv: codigoCuv,
                    Palanca: palanca,
                    Estrategia: infoCuvItem
                };
                LocalStorageListado(ConstantesModule.KeysLocalStorage.EstrategiaTemporal, modeloEstrategiaTemporal);
            }
            else {
                LocalStorageListado(ConstantesModule.KeysLocalStorage.EstrategiaTemporal, null, 2);
            }

        }

        window.location = UrlDetalle;

        return true;
    };

    var getOrigenPedidoWebDetalle = function (item) {
        if (!item) return;

        if (item.FlagNueva) {
            if (item.EsDuoPerfecto && typeof origenPedidoWebDuoPerfecto !== 'undefined') {
                return origenPedidoWebDuoPerfecto;
            } else if (typeof origenPedidoWebPackNuevas !== 'undefined') {
                return origenPedidoWebPackNuevas;
            }
        }

        return '';
    };

    var getPalanca = function (codigoEstrategia, origenPedidoWeb, esUrl) {

        var url = "";

        if (codigoEstrategia == null || typeof codigoEstrategia === "undefined") {
            return url;
        }

        origenPedidoWeb = origenPedidoWeb || -1;
        esUrl = esUrl === undefined || esUrl;
        if (esUrl) {
            url = isMobile() ? "/Mobile/Detalle/" : "/Detalle/";
        }

        switch (codigoEstrategia) {

            case ConstantesModule.TipoEstrategia.OfertaParaTi:
                url += ConstantesModule.TipoEstrategiaTexto.OfertaParaTi;
                break;
            case ConstantesModule.TipoEstrategia.PackNuevas:
                url += ConstantesModule.TipoEstrategiaTexto.PackNuevas;
                break;
            case ConstantesModule.TipoEstrategia.OfertaWeb:
                url += ConstantesModule.TipoEstrategiaTexto.OfertaWeb;
                break;
            case ConstantesModule.TipoEstrategia.Lanzamiento:
                url += ConstantesModule.TipoEstrategiaTexto.Lanzamiento;
                break;
            case ConstantesModule.TipoEstrategia.OfertasParaMi:
                {
                    if (origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopContenedorGanadorasCarrusel
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopContenedorGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasCarrusel
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileContenedorGanadorasCarrusel
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileContenedorGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingGanadorasGanadorasCarrusel
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingGanadorasGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopBuscadorGanadorasDesplegable
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopBuscadorGanadorasCarrusel
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopBuscadorGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingBuscadorGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileBuscadorGanadorasDesplegable
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileBuscadorGanadorasCarrusel
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileBuscadorGanadorasFicha
                        || origenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingBuscadorGanadorasFicha
                    )
                        url += ConstantesModule.TipoEstrategiaTexto.Ganadoras;
                    else
                        url += ConstantesModule.TipoEstrategiaTexto.OfertaParaTi;
                }
                break;
            case ConstantesModule.TipoEstrategia.PackAltoDesembolso:
                url += ConstantesModule.TipoEstrategiaTexto.OfertaParaTi;
                break;
            case ConstantesModule.TipoEstrategia.RevistaDigital:
                url += ConstantesModule.TipoEstrategiaTexto.OfertaParaTi;
                break;
            case ConstantesModule.TipoEstrategia.LosMasVendidos:
                url += ConstantesModule.TipoEstrategiaTexto.LosMasVendidos;
                break;
            case ConstantesModule.TipoEstrategia.IncentivosProgramaNuevas:
                url += ConstantesModule.TipoEstrategiaTexto.IncentivosProgramaNuevas;
                break;
            case ConstantesModule.TipoEstrategia.OfertaDelDia:
                url += ConstantesModule.TipoEstrategiaTexto.OfertaDelDia;
                break;
            case ConstantesModule.TipoEstrategia.GuiaDeNegocioDigitalizada:
                url += ConstantesModule.TipoEstrategiaTexto.GuiaDeNegocioDigitalizada;
                break;
            case ConstantesModule.TipoEstrategia.Incentivos:
                url += ConstantesModule.TipoEstrategiaTexto.Incentivos;
                break;
            case ConstantesModule.TipoEstrategia.ShowRoom:
                url += ConstantesModule.TipoEstrategiaTexto.ShowRoom;
                break;
            case ConstantesModule.TipoEstrategia.HerramientasVenta:
                url += ConstantesModule.TipoEstrategiaTexto.HerramientasVenta;
                break;
            case ConstantesModule.TipoEstrategia.ProgramaNuevasRegalo:
                url += ConstantesModule.TipoEstrategiaTexto.ProgramaNuevasRegalo;
                break;
            case ConstantesModule.TipoEstrategia.ParticipaProgramaNuevas:
                url += ConstantesModule.TipoEstrategiaTexto.ParticipaProgramaNuevas;
                break;
            case ConstantesModule.TipoEstrategia.NotParticipaProgramaNuevas:
                url += ConstantesModule.TipoEstrategiaTexto.NotParticipaProgramaNuevas;
                break;
            case ConstantesModule.TipoEstrategia.CaminoBrillanteDemostradores:
                url += ConstantesModule.TipoEstrategiaTexto.CaminoBrillanteDemostradores;
                break;
            case ConstantesModule.TipoEstrategia.CaminoBrillanteKits:
                url += ConstantesModule.TipoEstrategiaTexto.CaminoBrillanteKits;
                break;
            case ConstantesModule.TipoEstrategia.MasGanadoras:
                url += ConstantesModule.TipoEstrategiaTexto.Ganadoras;
                break;
            default:
                url = "";
        }

        if (url != "" && esUrl) {
            url = url + "/";
        }

        return url;
    }

    var getUrlTipoPersonalizacion = function (tipoPersonalizacion) {

        var url = "";

        if (tipoPersonalizacion == null || typeof tipoPersonalizacion === "undefined") {
            return url;
        }

        url = isMobile() ? "/Mobile/Detalle/" : "/Detalle/";

        switch (tipoPersonalizacion) {

            case ConstantesModule.TipoPersonalizacion.Catalogo:
                url += ConstantesModule.TipoPersonalizacionTexto.Catalogo + "/";
                break;

            default:
                url = "";
        }

        return url;
    }

    return {
        OnClickFichaDetalle: onClickFichaDetalle,
        GetOrigenPedidoWebDetalle: getOrigenPedidoWebDetalle,
        GetPalanca: getPalanca,
        GetUrlTipoPersonalizacion: getUrlTipoPersonalizacion
    }

})();
