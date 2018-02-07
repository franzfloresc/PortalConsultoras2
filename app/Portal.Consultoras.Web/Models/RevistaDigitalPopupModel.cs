using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalPopupModel
    {
        public string Mensaje1 { get; set; }
        public string Mensaje1Color { get; set; }
        public string Mensaje2 { get; set; }
        public string Mensaje2Color { get; set; }
        public string ImagenEtiqueta { get; set; }
        public string ImagenPublicidad { get; set; }
        public string BotonColorFondo { get; set; }
        public string BotonColorTexto { get; set; }
        public string BotonTexto { get; set; }
        public string FondoColor { get; set; }
        public string FondoColorMarco { get; set; }
    }
}