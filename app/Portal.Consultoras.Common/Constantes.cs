﻿using System.Collections.Generic;
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

        public class TipoUsuario
        {
            public const int Consultora = 1;
            public const int Postulante = 2;
            public const int Admin = 3;
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
            public const int PersonalizacionShowroom = 9850;
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
        
        public class TipoEstrategiaSet
        {
            public const string IndividualConTonos = "2001";
            public const string CompuestaFija = "2002";
            public const string CompuestaVariable = "2003";
        }

        public class TipoEstrategiaCodigo
        {
            public const string OfertaParaTi = "001";
            public const string PackNuevas = "002";
            public const string Lanzamiento = "005";
            public const string OfertasParaMi = "007";
            public const string PackAltoDesembolso = "008";
            public const string RevistaDigital = "101"; // No tiene referecia con BD, es un grupo de estrategias

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
            
            //ShowRoom
            public const string ListaProductoShowRoom = "ListaProductoShowRoom";
            public const string ListaProductoShowRoomCpc = "ListaProductoShowRoomCpc";
        }

        public class TipoOfertaFinalCatalogoPersonalizado
        {
            public const int SinConfiguracion = 0;
            public const int Arp = 1;
            public const int Jetlore = 2;
        }

        public class OrigenPedidoWeb
        {
            // Primer Dígito -- Plataforma
            // 1: Desktop                   2: Mobile

            // Segundo Dígito -- Pantalla
            // 1: Home                      2: Pedido
            // 3: Liquidacion               4: Catalogo Personalizado
            // 5: ShowRoom                  9: General
            // 6: OfertaParaTi
            // 7: RevistaDigital

            // Tercer Dígito -- Sección dentro de la Pantalla
            // 1: Banners                   2: Ofertas para ti
            // 3: Catalogo Personalizado    4: Liquidacion
            // 5: Producto Sugerido         6: Oferta Final
            // 7: ShowRoom                  8: Consultora Online
            // 9: Oferta del dia            0: Revista Digital
            // 1: index
            // 2: OfertaParaTi Detalle

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

            /*Para ShowRoom Aplica nuevo formato*/
            public const int DesktopShowRoomLandingIntriga = 1511;
            public const int DesktopShowRoomLandingCompra = 1521;
            public const int DesktopShowRoomLandingCompraTactica = 1522;
            public const int DesktopShowRoomProductPage = 1531;
            public const int DesktopShowRoomProductPageCarrusel = 1532;
            public const int DesktopShowRoomProductPageTactica = 1533;
            public const int DesktopShowRoomBienvenida = 1541;
            public const int DesktopShowRoomSubCampanias = 1524;
            public const int MobileShowRoomSubCampanias = 2524;
            public const int MobileShowRoomLandingIntriga = 2511;
            public const int MobileShowRoomLandingCompraTactica = 2522;
            public const int MobileShowRoomProductPage = 2531;
            public const int MobileShowRoomProductPageCarrusel = 2532;
            public const int MobileShowRoomProductPageTactica = 2533;
            
            public const int MobileHomeOfertasParaTi = 2121;

            public const int MobilePedidoOfertasParaTi = 2221;
            public const int MobilePedidoSugerido = 2251;
            public const int MobilePedidoOfertaFinal = 2261;

            public const int MobileOfertasParaTiIndex = 2611;
            public const int MobileOfertasParaTiDetalle = 2621;

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
            
            /* Revista Digital */
            public const int RevistaDigitalDesktopLanding = 1711;
            public const int RevistaDigitalDesktopLandingCarrusel = 1721;
            public const int RevistaDigitalDesktopLandingPopUp = 1712;
            public const int RevistaDigitalDesktopProductPage = 1731;
            public const int RevistaDigitalMobileLanding = 2711;
            public const int RevistaDigitalMobileLandingCarrusel = 2721;
            public const int RevistaDigitalMobileLandingPopUp = 2712;
            public const int RevistaDigitalMobileProductPage = 2731;

            public const int RevistaDigitalDesktopHomeSeccion = 1101;
            public const int RevistaDigitalDesktopHomePopUp = 1102;
            public const int RevistaDigitalDesktopHomeLanzamiento = 1103;

            public const int RevistaDigitalMobileHomeSeccion = 2101;
            public const int RevistaDigitalMobileHomePopUp = 2102;
            public const int RevistaDigitalMobileHomeLanzamiento = 2103;
            
            public const int RevistaDigitalDesktopPedidoSeccion = 1201;
            public const int RevistaDigitalDesktopPedidoPopUp = 1202;
            public const int RevistaDigitalDesktopPedidoLanzamiento = 1203;

            public const int RevistaDigitalMobilePedidoSeccion = 2201;
            public const int RevistaDigitalMobilePedidoPopUp = 2202;
            public const int RevistaDigitalMobilePedidoLanzamiento = 2203;
            /* FIN Revista Digital */
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
            public const string ZonaBloqueada = "Lo sentimos, por el momento tu zona no se encuentra disponible para realizar esta operación.";
            public const string ConsultoraBloqueada = "Lo sentimos, por el momento te encuentras bloqueada para realizar esta operación.";
            public const string SinPedidosDisponibles = "Lo sentimos, en estos momentos no cuentas con pedidos disponibles para reclamar.";
            public const string FueraDeFecha = "Tu solicitud se encuentra fuera de fecha para poder ser atendida.";
            public const string ContactateChatEnLinea = "Por favor, contáctate con nuestro <span class=\"enlace_chat belcorpChat\"><a>Chat en Línea</a></span>.";
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
            public const int RevistaDigitalSuscripcion = 9;
            public const int Cupon = 10;
            public const int CuponForzado = 11;
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
        
        public class MensajeEstaEnRevista
        {
            public const string EsikaWeb = "Producto en la Guía de Negocio Ésika con oferta especial.";
            public const string LbelWeb = "Producto en Mi Negocio L’Bel con oferta especial.";
            public const string EsikaMobile = "Este producto está en la Guía de Negocio Ésika con oferta especial.";
            public const string LbelMobile = "Este producto está en Mi Negocio L’Bel con oferta especial.";
        }
        
        public class PestanhasMisPagos
        {
            public const string EstadoCuenta = "EstadoCuenta";
            public const string LugaresPago = "LugaresPago";
            public const string MisPercepciones = "MisPercepciones";
        }

        public class ShowRoomPersonalizacion
        {
            public class Desktop
            {
                public const string PopupImagenIntriga = "PopupImagenIntriga";
                public const string PopupImagenVenta = "PopupImagenVenta";
                public const string BannerImagenIntriga = "BannerImagenIntriga";
                public const string BannerImagenVenta = "BannerImagenVenta";
                public const string UrlTerminosCondiciones = "UrlTerminosCondiciones";
                public const string TextoCondicionCompraCpc = "TextoCondicionCompraCpc";
                public const string TextoDescripcionLegalCpc = "TextoDescripcionLegalCpc";
                public const string IconoLluvia = "IconoLluvia";
                public const string BannerEnvioCorreo = "BannerEnvioCorreo";
                public const string TextoEnvioCorreo = "TextoEnvioCorreo";
                public const string ImagenFondoProductPage = "ImagenFondoProductPage";
                public const string BannerLateralBienvenida = "BannerLateralBienvenida";
                public const string IconoMenuShowRoom = "IconoMenuShowRoom";
                public const string TextoInicialOfertaSubCampania = "TextoInicialOfertaSubCampania";
                public const string ColorTextoInicialOfertaSubCampania = "ColorTextoInicialOfertaSubCampania";
                public const string TextoTituloOfertaSubCampania = "TextoTituloOfertaSubCampania";
                public const string ColorTextoTituloOfertaSubCampania = "ColorTextoTituloOfertaSubCampania";
                public const string ColorFondoTituloOfertaSubCampania = "ColorFondoTituloOfertaSubCampania";
                public const string ImagenFondoTituloOfertaSubCampania = "ImagenFondoTituloOfertaSubCampania";
                public const string ColorFondoContenidoOfertaSubCampania = "ColorFondoContenidoOfertaSubCampania";
                public const string TextoBotonVerMasOfertaSubCampania = "TextoBotonVerMasOfertaSubCampania";                                   
            }

            public class Mobile
            {
                public const string PopupImagenIntriga = "PopupImagenIntriga";
                public const string PopupImagenVenta = "PopupImagenVenta";
                public const string BannerImagenIntriga = "BannerImagenIntriga";
                public const string BannerImagenVenta = "BannerImagenVenta";
                public const string BannerImagenPaginaVenta = "BannerImagenPaginaVenta";
                public const string UrlTerminosCondiciones = "UrlTerminosCondiciones";
                public const string TextoCondicionCompraCpc = "TextoCondicionCompraCpc";
                public const string TextoDescripcionLegalCpc = "TextoDescripcionLegalCpc";
                public const string ImagenFondoProductPage = "ImagenFondoProductPage";
                public const string TextoInicialOfertaSubCampania = "TextoInicialOfertaSubCampania";
                public const string ColorTextoInicialOfertaSubCampania = "ColorTextoInicialOfertaSubCampania";
                public const string TextoTituloOfertaSubCampania = "TextoTituloOfertaSubCampania";
                public const string ColorTextoTituloOfertaSubCampania = "ColorTextoTituloOfertaSubCampania";
                public const string ColorFondoTituloOfertaSubCampania = "ColorFondoTituloOfertaSubCampania";               
            }

            public class TipoAplicacion
            {
                public const string Desktop = "Desktop";
                public const string Mobile = "Mobile";
            }

            public class TipoPersonalizacion
            {
                public const string Evento = "EVENTO";
                public const string Categoria = "CATEGORIA";
            }
        }

        public class ShowRoomTipoFiltro
        {
            public const string Categoria = "CATEGORIA";
            public const string RangoPrecios = "RANGOPRECIOS";
        }

        public class ShowRoomTipoOrdenamiento
        {
            public const string Precio = "PRECIO";
            public class ValorPrecio
            {
                public const string Predefinido = "01";
                public const string MenorAMayor = "02";
                public const string MayorAMenor = "03";
            }
        }

        public class IncentivosSMS
        {
            public const string MensajeAgregarMasProductos = "Agrega otros productos desde aquí";
        }

        public class MenuCodigo
        {
            public const string RevistaShowRoom = "ShowRoom";
            public const string MiNegocio = "MiNegocio";
            public const string RevistaDigital = "RevistaDigital";
            public const string RevistaDigitalSuscripcion = "RevistaDigitalSuscripcion";
            public const string CatalogoPersonalizado = "FDTC";
        }

        public const string RevistaDigitalReducida = "RDR";

        public const int SinRegistroDB = 0;

        public class IngresoExternoPagina
        {
            public const string EstadoCuenta = "ESTADOCUENTA";
            public const string SeguimientoPedido = "SEGUIMIENTOPEDIDO";
            public const string PedidoDetalle = "PEDIDODETALLE";
            public const string NotificacionesValidacionAuto = "NOTIFICACIONVALIDACIONAUTO";
            public const string CompartirCatalogo = "COMPARTIRCATALOGO";
        }

        public class EstadoCuentaTipoMovimiento
        {
            public const int Abono = 2;
            public const int Cargo = 1;
        }

        public class TamaniosImagenIssuu
        {
            public const string ThumbSmall = "_thumb_small";
            public const string ThumbMedium = "_thumb_medium";
            public const string ThumbLarge = "_thumb_large";
        }

        public class CatalogoImagenDefault
        {
            public const string Catalogo = "https://www.somosbelcorp.com/Content/Images/catalogo_no_disponible.jpg";
            public const string Revista = "https://www.somosbelcorp.com/Content/Images/revista_no_disponible.jpg";
        }

        public class CatalogoUrlDefault
        {
            public const string Esika = "http://www.esika.biz";
            public const string Lbel = "http://www.lbel.com";
            public const string Cyzone = "http://www.cyzone.com";
        }

        public class RevistaNombre
        {
            public const string Esika = "Guía de Negocio Ésika";
            public const string Lbel = "Mi Negocio L’Bel";
        }

        public class MensajesError
        {
            public const string InsertarDesglose = "Ocurrió un error al procesar la reserva.";
            public const string CargarProductosShowRoom = "Error al cargar los productos.";
        }

        public class ConfiguracionPais
        {
            public const string RevistaDigital = "RD";
            public const string RevistaDigitalReducida = "RDR";
            public const string RevistaDigitalSuscripcion = "RDS";
        }

        public class TooltipLoginUsuario
        {
            public const string BO = "Tu código de consultora,<br/>Carné de Identidad<br/>o correo electrónico.";
            public const string CL = "Tu número de RUT<br/>(sin puntos ni guión).<br/>Ejem:12345678k<br/>o correo electrónico.";
            public const string CO = "Tu número de cédula de ciudadanía,<br/>o correo electrónico.";
            public const string DO = "Tu código de consultora,<br/>cédula de identidad<br/>o correo electrónico.";
            public const string EC = "Tu número de cédula de identidad<br/>o correo electrónico.";
            public const string MX = "Tu código de consultora,<br/>INE o correo electrónico.";
            public const string PA = "Tu código de consultora,<br/>documento de identidad<br/>o correo electrónico.";
            public const string PE = "Tu código de consultora,<br/>DNI o correo electronico.";
            public const string PR = "Tu código de consultora,<br/>tarjeta electoral<br/>o correo electrónico.";
            public const string VE = "Tu código de consultora,<br/>cédula de identidad<br/>o correo electrónico.";
            public const string CAM = "Tu código de consultora,<br/>documento único de identidad o<br/>correo electrónico.";
        }

        public class TooltipLoginPassword
        {
            public const string BO = "Si es la primera vez que ingresas, es<br/>el número de tu Carné de Identidad,<br/>con las 3 letras de la extensión del<br/>lugar de emisión.";
            public const string CL = "Si es la primera vez que ingresas, es<br/>tu código de consultora de 7 dígitos<br/>(incluido el 0 inicial, si lo tuviera).";
            public const string CO = "El número de tu<br/>cédula de identidad.";
            public const string DO = "Los 4 últimos dígitos de<br/>tu Cédula de Identidad<br/>(sin guiones).";
            public const string EC = "El número de tu<br/>cédula de identidad.";
            public const string MX = "Los 4 últimos dígitos de<br/>tu código de consultora.";
            public const string PE = "Si es la primera vez que<br/>ingresas, es tu número<br/>de DNI.";
            public const string PR = "Los 4 últimos dígitos de<br/>tu Seguro Social(sin guiones).";
            public const string VE = "Los 4 últimos dígitos de<br/>tu Cédula de Identidad.";
            public const string CAM = "Si es la primera vez<br/>que ingresas, son los<br/>4 últimos dígitos de tu<br/>documento de identidad.";
        }

        public class EstadoRDSuscripcion
        {
            public const int SinRegistroDB = 0;
            public const int Activo = 1;
            public const int Desactivo = 2;
            public const int NoPopUp = 3;
        }

        public struct TablaLogica
        {
            public const int Plan20 = 98;
        }

        public class EstadoCupon
        {
            public const int Reservado = 1;
            public const int Activo = 2;
        }

        public class TipoOfertasPlan20
        {
            public const int OfertaFinal = 35;
            public const int Showroom = 44;
            public const int OPT = 45;
            public const int ODD = 46;
        }

        #region Clientes
        public class ClienteTipoContacto
        {
            public const short Celular = 1;
            public const short TelefonoFijo = 2;
            public const short Correo = 3;
            public const short Direccion = 4;
            public const short Referencia = 5;
        }

        public class ClienteCelularValidacion
        {
            private static Dictionary<string, string> _RegExp;

            public static Dictionary<string, string> RegExp
            {
                get
                {
                    return _RegExp ?? (_RegExp = new Dictionary<string, string>
                    {
                        {"BO", @""},
                        {"CL", @"^(?:(9)[0-9]{8}|)$"},
                        {"CO", @"^(?:(3)[0-9]{9}|)$"},
                        {"CR", @"^[0-9]{8}$"},
                        {"DO", @""},
                        {"EC", @"^(?:[0-9]{9,10}|)$"},
                        {"GT", @"^[0-9]{8}$"},
                        {"MX", @"^(?!.*?(?=(\d)\1{5,}))\d{10}$.*$"},
                        {"PA", @"^[0-9]{8}$"},
                        {"PE", @"^(?:(9)[0-9]{8}|)$"},
                        {"PR", @""},
                        {"SV", @"^[0-9]{8}$"},
                        {"VE", @""},
                    });
                }
            }
        }

        public class ClienteTelefonoValidacion
        {
            private static Dictionary<string, string> _RegExp;

            public static Dictionary<string, string> RegExp
            {
                get
                {
                    return _RegExp ?? (_RegExp = new Dictionary<string, string>
                    {
                        {"BO", @""},
                        {"CL", @""},
                        {"CO", @"^(?:[0-9]{7}|)$"},
                        {"CR", @"^(?:[0-9]{8}|)$"},
                        {"DO", @""},
                        {"EC", @"^(?:[0-9]{9,10}|)$"},
                        {"GT", @"^(?:[0-9]{8}|)$"},
                        {"MX", @"^(?!.*?(?=(\d)\1{5,}))\d{8,12}$.*$"},
                        {"PA", @"^(?:[0-9]{8}|)$"},
                        {"PE", @"^(?:[0-9]{7,9}|)$"},
                        {"PR", @""},
                        {"SV", @"^(?:[0-9]{8}|)$"},
                        {"VE", @""},
                    });
                }
            }
        }

        public class ClienteValidacion
        {
            private static Dictionary<string, string> _Message;

            public class Code
            {
                public const string SUCCESS = "0";
                public const string ERROR_FORMATOTELCELULAR = "1";
                public const string ERROR_FORMATOTELFIJO = "2";
                public const string ERROR_NOMBRENOENVIADO = "3";
                public const string ERROR_NUMEROTELEFONONOENVIADO = "4";
                public const string ERROR_FORMATOCORREO = "5";
                public const string ERROR_CONTACTOSNOENVIADO = "6";
                public const string ERROR_TIPOCONTACTOVALORNOENVIADO = "7";
                public const string ERROR_CONSULTORANOMBREEXISTE = "8";
                public const string ERROR_CONSULTORATELEFONOEXISTE = "9";
                public const string ERROR_NUMEROTELEFONOEXISTE = "10";
                public const string ERROR_CLIENTENOREGISTRADO = "11";
                public const string ERROR_CLIENTENOACTUALIZADO = "12";

                //public const string ERROR_ORIGENNOENVIADO = "6";
                //public const string ERROR_ANOTACIONDESCRIPCIONNOENVIADO = "9";
                
            }

            public static Dictionary<string, string> Message
            {
                get
                {
                    return _Message ?? (_Message = new Dictionary<string, string>
                    {
                        {Code.SUCCESS, "OK"},
                        {Code.ERROR_FORMATOTELCELULAR, "Formato de número de teléfono celular incorrecto."},
                        {Code.ERROR_FORMATOTELFIJO, "Formato de número de teléfono fijo incorrecto."},
                        {Code.ERROR_NOMBRENOENVIADO, "Campo Nombres no fue enviado."},
                        {Code.ERROR_NUMEROTELEFONONOENVIADO, "El cliente debe tener un teléfono de contacto."},
                        {Code.ERROR_FORMATOCORREO, "Formato de correo incorrecto."},
                        {Code.ERROR_CONTACTOSNOENVIADO, "Campo Contactos no fue enviado."},
                        {Code.ERROR_TIPOCONTACTOVALORNOENVIADO, "Campo Tipo Contacto {0} Valor no fue enviado."},
                        {Code.ERROR_CONSULTORANOMBREEXISTE, "Nombre ya se encuentra registrado para la consultora."},
                        {Code.ERROR_CONSULTORATELEFONOEXISTE, "Número de telefono ya esta registrado para la consultora."},
                        {Code.ERROR_NUMEROTELEFONOEXISTE, "El número de teléfono ya se encuentra registrado en nuestra base."},
                        {Code.ERROR_CLIENTENOREGISTRADO, "El cliente no fue registrado."},
                        {Code.ERROR_CLIENTENOACTUALIZADO, "El cliente no fue actualizado."},

                        //{Code.ERROR_ORIGENNOENVIADO, "Campo Origen no fue enviado."},                        
                        //{Code.ERROR_ANOTACIONDESCRIPCIONNOENVIADO, "Campo Anotación Descripción no fue enviado."},
                    });
                }
            }
        }

        public class ClienteEstado
        {
            public const short Activo = 1;
            public const short Inactivo = 0;
        }

        public class ClienteTipoRegistro
        {
            public const short Todos = 0;
            public const short DatosGenerales = 1;
            public const short TipoContacto = 2;
        }

        public class ClienteOrigen
        {
            public const string Desktop = "SOMOS_BELCORP_DESKTOP";
            public const string Mobile = "SOMOS_BELCORP_MOBILE";
        }
        #endregion
    }
}