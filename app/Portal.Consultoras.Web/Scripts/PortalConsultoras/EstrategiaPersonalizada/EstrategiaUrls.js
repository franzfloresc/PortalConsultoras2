/**
 * Constantes Referenciadas por Palancas
 */
const OfertaParaTi = "001";
const PackNuevas = "002";
const OfertaWeb = "003";
const Lanzamiento = "005";
const OfertasParaMi = "007";
const PackAltoDesembolso = "008";
const RevistaDigital = "101";
const LosMasVendidos = "020";
const IncentivosProgramaNuevas = "021";
const OfertaDelDia = "009";
const GuiaDeNegocioDigitalizada = "010";
const Incentivos = "022";
const ShowRoom = "030";
const HerramientasVenta = "011";
const ProgramaNuevasRegalo = "044";
const ParticipaProgramaNuevas = "1";
const NotParticipaProgramaNuevas = "0";


function OnClickFichaDetalle(e) {
    //el objeto e debe establecido con  target  (e.target)
    var infoItem         = EstrategiaAgregarModule.EstrategiaObtenerObj($(e));
    var codigoEstrategia = $.trim(infoItem.CodigoEstrategia);
    var codigoCampania   = $.trim(infoItem.CampaniaID);
    var codigoCuv        = $.trim(infoItem.CUV2);
    var UrlDetalle = GetPalanca(codigoEstrategia);
    var OrigenPedidoWeb = EstrategiaAgregarModule.GetOrigenPedidoWeb($(e));

    if (OrigenPedidoWeb == "" || OrigenPedidoWeb === "undefined" || OrigenPedidoWeb == null)
        OrigenPedidoWeb = "";
    
    if (UrlDetalle == "" || UrlDetalle === "undefined" || UrlDetalle == null)
        return null;

    UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
                            
    return window.location = UrlDetalle;
}

function GetPalanca(codigoEstrategia) {

    var url = "/Detalle/";

    if (codigoEstrategia != null && typeof codigoEstrategia !== "undefined")

        switch (codigoEstrategia) {
            case OfertaParaTi:
                url += "OfertaParaTi/";
                break;
            case PackNuevas:
                url += "PackNuevas/";
                break;
            case OfertaWeb:
                url += "OfertaWeb/";
                break;
            case Lanzamiento:
                url += "Lanzamiento/";
                break;
            case OfertasParaMi:
                url += "OfertasParaMi/";
                break;
            case PackAltoDesembolso:
                url += "PackAltoDesembolso/";
                break;
            case RevistaDigital:
                url += "RevistaDigital/";
                break;
            case LosMasVendidos:
                url += "LosMasVendidos/";
                break;
            case IncentivosProgramaNuevas:
                url += "IncentivosProgramaNuevas/";
                break;
            case OfertaDelDia:
                url += "OfertaDelDia/";
                break;
            case GuiaDeNegocioDigitalizada:
                url += "GuiaDeNegocioDigitalizada/";
                break;
            case Incentivos:
                url += "Incentivos/";
                break;
            case ShowRoom:
                url += "ShowRoom/";
                break;
            case HerramientasVenta:
                url += "HerramientasVenta/";
                break;
            case ProgramaNuevasRegalo:
                url += "ProgramaNuevasRegalo/";
                break;
            case ParticipaProgramaNuevas:
                url += "ParticipaProgramaNuevas/";
                break;
            case NotParticipaProgramaNuevas:
                url += "NotParticipaProgramaNuevas/";
                break;
            default:
                return "";
        }
    return url;
}

