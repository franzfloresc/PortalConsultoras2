using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class VariablesGeneralesPortalModel
    {
        public string UrlCompartir { get; set; }
        public string ExtensionImgSmall { get; set; } 
        public string ImgUrlBase { get; set; }
        public string SimboloMoneda { get; set; }
    }
}