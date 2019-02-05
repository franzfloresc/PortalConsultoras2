﻿
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

function GetPalanca(codigoEstrategia, OrigenPedidoWeb) {
    OrigenPedidoWeb = OrigenPedidoWeb || -1;

    var url = "";

    if (codigoEstrategia == null || typeof codigoEstrategia === "undefined") {

        return url;
    }

    url = isMobile() ? "/Mobile/Detalle/" : "/Detalle/";

    switch (codigoEstrategia) {

        case ConstantesModule.ConstantesPalanca.OfertaParaTi:
            url += ConstantesModule.CodigosPalanca.OfertaParaTi + "/";
            break;
        case ConstantesModule.ConstantesPalanca.PackNuevas:
            url += ConstantesModule.CodigosPalanca.PackNuevas + "/";
            break;
        case ConstantesModule.ConstantesPalanca.OfertaWeb:
            url += ConstantesModule.CodigosPalanca.OfertaWeb + "/";
            break;
        case ConstantesModule.ConstantesPalanca.Lanzamiento:
            url += ConstantesModule.CodigosPalanca.Lanzamiento + "/";
            break;
        case ConstantesModule.ConstantesPalanca.OfertasParaMi:
            {
                if (OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopContenedorGanadorasCarrusel ||
                    OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopContenedorGanadorasFicha ||
                    OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasCarrusel ||
                    OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasFicha ||
                    OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileContenedorGanadorasCarrusel ||
                    OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileContenedorGanadorasFicha ||
                    OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingGanadorasGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingGanadorasGanadorasFicha ||

                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopBuscadorGanadorasDesplegable ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopBuscadorGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopBuscadorGanadorasFicha ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingBuscadorGanadorasFicha ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileBuscadorGanadorasDesplegable ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileBuscadorGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileBuscadorGanadorasFicha ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingBuscadorGanadorasFicha
                    )
                    url += ConstantesModule.CodigosPalanca.Ganadoras + "/";
                else
                    url += ConstantesModule.CodigosPalanca.OfertaParaTi + "/";
            }
            break;
        case ConstantesModule.ConstantesPalanca.PackAltoDesembolso:
            url += ConstantesModule.CodigosPalanca.OfertaParaTi + "/";
            break;
        case ConstantesModule.ConstantesPalanca.RevistaDigital:
            url += ConstantesModule.CodigosPalanca.OfertaParaTi + "/";
            break;
        case ConstantesModule.ConstantesPalanca.LosMasVendidos:
            url += ConstantesModule.CodigosPalanca.LosMasVendidos + "/";
            break;
        case ConstantesModule.ConstantesPalanca.IncentivosProgramaNuevas:
            url += ConstantesModule.CodigosPalanca.IncentivosProgramaNuevas + "/";
            break;
        case ConstantesModule.ConstantesPalanca.OfertaDelDia:
            url += ConstantesModule.CodigosPalanca.OfertaDelDia + "/";
            break;
        case ConstantesModule.ConstantesPalanca.GuiaDeNegocioDigitalizada:
            url += ConstantesModule.CodigosPalanca.GuiaDeNegocioDigitalizada + "/";
            break;
        case ConstantesModule.ConstantesPalanca.Incentivos:
            url += ConstantesModule.CodigosPalanca.Incentivos + "/";
            break;
        case ConstantesModule.ConstantesPalanca.ShowRoom:
            url += ConstantesModule.CodigosPalanca.ShowRoom + "/";
            break;
        case ConstantesModule.ConstantesPalanca.HerramientasVenta:
            url += ConstantesModule.CodigosPalanca.HerramientasVenta + "/";
            break;
        case ConstantesModule.ConstantesPalanca.ProgramaNuevasRegalo:
            url += ConstantesModule.CodigosPalanca.ProgramaNuevasRegalo + "/";
            break;
        case ConstantesModule.ConstantesPalanca.ParticipaProgramaNuevas:
            url += ConstantesModule.CodigosPalanca.ParticipaProgramaNuevas + "/";
            break;
        case ConstantesModule.ConstantesPalanca.NotParticipaProgramaNuevas:
            url += ConstantesModule.CodigosPalanca.NotParticipaProgramaNuevas + "/";
            break;
        default:
            return "";
    }

    return url;
}

function GetNombrePalanca(codigoEstrategia, OrigenPedidoWeb) {
    console.log('GetNombrePalanca', codigoEstrategia, OrigenPedidoWeb);
    OrigenPedidoWeb = OrigenPedidoWeb || -1;

    var palanca = "";

    if (codigoEstrategia != null && typeof codigoEstrategia !== "undefined") {
        switch (codigoEstrategia) {

            case ConstantesModule.ConstantesPalanca.OfertaParaTi:
                palanca += ConstantesModule.CodigosPalanca.OfertaParaTi;
                break;
            case ConstantesModule.ConstantesPalanca.PackNuevas:
                palanca += ConstantesModule.CodigosPalanca.PackNuevas;
                break;
            case ConstantesModule.ConstantesPalanca.OfertaWeb:
                palanca += ConstantesModule.CodigosPalanca.OfertaWeb;
                break;
            case ConstantesModule.ConstantesPalanca.Lanzamiento:
                palanca += ConstantesModule.CodigosPalanca.Lanzamiento;
                break;
            case ConstantesModule.ConstantesPalanca.OfertasParaMi:
                {
                    if (OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopContenedorGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopContenedorGanadorasFicha ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasFicha ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileContenedorGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileContenedorGanadorasFicha ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingGanadorasGanadorasCarrusel ||
                        OrigenPedidoWeb == ConstantesModule.OrigenPedidoWeb.MobileLandingGanadorasGanadorasFicha)
                        palanca += ConstantesModule.CodigosPalanca.Ganadoras;
                    else
                        palanca += ConstantesModule.CodigosPalanca.OfertaParaTi;
                }
                break;
            case ConstantesModule.ConstantesPalanca.PackAltoDesembolso:
                palanca += ConstantesModule.CodigosPalanca.OfertaParaTi;
                break;
            case ConstantesModule.ConstantesPalanca.RevistaDigital:
                palanca += ConstantesModule.CodigosPalanca.OfertaParaTi;
                break;
            case ConstantesModule.ConstantesPalanca.LosMasVendidos:
                palanca += ConstantesModule.CodigosPalanca.LosMasVendidos;
                break;
            case ConstantesModule.ConstantesPalanca.IncentivosProgramaNuevas:
                palanca += ConstantesModule.CodigosPalanca.IncentivosProgramaNuevas;
                break;
            case ConstantesModule.ConstantesPalanca.OfertaDelDia:
                palanca += ConstantesModule.CodigosPalanca.OfertaDelDia;
                break;
            case ConstantesModule.ConstantesPalanca.GuiaDeNegocioDigitalizada:
                palanca += ConstantesModule.CodigosPalanca.GuiaDeNegocioDigitalizada;
                break;
            case ConstantesModule.ConstantesPalanca.Incentivos:
                palanca += ConstantesModule.CodigosPalanca.Incentivos;
                break;
            case ConstantesModule.ConstantesPalanca.ShowRoom:
                palanca += ConstantesModule.CodigosPalanca.ShowRoom;
                break;
            case ConstantesModule.ConstantesPalanca.HerramientasVenta:
                palanca += ConstantesModule.CodigosPalanca.HerramientasVenta;
                break;
            case ConstantesModule.ConstantesPalanca.ProgramaNuevasRegalo:
                palanca += ConstantesModule.CodigosPalanca.ProgramaNuevasRegalo;
                break;
            case ConstantesModule.ConstantesPalanca.ParticipaProgramaNuevas:
                palanca += ConstantesModule.CodigosPalanca.ParticipaProgramaNuevas;
                break;
            case ConstantesModule.ConstantesPalanca.NotParticipaProgramaNuevas:
                url += ConstantesModule.CodigosPalanca.NotParticipaProgramaNuevas;
                break;
            default:
                return "";
        }
    }
    return palanca;
}
