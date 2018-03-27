using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaDetalleModelo
    {
        public bool FlagIndividual { get; set; }
        public string Slogan { get; set; }

        public string ImgHomeDesktop { get; set; }
        public string ImgFondoDesktop { get; set; }
        public string ImgFichaDesktop { get; set; }//es el sello
        public string ImgFichaFondoDesktop { get; set; }
        public string UrlVideoDesktop { get; set; }

        public string ImgHomeMobile { get; set; }
        public string ImgFondoMobile { get; set; }
        public string ImgFichaMobile { get; set; }//es el sello
        public string ImgFichaFondoMobile { get; set; }
        public string UrlVideoMobile { get; set; }

        //public string ImgPrevDesktop { get; set; }
    }
}