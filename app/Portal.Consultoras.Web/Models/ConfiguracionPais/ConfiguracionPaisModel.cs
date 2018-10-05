using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionPaisModel : ICloneable
    {
        public int ConfiguracionPaisID { get; set; }
        public int DesdeCampania { get; set; }
        public string Codigo { get; set; }
        public bool Excluyente { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }
        public bool Validado { get; set; }
        public int Orden { get; set; }

        public bool TienePerfil { get; set; }
        public string DesktopLogoMenuNoActivo { get; set; }
       // public string MobileLogoMenuNoActivo { get; set; }

        public string DesktopLogoMenu { get; set; }
       // public string MobileLogoMenu { get; set; }
        public string DesktopTituloMenu { get; set; }
        public string MobileTituloMenu { get; set; }
        public string DesktopSubTituloMenu { get; set; }
        public string MobileSubTituloMenu { get; set; }

        public string DesktopTituloBanner { get; set; }
        public string MobileTituloBanner { get; set; }
        public string DesktopSubTituloBanner { get; set; }
        public string MobileSubTituloBanner { get; set; }
        public string DesktopFondoBanner { get; set; }
        public string MobileFondoBanner { get; set; }
        public string DesktopLogoBanner { get; set; }
        public string MobileLogoBanner { get; set; }

        public string UrlMenu { get; set; }
        public string UrlMenuMobile
        {
            get
            {
                return "/Mobile/" + UrlMenu ?? string.Empty;
            }
        }

        public bool EsAncla
        {
            get
            {
                return UrlMenu != null && UrlMenu.Contains("#");
            }
        }
        public int CampaniaId { get; set; }

        public int OrdenBpt { get; set; }

        public bool BloqueoRevistaImpresa { get; set; }

        public int MobileOrden { get; set; }
        public int MobileOrdenBPT { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}