using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class UsuarioModel
    {
        public UsuarioModel()
        {            
            this.ClaveSecreta = string.Empty;
            this.CodigoISO = string.Empty;
            this.NombreConsultora = string.Empty;
            this.CodigoConsultora = string.Empty;
            this.CodigoUsuario = string.Empty;
            this.NombreConsultora = string.Empty;
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
            this.IndicadorOfertaFIC = 0;//SSAP CGI(Id Solicitud=1402)
            this.ImagenURLOfertaFIC = string.Empty;//SSAP CGI(Id Solicitud=1402)
            this.Lider = 0;
            this.ConsultoraAsociada = string.Empty;
            this.CampaniaInicioLider = string.Empty;
            this.SeccionGestionLider = string.Empty;
            this.NivelLider = 0;
            this.PortalLideres = false;
            this.LogoLideres = string.Empty;
            this.IndicadorContrato = 0;
            this.PROLSinStock = false;//1510
            this.ValidacionAbierta = false;//CCSS_JZ_PROL
            this.MenuNotificaciones = 0;//CCSS_JZ_PROL
            this.TieneNotificaciones = 0;//CCSS_JZ_PROL
            this.NuevoPROL = false;//RQ_NP - R2133
            this.ZonaNuevoPROL = false;//RQ_NP - R2133
            this.EsUsuarioComunidad = false;//Cambios_Landing_Comunidad
            this.SegmentoConstancia = string.Empty;//R2469
            this.SeccionAnalytics = string.Empty;//R2469
            this.DescripcionNivel = string.Empty; //2469
            this.esConsultoraLider = false;//2469
            this.EMailActivo = false; //2532 EGL
            this.EstadoSimplificacionCUV = false;  /*R20150701*/
            this.IngresoPedidoCierre = false; //20150811
            this.EsquemaDAConsultora = false;
            this.TipoCasoPromesa = string.Empty;
            this.DiasCasoPromesa = 0;
        }

        public string Celular { get; set; }
        public string Telefono { get; set; }
        public int CambioClave { get; set; }
        public int ConsultoraNueva { get; set; }
        public string NombrePais { get; set; }
        public string BanderaImagen { get; set; }
        public string CodigoFuente { get; set; }
        public string ClaveSecreta { get; set; }
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
        public int RolID { get; set; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public long ConsultoraID { get; set; }
        public string NombreConsultora { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoUsuario { get; set; }
        public int CampaniaID { get; set; }
        public string CampaniaAnio { get {
            if (CampaniaID > 999)
            {
                return CampaniaID.ToString().Substring(0, 4);
            }
            return "";
        } }
        public string CampaniaNro { get {
            if (CampaniaID > 99999)
            {
                return CampaniaID.ToString().Substring(4, 2);
            }
            return "";   
        } }
        public string NombreCorto { get; set; }
        public int DiasCampania { get; set; }
        public DateTime FechaFacturacion { get; set; }

        public DateTime FechaLimPago { get; set; }

        public int PedidoID { get; set; }
        public string CodigorRegion { get; set; }
        public string CodigoZona { get; set; }
        public string EMail { get; set; }
        public TimeSpan HoraFacturacion { get; set; }
        public TimeSpan HoraFinFacturacion { get; set; }
        public bool DiaPROL { get; set; }
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
        public List<BEProductoFaltante> ListaProductoFaltante { get; set; }
        public string UrlAyuda { get; set; }
        public string UrlCapedevi { get; set; }
        public string UrlTerminos { get; set; }
        public bool ModificaPedido { get; set; }
        public TimeSpan HoraCierreZonaNormal { get; set; }
        public TimeSpan HoraCierreZonaDemAnti { get; set; }
        public int HorasDuracionRestriccion { get; set; }
        public double ZonaHoraria { get; set; }
        public int TipoUsuario { get; set; }
        public int EsZonaDemAnti { get; set; }
        public decimal MontoMaximo { get; set; }
        public string Segmento { get; set; }
        public string Sobrenombre { get; set; }
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
        public bool IndicadorPermisoFlexipago { get; set; }

        public string CampanaInvitada { get; set; } //1796
        public string InscritaFlexipago { get; set; } //1796
        public string InvitacionRechazada { get; set; } //1796

        public bool MostrarAyudaWebTraking { get; set; }
        public int IndicadorOfertaFIC { get; set; }//SSAP CGI(Id Solicitud=1402)
        public string ImagenURLOfertaFIC { get; set; }//SSAP CGI(Id Solicitud=1402)
        public int Lider { get; set; }//1485
        public string ConsultoraAsociada { get; set; }//1688
        public string CampaniaInicioLider { get; set; }//1589
        public string SeccionGestionLider { get; set; }//1589
        public int NivelLider { get; set; }//1485        
        public bool PortalLideres { get; set; }//1589
        public string LogoLideres { get; set; }//1589
        public int IndicadorContrato { get; set; }//1484
        public int NroCampanias { get; set; }
        public string RolDescripcion { get; set; }
        public DateTime FechaFinFIC { get; set; }//1501
        public int EsJoven { get; set; }
        public bool ValidacionAbierta { get; set; }//CCSS_JZ_PROL
        public int MenuNotificaciones { get; set; }//CCSS_JZ_PROL
        public int TieneNotificaciones { get; set; }//CCSS_JZ_PROL
        public bool EMailActivo { get; set; } //2532 EGL
        public bool EstadoSimplificacionCUV { get; set; } /*20150701*/
        public bool IngresoPedidoCierre { get; set; }//20150811 
        public bool EsquemaDAConsultora { get; set; }
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; } //R20151123
        
        public string TipoCasoPromesa { get; set; }
        public int DiasCasoPromesa { get; set; }

        /*Inicio Cambios_Landing_Comunidad*/
        public static bool HasAcces(List<PermisoModel> lista, string Action)
        {
            bool estado = false;
            if (lista != null)
            {
                if (lista.Count > 0)
                {
                    estado = HasAccessRecursive(lista, Action);
                }
            }
            return estado;
        }
        private static bool HasAccessRecursive(List<PermisoModel> lista, string Action)
        {
            foreach (var permiso in lista)
            {
                if (permiso.UrlItem.ToLower().Equals(Action.ToLower()))
                {
                    return true;
                }

                if (HasAccessRecursive(permiso.SubMenus, Action))
                {
                    return true;
                }
            }

            return false;
        }
        /*Fin Cambios_Landing_Comunidad*/
        public bool PROLSinStock { get; set; }//1510
        public bool NuevoPROL { get; set; } //RQ_NP - R2133
        public bool ZonaNuevoPROL { get; set; } //RQ_NP - R2133
        public DateTime FechaPromesaEntrega { get; set; }//RQ_FP - R2161
        public bool EsUsuarioComunidad { get; set; }//Cambios_Landing_Comunidad
        public string SegmentoConstancia { get; set; } //R2469
        public string SeccionAnalytics { get; set; } //R2469
        public string DescripcionNivel { get; set; } //R2469
        public bool esConsultoraLider { get; set; } //R2469        
        /*re2544 - cs*/
        public int? SegmentoInternoID
        {
            get;
            set;
        }

        public bool ValidacionInteractiva { get; set; } // R20150306
        public string MensajeValidacionInteractiva { get; set; } // R20150306

        public bool CargoEntidadesShowRoom { get; set; } // GR-1776
        public BEShowRoomEventoConsultora BeShowRoomConsultora { get; set; } // GR-1776
        public BEShowRoomEvento BeShowRoom { get; set; } // GR-1776

        public int OfertaFinal { get; set; }

        public bool EsOfertaFinalZonaValida { get; set; }
    }
}