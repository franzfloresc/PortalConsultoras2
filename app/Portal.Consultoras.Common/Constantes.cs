using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Amazon.SQS.Model;

namespace Portal.Consultoras.Common
{
    public class Constantes
    {
        public class TipoLink
        {
            public const int Ayuda = 301;
            public const int Capedevi = 302;
            public const int Terminos = 303;
        }

        public class Marca
        {
            public const int LBel = 1;
            public const int Esika = 2;
            public const int Cyzone = 3;
            public const int Finart = 4;
        }

        public class TipoCronograma
        {
            public const int Regular = 1;
            public const int Anticipado = 2;
        }

        public class Rol
        {
            public const int Consultora = 1;
            public const int Administrador = 2;
            public const int AdministradorSAC = 3;
            public const int AdministradorContenido = 4;
            public const int SAC = 7;
            public const int Digitador = 20;
            public const int DigitadorGenerico = 21;
            public const int GerenteZona = 22;
            public const int SacDD = 23;

        }

        public class CatalogoUrlParameters
        {
            public const string UrlPart01 = "https://image.issuu.com/";
            public const string UrlPart02 = "/jpg/page_1_thumb_small.jpg";
            public const string UrlPart03 = "/jpg/page_1_thumb_medium.jpg";
            public const string UrlPart02Alternativo = "/jpg/page_1.jpg";
        }

        public class EstadoPedido
        {
            public const short Pendiente = 201;
            public const short Procesado = 202;
        }

        public class CodigosISOPais
        {
            public const string Peru = "PE";
            public const string Chile = "CL";
            public const string Ecuador = "EC";
            public const string CostaRica = "CR";
            public const string Salvador = "SV";
            public const string Guatemala = "GT";
            public const string Panama = "PA";
            public const string Venezuela = "VE";
            public const string Colombia = "CO";

            public const string Argentina = "AR";
            public const string Bolivia = "BO";
            public const string Mexico = "MX";
            public const string PuertoRico = "PR";
            public const string Dominicana = "DO";
        }

        public class ConfiguracionOferta
        {
            public const int Web = 1701;
            public const int Liquidacion = 1702;
            public const int CrossSelling = 1703;
            public const int Nueva = 1704;
            public const int Flexipago = 1705;
            public const int Accesorizate = 1706;
            public const int ShowRoom = 1707;
        }

        public class TipoOferta
        {
            public const int Web = 1;
            public const int Dupla = 2;
            public const int Liquidacion = 3;
            public const int CrossSelling = 4;
            public const int Nueva = 5;
            public const int Flexipago = 6;
            public const int Accesorizate = 7;
        }
        //2:SICC - 1:FOX
        public class ConsultoraNueva
        {
            public const int Sicc = 2;
            public const int Fox = 1;
        }

        public class RangoCantidadPedido
        {
            public const int IdRango = 39;
            public const int IdMinimo = 501;
            public const int IdMaximo = 502;
        }

        public class TablaLogicaDato
        {
            // PackNuevas-PedidoAsociado.
            public const int TablaLogicaPackNuevasPedidoAsociadoID = 72;
            public const int TablaLogicaDatosPackNuevasPedidoAsociadoID = 7201;
        }


        public class ParametrosNames
        {
            public const string CorreoRequerido = "CorreoRequerido";
            public const string TelefonoRequerido = "TelefonoRequerido";
        }
        public class TipoNivelesRiesgo
        {
            public const string Bajo = "BAJO";
            public const string Medio = "MEDIO";
            public const string Alto = "ALTO";
        }


        public class EstadoActividadConsultora
        {
            public const int Registrada = 1;
            public const int Ingreso_Nueva = 2;
            public const int Constante_Normal = 3;
            public const int Posible_Egreso_Egresante = 4;
            public const int Egreso_Egresada = 5;
            public const int Reingreso = 6;
            public const int Retirada = 7;
            public const int Reactivada = 8;
        }

        public class TipoEstrategia
        {
            public const int CrossSelling = 1;
            public const int PackNuevas = 2;
            public const int OfertaParaTi = 3;
            public const int OfertaWeb = 4;
            public const int Lanzamiento = 5;
        }

        public class TipoEstrategiaCodigo
        {
            public const string OfertaParaTi = "001";
        }

        public class ConstSession
        {
            public const string IngresoPortalLideres = "IngresoPortalLideres";
            public const string IngresoPortalConsultoras = "IngresoPortalConsultoras";
            public const string ListaEscalaDescuento = "ListaEscalaDescuento";
            public const string ClientesByConsultora = "ClientesByConsultora";
            public const string TippingPoint = "TippingPoint";
            public const string TippingPoint_MontoVentaExigido = "TippingPoint_MontoVentaExigido";
            public const string MensajeMetaConsultora = "MensajeMetaConsultora";

            // prol
            public const string PROL_CalculoMontosProl = "PROL_CalculoMontosProl";

            //  CDR
            public const string CDRCampanias = "CDRCampanias";
            public const string CDRMotivoOperacion = "CDRMotivoOperacion";
            public const string CDRPedidosFacturado = "CDRPedidosFacturado";
            public const string CDRDescripcion = "CDRDescripcion";
            public const string CDRWebDetalle = "CDRWebDetalle";
            public const string CDRWeb = "CDRWeb";
            public const string CDRParametria = "CDRParametria";
            public const string CDRWebDatos = "CDRWebDatos";

            // Tabla LOgica

            public const string TablaLogicaDatos = "TablaLogicaDatos";
        }

        public class TipoOfertaFinalCatalogoPersonalizado
        {
            public const int SinConfiguracion = 0;
            public const int Arp = 1;
            public const int Jetlore = 2;
        }

        public class OrigenPedidoWeb
        {

            // Primer Dígito
            // 1: Desktop                   2: Mobile

            // Segundo Dígito
            // 1: Home                      2: Pedido
            // 3: Liquidacion               4: Catalogo Personalizado
            // 5: ShowRoom                  9: General

            // Tercer Dígito
            // 1: Banners                   2: Ofertas para ti
            // 3: Catalogo Personalizado    4: Liquidacion
            // 5: Producto Sugerido         6: Oferta Final
            // 7: ShowRoom                  8: Consultora Online
            // 9: Oferta del dia

            // Cuarto Dígito
            // 1. Sin popUp                 2. Con popUp

            public const int DesktopHomeBanners = 1111;
            public const int DesktopHomeOfertasParaTi = 1121;
            public const int DesktopHomeOfertasParaTiPopUp = 1122;
            public const int DesktopHomeCatalogoPersonalizado = 1131;
            public const int DesktopHomeCatalogoPersonalizadoPopUp = 1132;
            public const int DesktopHomeLiquidacion = 1141;

            public const int DesktopPedidoOfertasParaTi = 1221;
            public const int DesktopPedidoOfertasParaTiPopUp = 1222;
            public const int DesktopPedidoSugerido = 1251;
            public const int DesktopPedidoOfertaFinal = 1261;

            public const int DesktopLiquidacion = 1341;

            public const int DesktopCatalogoPersonalizado = 1431;
            public const int DesktopCatalogoPersonalizadoPopUp = 1432;

            public const int DesktopShowRoom = 1571;
            public const int DesktopConsultoraOnline = 1281;

            public const int MobileHomeOfertasParaTi = 2121;

            public const int MobilePedidoOfertasParaTi = 2221;
            public const int MobilePedidoSugerido = 2251;
            public const int MobilePedidoOfertaFinal = 2261;

            public const int MobileShowRoom = 2571;

            public const int MobileLiquidacion = 2341;

            public const int MobileCatalogoPersonalizado = 2431;
            public const int MobileCatalogoPersonalizadoPopUp = 2432;

            /*PL20-1227*/
            public const int DesktopHomeBannerOfertaDelDia = 1191;
            public const int DesktopHomeDisplayOfertaDelDia = 1192;
            public const int DesktopPedidoBannerOfertaDelDia = 1291;
            public const int DesktopPedidoDisplayOfertaDelDia = 1292;
            public const int DesktopGeneralBannerOfertaDelDia = 1991;
            public const int DesktopGeneralDisplayOfertaDelDia = 1992;
        }
        
        public class COTipoAtencionMensaje
        {
            public const string Agotado = "Agotado";
            public const string IngresadoPedido = "Ingresado al Pedido";
            public const string YaTengo = "Ya lo tengo";
        }

        public class COPedidoCanceladoMensaje
        {
            public const string Portal = "Se retiraron de tu pedido los productos de este cliente.";
            public const string Marcas = "No te olvides comunicarte con tu cliente.";
        }
        
        public class TipoTutorial
        {
            public const int Video = 1;
            public const int Desktop = 2;
            public const int Salvavidas = 3;
            public const int Mobile = 4;
        }

        public class BackOrder
        {
            public const string LogAccionCancelar = "El cliente no aceptó BackOrder.";
        }
        
        public class EstadoCDRWeb
        {
            public const int Pendiente = 1;
            public const int Enviado = 2;
            public const int Aceptado = 3;
            public const int Observado = 4;
        }

        public class TipoMensajeCDR
        {
            public const string Motivo = "Motivo";
            public const string Solucion = "Solucion";
            public const string Propuesta = "Propuesta";
            public const string TenerEnCuenta = "TenerEnCuenta";
            public const string Finalizado = "Finalizado";
            public const string MensajeFinalizado = "MensajeFinalizado"; 
        }

        public class ParametriaCDR
        {
            public const string Faltante = "STO_PMON_FM";
            public const string Devolucion = "STO_PMON_DEV";
            public const string Trueque = "STO_DESV_TRQ";
            public const string TruequeValAbs = "STO_DESV_TRQ_OPER";
        }

        public class CdrWebDatos
        {
            public const string UnidadesPermitidasFaltante = "UnidadesPermitidasFaltante";
            public const string ValidacionDiasFaltante = "ValidacionDiasFaltante";
            public const string DiasAntesFacturacion = "DiasAntesFacturacion";
        }
        public class CdrWebMensajes
        {
            public const string FueraDeFecha = "Tu solicitud se encuentra fuera de fecha para poder ser atendida";
        }

        public class CodigoOperacionCDR
        {
            public const string Faltante = "F";
            public const string FaltanteAbono = "G";
            public const string Devolucion = "D";
            public const string Trueque = "T";
            public const string Canje = "C";
        }
        public class TipoPopUp
        {
            public const int VideoIntroductorio = 1;
            public const int GPR = 2;
            public const int DemandaAnticipada = 3;
            public const int AceptacionContrato = 4;
            public const int Showroom = 5;
            public const int ActualizarDatos = 6;
            public const int Flexipago = 7;
            public const int Comunicado = 8;
        }

        // Constantes de los motivos de GPR.
        public class GPRMotivoRechazo
        {
            public const string MontoMinino = "OCC-16"; //MONTO MINIMO
            public const string MontoMaximo = "OCC-17"; // MONTO MAXIMO
            public const string ActualizacionDeuda = "OCC-19"; //ACTUALIZACION DE DEUDA
            public const string ValidacionMontoMinimoStock = "OCC-51"; //VALIDACION MONTO MINIMO STOCK
            public const string Mostrar2OpcionesNotificacion = "1"; // Flag para mostrar dos opciones en notificaciones.
        }

        public class LogDynamoDB
        {
            public const string AplicacionPortalConsultoras = "PORTALCONSULTORAS";
            public const string AplicacionPortalLideres = "PORTALLIDERES";

            public const string RolConsultora = "CO";
            public const string RolSociaEmpresaria = "SE";
        }
        
        public class ValidacionExisteUsuario
        {
            public const int NoExiste = 0;
            public const int ExisteDiferenteClave = 1;
            public const int Existe = 2;
        }

    }
}

