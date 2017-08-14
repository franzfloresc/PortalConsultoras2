using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaDetalleModelo
    {
        public string ImgFondoDesktop { get; set; }
        public string ImgPrevDesktop { get; set; }
        public string ImgFichaDesktop { get; set; }//en el sello
        public string UrlVideoDesktop { get; set; }
        public string ImgFichaFondoDesktop { get; set; }
        public string ImgFondoMobile { get; set; }
        public string ImgFichaMobile { get; set; }//en el sello
        public string UrlVideoMobile { get; set; }
        public string ImgFichaFondoMobile { get; set; }
        public string ImgHomeDesktop { get; set; }
        public string ImgHomeMobile { get; set; }
    }
}