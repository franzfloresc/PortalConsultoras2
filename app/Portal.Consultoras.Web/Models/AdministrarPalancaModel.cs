using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarPalancaModel
    {
        public int ConfiguracionPaisID { get; set; }
        public string Codigo { get; set; }
        public bool Excluyente { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }
        public bool Validado { get; set; }
        public bool TienePerfil { get; set; }
        public string MobileTituloMenu { get; set; }
        public string MobileSubTituloMenu { get; set; }
        public string DesktopTituloMenu { get; set; }
        public string DesktopSubTituloMenu { get; set; }
        public string Logo { get; set; }
        public int Orden { get; set; }
        public int DesdeCampania { get; set; }
        public string DesktopTituloBanner { get; set; }
        public string MobileTituloBanner { get; set; }
        public string DesktopSubTituloBanner { get; set; }
        public string MobileSubTituloBanner { get; set; }
        public string Color { get; set; }
        public string DesktopFondoBanner { get; set; }
        public string MobileFondoBanner { get; set; }
        public string DesktopLogoBanner { get; set; }
        public string MobileLogoBanner { get; set; }
        public string UrlMenu { get; set; }

        public int OrdenBpt { get; set; }
        public int MobileOrden { get; set; }
        public int MobileOrdenBpt { get; set; }

        public int PaisID { get; set; }
        public IEnumerable<PaisModel> ListaPaises { set; get; }
        public IEnumerable<CampaniaModel> ListaCampanias { set; get; }
        public IEnumerable<ConfiguracionPaisModel> ListaConfiguracionPais { get; set; }
        public IEnumerable<TablaLogicaDatosModel> ListaTipoPresentacion { get; set; }
    }
}