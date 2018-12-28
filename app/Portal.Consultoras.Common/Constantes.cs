﻿using System.Collections.Generic;

namespace Portal.Consultoras.Common
{
    public class Constantes
    {
        public static class TipoLink
        {
            public const int Ayuda = 301;
            public const int Capedevi = 302;
            public const int Terminos = 303;
        }

        public static class Marca
        {
            public const int LBel = 1;
            public const int Esika = 2;
            public const int Cyzone = 3;
            public const int Finart = 4;
        }

        public static class MarcaNombre
        {
            public const string LBel = "L'bel";
            public const string Esika = "Ésika";
        }

        public static class TipoCronograma
        {
            public const int Regular = 1;
            public const int Anticipado = 2;
        }

        public static class TipoUsuario
        {
            public const int Consultora = 1;
            public const int Postulante = 2;
            public const int Admin = 3;
        }

        public static class Rol
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

        public static class CatalogoUrlParameters
        {
            public const string UrlPart01 = "https://image.issuu.com/";
            public const string UrlPart02 = "/jpg/page_1_thumb_small.jpg";
            public const string UrlPart03 = "/jpg/page_1_thumb_medium.jpg";
            public const string UrlPart02Alternativo = "/jpg/page_1.jpg";

        }

        public static class EstadoPedido
        {
            public const short Pendiente = 201;
            public const short Procesado = 202;

            public const short Registrado = 1;
            public const short Facturado = 2;

            public const string PedidoValidado = "PV";
        }

        public static class PaisID
        {
            public const int Argentina = 1;
            public const int Bolivia = 2;
            public const int Chile = 3;
            public const int Colombia = 4;
            public const int CostaRica = 5;
            public const int Ecuador = 6;
            public const int ElSalvador = 7;
            public const int Guatemala = 8;
            public const int Mexico = 9;
            public const int Panama = 10;
            public const int Peru = 11;
            public const int PuertoRico = 12;
            public const int RepublicaDominicana = 13;
            public const int Venezuela = 14;
            public const int Brasil = 15;
        }

        public static class CodigosISOPais
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

        public static class ConfiguracionOferta
        {
            public const int Web = 1701;
            public const int Liquidacion = 1702;
            public const int CrossSelling = 1703;
            public const int Nueva = 1704;
            public const int Flexipago = 1705;
            public const int Accesorizate = 1706;
            public const int ShowRoom = 1707;
        }

        public static class TipoOferta
        {
            public const int Web = 1;
            public const int Dupla = 2;
            public const int Liquidacion = 3;
            public const int CrossSelling = 4;
            public const int Nueva = 5;
            public const int Flexipago = 6;
            public const int Accesorizate = 7;
        }

        public static class RangoCantidadPedido
        {
            public const int IdRango = 39;
            public const int IdMinimo = 501;
            public const int IdMaximo = 502;
        }

        public static class TablaLogicaDato
        {
            // PackNuevas-PedidoAsociado.
            public const int TablaLogicaPackNuevasPedidoAsociadoID = 72;
            public const int TablaLogicaDatosPackNuevasPedidoAsociadoID = 7201;
            public const int PersonalizacionShowroom = 9850;
            public const int BusquedaNemotecnicoMatriz = 9851;
            public const int BusquedaNemotecnicoOfertaLiquidacion = 9852;
            public const int BusquedaNemotecnicoProductoSugerido = 9853;
            public const int BusquedaNemotecnicoZonaEstrategia = 9854;
            public const int Tonos = 9802;

            public const int ValoresImagenesResizeWitdhMaxSmall = 12101;
            public const int ValoresImagenesResizeHeightSmall = 12102;
            public const int ValoresImagenesResizeWitdhMaxMedium = 12103;
            public const int ValoresImagenesResizeHeightMedium = 12104;

            public const int MerchantId = 12201;
            public const int AccessKeyId = 12202;
            public const int SecretAccessKey = 12203;
            public const int UrlSessionBotonPago = 12204;
            public const int UrlGenerarNumeroPedido = 12205;
            public const int PorcentajeGastosAdministrativos = 12206;
            public const int UrlLibreriaPagoVisa = 12207;
            public const int UrlAutorizacionBotonPago = 12208;
            public const int UrlLogoPasarelaPago = 12209;
            public const int ColorBotonPagarPasarelaPago = 12210;
            public const int MensajeInformacionPagoExitoso = 12211;

            public const int CantidadCuvMasivo_NuevoMasivo = 13701;
            public const int EstrategiaImagen_NuevoMasivo = 13702;

            public const int ActualizaDatosEnabled = 14301;

            public const int MensajeActualizarEmailSms = 1001;
            public const int MensajeActualizarSms = 1002;
            public const int MensajeActualizarEmail = 1003;

            public static class PersonalizacionOdd
            {
                public static readonly int ColorFondoBanner = 9301;
                public static readonly int ColorFondoDisplay = 9302;
            }

            public const int ActualizaEscalaDescuentoDestokp = 7201;
            public const int ActualizaEscalaDescuentoMobile = 7301;

            public static class PagoEnLinea
            {
                public const int Habilitar_App = 12213;
                public const int Habilitar_App_PBI_ExternalApp = 12214;
            }

            public static class ArmaTuPack
            {
                public const string ListCuv = "ListCuv";
            }

        }

        public static class ParametrosNames
        {
            public const string CorreoRequerido = "CorreoRequerido";
            public const string TelefonoRequerido = "TelefonoRequerido";
        }

        public static class TipoNivelesRiesgo
        {
            public const string Bajo = "BAJO";
            public const string Medio = "MEDIO";
            public const string Alto = "ALTO";
        }

        public static class EstadoActividadConsultora
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

        public static class TipoEstrategia
        {
            public const int CrossSelling = 1;
            public const int PackNuevas = 2;
            public const int OfertaParaTi = 3;
            public const int OfertaWeb = 4;
            public const int Lanzamiento = 5;
        }

        public static class TipoEstrategiaSet
        {
            public const string IndividualConTonos = "2001";
            public const string CompuestaFija = "2002";
            public const string CompuestaVariable = "2003";
        }

        public static class TipoEstrategiaCodigo
        {
            public const string OfertaParaTi = "001";
            public const string PackNuevas = "002"; // Oferta Nueva Esika
            public const string OfertaWeb = "003";
            public const string Lanzamiento = "005";
            public const string OfertasParaMi = "007";
            public const string PackAltoDesembolso = "008";
            public const string RevistaDigital = "101"; // No tiene referecia con BD, es un grupo de estrategias
            public const string LosMasVendidos = "020";
            public const string IncentivosProgramaNuevas = "021";
            public const string OfertaDelDia = "009";
            public const string GuiaDeNegocioDigitalizada = "010";
            public const string Incentivos = "022";
            public const string ShowRoom = "030";
            public const string HerramientasVenta = "011";
            public const string NotParticipaProgramaNuevas = "0";
            public const string MasGanadoras = "201"; // No tiene referecia con BD, es un grupo de estrategias
        }

        public static class TipoPersonalizacion
        {
            public const string OfertaParaTi = "OPT";
            public const string Lanzamiento = "LAN";
            public const string OfertasParaMi = "OPM";
            public const string PackAltoDesembolso = "PAD";
            public const string OfertaDelDia = "ODD";
            public const string GuiaDeNegocioDigitalizada = "GND";
            public const string ShowRoom = "SR";
            public const string HerramientasVenta = "HV";
        }

        public static class TipoAccionAgregar
        {
            public const int SinBoton = 0;
            public const int AgregaloPackNuevas = 1;
            public const int AgregaloNormal = 2;
            public const int EligeOpcion = 3;
            public const int LoQuieres = 4;
            public const int LoQuieresInactivo = 5;

            public const int BannerCarrusel = 11;

        }

        public static class Inicializacion
        {
            public const int EnteroInicial = -1;
        }

        public static class EstadoRespuestaServicio
        {
            public const string Success = "OK";
            public const string Error = "ERROR";
        }
        public static class NombrePalanca
        {
            public const string OfertaParaTi = "OfertaParaTi";
            public const string PackNuevas = "PackNuevas"; // Oferta Nueva Esika
            public const string OfertaWeb = "OfertaWeb";
            public const string Lanzamiento = "LoNuevoNuevo";
            public const string OfertasParaMi = "OfertasParaMi";
            public const string PackAltoDesembolso = "PackAltoDesembolso";
            public const string RevistaDigital = "RevistaDigital"; // No tiene referecia con BD, es un grupo de estrategias
            public const string LosMasVendidos = "LosMasVendidos";
            public const string IncentivosProgramaNuevas = "IncentivosProgramaNuevas";
            public const string OfertaDelDia = "SoloHoy";
            public const string GuiaDeNegocioDigitalizada = "GuiadeNegocio";
            public const string Incentivos = "Incentivos";
            public const string ShowRoom = "Especiales";
            public const string HerramientasVenta = "Demostradores";
            public const string ProgramaNuevasRegalo = "ProgramaNuevasRegalo";
            public const string ParticipaProgramaNuevas = "ParticipaProgramaNuevas";
            public const string NotParticipaProgramaNuevas = "NotParticipaProgramaNuevas";
            public const string MasGanadoras = "Ganadoras";

            private static Dictionary<string, string> _Palancas;
            public static Dictionary<string, string> Palancas
            {
                get
                {
                    return _Palancas ?? (_Palancas = new Dictionary<string, string>
                    {
                        {TipoEstrategiaCodigo.OfertaParaTi, NombrePalanca.OfertaParaTi},
                        {TipoEstrategiaCodigo.PackNuevas, NombrePalanca.PackNuevas},
                        {TipoEstrategiaCodigo.OfertaWeb, NombrePalanca.OfertaWeb},
                        {TipoEstrategiaCodigo.Lanzamiento, NombrePalanca.Lanzamiento},
                        {TipoEstrategiaCodigo.OfertasParaMi, NombrePalanca.OfertasParaMi},
                        {TipoEstrategiaCodigo.PackAltoDesembolso, NombrePalanca.PackAltoDesembolso},
                        {TipoEstrategiaCodigo.RevistaDigital, NombrePalanca.RevistaDigital},
                        {TipoEstrategiaCodigo.LosMasVendidos, NombrePalanca.LosMasVendidos},
                        {TipoEstrategiaCodigo.IncentivosProgramaNuevas, NombrePalanca.IncentivosProgramaNuevas},
                        {TipoEstrategiaCodigo.OfertaDelDia, NombrePalanca.OfertaDelDia},
                        {TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, NombrePalanca.GuiaDeNegocioDigitalizada},
                        {TipoEstrategiaCodigo.Incentivos, NombrePalanca.Incentivos},
                        {TipoEstrategiaCodigo.ShowRoom, NombrePalanca.ShowRoom},
                        {TipoEstrategiaCodigo.HerramientasVenta, NombrePalanca.HerramientasVenta},
                        {TipoEstrategiaCodigo.NotParticipaProgramaNuevas, NombrePalanca.NotParticipaProgramaNuevas},
                    });
                }
            }

        }
        public static class ConstSession
        {
            public const string IngresoPortalLideres = "IngresoPortalLideres";
            public const string IngresoPortalConsultoras = "IngresoPortalConsultoras";
            public const string ListaEscalaDescuento = "ListaEscalaDescuento";
            public const string ClientesByConsultora = "ClientesByConsultora";
            public const string TippingPoint_MontoVentaExigido = "TippingPoint_MontoVentaExigido";
            public const string MensajeMetaConsultora = "MensajeMetaConsultora";
            public const string ActualizarDatosConsultora = "ActualizarDatosConsultora";

            // prol
            public const string PROL_CalculoMontosProl = "PROL_CalculoMontosProl";

            //  CDR
            public const string CDRProductoFacturado = "CDRProductoFacturado";
            public const string CDRCampanias = "CDRCampanias";
            public const string CDRMotivoOperacion = "CDRMotivoOperacion";
            public const string CDRPedidosFacturado = "CDRPedidosFacturado";
            public const string CDRDescripcion = "CDRDescripcion";
            public const string CDRWebDetalle = "CDRWebDetalle";
            public const string CDRWeb = "CDRWeb";
            public const string CDRParametria = "CDRParametria";
            public const string CDRWebDatos = "CDRWebDatos";
            public const string CDRExpressMensajes = "CDRExpressMensajes";

            // Tabla LOgica
            public const string TablaLogicaDatos = "TablaLogicaDatos";

            //ShowRoom
            public const string CargoShowRoomOfertas = "CargoShowRoomOfertas";
            public const string ListaShowRoomOfertas = "ListaShowRoomOfertas";
            public const string ListaShowRoomSubCampania = "ListaShowRoomSubCampania";
            public const string ListaShowRoomOfertasPerdio = "ListaShowRoomOfertasPerdio";
            public const string ListaShowRoomOfertasCpc = "ListaShowRoomOfertasCpc";

            //FIC
            public const string PedidoFIC = "PedidoFIC";

            public const string TipoPopUpMostrar = "TipoPopUpMostrar";

            //AsesoraOnline
            public const string EmailAsesoraOnline = "EmailAsesoraOnline";

            // Configuracion Seccion Home Contenedor de Palancas
            public const string ListadoSeccionPalanca = "ListadoSeccionPalanca";

            public const string MenuContenedor = "MenuContenedor";

            public const string ListaEstrategia = "ListadoEstrategiaPedido";

            public const string ProductoTemporal = "ProductoTemporal";
            public const string MenuContenedorActivo = "MenuContenedorActivo";

            public const string RevistaDigital = "RevistaDigital";
            public const string HerramientasVenta = "HerramientasVenta";
            public const string ConfiguracionPaises = "ConfiguracionPaises";

            public const string EventoFestivo = "EventoFestivo";

            public const string OfertaFinal = "OfertaFinal";
            public const string TieneLan = "TieneLan";
            public const string TieneLanX1 = "TieneLanX1";
            public const string TieneOpt = "TieneOpt";
            public const string TieneOpm = "TieneOpm";
            public const string TieneOpmX1 = "TieneOpmX1";
            public const string TieneHv = "TieneHv";
            public const string TieneHvX1 = "TieneHvX1";
            public const string TieneMg = "TieneMg";

            public const string MisCertificados = "MisCertificados";
            public const string MisCertificadosData = "MisCertificadosData";
            public const string DatosPagoVisa = "DatosPagoVisa";
            //ODD
            public const string ConfiguracionEstrategiaOdd = "ConfiguracionEstrategiaOdd";
            public const string GuiaNegocio = "GuiaNegocio";
            public const string HabilidarLogCargaOferta = "HabilidarLogCargaOferta";

            public const string PedidoWebDDConf = "PedidoWebDDConf";
            public const string PedidoWebDD = "PedidoWebDD";
            public const string PedidoWebDDDetalleConf = "PedidoWebDDDetalleConf";
            public const string PedidoWebDDDetalle = "PedidoWebDDDetalle";
            public const string DescargaExcelMaxItems = "DescargaExcelMaxItems";

            public const string ConsultoraNuevaBannerAppMostrar = "ConsultoraNuevaBannerAppMostrar";

            public const string PedidosFacturados = "PedidosFacturados";

            public const string DescripcionPedidoOtro = "OTROS";
            public const int CodigoPedidoOtro = 0;


            public const string JwtApiSomosBelcorp = "JwtApiSomosBelcorp";
            public const string RecomendacionesConfig = "RecomendacionesConfiguracion";
            public const string BuscadorYFiltrosConfig = "BuscadorYFiltros";
        }

        public static class ConfiguracionManager
        {
            public const string PaisesEsika = "PaisesEsika";
            public const string PaisesLBel = "PaisesLBel";
            public const string PaisesConTrackingJetlore = "PaisesConTrackingJetlore";
            public const string PaisesCatalogoWhatsUp = "PaisesCatalogoWhatsUp";
            public const string PaisesConPcm = "PaisesConPcm";
            public const string PaisesFlexipago = "PaisesFlexipago";
            public const string rutaFlexipagoCL = "rutaFlexipagoCL";
            public const string UrlImagenFAVMobile = "UrlImagenFAVMobile";
            public const string UrlImagenFAVHome = "UrlImagenFAVHome";
            public const string UrlImagenFAVLanding = "UrlImagenFAVLanding";
            public const string UrlPagoLineaChile = "UrlPagoLineaChile";
            public const string UrlPoliticasCDR = "UrlPoliticasCDR";
            public const string UrlLogDynamo = "UrlLogDynamo";
            public const string rutaImagenNotFoundAppCatalogo = "rutaImagenNotFoundAppCatalogo";
            public const string urlSinImagenTiposyTonos = "urlSinImagenTiposyTonos";
            public const string URL_LIDER = "URL_LIDER";
            public const string oferta_final_regalo_url_s3 = "oferta_final_regalo_url_s3";
            public const string GIF_MENU_DEFAULT_OFERTAS = "GIF_MENU_DEFAULT_OFERTAS";
            public const string MostrarPedidosPendientes = "MostrarPedidosPendientes";
            public const string Permisos_CCC = "Permisos_CCC";
            public const string Efecto_TutorialSalvavidas = "Efecto_TutorialSalvavidas";
            public const string LimiteJetloreOfertaFinal = "LimiteJetloreOfertaFinal";
            public const string LimiteJetloreCatalogoPersonalizado = "LimiteJetloreCatalogoPersonalizado";
            public const string LimiteJetloreCatalogoPersonalizadoHome = "LimiteJetloreCatalogoPersonalizadoHome";
            public const string BUCKET_NAME = "BUCKET_NAME";
            public const string FacturaElectronica_EC = "FacturaElectronica_EC";

            public const string BelcorpRespondeTEL = "BelcorpRespondeTEL_{0}";
            public const string DES_UBIGEO = "DES_UBIGEO_";
            public const string FechaChat = "FechaChat_";
            public const string MensajeChatBienvenida = " tú eres nuestro ejemplo e inspiración. En un momento uno de nuestros creadores de experiencia te atenderá.";
            public const string PaisesBelcorpChatEMTELCO = "PaisesBelcorpChatEMTELCO";
            public const string UrlBelcorpChat = "UrlBelcorpChat";
            public const string UrlChatPA = "UrlChatPA";
            public const string UrlChatQR = "UrlChatQR";
            public const string UrlChatSV = "UrlChatSV";
            public const string UrlChatGT = "UrlChatGT";
            public const string UrlChatDefault = "UrlChatDefault";
            public const string TokenAtento = "TokenAtento_";
            public const string URLCaminoExisto = "URLCaminoExisto";

            public const string EmailCodigoProceso = "EmailCodigoProceso";
            public const string NumeroCampanias = "NumeroCampanias";
            public const string RutaServicePROLConsultas = "RutaServicePROLConsultas";
            public const string UrlImgMiAcademia = "UrlImgMiAcademia";
            public const string NombreCarpetaTC = "NombreCarpetaTC";
            public const string NombreArchivoTC = "NombreArchivoTC";
            public const string CarpetaImagenCompartirCatalogo = "CarpetaImagenCompartirCatalogo";
            public const string NombreImagenCompartirCatalogo = "NombreImagenCompartirCatalogo";

            public const string CarpetaRevistaDigital = "CarpetaRevistaDigital";
            public const string URL_S3 = "URL_S3";
            public const string ROOT_DIRECTORY = "ROOT_DIRECTORY";
            public const string ServiceController = "ServiceController";
            public const string ServiceAction = "ServiceAction";
            public const string Ambiente = "Ambiente";

            public const string GZURL = "GZURL";
            public const string UrlUneteBelcorp = "UrlUneteBelcorp";
            public const string SMPTURL = "SMPTURL";
            public const string SMPTPassword = "SMPTPassword";
            public const string UneteMailFrom = "UneteMailFrom";
            public const string UneteMailSubject = "UneteMailSubject";
            public const string WSGEO_Url = "WSGEO_Url";
            public const string UneteURL = "UneteURL";
            public const string URL_COM_LO = "URL_COM_LO";
            public const string URL_SB = "URL_SB";
            public const string KeyPaisFormatDecimal = "KeyPaisFormatDecimal";
            public const string PaisesShowRoom = "PaisesShowRoom";
            public const string RevistaPiloto_Zonas = "RevistaPiloto_Zonas_";
            public const string RevistaPiloto_Codigo = "RevistaPiloto_Codigo";
            public const string RevistaPiloto_Zonas_RDR_2 = "RevistaPiloto_Zonas_RDR_2_";
            public const string CodigoRevistaIssuu = "CodigoRevistaIssuu";
            public const string CodigoCatalogoIssuu = "CodigoCatalogoIssuu";
            public const string URL_SUPERATE_NUEVO = "URL_SUPERATE_NUEVO";
            public const string Contrato_ActualizarDatos = "Contrato_ActualizarDatos_";
            public const string indicadorContrato = "indicadorContrato";
            public const string PaisesDigitoControl = "PaisesDigitoControl";
            public const string UrlIssuu = "UrlIssuu";
            public const string PaisesCatalogoUnificado = "PaisesCatalogoUnificado";
            public const string WS_RV_Campanias_NEW = "WS_RV_Campanias_NEW";
            public const string WS_RV_PDF_NEW = "WS_RV_PDF_NEW";
            public const string ExpresionValidacionNemotecnico = "ExpresionValidacionNemotecnico";
            public const string URL_DUPLACYZONE = "URL_DUPLACYZONE";
            public const string WebTrackingConfirmacion = "WebTrackingConfirmacion";
            public const string URL_ABCProductos = "URL_ABCProductos";
            public const string secret_key = "secret_key";
            public const string UrlLMS = "UrlLMS";
            public const string CursosMarquesina = "CursosMarquesina";
            public const string UrlCursoMiAcademiaVideo = "UrlCursoMiAcademiaVideo";
            public const string UrlMisCursos = "UrlMisCursos";
            public const string TokenMisCursos = "TokenMisCursos";
            public const string UrlCursoMiAcademia = "UrlCursoMiAcademia";
            public const string URL_FAMILIAPROTEGIDA_ = "URL_FAMILIAPROTEGIDA_";
            public const string ProductoSugeridoAppCatalogosNroCampaniasAtras = "ProductoSugeridoAppCatalogosNroCampaniasAtras";
            public const string ConsultoraOnlineEmailDe = "ConsultoraOnlineEmailDe";
            public const string AMB_COM = "AMB_COM";
            public const string COM_CLIENT_ID = "COM_CLIENT_ID";
            public const string URL_COM = "URL_COM";
            public const string COM_DOMAIN = "COM_DOMAIN";

            public const string RDUrlTerminosCondiciones = "UrlTerminosCondiciones";
            public const string RDUrlPreguntasFrecuentes = "UrlPreguntasFrecuentes";

            public const string RevistaPiloto_Grupos = "RevistaPiloto_Grupos_";
            public const string RevistaPiloto_Escenario = "ESC";
            public const string PaisesCancelarSuscripcionRDUnete = "PaisesCancelarSuscripcionRDUnete";
            public const string PaisesCancelarSuscripcionRDNuevas = "PaisesCancelarSuscripcionRDNuevas";

            public const string Catalogo_Piloto_Escenario = "ESC";
            public const string Catalogo_Piloto_Zonas = "Catalogo_Piloto_Zonas_";
            public const string Catalogo_Piloto_Grupos = "Catalogo_Piloto_Grupos_";
            public const string Catalogo_Marca_Piloto = "Catalogo_Marca_Piloto_";
            public const string SubGuion = "_";
            public const string estrategiaWebApiDisponibilidadTipo = "EstrategiaDisponibleMicroservicioPersonalizacion";
            public const string paisesMicroservicioPersonalizacion = "PaisesMicroservicioPersonalizacion";
            public const string EnabledRemoveCache = "EnabledRemoveCache";
            public const string UrlServiceSicc = "UrlServiceSicc";
            public const string MenuCondicionesDescripcion = "CONDICIONES DE USO WEB";
            public const string MenuCondicionesDescripcionMx = "TÉRMINOS Y CONDICIONES";

            public const string UrlImagenEsika = "https://s3.amazonaws.com/somosbelcorpprd/Unete/Images/logo-marca.png";
            public const string UrlImagenLbel = "https://s3.amazonaws.com/somosbelcorpprd/Unete/Images/logo-marca-lbel.png";
            public const string ColorTemaEsika = "#e81c36";
            public const string ColorTemaLbel = "#613c87";

            public const string ORDEN_COMPONENTES_FICHA_ESIKA = "ORDEN_COMPONENTES_FICHA_ESIKA";
            public const string ORDEN_COMPONENTES_FICHA_LBEL = "ORDEN_COMPONENTES_FICHA_LBEL";

            public const string RutaImagenesAppCatalogo = "RutaImagenesAppCatalogo";
            public const string RutaImagenesAppCatalogoBulk = "RutaImagenesAppCatalogoBulk";

            public const string PaisesEscalaDescuento = "PaisesEscalaDescuento";

        }

        public static class TipoOfertaFinalCatalogoPersonalizado
        {
            public const int SinConfiguracion = 0;
            public const int Arp = 1;
            public const int Jetlore = 2;
        }

        #region Banner Security
        public static class TipoAccesoSegmento
        {
            public const byte Inclusion = 1;
            public const byte Exclusion = 2;
        }
        #endregion

        public static class OrigenPantallaWeb
        {
            // Primer Dígito -- Plataforma
            // 1: Desktop                   2: Mobile

            // Segundo Dígito -- Pantalla
            // A: Contenedor Home           B: Contenedor Home Revisar
            // C: Landing EPM               D: Landing EPM Revisar
            // E: Landing ShowRoom          F: Landing ShowRoom Intriga
            // G: Revista Digital Info      H: Revista Digital Detalle
            // I: Guia de Negocio           J: Herramiento de venta
            // K: Mas Ganadoras             L: Duo perfecto
            // M: Packs de nuevas

            // Tercer Dígito -- Sección dentro de la Pantalla
            // 0: Principal                 1: OPT

            public const string DContenedorHome = "1A0";
            public const string MContenedorHome = "2A0";
            public const string DContenedorHomeRevisar = "1B0";
            public const string MContenedorHomeRevisar = "2B0";
            public const string DRevistaDigital = "1C0";
            public const string MRevistaDigital = "2C0";
            public const string DRevistaDigitalRevisar = "1D0";
            public const string MRevistaDigitalRevisar = "2D0";
            public const string DShowRoom = "1E0";
            public const string MShowRoom = "2E0";
            public const string DShowRoomIntriga = "1F0";
            public const string MShowRoomIntriga = "2F0";
            public const string DRevistaDigitalInfo = "1G0";
            public const string MRevistaDigitalInfo = "2G0";
            public const string DRevistaDigitalDetalle = "1H0";
            public const string MRevistaDigitalDetalle = "2H0";
            public const string DGuiaNegocio = "1I0";
            public const string MGuiaNegocio = "2I0";
            public const string DHerramientaVenta = "1J0";
            public const string MHerramientaVenta = "2J0";
            public const string DMasGanadoras = "1K0";
            public const string MMasGanadoras = "2K0";
            public const string DDuoPerfecto = "1L0";
            public const string MDuoPerfecto = "2L0";
            public const string DPacksNuevas = "1M0";
            public const string MPacksNuevas = "2M0";
        }

        /// <summary>
        /// Los cambios replicarlos en
        /// RevistaDigital-DataLayer.js + ConstantesModule.js
        /// </summary>
        public static class OrigenPedidoWeb
        {
            public static class Campos
            {
                // Primer Dígito
                public const int PLATAFORMA_INICIO = 0;
                public const int PLATAFORMA_TAMANO = 1;
                //  Segundo Dígito
                public const int PANTALLA_INICIO = 1;
                public const int PANTALLA_TAMANO = 1;
                // Tercer Dígito
                public const int SECCION_DENTRO_DE_PANTALLA_INICIO = 2;
                public const int SECCION_DENTRO_DE_PANTALLA_TAMANO = 1;

                // Cuarto Dígito
                public const int POPUP_INICIO = 3;
                public const int POPUP_TAMANO = 1;
            }

            // Primer Dígito -- Plataforma
            // 1: Desktop                   2: Mobile

            // Segundo Dígito -- Pantalla
            // 1: Home                      2: Pedido
            // 3: Liquidacion               4: Catalogo Personalizado
            // 5: ShowRoom                  6: OfertaParaTi
            // 7: RevistaDigital            8: GuiaNegocioDigital
            // 9: General

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


            public const int SectionBptDesktopPedido = 12; // Seccion BPT, metodo GetPartialSectionBptModel
            public const int SectionBptDesktopHome = 11; // Seccion BPT, metodo GetPartialSectionBptModel
            public const int SectionBptDesktopCatalogo = 14; // Seccion BPT, metodo GetPartialSectionBptModel
            public const int SectionBptMobilePedido = 22; // Seccion BPT, metodo GetPartialSectionBptModel
            public const int SectionBptMobileHome = 21; // Seccion BPT, metodo GetPartialSectionBptModel
            public const int SectionBptMobileCatalogo = 24; // Seccion BPT, metodo GetPartialSectionBptModel

            #region CatalogoPersonalizado
            public const int CatalogoPersonalizadoDesktopHome = 1131;
            public const int CatalogoPersonalizadoDesktopHomePopUp = 1132;
            public const int CatalogoPersonalizadoDesktop = 1431;
            public const int CatalogoPersonalizadoDesktopPopUp = 1432;
            public const int CatalogoPersonalizadoMobile = 2431;
            public const int CatalogoPersonalizadoMobilePopUp = 2432;
            #endregion

            public const int DesktopPedidoOfertaFinal = 1261; // se mantiene para el metodo obtenerNuevaDescripcionProductoDetalle, grilla pedido
            public const int MobilePedidoOfertaFinal = 2261; // se mantiene para el metodo obtenerNuevaDescripcionProductoDetalle, grilla pedido

            #region RevistaDigital
            public const int RevistaDigitalDesktopHomeSeccion = 1101; // para rediccecionar metodo RedireccionarContenedorComprar
            public const int RevistaDigitalMobileHomeSeccion = 2101; // para rediccecionar metodo RedireccionarContenedorComprar
            public const int RevistaDigitalDesktopPedidoSeccion = 1201; // para rediccecionar metodo RedireccionarContenedorComprar
            public const int RevistaDigitalMobilePedidoSeccion = 2201; // para rediccecionar metodo RedireccionarContenedorComprar
            public const int RevistaDigitalDesktopHomeLanzamiento = 1103; // para rediccecionar metodo RedireccionarContenedorComprar
            public const int RevistaDigitalMobileHomeLanzamiento = 2103; // para rediccecionar metodo RedireccionarContenedorComprar
            public const int RevistaDigitalDesktopCatalogoSeccion = 1401; // para rediccecionar metodo RedireccionarContenedorComprar, RedireccionarContenedorInformativa
            public const int RevistaDigitalMobileCatalogoSeccion = 2401; // para rediccecionar metodo RedireccionarContenedorComprar, RedireccionarContenedorInformativa
            #endregion

            #region MasVendidos
            public const int MasVendidosDesktopHomeCarrusel = 1151;
            public const int MasVendidosDesktopProductPageFicha = 1611;
            public const int MasVendidosDesktopProductPageCarrusel = 1612;
            public const int MasVendidosMobileHomeCarrusel = 2151;
            public const int MasVendidosMobileProductPageFicha = 2611;
            #endregion


            #region MasGanadoras
            public const int DesktopContenedorGanadorasCarrusel = 1081401; // Esta en duro en ConstantesModule
            public const int DesktopContenedorGanadorasFicha = 1081402; // Esta en duro en ConstantesModule
            public const int DesktopLandingGanadorasGanadorasCarrusel = 1111401; // Esta en duro en ConstantesModule
            public const int DesktopLandingGanadorasGanadorasFicha = 1111402; // Esta en duro en ConstantesModule
            public const int MobileContenedorGanadorasCarrusel = 2081401; // Esta en duro en ConstantesModule
            public const int MobileContenedorGanadorasFicha = 2081402; // Esta en duro en ConstantesModule
            public const int MobileLandingGanadorasGanadorasCarrusel = 2111401; // Esta en duro en ConstantesModule
            public const int MobileLandingGanadorasGanadorasFicha = 2111402; // Esta en duro en ConstantesModule
            #endregion

            #region VirtualCoach
            public const int VirtualCoachDesktopPedido = 1231;
            public const int VirtualCoachMobilePedido = 2231;
            #endregion

            #region Programa de Nuevas
            public const string Mensaje1 = "El código solicitado es exclusivo del Programa de Nuevas.";
            #endregion

            #region Busqueda y filtros
            public const int DesktopLandingBuscadorOfertasParaTiCarrusel = 1100001;
            public const int DesktopLandingBuscadorShowroomCarrusel = 1100101;
            public const int DesktopLandingBuscadorLanzamientosCarrusel = 1100201;
            public const int DesktopLandingBuscadorOfertaDelDiaCarrusel = 1100301;
            public const int DesktopLandingBuscadorGNDCarrusel = 1100501;
            public const int DesktopLandingBuscadorLiquidacionCarrusel = 1100601;
            public const int DesktopLandingBuscadorHerramientasDeVentaCarrusel = 1100801;
            public const int DesktopLandingBuscadorCatalogoLbelCarrusel = 1101101;
            public const int DesktopLandingBuscadorCatalogoEsikaCarrusel = 1101201;
            public const int DesktopLandingBuscadorCatalogoCyzoneCarrusel = 1101201;

            public const int MobileLandingBuscadorOfertasParaTiCarrusel = 2100001;
            public const int MobileLandingBuscadorShowroomCarrusel = 2100101;
            public const int MobileLandingBuscadorLanzamientosCarrusel = 2100201;
            public const int MobileLandingBuscadorOfertaDelDiaCarrusel = 2100301;
            public const int MobileLandingBuscadorGNDCarrusel = 2100501;
            public const int MobileLandingBuscadorLiquidacionCarrusel = 2100601;
            public const int MobileLandingBuscadorHerramientasDeVentaCarrusel = 2100801;
            public const int MobileLandingBuscadorCatalogoLbelCarrusel = 2101101;
            public const int MobileLandingBuscadorCatalogoEsikaCarrusel = 2101201;
            public const int MobileLandingBuscadorCatalogoCyzoneCarrusel = 2101301;


            public const int DesktopLandingBuscadorOfertasParaTiFicha = 1100002;
            public const int DesktopLandingBuscadorShowroomFicha = 1100102;
            public const int DesktopLandingBuscadorLanzamientosFicha = 1100202;
            public const int DesktopLandingBuscadorOfertaDelDiaFicha = 1100302;
            public const int DesktopLandingBuscadorGNDFicha = 1100502;
            public const int DesktopLandingBuscadorHerramientasDeVentaFicha = 1100802;

            public const int MobileLandingBuscadorOfertasParaTiFicha = 2100002;
            public const int MobileLandingBuscadorShowroomFicha = 2100102;
            public const int MobileLandingBuscadorLanzamientosFicha = 2100202;
            public const int MobileLandingBuscadorOfertaDelDiaFicha = 2100302;
            public const int MobileLandingBuscadorGNDFicha = 2100502;
            public const int MobileLandingBuscadorHerramientasDeVentaFicha = 2100802;

            #endregion

            #region Nuevos Códigos Origen Pedido
            public const int DesktopHomeOfertasParaTiCarrusel = 1010001;
            public const int DesktopHomeOfertasParaTiFicha = 1010002;
            public const int DesktopContenedorOfertasParaTiCarrusel = 1080001;
            public const int DesktopContenedorOfertasParaTiFicha = 1080002;
            public const int DesktopLandingOfertasParaTiOfertasParaTiCarrusel = 1070001; // Esta en duro en rdAnalyticsModule
            public const int DesktopLandingOfertasParaTiOfertasParaTiFicha = 1070002;
            public const int DesktopPedidoOfertasParaTiCarrusel = 1020001;
            public const int DesktopPedidoOfertasParaTiFicha = 1020002;
            public const int MobileHomeOfertasParaTiCarrusel = 2010001;
            public const int MobileHomeOfertasParaTiFicha = 2010002;
            public const int MobileLandingOfertasParaTiOfertasParaTiCarrusel = 2070001; // Esta en duro en rdAnalyticsModule
            public const int MobileLandingOfertasParaTiOfertasParaTiFicha = 2070002;
            public const int AppConsultoraLandingOfertasParaTiOfertasParaTiFicha = 4070002;
            public const int MobilePedidoOfertasParaTiCarrusel = 2020001;
            public const int MobilePedidoOfertasParaTiFicha = 2020002;
            public const int AppConsultoraPedidoOfertasParaTiCarrusel = 4020001;
            public const int AppConsultoraPedidoOfertasParaTiFicha = 4020002;
            public const int AppConsultoraContenedorOfertasParaTiCarrusel = 4080001;
            public const int AppConsultoraContenedorOfertasParaTiFicha = 4080002;
            public const int MobileContenedorOfertasParaTiCarrusel = 2080001;
            public const int MobileContenedorOfertasParaTiFicha = 2080002;

            public const int DesktopContenedorLanzamientosCarrusel = 1080201;
            public const int DesktopContenedorLanzamientosFicha = 1080202; // Esta en duro en rdAnalyticsModule
            public const int DesktopContenedorLanzamientosCarruselVerMas = 1080205;
            public const int MobileContenedorLanzamientosFicha = 2080202; // Esta en duro en rdAnalyticsModule
            public const int AppConsultoraContenedorLanzamientosFicha = 4080202;
            public const int DesktopHomeOfertaDelDiaBannerSuperior = 1010306; // Esta en duro en ConstantesModule
            public const int DesktopHomeOfertaDelDiaFicha = 1010302;

            public const int DesktopContenedorOfertaDelDiaCarrusel = 1080301;
            public const int DesktopContenedorOfertaDelDiaFicha = 1080302;
            public const int DesktopContenedorOfertaDelDiaCarruselVerMas = 1080305;
            public const int DesktopOtrasOfertaDelDiaBannerSuperior = 1090306; // Esta en duro en ConstantesModule
            public const int DesktopPedidoOfertaDelDiaBannerSuperior = 1020306; // Esta en duro en ConstantesModule
            public const int MobileHomeOfertaDelDiaCarrusel = 2010301;
            public const int MobileHomeOfertaDelDiaFicha = 2010302;
            public const int MobileOtrasOfertaDelDiaFicha = 2090302;
            public const int MobileContenedorOfertaDelDiaCarrusel = 2080301;
            public const int MobileContenedorOfertaDelDiaFicha = 2080302;
            public const int AppConsultoraContenedorOfertaDelDiaFicha = 4080302;

            public const int DesktopHomeShowroomCarrusel = 1010101;
            public const int DesktopHomeShowroomFicha = 1010102;
            public const int DesktopHomeShowroomCarruselVerMas = 1010105;
            public const int DesktopContenedorShowroomCarrusel = 1080101;
            public const int DesktopContenedorShowroomFicha = 1080102;
            public const int DesktopContenedorShowroomCarruselVerMas = 1080105;
            public const int DesktopLandingShowroomShowroomCarrusel = 1050101;
            public const int DesktopLandingShowroomShowroomFicha = 1050102;
            public const int DesktopLandingShowroomShowroomCarruselVerMas = 1050105;
            public const int DesktopLandingShowroomShowroomSubCampania = 1050107;
            public const int MobileLandingShowroomShowroomCarrusel = 2050101;
            public const int MobileLandingShowroomShowroomFicha = 2050102;
            public const int AppConsultoraLandingShowroomShowroomFicha = 4050102;
            public const int MobileLandingShowroomShowroomSubCampania = 2050107;
            public const int AppConsultoraLandingShowroomShowroomSubCampania = 4050107;

            public const int DesktopLandingGNDGNDCarrusel = 1060501;
            public const int DesktopLandingGNDGNDFicha = 1060502;
            public const int MobileLandingGNDGNDCarrusel = 2060501;
            public const int MobileLandingGNDGNDFicha = 2060502;
            public const int AppConsultoraLandingGNDGNDFicha = 4060502;
            public const int DesktopPedidoOfertaFinalCarrusel = 1020401;
            public const int DesktopPedidoOfertaFinalFicha = 1020402;
            public const int MobilePedidoOfertaFinalCarrusel = 2020401;
            public const int MobilePedidoOfertaFinalFicha = 2020402;
            public const int AppConsultoraPedidoOfertaFinalCarrusel = 4020401;
            public const int AppConsultoraPedidoOfertaFinalFicha = 4020402;
            public const int DesktopContenedorHerramientasdeVentaCarrusel = 1080801;
            public const int DesktopContenedorHerramientasdeVentaFicha = 1080802;
            public const int DesktopLandingHerramientasdeVentaHerramientasdeVentaCarrusel = 1000801;
            public const int DesktopLandingHerramientasdeVentaHerramientasdeVentasFicha = 1000802;
            public const int MobileLandingHerramientasdeVentaHerramientasdeVentaCarrusel = 2000801;
            public const int MobileLandingHerramientasdeVentaHerramientasdeVentaFicha = 2000802;
            public const int AppConsultoraLandingHerramientasdeVentaHerramientasdeVentaFicha = 4000802;
            public const int DesktopHomeLiquidacionCarrusel = 1010601;
            public const int DesktopLandingLiquidacionLiquidacionCarrusel = 1030601;
            public const int MobileLandingLiquidacionLiquidacionCarrusel = 2030601;
            public const int DesktopPedidoProductoSugeridoCarrusel = 1020701;
            public const int MobilePedidoProductoSugeridoCarrusel = 2020701;
            public const int DesktopHomeBannersCarrusel = 1010901;
            public const int DesktopPedidoDigitado = 10210;
            public const int MobilePedidoDigitado = 20210;
            public const int AppConsultoraPedidoDigitado = 40210;
            public const int DesktopBuscadorOfertasParaTiDesplegableBuscador = 1040004;
            public const int DesktopBuscadorShowroomDesplegableBuscador = 1040104;
            public const int DesktopBuscadorLanzamientosDesplegableBuscador = 1040204;
            public const int DesktopBuscadorOfertaDelDiaDesplegableBuscador = 1040304;
            public const int DesktopBuscadorLiquidacionDesplegableBuscador = 1040604;
            public const int DesktopBuscadorHerramientasdeVentaDesplegableBuscador = 1040804;
            public const int DesktopBuscadorGNDDesplegableBuscador = 1040504;
            public const int DesktopBuscadorCatalogoLbelDesplegableBuscador = 1041104;
            public const int DesktopBuscadorCatalogoEsikaDesplegableBuscador = 1041204;
            public const int DesktopBuscadorCatalogoCyzoneDesplegableBuscador = 1041304;
            public const int DesktopBuscadorOfertasParaTiFicha = 1040002;
            public const int DesktopBuscadorShowroomFicha = 1040102;
            public const int DesktopBuscadorLanzamientosFicha = 1040202;
            public const int DesktopBuscadorOfertaDelDiaFicha = 1040302;
            public const int DesktopBuscadorGNDFicha = 1040502;
            public const int DesktopBuscadorHerramientasdeVentaFicha = 1040802;
            public const int MobileBuscadorOfertasParaTiDesplegableBuscador = 2040004;
            public const int MobileBuscadorShowroomDesplegableBuscador = 2040104;
            public const int MobileBuscadorLanzamientosDesplegableBuscador = 2040204;
            public const int MobileBuscadorOfertaDelDiaDesplegableBuscador = 2040304;
            public const int MobileBuscadorLiquidacionDesplegableBuscador = 2040604;
            public const int MobileBuscadorHerramientasdeVentaDesplegableBuscador = 2040804;
            public const int MobileBuscadorGNDDesplegableBuscador = 2040504;
            public const int MobileBuscadorCatalogoLbelDesplegableBuscador = 2041104;
            public const int MobileBuscadorCatalogoEsikaDesplegableBuscador = 2041204;
            public const int MobileBuscadorCatalogoCyzoneDesplegableBuscador = 2041304;
            public const int MobileBuscadorOfertasParaTiFicha = 2040002;
            public const int MobileBuscadorShowroomFicha = 2040102;
            public const int MobileBuscadorLanzamientosFicha = 2040202;
            public const int MobileBuscadorOfertaDelDiaFicha = 2040302;
            public const int MobileBuscadorGNDFicha = 2040502;
            public const int MobileBuscadorHerramientasdeVentaFicha = 2040802;

            public const int MobileContenedorShowroomCarrusel = 2080101;
            public const int MobileContenedorShowroomFicha = 2080102;
            public const int MobileContenedorLanzamientosCarrusel = 2080201; // Esta en duro en rdAnalyticsModule

            #endregion

            #region Producto Recomendado
            public const int DesktopPedidoProductoRecomendadoCarrusel = 1021501;
            public const int MobilePedidoProductoRecomendadoCarrusel = 2021501;
            #endregion
        }

        public static class TipoTutorial
        {
            public const int Video = 1;
            public const int Desktop = 2;
            public const int Salvavidas = 3;
            public const int Mobile = 4;
        }

        public static class COTipoAtencionMensaje
        {
            public const string Agotado = "Agotado";
            public const string IngresadoPedido = "Ingresado al Pedido";
            public const string YaTengo = "Ya lo tengo";
        }

        public static class COPedidoCanceladoMensaje
        {
            public const string Portal = "Se retiraron de tu pedido los productos de este cliente.";
            public const string Marcas = "No te olvides comunicarte con tu cliente.";
        }

        public static class BackOrder
        {
            public const string LogAccionCancelar = "El cliente no aceptó BackOrder.";
            public const string mensajeBackOrderDestokp = "Se agotó el producto, ¿Te lo enviamos la próxima campaña al mismo precio?. Recuerda ingresar pedido esta y la siguiente campaña para que te llegue.";
            public const string mensajeBackOrderMobile = "Se agotó el producto, ¿Te lo enviamos la próxima campaña al mismo precio?. Recuerda ingresar pedido esta y la siguiente campaña para que te llegue.";
        }

        public static class EstadoCDRWeb
        {
            public const int Pendiente = 1;
            public const int Enviado = 2;
            public const int Aceptado = 3;
            public const int Observado = 4;
        }

        public static class TipoMensajeCDR
        {
            public const string Motivo = "Motivo";
            public const string Solucion = "Solucion";
            public const string Propuesta = "Propuesta";
            public const string TenerEnCuenta = "TenerEnCuenta";
            public const string Finalizado = "Finalizado";
            public const string MensajeFinalizado = "MensajeFinalizado";
        }

        public static class ParametriaCDR
        {
            public const string Faltante = "STO_PMON_FM";
            public const string Devolucion = "STO_PMON_DEV";
            public const string Trueque = "STO_DESV_TRQ";
            public const string TruequeValAbs = "STO_DESV_TRQ_OPER";
        }

        public static class CdrWebDatos
        {
            public const string UnidadesPermitidasFaltante = "UnidadesPermitidasFaltante";
            public const string ValidacionDiasFaltante = "ValidacionDiasFaltante";
            public const string DiasAntesFacturacion = "DiasAntesFacturacion";
        }

        public static class CdrWebMensajes
        {
            public const string ZonaBloqueada = "Lo sentimos, por el momento tu zona no se encuentra disponible para realizar esta operación.";
            public const string ConsultoraBloqueada = "Lo sentimos, por el momento te encuentras bloqueada para realizar esta operación.";
            public const string SinPedidosDisponibles = "Lo sentimos, en estos momentos no cuentas con pedidos disponibles para reclamar.";
            public const string FueraDeFecha = "Tu solicitud se encuentra fuera de fecha para poder ser atendida.";
            public const string ContactateChatEnLinea = "Por favor, contáctate con nuestro <span class=\"enlace_chat belcorpChat\"><a>Chat en Línea</a></span>.";
        }

        public static class CodigoOperacionCDR
        {
            public const string Faltante = "F";
            public const string FaltanteAbono = "G";
            public const string Devolucion = "D";
            public const string Trueque = "T";
            public const string Canje = "C";
        }

        public static class TipoPopUp
        {
            public const int Ninguno = 0;
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
            public const int AsesoraOnline = 12;
            public const int ActualizarCorreo = 13;

        }

        public static class GPRMotivoRechazo
        {
            public const string MontoMinino = "OCC-16";
            public const string MontoMaximo = "OCC-17";
            public const string ActualizacionDeuda = "OCC-19";
            public const string ValidacionMontoMinimoStock = "OCC-51";
            public const string Mostrar2OpcionesNotificacion = "1";
        }

        public static class ValidacionExisteUsuario
        {
            public const int NoExiste = 0;
            public const int ExisteDiferenteClave = 1;
            public const int Existe = 2;

        }

        public static class LogDynamoDB
        {
            public const string AplicacionPortalConsultoras = "PORTALCONSULTORAS";
            public const string AplicacionPortalLideres = "PORTALLIDERES";

            public const string RolConsultora = "CO";
            public const string RolSociaEmpresaria = "SE";
        }

        public static class MensajeEstaEnRevista
        {
            public const string EsikaWeb = "Producto en la Guía de Negocio Ésika con oferta especial.";
            public const string LbelWeb = "Producto en Mi Negocio L’Bel con oferta especial.";
            public const string EsikaMobile = "Este producto está en la Guía de Negocio Ésika con oferta especial.";
            public const string LbelMobile = "Este producto está en Mi Negocio L’Bel con oferta especial.";
        }

        public static class PestanhasMisPagos
        {
            public const string EstadoCuenta = "EstadoCuenta";
            public const string LugaresPago = "LugaresPago";
            public const string MisPercepciones = "MisPercepciones";
        }

        public static class ShowRoomPersonalizacion
        {
            public static class Desktop
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
                public const string ImagenFondoContenedorOfertasShowRoomIntriga = "ImagenFondoContenedorOfertasShowRoomIntriga";
                public const string ImagenFondoContenedorOfertasShowRoomVenta = "ImagenFondoContenedorOfertasShowRoomVenta";

            }

            public static class Mobile
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
                public const string ImagenBannerContenedorOfertasIntriga = "ImagenBannerContenedorOfertasIntriga";
                public const string ImagenBannerContenedorOfertasVenta = "ImagenBannerContenedorOfertasVenta";

            }

            public static class TipoAplicacion
            {
                public const string Desktop = "Desktop";
                public const string Mobile = "Mobile";
            }

            public static class TipoPersonalizacion
            {
                public const string Evento = "EVENTO";
                public const string Categoria = "CATEGORIA";
            }
        }

        public static class ShowRoomTipoFiltro
        {
            public const string Categoria = "CATEGORIA";
            public const string RangoPrecios = "RANGOPRECIOS";
        }

        public static class ShowRoomTipoOrdenamiento
        {
            public const string Precio = "PRECIO";
            public static class ValorPrecio
            {
                public const string Predefinido = "01";
                public const string MenorAMayor = "02";
                public const string MayorAMenor = "03";
            }
        }

        public static class GuiaNegocioTipoOrdenamiento
        {
            public const string Precio = "PRECIO";
            public static class ValorPrecio
            {
                public const string Predefinido = "01";
                public const string MenorAMayor = "02";
                public const string MayorAMenor = "03";
            }
        }

        public static class GuiaNegocioMarca
        {
            public const string Precio = "MARCA";
            public static class ValorPrecio
            {
                public const string Predefinido = "-";
                public const string Cyzone = "CYZONE";
                public const string Esika = "ÉSIKA";
                public const string LBel = "LBEL";
            }
        }

        public static class RevistaDigitalOrigen
        {
            public const string RD = "RD";
            public const string Unete = "UNETE";
            public const string Nueva = "NUEVA";
        }

        public static class RevistaDigital
        {
            public static class Estado
            {
                public const string InscritaActiva = "IA";
                public const string NoInscritaActiva = "NIA";
                public const string InscritaNoActiva = "INA";
                public const string NoInscritaNoActiva = "NINA";
                public const string Intriga = "INTRIGA";
            }
        }

        public static class MatrizNemotecnicoMensajes
        {
            public const string TooltipInformacionFormatoBusqueda = "Formato de búsqueda de Nemotécnico: &lt;SAP_1&gt;#&lt;Cantidad_1&gt;&amp;&lt;SAP_2&gt;#&lt;Cantidad_2&gt;&amp;...&lt;SAP_N&gt;#&lt;Cantidad_N&gt; , ejemplos: 210080203, 210080203#01, 200083988 210080203, 200083988&210080203, 200083988#02&210080203#01";
            public const string PlaceHolderTextoNemotecnico = "Ingrese patrón de búsqueda";
            public const string TextoBotonBuscar = "Buscar por nemotécnico";
            public const string TextoBotonLimpiar = "Limpiar filtros nemotécnico";
            public const string TextoBusquedaExacta = "B.Exacta";
        }

        public static class IncentivosSMS
        {
            public const string MensajeAgregarMasProductos = "Agrega otros productos desde aquí";
        }

        public static class MenuCodigo
        {
            public const string MiNegocio = "MiNegocio";
            public const string RevistaDigitalSuscripcion = "RevistaDigitalSuscripcion";
            public const string CatalogoPersonalizado = "FDTC";
            public const string PedidoFIC = "PedidoFIC";
            public const string ContenedorOfertas = "ContenedorOfertas";
            public const string LiquidacionWeb = "LiquidacionWeb";
        }

        public static class MenuMobileId
        {
            public static readonly int CatalogosYRevistas = 1002;
            public static readonly int NecesitasAyuda = 1039;
        }

        public static class BannerCodigo
        {
            public const string RevistaDigital = "RevistaDigital";
        }

        public static class IngresoExternoPagina
        {
            public const string EstadoCuenta = "ESTADOCUENTA";
            public const string SeguimientoPedido = "SEGUIMIENTOPEDIDO";
            public const string PedidoDetalle = "PEDIDODETALLE";
            public const string NotificacionesValidacionAuto = "NOTIFICACIONVALIDACIONAUTO";
            public const string CompartirCatalogo = "COMPARTIRCATALOGO";
            public const string Pedido = "PEDIDO";
            public const string MisPedidos = "MISPEDIDOS";
            public const string ShowRoom = "SHOWROOM";
            public const string ProductosAgotados = "PRODUCTOSAGOTADOS";
            public const string Ofertas = "OFERTAS";
            public const string GuiaNegocio = "GUIANEGOCIO";
            public const string RevistaDigitalInformacion = "REVISTADIGITALINFORMACION";
            public const string LiquidacionWeb = "LIQUIDACIONWEB";
            public const string CambiosDevoluciones = "CAMBIODEVOLUCIONES";
            public const string PedidosFIC = "PEDIDOSFIC";
            public const string DetalleEstrategia = "DETALLEESTRATEGIA";
            public const string LoNuevoNuevo = "LONUEVONUEVO";
            public const string OfertasParaTi = "OFERTASPARATI";
            public const string SoloHoy = "SOLOHOY";
            public const string HerramientasDeVenta = "HERRAMIENTASDEVENTA";
            public const string SaberMasInscripcion = "SABERMASINSCRIPCION";
            public const string DuoPerfecto = "DUOPERFECTO";
        }

        public static class IngresoExternoOrigen
        {
            public const string App = "4";
        }

        public static class EstadoCuentaTipoMovimiento
        {
            public const int Abono = 2;
            public const int Cargo = 1;
        }

        public static class TamaniosImagenIssuu
        {
            public const string ThumbSmall = "_thumb_small";
            public const string ThumbMedium = "_thumb_medium";
            public const string ThumbLarge = "_thumb_large";
        }

        public static class CatalogoImagenDefault
        {
            public const string Catalogo = "https://www.somosbelcorp.com/Content/Images/catalogo_no_disponible.jpg";
            public const string Revista = "https://www.somosbelcorp.com/Content/Images/revista_no_disponible.jpg";
        }

        public static class CatalogoUrlDefault
        {
            public const string Esika = "http://www.esika.biz";
            public const string Lbel = "http://www.lbel.com";
            public const string Cyzone = "http://www.cyzone.com";
        }

        public static class CatalogoUrlIssu
        {
            public const string Buscador = "//search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            public const string RDR = "rdr";
        }

        public static class RevistaNombre
        {
            public const string Esika = "Guía de Negocio Ésika";
            public const string Lbel = "Mi Negocio L’Bel";
        }

        public static class EstadoCupon
        {
            public const int Reservado = 1;
            public const int Activo = 2;
            public const int Utilizado = 3;
        }

        public static class NombreEstadoCupon
        {
            public const string Reservado = "Registrado";
            public const string Activo = "Activado";
            public const string Utilizado = "Utilizado";
        }

        public static class CodigoTipoCupon
        {
            public const int Monto = 1;
            public const int Porcentaje = 2;
        }

        public static class NombreTipoCupon
        {
            public const string Monto = "Monto";
            public const string Porcentaje = "Porcentaje";
        }

        public static class MensajesError
        {
            public const string InsertarDesglose = "Ocurrió un error al procesar la reserva.";
            public const string CargarProductosShowRoom = "Error al cargar los productos.";
            public const string DeletePedido_CuvNoExiste = "El producto que deseas eliminar ya no se encuentra en tu pedido. Por favor, vuelva a carga la página (F5).";
            public const string RecuperarContrasenia = "Error en la respuesta del servicio de Recuperar Contraseña.";
            public const string SinConexion = "Necesitas internet para acceder a esta opción.";
            public const string SinConexion_LoginChatbot = "Necesitas internet para acceder a esta opción.";
            public const string SinConexion_CatalogoRevistaIssu = "Necesitas internet para acceder a esta opción.";
            public const string SinConexion_Reserva = "Necesita tener conexion a internet para poder reservar.";
            public const string ReportePedidoDDWeb_DescargaCabecera = "Ocurrió un error al intentar descargar sus pedidos. Inténtelo más tarde.";
            public const string ReportePedidoDDWeb_DescargaDetalle = "Ocurrió un error al intentar descargar los detalles de sus pedidos. Inténtelo más tarde.";
            public const string LimiteDescargaSobrepasado = "El archivo no se puede descargar debido a que se sobrepaso el máximo de items ({0}).";
            public const string PaqueteDocumentario_ConsumirServicio = "Ocurrió un error al intentar obtener la información. Por favor, vuelva a intentar dentro de unos minutos.";
            public const string Cache_Eliminar = "Ocurrió un error al eliminar la caché. Inténtelo más tarde";
            public const string Pedido_Reserva = "Hubo un error al tratar de realizar la validación del pedido, por favor vuelva a intentarlo.";
            public const string Reserva_SinDetalle = "No tiene productos que reservar esta campaña.";
            public const string Pedido_DeleteAll = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            public const string UpdCorreoConsultora = "Ocurrió un error al intentar actualizar su correo. Inténtelo más tarde.";
            public const string UpdCorreoConsultora_NoAutorizado = "Su país no permite la actualización de datos.";
            public const string UpdCorreoConsultora_CorreoVacio = "Debe ingresar un correo nuevo.";
            public const string UpdCorreoConsultora_CorreoNoCambia = "Debe ingresar un correo diferente a su correo actual.";
            public const string UpdCorreoConsultora_CorreoYaExiste = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.";
            public const string ActivacionCorreo = "Ha ocurrido un error con la activación de su correo electrónico.";
            public const string ActivacionCorreo_NoExiste = "No existe una activación de correo pendiente para su correo.";
            public const string ActivacionCorreo_EstaActivo = "Esta dirección de correo electrónico ya ha sido activada.";
            public const string ValorVacio = "El valor no puede estar vacío.";
            public const string CodigoIncorrecto = "El código ingresado no es el correcto.";
            public const string CelularActivacion = "No se pudo confirmar el número registrado.";
            public const string CelularEnUso = "El número ya está en uso.";
            public const string DeleteAllPedido_Error = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            public const string Reserva_ObsHuerfanas = "Reserva_ObsHuerfanas: Se obtuvieron observaciones al reservar que no se encuentran en el detalle.";
            public const string Reserva_Prol2 = "Reserva_Prol2: El servicio externo de reserva de Prol2 retornó vacio.";
            public const string Reserva_Prol3 = "Reserva_Prol3: El servicio externo de reserva de Sicc retornó vacio o error.";
            public const string ErrorGenerico = "Ocurrio un error, vuelva ha intentarlo.";
            public const string InsertarValidarKitInicio = "No está permitido agregar el Kit de un programa obligatorio.";
            public const string ValidarAgregarProgNuevas = "Sucedió un error al validar el programa de nuevas. Inténtenlo más tarde.";
            public const string ExcedioLimiteVenta = "Las unidades ingresadas exceden el máximo permitido ({0}) en esta campaña.";
        }

        public static class MensajesExito
        {
            public const string UpdCorreoConsultora_Reenvio = "Email reenviado satisfactoriamente.";
        }

        public static class ConfiguracionPais
        {
            public const string InicioRD = "INICIORD";
            public const string Inicio = "INICIO";
            public const string OfertasParaTi = "OPT";
            public const string OfertasParaMi = "OPM";
            public const string RevistaDigitalIntriga = "RDI";
            public const string RevistaDigital = "RD";
            public const string RevistaDigitalReducida = "RDR";
            public const string RevistaDigitalSuscripcion = "RDS";
            public const string Lanzamiento = "LAN";
            public const string ValidacionMontoMaximo = "MMAX";
            public const string OfertaFinalTradicional = "OFT";
            public const string OfertaFinalCrossSelling = "OFC";
            public const string OfertaFinalRegaloSorpresa = "OFR";
            public const string OfertaFinalCrossSellingGanaMas = "OFCGM";
            public const string ShowRoom = "SR";
            public const string OfertaDelDia = "ODD";
            public const string Informacion = "INFO";
            public const string Descargables = "DES-NAV";
            public const string GuiaDeNegocioDigitalizada = "GND";
            public const string HerramientasVenta = "HV";
            public const string PagoEnLinea = "PAYONLINE";
            public const string BuscadorYFiltros = "B&F";
            public const string ProgramaNuevas = "PN";
            public const string ElecMultiple = "DP";
            public const string MasGanadoras = "MG";
            public const string Recomendaciones = "RECOMDS";
        }


        public static class ConfiguracionPaisComponente
        {
            public static class RD
            {
                public const string PopupClubGanaMas = "Popup_Club_Gana+";
            }
        }

        public static class ConfiguracionPaisDatos
        {
            public const string BloqueoProductoDigital = "BloqueoProductoDigital";
            public const string ActivoMdo = "ActivoMDO";

            #region Banner Carrusel - Caja Producto
            public const string BannerCarruselTitulo = "BannerCarruselTitulo";
            public const string BannerCarruselTextoEnlace = "BannerCarruselTextoEnlace";
            public const string BannerCarruselImagenFondo = "BannerCarruselImagenFondo";
            #endregion

            public static class RD
            {
                #region Data de Cabecera
                public const string BloquearDiasAntesFacturar = "BloquearDiasAntesFacturar";
                public const string CantidadCampaniaEfectiva = "CantidadCampaniaEfectiva";
                public const string NombreComercialActiva = "NombreComercialActiva";
                public const string NombreComercialNoActiva = "NombreComercialNoActiva";
                public const string LogoMenuInicioActiva = "LogoMenuInicioActiva";
                public const string LogoMenuInicioNoActiva = "LogoMenuInicioNoActiva";
                public const string LogoMenuInicioNoSuscrita = "LogoMenuInicioNoSuscrita";
                public const string LogoMenuInicioNoActivaNoSuscrita = "LogoMenuInicioNoActivaNoSuscrita";
                public const string LogoComercialActiva = "LogoComercialActiva";
                public const string LogoComercialNoActiva = "LogoComercialNoActiva";
                public const string LogoComercialFondoActiva = "LogoComercialFondoActiva";
                public const string LogoComercialFondoNoActiva = "LogoComercialFondoNoActiva";
                public const string LogoMenuOfertasActiva = "LogoMenuOfertasActiva";
                public const string LogoMenuOfertasNoActiva = "LogoMenuOfertasNoActiva";
                public const string BloquearPedidoRevistaImp = "BloquearPedidoRevistaImp";
                public const string BloquearSugerenciaProducto = "BloquearSugerenciaProducto";
                public const string SubscripcionAutomaticaAVirtualCoach = "SubscripcionAutomaticaAVirtualCoach";
                public const string BannerOfertasNoActivaNoSuscrita = "BannerOfertasNoActivaNoSuscrita";
                public const string BannerOfertasNoActivaSuscrita = "BannerOfertasNoActivaSuscrita";
                public const string BannerOfertasActivaNoSuscrita = "BannerOfertasActivaNoSuscrita";
                public const string BannerOfertasActivaSuscrita = "BannerOfertasActivaSuscrita";
                #endregion

                #region Bienvenida
                public const string DBienvenidaInscritaActiva = "DBienvenidaInscritaActiva";
                public const string DBienvenidaInscritaNoActiva = "DBienvenidaInscritaNoActiva";
                public const string DBienvenidaNoInscritaActiva = "DBienvenidaNoInscritaActiva";
                public const string DBienvenidaNoInscritaNoActiva = "DBienvenidaNoInscritaNoActiva";
                public const string MBienvenidaInscritaActiva = "MBienvenidaInscritaActiva";
                public const string MBienvenidaInscritaNoActiva = "MBienvenidaInscritaNoActiva";
                public const string MBienvenidaNoInscritaActiva = "MBienvenidaNoInscritaActiva";
                public const string MBienvenidaNoInscritaNoActiva = "MBienvenidaNoInscritaNoActiva";
                #endregion

                #region Pedido
                public const string DPedidoInscritaActiva = "DPedidoInscritaActiva";
                public const string DPedidoInscritaNoActiva = "DPedidoInscritaNoActiva";
                public const string DPedidoNoInscritaActiva = "DPedidoNoInscritaActiva";
                public const string DPedidoNoInscritaNoActiva = "DPedidoNoInscritaNoActiva";
                public const string MPedidoInscritaActiva = "MPedidoInscritaActiva";
                public const string MPedidoInscritaNoActiva = "MPedidoInscritaNoActiva";
                public const string MPedidoNoInscritaActiva = "MPedidoNoInscritaActiva";
                public const string MPedidoNoInscritaNoActiva = "MPedidoNoInscritaNoActiva";
                #endregion

                #region Catalogo
                public const string DCatalogoInscritaActiva = "DCatalogoInscritaActiva";
                public const string DCatalogoInscritaNoActiva = "DCatalogoInscritaNoActiva";
                public const string DCatalogoNoInscritaActiva = "DCatalogoNoInscritaActiva";
                public const string DCatalogoNoInscritaNoActiva = "DCatalogoNoInscritaNoActiva";
                public const string MCatalogoInscritaActiva = "MCatalogoInscritaActiva";
                public const string MCatalogoInscritaNoActiva = "MCatalogoInscritaNoActiva";
                public const string MCatalogoNoInscritaActiva = "MCatalogoNoInscritaActiva";
                public const string MCatalogoNoInscritaNoActiva = "MCatalogoNoInscritaNoActiva";
                #endregion

                #region Revista Digital Popup Bloqueado
                public const string DPopupBloqueadoNoActivaNoSuscrita = "DPopupBloqueadoNoActivaNoSuscrita";
                public const string DPopupBloqueadoNoActivaSuscrita = "DPopupBloqueadoNoActivaSuscrita";
                public const string MPopupBloqueadoNoActivaNoSuscrita = "MPopupBloqueadoNoActivaNoSuscrita";
                public const string MPopupBloqueadoNoActivaSuscrita = "MPopupBloqueadoNoActivaSuscrita";
                public const string PopupBloqueadoNS = "PopupBloqueadoNS";
                public const string PopupBloqueadoSNA = "PopupBloqueadoSNA";
                #endregion

                #region Revista Digital Lo que te perdiste
                public const string DPerdiste = "DPerdiste";
                public const string MPerdiste = "MPerdiste";
                public const string NSPerdiste = "NSPerdiste";
                public const string SNAPerdiste = "SNAPerdiste";
                #endregion

                #region Inicio Revista Digital - Banner
                public const string DLandingBannerInicioRdActivaNoSuscrita = "DLandingBannerInicioRdActivaNoSuscrita";
                public const string DLandingBannerInicioRdNoActivaNoSuscrita = "DLandingBannerInicioRdNoActivaNoSuscrita";
                public const string DLandingBannerInicioRdNoActivaSuscrita = "DLandingBannerInicioRdNoActivaSuscrita";
                public const string DLandingBannerInicioRdActivaSuscrita = "DLandingBannerInicioRdActivaSuscrita";
                #endregion

                #region Revista Digital Landing Productos - Banner
                public const string DLandingBannerNoActivaNoSuscrita = "DLandingBannerNoActivaNoSuscrita";
                public const string DLandingBannerNoActivaSuscrita = "DLandingBannerNoActivaSuscrita";
                public const string DLandingBannerActivaNoSuscrita = "DLandingBannerActivaNoSuscrita";
                public const string DLandingBannerActivaSuscrita = "DLandingBannerActivaSuscrita";
                public const string MLandingBannerNoActivaNoSuscrita = "MLandingBannerNoActivaNoSuscrita";
                public const string MLandingBannerNoActivaSuscrita = "MLandingBannerNoActivaSuscrita";
                public const string MLandingBannerActivaNoSuscrita = "MLandingBannerActivaNoSuscrita";
                public const string MLandingBannerActivaSuscrita = "MLandingBannerActivaSuscrita";
                #endregion

                #region Landing Informativo
                public const string InformativoVideo = "InformativoVideo";

                #endregion

                #region PopupSuscripcion
                public const string PopupMensaje1 = "PopupMensaje1";
                public const string PopupMensaje2 = "PopupMensaje2";
                public const string PopupMensajeColor = "PopupMensajeColor";
                public const string PopupImagenEtiqueta = "PopupImagenEtiqueta";
                public const string PopupImagenPublicidad = "PopupImagenPublicidad";
                public const string PopupBotonColorFondo = "PopupBotonColorFondo";
                public const string PopupBotonColorTexto = "PopupBotonColorTexto";
                public const string PopupBotonTexto = "PopupBotonTexto";
                public const string PopupFondoColor = "PopupFondoColor";
                public const string PopupFondoColorMarco = "PopupFondoColorMarco";
                #endregion

                #region SociaEmpresaria
                public static readonly string SociaEEmpresariaExperienciaClub = "SEExperienciaClub";
                public static readonly string SociaEmpresariaSuscritaNoActivaCancelarSuscripcion = "SESuscritaNoActivaCancelarSuscripcion";
                public static readonly string SociaEmpresariaSuscritaActivaCancelarSuscripcion = "SESuscritaActivaCancelarSuscripcion";
                #endregion
            }

            public static class RDR
            {
                public const string BloquearProductoGnd = "BloquearProductoGnd";
            }

            public static class RDI
            {

                public const string LogoMenuRevistaDigitaIntrigaNoActivo = "LogoMenuRevistaDigitaIntrigaNoActivo";
                public const string LogoMenuRevistaDigitaIntrigaActiva = "LogoMenuRevistaDigitaIntrigaActiva";

                public const string LogoMenuOfertas = "LogoMenuOfertas";
                public const string DBienvenidaIntriga = "DBienvenidaIntriga";
                public const string MBienvenidaIntriga = "MBienvenidaIntriga";
                public const string LogoComercial = "LogoComercial";
                public const string LogoComercialFondo = "LogoComercialFondo";
                public const string NombreComercial = "NombreComercial";
                public const string DCatalogoIntriga = "DCatalogoIntriga";
                public const string MCatalogoIntriga = "MCatalogoIntriga";
                public const string DPedidoIntriga = "DPedidoIntriga";
                public const string MPedidoIntriga = "MPedidoIntriga";
                public const string DLandingBannerIntriga = "DLandingBannerIntriga";
                public const string MLandingBannerIntriga = "MLandingBannerIntriga";
            }

            public static class HV
            {
                #region Revista Digital Popup Bloqueado
                public const string DPopupBloqueado = "DPopupBloqueado";
                public const string MPopupBloqueado = "MPopupBloqueado";
                #endregion
            }
        }

        public static class ConfiguracionSeccion
        {
            public static class TipoPresentacion
            {
                public const int CarruselSimple = 1;// Ejm OPT en RDI
                public const int SimpleCentrado = 3;// Ejm HV
                public const int Banners = 4;
                public const int ShowRoom = 5;
                public const int OfertaDelDia = 6;
                public const int DescagablesNavidenos = 7;
                public const int CarruselIndividuales = 8; // Ejm LAN
                public const int CarruselIndividualesV2 = 9; // Ejm GM
            }
        }

        public static class TooltipLoginUsuario
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

        public static class TipoOfertasPlan20
        {
            public const int OfertaFinal = 35;
            public const int Showroom = 44;
            public const int OPT = 45;
            public const int ODD = 46;
            public const int TablaLogicaId = 130;
        }

        public static class TipoBusqueda
        {
            public const int Aproximacion = 1;
            public const int Exacta = 2;
        }

        public static class TooltipLoginPassword
        {
            public const string BO = "Si es la primera vez que ingresas, es<br/>el número de tu Carné de Identidad,<br/>con las 3 letras de la extensión del<br/>lugar de emisión.";
            public const string CL = "Si es la primera vez que ingresas, es<br/>tu código de consultora de 7 dígitos<br/>(incluido el 0 inicial, si lo tuviera).";
            public const string CO = "El número de tu<br/>cédula de identidad.";
            public const string DO = "Los 4 últimos dígitos de<br/>tu Cédula de Identidad<br/>(sin guiones).";
            public const string EC = "El número de tu<br/>cédula de identidad.";
            public const string MX = "Los 4 últimos dígitos de<br/>tu código de consultora.<br/><b>Recuerda cambiar tu<br/>clave por seguridad.</b>";
            public const string PE = "Si es la primera vez que<br/>ingresas, es tu número<br/>de DNI.";
            public const string PR = "Los 4 últimos dígitos de<br/>tu Seguro Social(sin guiones).";
            public const string VE = "Los 4 últimos dígitos de<br/>tu Cédula de Identidad.";
            public const string CAM = "Si es la primera vez<br/>que ingresas, son los<br/>4 últimos dígitos de tu<br/>documento de identidad.";
        }

        public static class SessionNames
        {
            // Lista de estrategias en session para OPT y BPT 
            public const string ListaEstrategia = "ListadoEstrategiaPedido";
            public const string ProductoTemporal = "ProductoTemporal";

            public const string FichaProductoTemporal = "FichaProductoTemporal";
        }

        public static class SeccionBienvenida
        {
            public const string Home = "Home";
            public const string Belcorp = "Belcorp";
            public const string MisOfertas = "MisOfertas";
            public const string MisAcademia = "MiAcademia";
            public const string Footer = "Footer";
        }

        public static class EstadoRDSuscripcion
        {
            public const int SinRegistroDB = 0;
            public const int Activo = 1;
            public const int Desactivo = 2;
            public const int NoPopUp = 3;
        }

        public struct TablaLogica
        {
            public const int PersonalizacionODD = 93;
            public const int Plan20 = 98;
            public const int CDRExpress = 104;

            public const int CorreoFeedbackAppConsultora = 105;

            /// <summary>
            /// Variables configurables del app
            /// </summary>
            public const short App = 106;

            public static class Keys
            {
                /// <summary>
                /// Codigo de cantidad Maxima de Movimientos
                /// </summary>
                public const string MovimientoCantidadMaxima = "mov_max_c";

                /// <summary>
                /// Codigo de movimientos de meses anteriores a procesar
                /// </summary>
                public const string MovimientoHistoricoMes = "mov_max_m";

                /// <summary>
                /// Codigo de cantidad maxima de Notas
                /// </summary>
                public const string NotaCantidadMaxima = "not_max_c";
            }

            public const short RevistaDigital = 131;
            public const short CodigoRevistaFisica = 132;
            public const short Palanca = 135;
            public const int ValoresImagenesResize = 121;
            public const short ExtensionBannerGanaMasApp = 136;
            public const short MontoLimiteCupon = 103;
            public const int ValoresPagoEnLinea = 122;
            public const int CantidadCuvMasivo = 137;
            public const short ProlObsCod = 5;
            public const int ActualizaDatosEnabled = 143;
            public const short HabilitarChatEmtelco = 144;
            public const short OrdenamientoShowRoom = 99;
            public const short NuevaDescripcionProductos = 145;
            public const short MensajesToolTipPerfil = 10;
            public const short EscalaDescuentoDestokp = 72;
            public const short EscalaDescuentoMobile = 73;
            public const short ListaOrdenamientoFiltros = 147;
            public const short ArmaTuPack = 14;
        }

        public struct MensajesCDRExpress
        {
            public const string RegularPrincipal = "Regular1";
            public const string RegularAdicional = "Regular2";
            public const string ExpressPrincipal = "Express1";
            public const string ExpressFlete = "Express2";
            public const string ExpressAdicional = "Express3";
            public const string ExpressFleteCero = "Express4";
            public const string Nuevas = "Nuevas1";
        }


        #region Clientes
        public struct ClienteTipoContacto
        {
            public const short Celular = 1;
            public const short TelefonoFijo = 2;
            public const short Correo = 3;
            public const short Direccion = 4;
            public const short Referencia = 5;
        }

        public static class ClienteCelularValidacion
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

        public static class ClienteTelefonoValidacion
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

        public static class ClienteValidacion
        {
            private static Dictionary<string, string> _Message;

            public static class Code
            {
                public const string ErrorGeneral = "-1";
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
                public const string ERROR_CLIENTEASOCIADOPEDIDO = "13";
                public const string ERROR_TIPOCONTACTOREPETIDO = "14";
                public const string ERROR_NOTAINVALIDA = "15";
                public const string ERROR_MOVIMIENTOINVALIDO = "16";
                public const string ERROR_NOTACANTIDADMAXIMA = "17";

                public const string ERROR_MOVIMIENTODETALLE_NOACTUALIZADO = "18";
                public const string ERROR_MOVIMIENTODETALLE_PEDIDOWEBFACTURADOID_NOENVIADO = "19";
                public const string ERROR_MOVIMIENTODETALLE_CANTIDAD_NOENVIADO = "20";
                public const string ERROR_MOVIMIENTODETALLE_PRECIOUNIDAD_NOENVIADO = "21";
                public const string ERROR_RECORDATORIOINVALIDA = "22";
            }

            public static Dictionary<string, string> Message
            {
                get
                {
                    return _Message ?? (_Message = new Dictionary<string, string>
                    {
                        {Code.ErrorGeneral, "No se pudo procesar su solicitud."},
                        {Code.SUCCESS, "OK"},
                        {Code.ERROR_FORMATOTELCELULAR, "Formato de número de teléfono celular incorrecto."},
                        {Code.ERROR_FORMATOTELFIJO, "Formato de número de teléfono fijo incorrecto."},
                        {Code.ERROR_NOMBRENOENVIADO, "Campo Nombres no fue enviado."},
                        {Code.ERROR_NUMEROTELEFONONOENVIADO, "El cliente debe tener un teléfono de contacto."},
                        {Code.ERROR_FORMATOCORREO, "Formato de correo incorrecto."},
                        {Code.ERROR_CONTACTOSNOENVIADO, "Campo Contactos no fue enviado."},
                        {Code.ERROR_TIPOCONTACTOVALORNOENVIADO, "Campo Tipo Contacto {0} Valor no fue enviado."},
                        {Code.ERROR_CONSULTORANOMBREEXISTE, "El nombre ya se encuentra registrado para otro cliente."},
                        {Code.ERROR_CONSULTORATELEFONOEXISTE, "El número de teléfono ya se encuentra registrado para otro cliente."},
                        {Code.ERROR_NUMEROTELEFONOEXISTE, "El número de teléfono ya se encuentra registrado en nuestra base."},
                        {Code.ERROR_CLIENTENOREGISTRADO, "El cliente no fue registrado."},
                        {Code.ERROR_CLIENTENOACTUALIZADO, "El cliente no fue actualizado."},
                        {Code.ERROR_CLIENTEASOCIADOPEDIDO, "No es posible eliminar al cliente dado que se encuentra asociado a un pedido."},
                        {Code.ERROR_TIPOCONTACTOREPETIDO, "El contacto se encuentra repetido para el cliente."},
                        {Code.ERROR_NOTAINVALIDA, "Nota invalida, no se pudo procesar"},
                        {Code.ERROR_MOVIMIENTOINVALIDO, "Movimiento invalido, no se pudo procesar"},
                        {Code.ERROR_RECORDATORIOINVALIDA, "Recordatorio invalido, no se pudo procesar"},

                        {Code.ERROR_MOVIMIENTODETALLE_NOACTUALIZADO, "El detalle de movimiento no fue actualizado."},
                        {Code.ERROR_MOVIMIENTODETALLE_PEDIDOWEBFACTURADOID_NOENVIADO, "El campo PedidoWebFacturadoID debe ser mayor que 0(cero)."},
                        {Code.ERROR_MOVIMIENTODETALLE_CANTIDAD_NOENVIADO, "El campo Cantidad debe ser mayor que 0(cero)."},
                        {Code.ERROR_MOVIMIENTODETALLE_PRECIOUNIDAD_NOENVIADO, "El campo PrecioUnidad debe ser mayor que 0(cero)."},
                    });
                }
            }
        }

        public static class MvcErrorMessages
        {
            public const string RequiredMessage = "Este campo es obligatorio";
            public const string RangeErrorMessage = "El campo {0} debe ser una cadena con una longitud mínima de {2} y una longitud máxima de {1}";
            public const string MaxErrorMessage = "El campo {0} debe ser una cadena con una longitud máxima de {1}";
            public const string LengthErrorMessage = "El campo {0} debe ser una cadena con una longitud de {1}";
            public const string DateErrorMessage = "No es una fecha válida";
            public const string NumberErrorMessage = "No es un número válido";
        }

        public static class ClienteEstado
        {
            public const short Activo = 1;
            public const short Inactivo = 0;
        }

        public static class ClienteTipoRegistro
        {
            public const short Todos = 0;
            public const short DatosGenerales = 1;
            public const short TipoContacto = 2;
        }

        public static class ClienteOrigen
        {
            public const string Desktop = "SOMOS_BELCORP_DESKTOP";
            public const string Mobile = "SOMOS_BELCORP_MOBILE";

            public const string OrigenDesktop = "Desktop";
            public const string OrigeMobile = "Mobile";
        }
        #endregion

        public static class MovimientoTipo
        {
            /// <summary>
            /// Abono
            /// </summary>
            public const string Abono = "A";

            /// <summary>
            /// Cargo
            /// </summary>
            public const string Cargo = "C";

            /// <summary>
            /// Cargo belcorp
            /// </summary>
            public const string CargoBelcorp = "CB";

            /// <summary>
            /// Historico belcorp, no editable desde la api
            /// </summary>
            public const string Historico = "H";

            public static string[] Todos
            {
                get
                {
                    return new[]
                    {
                        Abono, Cargo, CargoBelcorp, Historico
                    };
                }
            }
        }

        public static class Incentivo
        {
            public const string TeFaltan = "Te faltan {0}* puntos";
            public const string NoTenemosConcurso = "NO TENEMOS CONCURSO ESTA CAMPAÑA Estamos preparando una gran sorpresa … ";
            public const string VasXPuntos = "VAS {0}* PUNTOS.";
            public const string GANASTE = "¡GANASTE!";
            public const string TEFALTA = "¡TE FALTA!";
            public const string LlegasteAPuntosRequeridos = "¡Llegaste a los {0}* puntos requeridos!";
            public const string LlegasteAPuntosRequeridosNivel = "¡Llegaste a los {0}* puntos requeridos del nivel {1}!";
            public const string PuedesLlevarAdicionalmentePremio = "¡Puedes llevarte adicionalmente el premio del nivel {0}!";
            public const string PuedesLlevarPremio = "¡Puedes llevarte el premio del nivel {0}!";
            public const string CompraENBelcenter = "Compra en Belcenter hasta el {0} {1} y llévate el premio.";
            public const string IndicadorPremiacion = "Pasa pedido esta campaña para enviártelo";
            public const string MontoPremiacion = "Pasa pedido de {0} {1} esta campaña para entregarte tu premio.";
            public const string CalculoPuntos = "X;K";
            public const string CalculoProgramaNuevas = "P";
        }

        public static class ComunicadoTipoDispositivo
        {
            public const short Todos = 0;
            public const short Desktop = 1;
            public const short Mobile = 2;
        }

        public static class ProveedorAutenticacion
        {
            public const string Facebook = "Facebook";
        }

        public static class TipoTerminosCondiciones
        {
            public const short AppTerminosCondiciones = 1;
            public const short AppPoliticaPrivacidad = 2;
        }

        #region EventoFestivo
        public static class EventoFestivoAlcance
        {
            public const string LOGIN = "LOGIN";
            public const string SOMOS_BELCORP = "SOMOS_BELCORP";
            public const string MENU_SOMOS_BELCORP = "MENU_SOMOS_BELCORP";
        }

        public static class EventoFestivoNombre
        {
            public const string FONDO_ESIKA = "FONDO_ESIKA";
            public const string FONDO_LBEL = "FONDO_LBEL";
            public const string SALUDO = "SALUDO";
            public const string FONDO_INGPED = "FONDO_INGPED";
            public const string GIF_MENU_OFERTAS = "GIF_MENU_OFERTAS";
            public const string GIF_MENU_OFERTAS_BPT_GANA_MAS = "GIF_MENU_OFERTAS_BPT_GANA_MAS";
            public const string GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS = "GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS";
            public const string RD_SI_D_ImagenLogo = "RD_SI_D_ImagenLogo";
            public const string RD_SI_D_ImagenFondo = "RD_SI_D_ImagenFondo";
            public const string RD_SI_D_TituloBanner = "RD_SI_D_TituloBanner";
            public const string RD_SI_D_SubTituloBanner = "RD_SI_D_SubTituloBanner";
            public const string RD_SI_M_ImagenLogo = "RD_SI_M_ImagenLogo";
            public const string RD_SI_M_ImagenFondo = "RD_SI_M_ImagenFondo";
            public const string RD_SI_M_TituloBanner = "RD_SI_M_TituloBanner";
            public const string RD_SI_M_SubTituloBanner = "RD_SI_M_SubTituloBanner";
            public const string RD_NO_D_ImagenLogo = "RD_NO_D_ImagenLogo";
            public const string RD_NO_D_ImagenFondo = "RD_NO_D_ImagenFondo";
            public const string RD_NO_D_TituloBanner = "RD_NO_D_TituloBanner";
            public const string RD_NO_D_SubTituloBanner = "RD_NO_D_SubTituloBanner";
            public const string RD_NO_M_ImagenLogo = "RD_NO_M_ImagenLogo";
            public const string RD_NO_M_ImagenFondo = "RD_NO_M_ImagenFondo";
            public const string RD_NO_M_TituloBanner = "RD_NO_M_TituloBanner";
            public const string RD_NO_M_SubTituloBanner = "RD_NO_M_SubTituloBanner";
        }
        #endregion

        /* 
         * Url del contenedor
         * Usar solo minusculas. 
         */
        public static class UrlMenuContenedor
        {
            public const string Inicio = "/ofertas";
            public const string InicioIndex = "/ofertas/index";
            public const string InicioRevisar = "/ofertas/revisar";
            public const string RdInicio = "/revistadigital";
            public const string RdInicioIndex = "/revistadigital/index";
            public const string RdComprar = "/revistadigital/comprar";
            public const string RdRevisar = "/revistadigital/revisar";
            public const string RdInformacion = "/revistadigital/informacion";
            public const string SwInicio = "/showroom";
            public const string SwInicioIndex = "/showroom/index";
            public const string SwIntriga = "/showroom/intriga";
            public const string SwPersonalizado = "/showroom/personalizado";
            public const string OfertaDelDia = "/ofertadeldia";
            public const string OfertaDelDiaIndex = "/ofertadeldia/index";
            public const string GuiaDeNegocio = "/guianegocio";
            public const string GuiaDeNegocioIndex = "/guianegocio/index";
            public const string HerramientasVentaIndex = "/herramientasventa/index";
            public const string HerramientasVentaRevisar = "/herramientasventa/revisar";
            public const string HerramientasVentaComprar = "/herramientasventa/comprar";
            public const string MasGanadorasIndex = "/masganadoras/index";
            public const string MasGanadoras = "/masganadoras";
            // Url Ficha
            public const string DetalleHerramientasVenta = "/detalle/demostradores";
            public const string DetalleLanzamiento = "/detalle/lonuevonuevo";
            public const string DetalleOfertaParaTi = "/detalle/ofertaparati";
            public const string DetalleOfertasParaMi = "/detalle/ofertasparami";
            public const string DetalleGuiaDeNegocioDigitalizada = "/detalle/guiadenegocio";
            public const string DetalleShowRoom = "/detalle/especiales";
            public const string DetalleOfertaDelDia = "/detalle/solohoy";
            public const string DetallePackNuevas = "/detalle/packnuevas";
            public const string ProgramaNuevas = "/programanuevas";
            public const string ProgramaNuevasIndex = "/programanuevas/index";
            public const string DetalleMasGanadoras = "/detalle/ganadoras";

        }

        public static class TipoVistaEstrategia
        {
            public const int Todos = 0;
            public const int ProgramaNuevas = 1;
        }

        public static class Canal
        {
            public const string Mobile = "M";
            public const string Desktop = "W";
        }

        public static class ArchivosDescargables
        {
            public const string TARJETA_NAVIDENA = "2017_Navidad_Tarjeta.pdf";
            public const string PAPEL_REGALO_DORADO = "2017_Navidad_Regalo1.pdf";
            public const string PAPEL_REGALO_ROJO = "2017_Navidad_Regalo2.pdf";
        }

        public static class TagCadenaRd
        {
            public const string Nombre = "#NOMBRE";
            public const string Nombre1 = "#Nombre";
            public const string Nombre2 = "#nombre";
            public const string Campania = "#Campania";

            public const string CampaniaActual = "#CX";
            public const string CampaniaVer = "#CX1";
            public const string CampaniaSuscripcion = "#CS";
            public const string CampaniaActiva = "#CS1";
        }

        public static class ConfiguracionImagenResize
        {
            public const string ExtensionNombreImagenSmall = "_small";
            public const string ExtensionNombreImagenMedium = "_medium";
            public const int WidthImagenSmall = 125;
            public const int HeightImagenSmall = 125;
            public const int WidthImagenMedium = 250;
            public const int HeightImagenMedium = 250;
            public const string TipoImagenSmall = "SMALL";
            public const string TipoImagenMedium = "MEDIUM";
            public const string ValorTextoDefaultAppCatalogo = "appcatalogo";
        }

        public static class RecuperacionPedido
        {
            public const string Mensaje = "Nos es grato comunicarte que hemos podido recuperar productos de la anterior campaña con el precio original. " +
                "Están agregados en tu pedido bajo la descripción RECUPC16.Puedes mantenerlos para recibirlos con tu caja de C17 o borrarlos de tu pedido si ya no los necesitas.";
        }

        public static class ProgNuevas
        {
            public const string CarpetaBanner = "AppConsultora/{0}/ProgramaNuevas/{1}";
            public const string ArchivoBannerCupones = "Cupon{0}_{1}.jpg";
            public const string ArchivoBannerPremios = "Premio{0}_{1}.jpg";

            public static class TipoBanner
            {
                public const short BannerCupon = 1;
                public const short BannerPremio = 2;
            }

            public static class EncenderValidacion
            {
                public const short TablaLogicaID = 7;
                public const string FlagProgNuevas = "ProgramaNuevas";
                public const string FlagBannerElecMultiple = "BannerElecMultiple";
            }

            public static class Rango
            {
                public const short TablaLogicaID = 6;
                public const string cuvInicio = "cuvInicio";
                public const string cuvFinal = "cuvFinal";
            }

            public static class Mensaje
            {
                public const string KitNueva_Pedido1Unico = "Este Kit se agrega automáticamente sólo en tu primer pedido.";
                public const string KitNueva_Pedido1 = "Este Kit se agrega automáticamente en tu primer pedido.";
                public const string KitNueva_Pedido2 = "Este Kit se agrega automáticamente en tu segundo pedido.";
                public const string KitNueva_Pedido3 = "Este Kit se agrega automáticamente en tu tercer pedido.";
                public const string ConsultoraNoNueva = "El código solicitado es exclusivo para quienes participan del Programa de Nuevas.";
                public const string CuvNoPerteneceASuPrograma = "El codigo ingresado es incorrecto. Revise el folleto del Programa de Nuevas y solicite el que le corresponde.";
                public const string ExcedeLimiteUnidades = "Las unidades ingresadas exceden el máximo permitido ({0}) en esta campaña";
                public const string Electivo_PromocionNombre = "Dúo Perfecto";
                public const string Electivo_NoAgregarPorLimite = "Ya no puedes añadir otro producto, tu {0} está completo.";
                public const string Electivo_CompletasteLimite = "¡Completaste tu {0}!";
                public const string Electivo_TeFaltaPocoLimite = "¡Agregaste 1 producto, te falta {0} para completar tu {1}!";
                public const string ElecMultiple_ConfirmaEliminar = "Si eliminas este producto te quedarás sin tu {0}";
            }
        }

        public static class VentaExclusiva
        {
            public const string CuvNoEsVentaExclusiva = "El código solicitado pertenece a la Venta Exclusiva. Usted no cumple las condiciones para solicitarlo.";

            public static class EncenderValidacion
            {
                public const short TablaLogicaID = 7;
                public const string FlagActivar = "VentaExclusiva";
            }
        }

        public static class Comunicado
        {
            public const string AppConsultora = "App Consultora";
            public const string BannerDescargarAppNuevas = "BannerDescargarAppNuevas";
            public const string Extraordinarios = "App Consultora,BannerDescargarAppNuevas";
        }
        public static class ColumnsSetStrategyShowroom
        {
            public const string CUV = "cuv";
            public const string NormalPrice = "precio normal";
            public const string AllowedUnits = "unidades permitidas";
            public const string NameSet = "nombre de set";
            public const string BusinessTip = "tip negocio";
            public const string IsSubcampaign = "essubcampania";
            public const string OfferStatus = "estado de oferta";

            public enum Position
            {
                CUV = 0,
                AllowedUnits = 1,
                NameSet = 2,
                BusinessTip = 3,
                IsSubcampaign = 4,
                OfferStatus = 5
            };
        }

        public static class ColumnsProductStrategyShowroom
        {
            public const string CUV = "cuv";
            public const string Order = "posicion";
            public const string ProductName = "nombre producto";
            public const string Description = "descripcion";
            public const string BrandProduct = "marca producto";
            public enum Position { CUV = 0, Order = 1, ProductName = 2, Description = 3, BrandProduct = 4 };
        }

        public static class GanaMas
        {
            public const short PaisSinRD = 1;
            public const short PaisConRD_SuscritaActiva = 2;
            public const short PaisConRD_SuscritaNoActiva = 3;
            public const short PaisConRD_NoSuscritaActiva = 4;
            public const short PaisConRD_NoSuscritaNoActiva = 5;

            public static class Banner
            {
                public const string CarpetaPais = "AppConsultora/{0}";
                public const string ImagenSuscrita = "GanaMasSuscrita";
                public const string ImagenNoSuscrita = "GanaMasNoSuscrita";
                public const string TablaLogicaSuscrita = "Suscrita";
                public const string TablaLogicaNoSuscrita = "NoSuscrita";
            }
        }
        public static class ValAutoEstado
        {
            public const int NoExisteProceso = -1;
            public const int Programado = 0;
            public const int EnEjecucion = 1;
            public const int Finalizado = 2;
            public const int FaltaEnvioCorreos = 3;
            public const int Error = 99;
        }
        public static class ValAutoEstadoDescripcion
        {
            public const string NoExisteProceso = "No existen procesos programados.";
            public const string Programado = "Existen procesos programados por ejecutar.";
            public const string EnEjecucion = "El proceso de reserva está en ejecución.";
            public const string Finalizado = "Los procesos programados han sido ejecutados.";
            public const string FaltaEnvioCorreos = "El proceso de envío de correos está en ejecución.";
            public const string Error = "Error en la ejecución de los procesos programados.";
        }
        public static class ValAutoEjecucionResultado
        {
            public const string Inicio = "El proceso de PROL Automático ha iniciado.";
            public const string YaExisteProceso = "El proceso de PROL Automático está en proceso.";
        }
        public static class ValAutoDetalleEstadoDescripcion
        {
            public const string Programado = "Programado";
            public const string EnEjecucion = "En ejecución";
            public const string Finalizado = "Terminado";
            public const string Error = "Error";
        }

        public static class PedidoValidacion
        {
            private static Dictionary<string, PedidoValidacionConfiguracion> _Configuracion;

            public static class Code
            {
                public const string SUCCESS = "0000";
                public const string ERROR_INTERNO = "9999";
                public const string ERROR_PRODUCTO_NOEXISTE = "1101";
                public const string ERROR_PRODUCTO_AGOTADO = "1102";
                public const string ERROR_PRODUCTO_LIQUIDACION = "1103";
                public const string ERROR_PRODUCTO_OFERTAREVISTA_ESIKA = "1106";
                public const string ERROR_PRODUCTO_OFERTAREVISTA_LBEL = "1107";
                public const string ERROR_PRODUCTO_ESTRATEGIA = "1108";
                public const string ERROR_PRODUCTO_SUGERIDO = "1109";
                public const string ERROR_PRODUCTO_SET = "1110";
                public const string ERROR_PRODUCTO_NONUEVA = "1111";
                public const string ERROR_PRODUCTO_NUEVA_NOPERTENECE_TUPROGRAMA = "1112";
                public const string ERROR_PRODUCTO_NOPERTENECE_VENTAEXCLUSIVA = "1113";
                public const string ERROR_PRODUCTO_LIMITE_VENTA = "1114";

                public const string ERROR_RESERVADO_HORARIO_RESTRINGIDO = "2101";
                public const string ERROR_STOCK_ESTRATEGIA = "2102";
                public const string ERROR_KIT_INICIO = "2103";
                public const string ERROR_GRABAR = "2104";
                public const string ERROR_VALIDA_DATOS = "2105";
                public const string ERROR_ACTUALIZAR = "2106";
                public const string ERROR_ELIMINAR = "2107";
                public const string ERROR_ELIMINAR_TODO = "2108";
                public const string ERROR_CANTIDAD_LIMITE = "2111";
                public const string ERROR_ELIMINAR_TODO_SET = "2112";
                public const string ERROR_ELIMINAR_SET = "2113";
                public const string ERROR_ACTUALIZAR_SET = "2114";
                public const string ERROR_SET_NOENCONTRADO = "2115";
                public const string ERROR_UNIDAD_SOBREPASA_PERMITIDO = "2116";
                public const string ERROR_UNIDAD_SINSALDO = "2117";
                public const string ERROR_UNIDAD_CONSALDO = "2118";
                public const string ERROR_UNIDAD_SOBREPASA_STOCK = "2119";               

                public const string ERROR_RESERVA_NINGUNO = "2010";
                public const string SUCCESS_RESERVA = "2011";
                public const string SUCCESS_RESERVA_OBS = "2012";
                public const string ERROR_RESERVA_OBS = "2013";
                public const string ERROR_RESERVA_MONTO_MIN = "2014";
                public const string ERROR_RESERVA_MONTO_MAX = "2015";
                public const string ERORR_RESERVA_NO_DISP = "2016";
                public const string ERROR_RESERVA_DEUDA = "2017";
                public const string ERROR_RESERVA_BACK_ORDER = "2018";

                public const string ERROR_GUARDAR_NINGUNO = "2020";
                public const string SUCCESS_GUARDAR = "2021";
                public const string SUCCESS_GUARDAR_OBS = "2022";
                public const string ERROR_GUARDAR_OBS = "2023";
                public const string ERROR_GUARDAR_MONTO_MIN = "2024";
                public const string ERROR_GUARDAR_MONTO_MAX = "2025";
                public const string ERORR_GUARDAR_NO_DISP = "2026";
                public const string ERROR_GUARDAR_DEUDA = "2027";

                public const string ERROR_DESHACER_PEDIDO = "2109";
                public const string ERROR_DESHACER_PEDIDO_ESTADO = "2110";

                public const string ERROR_AGREGAR_BACKORDER_NO_PERMITIDO = "2201";
                public const string ERROR_AGREGAR_BACKORDER = "2202";

            }

            public static Dictionary<string, PedidoValidacionConfiguracion> Configuracion
            {
                get
                {
                    return _Configuracion ?? (_Configuracion = new Dictionary<string, PedidoValidacionConfiguracion>
                        {
                            {Code.SUCCESS, new PedidoValidacionConfiguracion(){ PermiteAgregarPedido = true, Mensaje = "OK" } } ,
                            {Code.ERROR_INTERNO, new PedidoValidacionConfiguracion() },
                            {Code.ERROR_PRODUCTO_NOEXISTE, new PedidoValidacionConfiguracion(){ Mensaje = "Este producto no existe." } },
                            {Code.ERROR_PRODUCTO_AGOTADO, new PedidoValidacionConfiguracion(){ Mensaje = "Este producto está agotado."} },
                            {Code.ERROR_PRODUCTO_LIQUIDACION, new PedidoValidacionConfiguracion(){ Mensaje = "Este producto solo está disponible desde la sección de Liquidación Web."} },
                            {Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA, new PedidoValidacionConfiguracion(){ PermiteAgregarPedido = true, Mensaje = "Encuentra este producto en la guía de negocio Ésika con oferta especial." } },
                            {Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL, new PedidoValidacionConfiguracion(){ PermiteAgregarPedido = true, Mensaje = "Encuentra este producto en la guía de negocio L'Bel con oferta especial."} },
                            {Code.ERROR_PRODUCTO_ESTRATEGIA, new PedidoValidacionConfiguracion() },
                            {Code.ERROR_PRODUCTO_SUGERIDO, new PedidoValidacionConfiguracion(){ Mensaje = "Este producto tiene reemplazos sugeridos." } },
                            {Code.ERROR_PRODUCTO_SET, new PedidoValidacionConfiguracion(){ Mensaje = "Este producto es una oferta digital. Te invitamos a que revises tu sección de ofertas."} },
                            {Code.ERROR_PRODUCTO_NONUEVA, new PedidoValidacionConfiguracion(){ Mensaje = ProgNuevas.Mensaje.ConsultoraNoNueva } },
                            {Code.ERROR_PRODUCTO_NUEVA_NOPERTENECE_TUPROGRAMA, new PedidoValidacionConfiguracion(){ Mensaje = ProgNuevas.Mensaje.CuvNoPerteneceASuPrograma } },
                            {Code.ERROR_PRODUCTO_NOPERTENECE_VENTAEXCLUSIVA, new PedidoValidacionConfiguracion(){ Mensaje = VentaExclusiva.CuvNoEsVentaExclusiva } },

                            {Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, new PedidoValidacionConfiguracion()},
                            {Code.ERROR_STOCK_ESTRATEGIA, new PedidoValidacionConfiguracion()},
                            {Code.ERROR_KIT_INICIO, new PedidoValidacionConfiguracion(){ Mensaje = Constantes.MensajesError.InsertarValidarKitInicio } },
                            {Code.ERROR_GRABAR, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al insertar el pedido."} },
                            {Code.ERROR_VALIDA_DATOS , new PedidoValidacionConfiguracion() },
                            {Code.ERROR_ACTUALIZAR, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al actualizar el pedido." } },
                            {Code.ERROR_ACTUALIZAR_SET, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al actualizar el set." } },
                            {Code.ERROR_SET_NOENCONTRADO, new PedidoValidacionConfiguracion(){ Mensaje ="Set no encontrado."} },
                            {Code.ERROR_UNIDAD_SOBREPASA_PERMITIDO, new PedidoValidacionConfiguracion(){ Mensaje ="Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta ({0}) del producto."} },
                            {Code.ERROR_UNIDAD_SINSALDO, new PedidoValidacionConfiguracion(){ Mensaje ="Las Unidades Permitidas de Venta son solo ({0}), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique." } },
                            {Code.ERROR_UNIDAD_CONSALDO, new PedidoValidacionConfiguracion(){ Mensaje ="Las Unidades Permitidas de Venta son solo ({0}), pero Usted solo puede adicionar ({1}) más, debido a que ya agregó este producto a su pedido, verifique." } },
                            {Code.ERROR_UNIDAD_SOBREPASA_STOCK, new PedidoValidacionConfiguracion(){ Mensaje ="Lamentablemente, la cantidad solicitada sobrepasa el stock actual ({0}) del producto, verifique." } },
                            {Code.ERROR_ELIMINAR, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al eliminar el detalle de pedido." } },
                            {Code.ERROR_ELIMINAR_SET, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al eliminar el detalle del set."} },
                            {Code.ERROR_ELIMINAR_TODO, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al eliminar el pedido." } },
                            {Code.ERROR_ELIMINAR_TODO_SET, new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al eliminar el set." } },
                            {Code.ERROR_CANTIDAD_LIMITE, new PedidoValidacionConfiguracion(){ Mensaje ="La cantidad no debe ser mayor que la cantidad limite ( {0} )." } },

                            {Code.ERROR_RESERVA_NINGUNO, new PedidoValidacionConfiguracion(){ Mensaje ="El pedido no se reservó." } },
                            {Code.SUCCESS_RESERVA, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido reservado." } },
                            {Code.SUCCESS_RESERVA_OBS, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido reservado, productos con observaciones." } },
                            {Code.ERROR_RESERVA_OBS, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no reservado, productos con observaciones." } },
                            {Code.ERROR_RESERVA_MONTO_MIN, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no reservado, no supera monto mínimo." } },
                            {Code.ERROR_RESERVA_MONTO_MAX, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no reservado, excede monto máximo." } },
                            {Code.ERORR_RESERVA_NO_DISP, new PedidoValidacionConfiguracion(){ Mensaje ="Reserva no disponible." } },
                            {Code.ERROR_RESERVA_DEUDA, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no reservado, deuda pendiente." } },
                            {Code.ERROR_RESERVA_BACK_ORDER, new PedidoValidacionConfiguracion(){ Mensaje ="No contamos con stock de este producto. ¿Deseas que te lo entreguemos en la siguiente campaña? (aplica beneficio solo si facturas en ésta campaña)"} },
                            {Code.ERROR_GUARDAR_NINGUNO, new PedidoValidacionConfiguracion(){ Mensaje ="El pedido no se guardó." } },
                            {Code.SUCCESS_GUARDAR, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido guardado." } },
                            {Code.SUCCESS_GUARDAR_OBS, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido guardado, productos con observaciones." } },
                            {Code.ERROR_GUARDAR_OBS, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no guardado, productos con observaciones." } },
                            {Code.ERROR_GUARDAR_MONTO_MIN, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no guardado, no supera monto mínimo." } },
                            {Code.ERROR_GUARDAR_MONTO_MAX, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no guardado, excede monto máximo." } },
                            {Code.ERORR_GUARDAR_NO_DISP, new PedidoValidacionConfiguracion(){ Mensaje ="Guardar no disponible." } },
                            {Code.ERROR_GUARDAR_DEUDA, new PedidoValidacionConfiguracion(){ Mensaje ="Pedido no guardado, deuda pendiente." } },

                            {Code.ERROR_DESHACER_PEDIDO , new PedidoValidacionConfiguracion(){ Mensaje ="Ocurrió un error al deshacer el pedido." } },
                            {Code.ERROR_DESHACER_PEDIDO_ESTADO , new PedidoValidacionConfiguracion(){ Mensaje ="El pedido no se encuentra reservado." } },

                            {Code.ERROR_AGREGAR_BACKORDER_NO_PERMITIDO , new PedidoValidacionConfiguracion(){ Mensaje ="No se puede agregar un set como BackOrder." } },
                            {Code.ERROR_AGREGAR_BACKORDER , new PedidoValidacionConfiguracion(){ Mensaje ="No se encuentra el detalle en el pedido para agregarlo como BackOrder." } }

                        });
                }
            }
        }

        public class PedidoValidacionConfiguracion
        {
            public PedidoValidacionConfiguracion()
            {
                PermiteAgregarPedido = false;
                Mensaje = string.Empty;
            }
            public bool PermiteAgregarPedido { get; set; }
            public string Mensaje { get; set; }
        }

        public static class PedidoDetalleApp
        {
            public const string DescripcionKitInicio = "KIT DE INICIO";
            public const string OfertaNiveles = "OFERTA POR NIVELES (*)";
            public const string OfertaLiquidacion = "OFERTA LIQUIDACIÓN";
            public const string OfertaFlexiPago = "OFERTA FLEXIPAGO";
            public const int idHerramientaVenta = 3028;
        }


        public static class PedidoAccion
        {
            public const string INSERT = "I";
            public const string UPDATE = "U";
            public const string DELETE = "D";
        }

        public static class FlagRevista
        {
            public const int Valor0 = 0;
            public const int Valor1 = 1;
            public const int Valor2 = 2;
            public const int Valor3 = 3;
        }

        public static class ProlCodigoRechazo
        {
            public const string MontoMinimo = "XXXXX";
            public const string MontoMaximo = "YYYYY";
            public const string Deuda = "ZZZZZ";
        }
        public static class ProlObsCod
        {
            public const string Deuda = "Deuda";
            public const string MontoMinVenta = "MontoMinVenta";
            public const string MontoMinFact = "MontoMinFact";
            public const string MontoMinVentaDesc = "MontoMinVentaDesc";
            public const string MontoMinFactDesc = "MontoMinFactDesc";
            public const string MontoMaximo = "MontoMaximo";
            public const string LimiteVenta0 = "LimiteVenta0";
            public const string LimiteVenta = "LimiteVenta";
            public const string Promocion2003 = "Promocion2003";
            public const string Promocion = "Promocion";
            public const string Reemplazo = "Reemplazo";
            public const string SinStock0 = "SinStock0";
            public const string SinStock = "SinStock";
        }
        public static class ProlSiccObs
        {
            public const string Promocion = "PROMOCION NO CUMPLE";
            public const string Reemplazo = "Reemp. ";
        }
        public static class ProlObsToken
        {
            public const string Simbolo = "{simb}";
            public const string DeudaMonto = "{deuMon}";
            public const string MaximoMonto = "{maxMon}";
            public const string MinimoMonto = "{minMon}";
            public const string DescuentoMonto = "{descMon}";
            public const string DetalleCuv = "{detCuv}";
            public const string LimiteVenta = "{limVen}";
            public const string ReemplazoCuv = "{remCuv}";
            public const string ReemplazoDesc = "{remDes}";
            public const string Stock = "{stock}";
        }

        public static class OpcionesDeVerificacion
        {
            public const int OrigenOlvideContrasenia = 1;
            public const int OrigenVericacionAutenticidad = 2;
            public const int OrigenActulizarDatos = 3;
        }

        public static class CambioCorreoResult
        {
            public const string Valido = "Empieza a disfrutar de todos los beneficios y ofertas que tenemos para ti.<br />Te recomendamos además actualizar tu contraseña por tu seguridad.";
            public const string Invalido = "Esta dirección de correo electrónico ya ha sido activada. ";
        }

        public static class EnviarCorreoYSms
        {
            public const string Activo = "Activo";
            public const string IdEstadoActividad = "IdEstadoActividad";

            public const int Origen_RecuperarClave = 1;
            public const int Origen_Autenticacion = 2;
            public const int Origen_ActualizarCorreo = 3;
            public const int OrigenActualizarCelular = 3;

            public const string OrigenDescripcion = "actualizar datos";

            public const int TipoEnvio_Email = 1;
        }

        #region Olvide Contrasenia
        public static class OlvideContrasenia
        {
            public const int Origen = 1;
            public const string OrigenDescripcion = "Olvide Contraseña";

            public static class TablaLogica
            {
                public const short TablaLogicaID = 8;
                public const string MostarTodasOpciones = "MostarTodasOpciones";
                public const string OpcionEmail = "OpcionEmail";
                public const string OpcionSms = "OpcionSms";
                public const string OpcionChat = "OpcionChat";
                public const string OpcionBelcorpResponde = "OpcionBelcorpResponde";
            }

            public static class CodigoOpciones
            {
                public const string ChatEmtelco = "ChatEmtelco";
                public const string BelcorpResponde = "BelcorpResponde";
            }

            public static class NombreOpcion
            {
                public const int MostrarEmailyCelular = 1;
                public const int MostrarEmail = 2;
                public const int MostrarCelular = 3;
                public const int MostrarChat = 4;
                public const int MostrarBelcorpResponde = 5;
                public const int MostrarMensajeFueraHorario = 6;

            }

            public static class Mensajes
            {
                public const string ErrorPais = "No se ha encontrado el País.";
                public const string ErrorValor = "No se ha encontrado el valor ingresado.";
            }
        }
        #endregion

        #region Verificar Pin Autenticidad
        public static class VerificacionAutenticidad
        {
            public const string OrigenDescripcion = "Verificacion de Autenticidad";

            public static class TablaLogica
            {
                public const short TablaLogicaID = 139;
                public const string Activar = "Activar";
                public const string TieneZona = "TieneZona";
                public const string OpcionEmail = "OpcionEmail";
                public const string OpcionSms = "OpcionSms";
                public const string IdEstadoActividad = "IdEstadoActividad";
            }

            public static class NombreOpcion
            {
                public const int MostrarEmailyCelular = 1;
                public const int MostrarEmail = 2;
                public const int MostrarCelular = 3;
                public const int MostrarChat = 4;

                public const int SinOpcion = 5;
            }

            public const int Origen = 2;
        }

        public static class EnviarSMS
        {
            public static class CredencialesProvedoresSMS
            {
                public const short TablaLogicaID = 133;
                public static class Bolivia
                {
                    public const string USUARIO = "USUARIO";
                    public const string CLAVE = "CLAVE";
                    public const string URL = "URL";
                    public const string RECURSO = "RECURSO";
                    public const string MENSAJE = "MENSAJE";
                    public const string MENSAJE_OPTIN = "MENSAJE_OPTIN";
                }
            }

            public static class SmsConsultoraWs
            {
                public const string urlKey = "SmsConsultorasWS";
                public const string RecursoApi = "Api/EnviarSms";
            }

            public static class Mensaje
            {
                public const string NoEnviaSMS = "Mensaje de texto no enviado, inténtelo mas tarde.";
            }
        }

        public static class EnviarEmail
        {
            public const string NoEnvioEmail = "Email no se ha enviado, inténtelo mas tarde.";
        }

        public static class TipoEnvioEmailSms
        {
            public const string EnviarPorEmail = "Email";
            public const string EnviarPorSms = "SMS";
        }
        #endregion

        public static class ValidacionDatosEstado
        {
            public const string Pendiente = "P";
            public const string Activo = "A";
        }

        public static class TipoConsultaOfertaPersonalizadas
        {
            public const int RDObtenerProductos = 1;
            public const int LANObtenerProductos = 2;
            public const int GNDObtenerProductos = 3;
            public const int HVObtenerProductos = 4;
            public const int OPTObtenerProductos = 5;
            public const int NuevasObtenerProductos = 6;
            public const int MGObtenerProductos = 7;
            public const int SRObtenerProductos = 8;
        };

        #region PagoEnLinea

        public static class PagoEnLineaTipoPago
        {
            public const string PagoTotal = "01";
            public const string PagoParcial = "02";
        }

        public static class PagoEnLineaMetodoPagoVisualizacionTyC
        {
            public const string Popup = "POPUP";
            public const string Archivo = "ARCHIVO";
        }

        public static class PagoEnLineaMetodoPago
        {
            public const string PasarelaVisa = "A";
            public const string PasarelaBelcorpPayU = "B";
        }

        public static class PagoEnLineaTipoTarjeta
        {
            public const string Credito = "CRED";
            public const string Debito = "DEB";
        }

        public static class PagoEnLineaPasarela
        {
            public const string Visa = "VISA";
            public const string PBI = "PBI";
        }

        public static class PagoEnLineaNotificacion
        {
            public const string Email_Notifier = "no-responder@somosbelcorp.com";
            public const string Email_Titulo = "PAGO EN LINEA";
            public const string Email_Template = "bin\\Templates\\mailing_pago_en_linea.html";
        }

        public static class PagoEnLineaPasarelaVisa
        {
            public const string MerchantId = "01";
            public const string AccessKeyId = "02";
            public const string SecretAccessKey = "03";
            public const string UrlSessionBotonPago = "04";
            public const string UrlGenerarNumeroPedido = "05";
            public const string PorcentajeGastosAdministrativos = "06";
            public const string UrlLibreriaPagoVisa = "07";
            public const string UrlAutorizacionBotonPago = "08";
            public const string UrlLogoPasarelaPago = "09";
            public const string ColorBotonPagarPasarelaPago = "10";
            public const string MensajeInformacionPagoExitoso = "11";
            public const string MontoMinimoPago = "13";
            public const string UrlAutorizacionPagoApp = "14";
            public const string UrlTerminosUsoApp = "15";

            public const string Recurrence = "FALSE";
            public const string RecurrenceAmount = "0.00";

            public static class Code
            {
                public const string CodigoError_Success = "0";
                public const string CodigoAccion_Success = "000";
            }
        }

        public static class PagoEnLineaRespuestaServicio
        {
            private static Dictionary<string, string> _Message;

            public static class Code
            {
                public const string SUCCESS = "0000";
                public const string SUCCESS_YA_AGREGADO = "0001";
            }

            public static Dictionary<string, string> Message
            {
                get
                {
                    return _Message ?? (_Message = new Dictionary<string, string>
                    {
                        {Code.SUCCESS, "Pago en Línea registrado con éxito."},
                        {Code.SUCCESS_YA_AGREGADO, "Pago en Línea ya fue registrado anteriormente."},
                    });
                }
            }
        }

        public static class PagoEnLineaPasarelaPayu
        {
            public const string MerchantId = "PayuMerchantId";
            public const string ApiLogin = "PayuApiLogin";
            public const string ApiKey = "PayuApiKey";
            public const string AccountId = "PayuAccountId";
            public const string Endpoint = "PayuEndpoint";
            public const string Test = "PayuTest";
            public const string PorcentajeGastosAdministrativos = "07";
            public const string MontoMinimoPago = "08";

        }

        public static class PagoEnLineaCampos
        {
            public const string FechaNacimiento = "FECHANAC";
            public const string Email = "EMAIL";
            public const string Celular = "CELULAR";
        }

        public static class PagoEnLineaPayuGenerales
        {
            public const string Language = "es";
            public const string Command = "SUBMIT_TRANSACTION";
            public const string OrderCodePrefix = "Pago_SB_";
            public const string OrderDescription = "Pago_SB";
            public const string OrderLanguage = "es";
            public const string Country = "MX";
            public const string Currency = "MXN";
            public const string TransactionType = "AUTHORIZATION_AND_CAPTURE";
            public const string DefaultCity = "Mexico";
        }

        public static class PagoEnLineaResultadoLog
        {
            public const int Accion_Insert = 1;
        }

        public static class PagoEnLineaMensajes
        {
            private static Dictionary<int, string> _GastosLabel;

            public const string CargoplataformaPe = "Cargo plataforma online";
            public const string CargoplataformaMx = "Comisión por transacción";

            public const string GastosLabelPe = "Gastos Adm.";
            public const string GastosLabelMx = "Cargo comisión por transacción";

            public static Dictionary<int, string> GastosLabel
            {
                get
                {
                    return _GastosLabel ?? (_GastosLabel = new Dictionary<int, string>
                    {
                        {PaisID.Peru, GastosLabelPe},
                        {PaisID.Mexico, GastosLabelMx},
                    });
                }
            }

        }

        public static class MensajePago
        {
            public const string MensajeGeneral = "Paga en Línea con Visa";
            public const string MensajeMx = "Paga en Línea";
        }

        public static class PagoEnLineaOrigen
        {
            public const string OrigenDesktop = "Desktop";
            public const string OrigeMobile = "Mobile";
        }

        #endregion

        public static class PersonalizacionOfertasService
        {
            #region Administrar Estrategia

            /// <summary>
            /// api/Estrategia/listar/{pais}/{tipo}/{campania}
            /// </summary>
            public const string UrlListarWebApi = "api/estrategia/listar/{0}/{1}/{2}";

            /// <summary>
            /// api/Estrategia/contar/{pais}/{tipo}/{campania}
            /// </summary>
            public const string UrlCantidadOfertas = "api/estrategia/contar/{0}/{1}/{2}";

            /// <summary>
            /// api/Estrategia/precargar/{pais}/{tipo}/{campania}
            /// </summary>
            public const string UrlPreCargarWebApi = "api/estrategia/precargar/{0}/{1}/{2}";

            /// <summary>
            /// api/Estrategia/cargar/{pais}
            /// </summary>
            public const string UrlCargarWebApi = "api/estrategia/cargar/{0}?usuario={1}";

            /// <summary>
            /// api/Estrategia/{pais}/{id} --REVISAR
            /// </summary>
            public const string UrlFiltrarEstrategia = "api/estrategia/{0}/{1}";

            /// <summary>
            /// api/Estrategia/editar/{pais}
            /// </summary>
            public const string UrlEditarWebApi = "api/estrategia/editar/{0}?prod={1}&perfil={2}";

            /// <summary>
            /// api/Estrategia/deshabilitar/{pais}/{id}?Usuario=
            /// </summary>
            public const string UrlDesactivarWebApi = "api/estrategia/deshabilitar/{0}/{1}?Usuario={2}";

            /// <summary>
            /// api/Estrategia/desactivar/{pais}/{tipo}
            /// </summary>
            public const string UrlActivarDesactivarEstrategias = "api/estrategia/activardesactivar/{0}/{1}";

            /// <summary>
            /// api/Estrategia/descripcion/{pais}/{tipo}/{campania}
            /// </summary>
            public const string UrlUploadCsv = "api/estrategia/descripcion/{0}/{1}/{2}";

            /// <summary>
            /// api/Estrategia/cuv/{pais}/{tipo}/{campania}/{cuv}
            /// </summary>
            public const string UrlEstrategiaCuv = "api/estrategia/cuv/{0}/{1}/{2}/{3}";

            /// <summary>
            /// api/Estrategia/registrar/{pais}
            /// </summary>
            public const string UrlRegistrarWebApi = "api/estrategia/registrar/{0}";

            /// <summary>
            /// api/TipoEstrategia/editar/{pais}
            /// </summary>
            public const string UrlEditarTipoEstrategiaWebApi = "api/tipo/editar/{0}";

            /// <summary>
            /// api/TipoEstrategia/registrar/{pais}
            /// </summary>
            public const string UrlRegistrarTipoEstrategiaWebApi = "api/tipo/registrar/{0}";

            /// <summary>
            /// api/Estrategia/multiple/{pais}
            /// </summary>
            public const string UrlListarEstrategiaPorConfigurarWebApi = "api/Estrategia/multiple/{0}";

            /// <summary>
            /// api/Evento/eliminar/{pais}/{id}
            /// </summary>
            public const string UrlEliminarShowRoomEvento = "api/Evento/eliminar/{0}/{1}";

            /// <summary>
            /// api/Evento/listar/{pais}/{campania}
            /// </summary>
            public const string UrlConsultarShowRoom = "api/Evento/listar/{0}/{1}";

            /// <summary>
            /// api/Evento/deshabilitar/{pais}/{id}?usuario={usuario}
            /// </summary>
            public const string UrlDeshabilitarShowRoomEvento = "api/Evento/deshabilitar/{0}/{1}?usuario={2}";

            /// <summary>
            /// api/Evento/personalizacion/guardar/{pais}/{idevento}
            /// </summary>
            public const string UrlEventoPersonalizacion = "/api/Evento/personalizacion/guardar/{0}/{1}";

            /// <summary>
            /// api/Estrategia/descripcion/{pais}/{tipo}/{campania}?tipoEstrategia={tipoEstrategia}&usuario={usuario}
            /// </summary>
            public const string UrlUploadFileSetStrategyShowroom = "api/Estrategia/descripcion/{0}/{1}/{2}?tipoEstrategia={3}&usuario={4}";

            /// <summary>
            /// api/Componente/descripcion/{pais}/{tipo}/{campania}?usuario={usuario}
            /// </summary>
            public const string UrlUploadFileProductStrategyShowroom = "api/Componente/descripcion/{0}/{1}/{2}?usuario={3}";

            /// <summary>
            /// api/Evento/registrar/{pais}
            /// </summary>
            public const string UrlGuardarShowRoom = "api/Evento/registrar/{0}";

            /// <summary>
            /// api/Evento/editar/{pais}
            /// </summary>
            public const string UrlUpdateShowRoomEvento = "api/Evento/editar/{0}";

            /// <summary>
            /// api/Estrategia/eliminar/{pais}?id={id}
            /// </summary>
            public const string UrlEliminarEstrategia = "api/Estrategia/eliminar/{0}?id={1}";

            /// <summary>
            /// api/Componente/deshabilitar/{pais}
            /// </summary>
            public const string UrlEliminarOfertaShowRoomDetalleNew = "api/Componente/deshabilitar/{0}";

            /// <summary>
            /// api/Componente/editar/{pais}/{tipo}
            /// </summary>
            public const string UrlUpdateOfertaShowRoomDetalleNew = "api/Componente/editar/{0}/{1}";

            /// <summary>
            /// api/Estrategia/buscador/{pais}/{tipo}/{campania}
            /// </summary>
            public const string UrlJobBuscador = "api/Estrategia/buscador/{0}/{1}/{2}";

            /// <summary>
            /// api/Evento/registrarConsultora/{pais}
            /// </summary>
            public const string UrlRegistrarEventoConsultora = "api/Evento/registrarConsultora/{0}";

            /// <summary>
            /// api/Evento/editarConsultora/{pais}/{tipo}
            /// </summary>
            public const string UrlEditarEventoConsultora = "api/Evento/editarConsultora/{0}/{1}";
            #endregion

            #region Oferta
            /// <summary>
            /// api/Oferta/{pais}/{tipo}/{codigoCampania}/{codigoConsultora}/{diaInicio}
            /// </summary>
            public const string UrlObtenerOfertasDelDia = "api/Oferta/{0}/{1}/{2}/{3}/{4}";

            /// <summary>
            /// api/Oferta/{pais}/{tipo}/{codigoCampania}/{codigoConsultora}/{codigoRegion}/{codigoZona}/{materialGanancia}
            /// </summary>
            public const string UrlObtenerOfertas = "api/Oferta/{0}/{1}/{2}/{3}/{4}/{5}/{6}";

            /// <summary>
            /// api/Evento/Get/{pais}/{campania}
            /// </summary>
            public const string UrlObtenerEvento = "api/Evento/Get/{0}/{1}";

            /// <summary>
            /// api/Nivel/listar/{pais}
            /// </summary>
            public const string UrlObtenerNivel = "api/Nivel/listar/{0}";

            /// <summary>
            /// api/Evento/listarConsultora/{pais}/{campania}/{codigoConsultora}
            /// </summary>
            public const string UrlObtenerEventoConsultora = "api/Evento/listarConsultora/{0}/{1}/{2}";
            #endregion

            #region Reporte
            /// <summary>
            /// api/Estrategia/ReporteValidacion/{tipo}/{campania}/{paises}
            /// </summary>
            public const string UrlReporteValidacion = "api/Estrategia/ReporteValidacion/{0}/{1}/{2}";
            #endregion
        }
        public static class OfertaFinalLog
        {
            private static Dictionary<int, string> _Message;

            public static class Code
            {
                public const int PRODUCTO_AGREGADO = 1;
                public const int POPUP_MOSTRADO = 2;
                public const int PRODUCTO_EXPUESTO = 3;
            }

            public static Dictionary<int, string> Message
            {
                get
                {
                    return _Message ?? (_Message = new Dictionary<int, string>
                    {
                        {Code.PRODUCTO_AGREGADO, "Producto Agregado"},
                        {Code.POPUP_MOSTRADO, "Popup Mostrado"},
                        {Code.PRODUCTO_EXPUESTO, "Producto Expuesto"},
                    });
                }
            }
        }

        public static class FacturacionElectronica
        {
            public const short TablaLogicaID = 9;
            public const string FlagActivacion = "01";
            public const string Url = "02";
            public const string Parametros = "03";
            public const string PaisesConfigurables = "CO;CR;GT;MX";
        }

        public static class TipoConfiguracionBuscador
        {
            public const string MostrarBuscador = "MostrarBuscador";
            public const string CaracteresBuscador = "CaracteresBuscador";
            public const string CaracteresBuscadorMostrar = "CaracteresBuscadorMostrar";
            public const string TotalResultadosBuscador = "TotalResultadosBuscador";
            public const string CantidadInicioSesionNovedadBuscador = "CantidadInicioSesionNovedadBuscador";
            public const string ConsultoraDummy = "ConsultoraDummy";
            public const string MostrarBotonVerTodos = "MostrarBotonVerTodos";
            public const string AplicarLogicaCantidadBotonVerTodos = "AplicarLogicaCantidadBotonVerTodos";
            public const string MostrarOpcionesOrdenamiento = "MostrarOpcionesOrdenamiento";
            public const string TotalProductosPaginaResultado = "TotalProductosPaginaResultado";
            public const string TotalCaracteresDescPaginaResultado = "TotalCaracteresDescPaginaResultado";
            public const string FlagFiltrosBuscador = "FlagFiltrosBuscador";
        }
        
        public static class CodigoConfiguracionRecomendaciones
        {
            public const string ActivarRecomendaciones = "ActivarRecomendaciones";
            public const string MaximoResultados = "MaximoResultados";
            public const string MinimoResultados = "MinimoResultados";
            public const string CaracteresDescripcion = "CaracteresDescripcion";
            public const string CodigoCatalogo = "CodigoCatalogo";
        }

        public static class RutaBuscadorService
        {
            /// <summary>
            /// Buscador/{CodigoISO}/{CampaniaID}
            /// </summary>
            public const string UrlBuscador = "Buscador/{0}/{1}/{2}";

            /// <summary>
            /// Personalizacion/{CodigoISO}/{CampaniaID}/{CodigoConsultora}/{Origen}
            /// </summary>
            public const string UrlPersonalizacion = "Personalizacion/{0}/{1}/{2}/{3}";

            public const string UrlRecomendaciones = "Recomendaciones/{0}/{1}/{2}";
        }

        public static class ActualizacionDatosValidacion
        {
            public const string ExpresionCelular = "^\\d+$";
            public const string CambioCorreoPendiente = "1";

            private static Dictionary<string, string> _Message;
            public static class Code
            {
                public const string SUCCESS = "0000";
                public const string ERROR_INTERNO = "9999";

                public const string ERROR_CELULAR_LONGITUD = "1001";
                public const string ERROR_CELULAR_INVALIDO = "1002";
                public const string ERROR_CELULAR_USADO = "1003";
                public const string ERROR_CELULAR_PRIMER_DIGITO = "1004";

                public const string ERROR_CORREO_CAMBIO_NO_AUTORIZADO = "1101";
                public const string ERROR_CORREO_VACIO = "1102";
                public const string ERROR_CORREO_YA_EXISTE = "1103";

                public const string ERROR_CORREO_ACTIVACION = "1201";
                public const string ERROR_CORREO_ACTIVACION_NO_EXISTE = "1202";
                public const string ERROR_CORREO_ACTIVACION_YA_ACTIVADA = "1203";
                public const string ERROR_CORREO_ACTIVACION_DUPLICADO = "1204";

                public const string ERROR_CELULAR_ACTIVACION = "1301";
                public const string ERROR_CELULAR_ACTIVACION_LIMITE_INTENTOS = "1302";

            }
            public static Dictionary<string, string> Message
            {
                get
                {
                    return _Message ?? (_Message = new Dictionary<string, string>
                   {
                       {Code.SUCCESS, "OK"},
                       {Code.ERROR_INTERNO, string.Empty},

                       {Code.ERROR_CELULAR_LONGITUD, "El número debe tener {0} dígitos."},
                       {Code.ERROR_CELULAR_INVALIDO, "No es un número válido."},
                       {Code.ERROR_CELULAR_USADO, "El celular ingresado ya está registrado para otra consultora."},
                       {Code.ERROR_CELULAR_PRIMER_DIGITO, "El número debe empezar por {0}."},

                       {Code.ERROR_CORREO_CAMBIO_NO_AUTORIZADO,Constantes.MensajesError.UpdCorreoConsultora_NoAutorizado},
                       {Code.ERROR_CORREO_VACIO,Constantes.MensajesError.UpdCorreoConsultora_CorreoVacio},
                       {Code.ERROR_CORREO_YA_EXISTE,Constantes.MensajesError.UpdCorreoConsultora_CorreoYaExiste},

                       {Code.ERROR_CORREO_ACTIVACION,"No pudimos validar tu correo electrónico. Por favor, vuelve a intentar."},
                       {Code.ERROR_CORREO_ACTIVACION_NO_EXISTE,"No pudimos validar tu correo electrónico. Por favor, vuelve a intentar."},
                       {Code.ERROR_CORREO_ACTIVACION_YA_ACTIVADA,"Esta dirección de correo electrónico ya ha sido validada."},
                       {Code.ERROR_CORREO_ACTIVACION_DUPLICADO,"La dirección de correo electrónico ingresada ya pertenece a otra Consultora."},

                       {Code.ERROR_CELULAR_ACTIVACION,"Opción de Validación no Disponible."},
                       {Code.ERROR_CELULAR_ACTIVACION_LIMITE_INTENTOS,"Superaste el máximo de envios. Podrás volver a intentar en {0}"},
                   });
                }
            }

            public static class VerificacionEmail
            {
                public const string UpsOcurrioUnProblema = "UPSS! OCURRIÓ UN PROBLEMA";
                public const string TuCorreoYaFueValidado = "TU CORREO YA FUE VALIDADO";

                public const string ComunicateConNosotros = "Para resolver el problema comunícate con nosotros al {0} o al {1}.";
                public const string ComunicateConNosotrosAlt = "Para resolver el problema comunícate con nosotros al {0}.";

                public const string VerificacionEmailValida = "Empieza a disfrutar de todos los beneficios y ofertas que tenemos para ti.";
            }

        }

        public static class VerificacionValidacion
        {
            public const int TIME_REINTENTO = 24 * 60 * 60;

            private static Dictionary<string, string> _Message;
            public static class Code
            {
                public const string SUCCESS = "0000";
                public const string ERROR_INTERNO = "9999";

                public const string ERROR_CELULAR_ACTIVACION = "1001";
                public const string ERROR_CELULAR_ACTIVACION_LIMITE_INTENTOS = "1002";

            }
            public static Dictionary<string, string> Message
            {
                get
                {
                    return _Message ?? (_Message = new Dictionary<string, string>
                   {
                       {Code.SUCCESS, "OK"},
                       {Code.ERROR_INTERNO, string.Empty},

                       {Code.ERROR_CELULAR_ACTIVACION,"Opción de Validación no Disponible."},
                       {Code.ERROR_CELULAR_ACTIVACION_LIMITE_INTENTOS,"Superaste el máximo de envios. Podrás volver a intentar en {0}"},
                   });
                }
            }

        }

        public static class RedireccionAndroidApp
        {
            public const string EsikaConmigo = "https://kpt22.app.goo.gl/esika";
            public const string LbelConmigo = "https://kpt22.app.goo.gl/lbel";
            public const string AppRedirectFormat = "IR AL APP {0} CONMIGO";
            public const string AppRedirectFormatAlt = "APP {0} Conmigo aquí";
        }

        public static class NuevoCatalogoProducto
        {
            public const string CLUBGANA = "CLUBGANA+";
            public const string SOLOHOY = "SOLOHOY";
            public const string CATALOGOLBEL = "CATALOGOLBEL";
            public const string CATALOGOESIKA = "CATALOGOESIKA";
            public const string CATALOGOCYZONE = "CATALOGOCYZONE";
            public const string OFERTASLIQUIDACION = "OFERTASLIQUIDACION";
            public const string OFERTAPARATI = "OFERTAPARATI";
            public const string LANZAMIENTOS = "LANZAMIENTOS";
            public const string OFERTADELDIA = "OFERTADELDIA";
            public const string GUIADENEGOCIODIGITAL = "GUIADENEGOCIODIGITAL";
            public const string HERRAMIENTASDEVENTA = "HERRAMIENTASDEVENTA";
            public const string ESPECIALES = "ESPECIALES";
            public const string OFERTASFLEXIPAGO = "OFERTASFLEXIPAGO";
        }

        public static class CodigosCatalogos
        {
            public const int ESIKA = 13;
            public const int LBEL = 9;
            public const int CYZONE = 10;
        }

        public static class AceptacionContrato
        {
            public const string UrlDescargarContratoCO = "http://somosbelcorpprd.s3.amazonaws.com/Menu/Contrato_Colombia.pdf";
            public const string ControladoresOmitidas = "Bienvenida;DescargarApp";
            public const string AcionesOmitidas = "ActualizarContrasenia";
        }

        public static class PlantillaExcel
        {
            public const string UrlExcelMatrizCampania = "http://somosbelcorpprd.s3.amazonaws.com/Matriz/PLANTILLA_MASIVO_MATRIZ.xlsx";
        }

        public static class CodigoEstrategiaBuscador
        {
            public const string Liquidacion = "LIQ";
            public const string Catalogo = "CAT";
            public const string OfertaDelDia = "ODD";
        }

        public static class MetaConsultora
        {
            public const string VerificacionCambioClave = "VF_CAMBIO_CLAVE";
        }

        public static class MasGanadoras
        {
            public const int ObtenerOpmTodo = 0;
            public const int ObtenerOpmSinForzadasMG1 = 1;
            public const int ObtenerOpmSoloForzadasMG1 = 2;
        }

        public static class ReporteValidacionDatos
        {
            private static Dictionary<int, string> _TipoPersonalizacion;
            private static Dictionary<int, string> _TipoEstrategiaCodigo;
            public static class EstrategiaID
            {
                public const int OPT = 4;
                public const int ODD = 7;
                public const int OPM = 10;
                public const int SR = 99;
            }

            public static Dictionary<int, string> TipoPersonalizacion
            {
                get
                {
                    return _TipoPersonalizacion ?? (_TipoPersonalizacion = new Dictionary<int, string>
                    {
                        {EstrategiaID.ODD, "ODD"},
                        {EstrategiaID.OPM, "OPM"},
                        {EstrategiaID.OPT, "OPT"},
                        {EstrategiaID.SR, "SR"}
                    });
                }
            }

            public static Dictionary<int, string> TipoEstrategiaCodigo
            {
                get
                {
                    return _TipoEstrategiaCodigo ?? (_TipoEstrategiaCodigo = new Dictionary<int, string>
                    {
                        {EstrategiaID.ODD, "009"},
                        {EstrategiaID.OPM, "007"},
                        {EstrategiaID.OPT, "001"},
                        {EstrategiaID.SR, "030"}
                    });
                }
            }
        }

        public static class EstrategiaDetalleCamposID
        {
            public const int FlagIndividual = 10212;
            public const int Slogan = 10213;
            public const int ImgHomeDesktop = 10210;
            public const int ImgHomeMobile = 10211;
            public const int ImgFondoDesktop = 10201;
            public const int ImgFondoMobile = 10205;
            public const int ImgFichaDesktop = 10203;
            public const int ImgFichaFondoDesktop = 10208;
            public const int ImgFichaMobile = 10206;
            public const int ImgFichaFondoMobile = 10209;
            public const int UrlVideoDesktop = 10204;
            public const int UrlVideoMobile = 10207;
        }

        public static class Formatos {
            public const string Fecha = "dd/MM/yyyy";
            public const string FechaHora = "dd/MM/yyyy HH:mm";
        }

    }
}