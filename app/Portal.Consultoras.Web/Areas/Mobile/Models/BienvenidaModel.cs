using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class BienvenidaModel
    {
        public BienvenidaModel()
        {
            RevistaDigital = new RevistaDigitalModel();
            PartialSectionBpt = new PartialSectionBpt();
        }
        public string Saludo { get; set; }
        public string NombreConsultora { get; set; }
        public string Simbolo { get; set; }
        public string NombrePais { get; set; }
        public string NumeroCampania { get; set; }
        public string CodigoZona { get; set; }
        public int DiasParaCierre { get; set; }
        public string RutaChile { get; set; }
        public string UrlChileEncriptada { get; set; }
        public string MensajeCierreCampania { get; set; }
        public int IsConsultoraOnline { get; set; }
        public string codigoConsultora { get; set; }
        public int PaisID { get; set; }
        public int IndicadorPermisoFIC { get; set; }
        public string InscritaFlexipago { get; set; }
        public string InvitacionRechazada { get; set; }
        public bool PortalLideres { get; set; }
        public int Lider { get; set; }
        public bool DiaPROL { get; set; }
        public decimal MontoAhorroCatalogo { get; set; }
        public decimal MontoAhorroRevista { get; set; }
        public decimal MontoPedido { get; set; }
        public string CodigoISO { get; set; }
        public decimal MontoDeuda { get; set; }
        public string FechaVencimiento { get; set; }
        public int VioTutorial { get; set; }
        public string UrlEnterateMas { get; set; }
        public string UrlImagenMiAcademia { get; set; }
        public string UrlImagenLiquidaciones { get; set; }
        public string UrlImagenCatalogoPersonalizado { get; set; }
        public string UrlImagenAppCatalogo { get; set; }
        public int CatalogoPersonalizadoMobile { get; set; }
        public bool EsCatalogoPersonalizadoZonaValida { get; set; }
        public int ActivacionAppCatalogoWhastUp { get; set; }
        public string CodigoUsuario { get; set; }
        public int ShowRoomMostrarLista { get; set; }
        public bool RevistaDigitalPopUpMostrar { get; set; }
        public string EMail { get; set; }
        public string Celular { get; set; }
        public int CampaniaActual { get; set; }
        public bool EmailActivo { get; set; }
        public int TieneCupon { get; set; }
        public int TieneMasVendidos { get; set; }
        public short PrimeraVezSession { get; set; }
        public int TieneAsesoraOnline { get; set; }
        public RevistaDigitalModel RevistaDigital { get; set; }
        public PartialSectionBpt PartialSectionBpt { get; set; }
        public int TipoPopUpMostrar { get; set; }
        public bool ConsultoraNuevaBannerAppMostrar { get; set; }
        public bool TienePagoEnLinea { get; set; }
        public int CambioClave { get; set; }
        public bool MostrarPagoEnLinea { get; set; }
    }
}