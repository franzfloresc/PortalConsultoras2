using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class UsuarioModel
    {
        public UsuarioModel()
        {
            this.ClaveSecreta = string.Empty;
            this.CodigoISO = string.Empty;
            this.NombreConsultora = string.Empty;
            this.CodigoConsultora = string.Empty;
            this.CodigoUsuario = string.Empty;
            this.NombreCorto = string.Empty;
            this.CodigorRegion = string.Empty;
            this.CodigoZona = string.Empty;
            this.EMail = string.Empty;
            this.CodigoTerritorio = string.Empty;
            this.Simbolo = string.Empty;
            this.PaisID = 11;
            this.BanderaImagen = string.Empty;
            this.CodigoFuente = string.Empty;
            this.NombrePais = string.Empty;
            this.Celular = string.Empty;
            this.Telefono = string.Empty;
            this.DiasAntes = 0;
            this.DiasDuracionCronograma = 1;
            this.HabilitarRestriccionHoraria = false;
            this.AnoCampaniaIngreso = string.Empty;
            this.PrimerNombre = string.Empty;
            this.PrimerApellido = string.Empty;
            this.IndicadorPermisoFIC = 0;
            this.IndicadorPermisoFlexipago = false;
            this.MostrarAyudaWebTraking = false;
            this.IndicadorOfertaFIC = 0;
            this.ImagenURLOfertaFIC = string.Empty;
            this.Lider = 0;
            this.ConsultoraAsociada = string.Empty;
            this.CampaniaInicioLider = string.Empty;
            this.SeccionGestionLider = string.Empty;
            this.NivelLider = 0;
            this.PortalLideres = false;
            this.LogoLideres = string.Empty;
            this.IndicadorContrato = 0;
            this.ValidacionAbierta = false;
            this.MenuNotificaciones = 0;
            this.TieneNotificaciones = 0;
            this.EsUsuarioComunidad = false;
            this.SegmentoConstancia = string.Empty;
            this.SeccionAnalytics = string.Empty;
            this.DescripcionNivel = string.Empty;
            this.esConsultoraLider = false;
            this.EMailActivo = false;
            this.EstadoSimplificacionCUV = false;
            this.IngresoPedidoCierre = false;
            this.EsquemaDAConsultora = false;
            this.TipoCasoPromesa = string.Empty;
            this.DiasCasoPromesa = 0;
            this.SegmentoAbreviatura = string.Empty;
            this.MensajePedidoDesktop = 0;
            this.MensajePedidoMobile = 0;
            this.EsLebel = false;
            this.TieneCDRExpress = false;
            this.PopupBienvenidaCerrado = false;
            this.FotoPerfil = string.Empty;
        }

        public string Celular { get; set; }
        public string Telefono { get; set; }
        public string TelefonoTrabajo { get; set; }
        public int CambioClave { get; set; }
        public int ConsultoraNueva { get; set; }
        public bool EsConsultoraNueva { get; set; }
        public bool EsConsultoraOficina { get; set; }
        public string NombrePais { get; set; }
        public string BanderaImagen { get; set; }
        public string CodigoFuente { get; set; }
        public string ClaveSecreta { get; set; }
        public int PaisID { get; set; }
        public int HdePaisID { get; set; }
        public string CodigoISO { get; set; }
        public int RolID { get; set; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public long ConsultoraID { get; set; }
        public string NombreConsultora { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoUsuario { get; set; }
        
        /// <summary>
        /// Codigo Campaña
        /// </summary>
        public int CampaniaID { get; set; }

        public string CampaniaAnio
        {
            get
            {
                if (CampaniaID > 999)
                {
                    return CampaniaID.ToString().Substring(0, 4);
                }
                return "";
            }
        }
        public string CampaniaNro
        {
            get
            {
                if (CampaniaID > 99999)
                {
                    return CampaniaID.ToString().Substring(4, 2);
                }
                return "";
            }
        }
        public string NombreCorto { get; set; }
        public int DiasCampania { get; set; }
        public DateTime FechaFacturacion { get; set; }

        public DateTime FechaLimPago { get; set; }

        public int VioVideoModelo { get; set; }

        public int VioTutorialModelo { get; set; }

        public int VioTutorialDesktop { get; set; }

        public int PedidoID { get; set; }
        public string CodigorRegion { get; set; }
        public string CodigoZona { get; set; }
        public string EMail { get; set; }
        public TimeSpan HoraFacturacion { get; set; }
        public TimeSpan HoraFinFacturacion { get; set; }
        public bool DiaPROL { get; set; }
        public bool DiaPROLMensajeCierreCampania { get; set; }
        public DateTime FechaInicioCampania { get; set; }
        public DateTime FechaFinCampania { get; set; }
        public TimeSpan HoraInicioReserva { get; set; }
        public TimeSpan HoraFinReserva { get; set; }
        public TimeSpan HoraInicioPreReserva { get; set; }
        public TimeSpan HoraFinPreReserva { get; set; }
        public bool ZonaValida { get; set; }
        public string CodigoTerritorio { get; set; }
        public string Simbolo { get; set; }
        public decimal MontoMinimo { get; set; }
        public string UrlAyuda { get; set; }
        public string UrlCapedevi { get; set; }
        public string UrlTerminos { get; set; }
        public TimeSpan HoraCierreZonaNormal { get; set; }
        public TimeSpan HoraCierreZonaDemAnti { get; set; }
        public int HorasDuracionRestriccion { get; set; }
        public double ZonaHoraria { get; set; }
        public int TipoUsuario { get; set; }
        public int EsZonaDemAnti { get; set; }
        public decimal MontoMaximo { get; set; }
        public string Segmento { get; set; }
        public string Sobrenombre { get; set; }

        public string UsuarioNombre
        {
            get { return string.IsNullOrEmpty(Sobrenombre) ? NombreConsultora : Sobrenombre; }
        }

        public string SobrenombreOriginal { get; set; }
        public int IndicadorDupla { get; set; }
        public int DiasAntes { get; set; }
        public int UsuarioPrueba { get; set; }
        public int DiasDuracionCronograma { get; set; }
        public int PasePedidoWeb { get; set; }
        public int TipoOferta2 { get; set; }
        public int CompraKitDupla { get; set; }
        public int CompraOfertaDupla { get; set; }
        public int CompraOfertaEspecial { get; set; }
        public int IndicadorMeta { get; set; }
        public int ProgramaReconocimiento { get; set; }
        public int NivelEducacion { get; set; }
        public int SegmentoID { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Nivel { get; set; }

        public long ConsultoraAsociadaID { get; set; }

        public string Direccion { get; set; }
        public string IPUsuario { get; set; }
        public bool MostrarBotonValidar { get; set; }
        public bool HabilitarRestriccionHoraria { get; set; }

        public string AnoCampaniaIngreso { get; set; }
        public string PrimerNombre { get; set; }
        public string PrimerApellido { get; set; }

        public int IndicadorFlexiPago { get; set; }
        public int IndicadorPagoOnline { get; set; }
        public string UrlPagoOnline { get; set; }
        public int IndicadorPermisoFIC { get; set; }
        public bool PedidoFICActivo { get; set; }
        public bool IndicadorPermisoFlexipago { get; set; }

        public string CampanaInvitada { get; set; }
        public string InscritaFlexipago { get; set; }
        public string InvitacionRechazada { get; set; }

        public bool MostrarAyudaWebTraking { get; set; }
        public int IndicadorOfertaFIC { get; set; }
        public string ImagenURLOfertaFIC { get; set; }
        public int Lider { get; set; }
        public string ConsultoraAsociada { get; set; }
        public string CampaniaInicioLider { get; set; }
        public string SeccionGestionLider { get; set; }
        public int NivelLider { get; set; }
        public bool PortalLideres { get; set; }
        public string LogoLideres { get; set; }
        public int IndicadorContrato { get; set; }
        public int NroCampanias { get; set; }
        public string RolDescripcion { get; set; }
        public DateTime FechaFinFIC { get; set; }
        public int EsJoven { get; set; }
        public bool ValidacionAbierta { get; set; }
        public int MenuNotificaciones { get; set; }
        public int TieneNotificaciones { get; set; }
        public bool EMailActivo { get; set; }
        public bool EstadoSimplificacionCUV { get; set; }
        public bool IngresoPedidoCierre { get; set; }
        public bool EsquemaDAConsultora { get; set; }
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; }

        public string TipoCasoPromesa { get; set; }
        public int DiasCasoPromesa { get; set; }

        public string SegmentoAbreviatura { get; set; }

        public static bool HasAcces(List<PermisoModel> lista, string Action)
        {
            bool estado = false;
            if (lista != null && lista.Count > 0)
            {
                estado = HasAccessRecursive(lista, Action);
            }
            return estado;
        }
        private static bool HasAccessRecursive(List<PermisoModel> lista, string Action)
        {
            foreach (var permiso in lista)
            {
                if (permiso.UrlItem.ToLower().Equals(Action.ToLower())) return true;
                if (HasAccessRecursive(permiso.SubMenus, Action)) return true;
            }
            return false;
        }
        public DateTime FechaPromesaEntrega { get; set; }
        public bool EsUsuarioComunidad { get; set; }
        public string SegmentoConstancia { get; set; }
        public string SeccionAnalytics { get; set; }
        public string DescripcionNivel { get; set; }
        public bool esConsultoraLider { get; set; }
        public int? SegmentoInternoID { get; set; }

        public bool ValidacionInteractiva { get; set; }
        public string MensajeValidacionInteractiva { get; set; }

        public int CatalogoPersonalizado { get; set; }

        public bool EjecutaProl { get; set; }

        public bool EsCatalogoPersonalizadoZonaValida { get; set; }

        public int VioTutorialSalvavidas { get; set; }
        public int TieneHana { get; set; }
        public int IndicadorBloqueoCDR { get; set; }
        public bool OptBloqueoProductoDigital { get; set; }
        public int IndicadorGPRSB { get; set; }
        public int EsCDRWebZonaValida { get; set; }
        public int EstadoPedido { get; set; }
        public int TieneCDR { get; set; }
        public int TieneCupon { get; set; }
        public int TieneMasVendidos { get; set; }
        public int TieneAsesoraOnline { get; set; }
        public int TieneOfertaLog { get; set; }
        public int IndicadorEnviado { get; set; }
        public int IndicadorRechazado { get; set; }
        public string GPRBannerTitulo { get; set; }
        public string GPRBannerMensaje { get; set; }
        public Enumeradores.RechazoBannerUrl GPRBannerUrl { get; set; }
        public DateTime FechaProceso { get; set; }
        public bool MostrarBannerRechazo { get; set; }
        public bool RechazadoXdeuda { get; set; }
        public bool MostrarBannerPostulante { get; set; }

        public bool TieneCDRExpress { get; set; }
        public string MensajeCDRExpress { get; set; }
        public bool EsConsecutivoNueva { get; set; }
        public DateTime FechaActualPais { get; set; }
        // 0: No hay Respuesta, 1: Rechazado, 2: No Rechazado
        public int CerrarRechazado { get; set; }
        public int CerrarBannerPostulante { get; set; }
        public string NombreGerenteZonal { get; set; }
        public decimal MontoDeuda { get; set; }
        public string MontoMinimoFlexipago { get; set; }

        public IEnumerable<PaisModel> listaPaises { get; set; }

        public List<PermisoModel> Menu { get; internal set; }
        public List<ServicioCampaniaModel> MenuService { get; internal set; }

        public int EsOfertaDelDia { get; set; }
        //public bool TieneOfertaDelDia { get; set; }
        public bool CloseOfertaDelDia { get; set; }
        public bool CloseBannerPL20 { get; set; }

        public bool EsDiasFacturacion
        {
            get { return FechaHoy >= FechaInicioCampania.Date && FechaHoy <= FechaFinCampania.Date; }
        }

        public bool HizoLoginExterno { get; set; }
        public bool TieneLoginExterno { get; set; }
        public List<UsuarioExternoModel> ListaLoginExterno { get; set; }

        public bool CloseBannerCompraPorCompra { get; set; }
        public bool EsLebel { get; set; }
        public int AceptacionConsultoraDA { get; set; }
        public int MensajePedidoDesktop { get; set; }
        public int MensajePedidoMobile { get; set; }

        public ConsultoraOnlineMenuResumenModel ConsultoraOnlineMenuResumen { get; set; }
        public ConsultoraRegaloProgramaNuevasModel ConsultoraRegaloProgramaNuevas { get; set; }
        public List<MenuMobileModel> MenuMobile { get; set; }

        public int OfertaFinal { get; set; }
        public bool TieneValidacionMontoMaximo { get; set; }
        public bool EsOfertaFinalZonaValida { get; set; }
        public bool EsOFGanaMasZonaValida { get; set; }
        public int OfertaFinalGanaMas { get; set; }
        public string CodigosConcursos { get; set; }
        public string CodigosProgramaNuevas { get; set; }
        public string ClaseLogoSB { get; set; }
        public bool PopupBienvenidaCerrado { get; set; }
        public bool TieneGND { get; set; }
        public string CodigosRevistaImpresa { get; set; }
        public string CodigoPrograma { get; set; }
        public int ConsecutivoNueva { get; set; }

        public DateTime FechaHoy
        {
            get { return DateTime.Now.AddHours(ZonaHoraria).Date; }
        } 

        public string FotoPerfil { get; set; }

        public string CodigoUsuarioHost { get; set; }
        
        public bool TienePagoEnLinea { get; set; }
        public string DocumentoIdentidad { get; set; }
        
        public double CompraVDirectaCer { get; set; }
        public double IVACompraVDirectaCer { get; set; }
        public double RetailCer { get; set; }
        public double IVARetailCer { get; set; }
        public double TotalCompraCer { get; set; }
        public double IvaTotalCer { get; set; }
        public string FotoOriginalSinModificar { get; set; }
        public bool PuedeEnviarSMS { get; set; }
        public bool PuedeActualizar { get; set; }
        public bool FotoPerfilAncha { get; set; }
        public string MensajeChat { get; set; }
        public double PromedioVenta { get; set; }
        public string GetCodigoConsultora()
        {
            return UsuarioPrueba == 1
                ? ConsultoraAsociada
                : CodigoConsultora;
        }

        public long GetConsultoraId()
        {
            return UsuarioPrueba == 1
                ? ConsultoraAsociadaID
                : ConsultoraID;
        }

        public bool EsConsultora()
        {
            return RolID == Constantes.Rol.Consultora;
        }
    }
}