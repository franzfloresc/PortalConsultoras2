
function OnClickFichaDetalle(e) {
    var estoyEnLaFicha = typeof fichaModule !== "undefined"; //una forma de identificar si estoy en la ficha o no.    
    //el objeto e debe ser establecido con target  (e.target)
    var infoCuvItem = EstrategiaAgregarModule.EstrategiaObtenerObj($(e));
    var codigoEstrategia = $.trim(infoCuvItem.CodigoEstrategia);
    var codigoCampania = $.trim(infoCuvItem.CampaniaID);
    var codigoCuv = $.trim(infoCuvItem.CUV2);
    var OrigenPedidoWeb = EstrategiaAgregarModule.GetOrigenPedidoWeb($(e), true);

    var UrlDetalle = GetPalanca(codigoEstrategia, OrigenPedidoWeb);

    if (UrlDetalle === "" || UrlDetalle === "undefined" || UrlDetalle == null)
        return null;

    if (OrigenPedidoWeb == "" || OrigenPedidoWeb === "undefined" || OrigenPedidoWeb == null)
        OrigenPedidoWeb = "";

    UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;

    if (!(typeof AnalyticsPortalModule === 'undefined')) {
        if (estoyEnLaFicha)
            AnalyticsPortalModule.MarcarClicSetProductos(infoCuvItem, e, OrigenPedidoWeb, estoyEnLaFicha);
        else
            AnalyticsPortalModule.MarcaGenericaClic(e, OrigenPedidoWeb);
    }

    window.location = UrlDetalle;

    return true;
}

function BuscadorFichaDetalle(codigoCampania, codigoCuv, OrigenPedidoWeb, codigoEstrategia) {

    var UrlDetalle = GetPalanca(codigoEstrategia);
    if (UrlDetalle == "") return false;
    UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
    window.location = UrlDetalle;
    return true;
}

function GetPalanca(codigoEstrategia, origenPedidoWeb, esUrl) {

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

        case ConstantesModule.ConstantesPalanca.OfertaParaTi:
            url += ConstantesModule.CodigosPalanca.OfertaParaTi;
            break;
        case ConstantesModule.ConstantesPalanca.PackNuevas:
            url += ConstantesModule.CodigosPalanca.PackNuevas;
            break;
        case ConstantesModule.ConstantesPalanca.OfertaWeb:
            url += ConstantesModule.CodigosPalanca.OfertaWeb;
            break;
        case ConstantesModule.ConstantesPalanca.Lanzamiento:
            url += ConstantesModule.CodigosPalanca.Lanzamiento;
            break;
        case ConstantesModule.ConstantesPalanca.OfertasParaMi:
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
                    url += ConstantesModule.CodigosPalanca.Ganadoras;
                else
                    url += ConstantesModule.CodigosPalanca.OfertaParaTi;
            }
            break;
        case ConstantesModule.ConstantesPalanca.PackAltoDesembolso:
            url += ConstantesModule.CodigosPalanca.OfertaParaTi;
            break;
        case ConstantesModule.ConstantesPalanca.RevistaDigital:
            url += ConstantesModule.CodigosPalanca.OfertaParaTi;
            break;
        case ConstantesModule.ConstantesPalanca.LosMasVendidos:
            url += ConstantesModule.CodigosPalanca.LosMasVendidos;
            break;
        case ConstantesModule.ConstantesPalanca.IncentivosProgramaNuevas:
            url += ConstantesModule.CodigosPalanca.IncentivosProgramaNuevas;
            break;
        case ConstantesModule.ConstantesPalanca.OfertaDelDia:
            url += ConstantesModule.CodigosPalanca.OfertaDelDia;
            break;
        case ConstantesModule.ConstantesPalanca.GuiaDeNegocioDigitalizada:
            url += ConstantesModule.CodigosPalanca.GuiaDeNegocioDigitalizada;
            break;
        case ConstantesModule.ConstantesPalanca.Incentivos:
            url += ConstantesModule.CodigosPalanca.Incentivos;
            break;
        case ConstantesModule.ConstantesPalanca.ShowRoom:
            url += ConstantesModule.CodigosPalanca.ShowRoom;
            break;
        case ConstantesModule.ConstantesPalanca.HerramientasVenta:
            url += ConstantesModule.CodigosPalanca.HerramientasVenta;
            break;
        case ConstantesModule.ConstantesPalanca.ProgramaNuevasRegalo:
            url += ConstantesModule.CodigosPalanca.ProgramaNuevasRegalo;
            break;
        case ConstantesModule.ConstantesPalanca.ParticipaProgramaNuevas:
            url += ConstantesModule.CodigosPalanca.ParticipaProgramaNuevas;
            break;
        case ConstantesModule.ConstantesPalanca.NotParticipaProgramaNuevas:
            url += ConstantesModule.CodigosPalanca.NotParticipaProgramaNuevas;
            break;
        default:
            url = "";
    }

    if (url != "" && esUrl) {
        url = url + "/";
    }

    return url;
}

