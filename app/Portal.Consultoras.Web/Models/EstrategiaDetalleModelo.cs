using System;
using System.Linq;
using System.Web.WebPages;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaDetalleModelo
    {
       
        public bool FlagIndividual { get; set; }
        private string _slogan;
        public string Slogan
        {
            get { return _slogan; }
            set { _slogan = value.IsNullOrEmptyTrim() ? "" : value.First().ToString().ToUpper() + value.Substring(1); }
        }

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