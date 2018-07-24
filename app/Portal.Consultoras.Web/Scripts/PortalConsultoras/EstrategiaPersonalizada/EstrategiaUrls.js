
function OnClickFichaDetalle(e) {
    //el objeto e debe ser establecido con target  (e.target)
    var infoItem = EstrategiaAgregarModule.EstrategiaObtenerObj($(e));
    
    //EstrategiaGuardarTemporal(infoItem);
    var codigoEstrategia = $.trim(infoItem.CodigoEstrategia);
    var codigoCampania   = $.trim(infoItem.CampaniaID);
    var codigoCuv        = $.trim(infoItem.CUV2);
    var UrlDetalle = GetPalanca(codigoEstrategia);
    var OrigenPedidoWeb = EstrategiaAgregarModule.GetOrigenPedidoWeb($(e), true);

    if (OrigenPedidoWeb == "" || OrigenPedidoWeb === "undefined" || OrigenPedidoWeb == null)
        OrigenPedidoWeb = "";
    
    if (UrlDetalle == "" || UrlDetalle === "undefined" || UrlDetalle == null)
        return null;

    UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
    
    window.location = UrlDetalle;  
                       
    return true;
}

function GetPalanca(codigoEstrategia) {

    var url = isMobile() ? "/Mobile/Detalle/": "/Detalle/";

    if (codigoEstrategia != null && typeof codigoEstrategia !== "undefined")

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
                url += ConstantesModule.CodigosPalanca.OfertaParaTi + "/";
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

