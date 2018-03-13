using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarLugaresPagoModel
    {
        public int LugarPagoID { get; set; }
        public int PaisID { set; get; }
        public string Nombre { set; get; }
        public string UrlSitio { set; get; }
        public string ArchivoLogo { set; get; }
        public string ArchivoLogoAnterior { set; get; }
        public string ArchivoInstructivo { set; get; }

        public string TextoPago { set; get; }
        public int Posicion { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}