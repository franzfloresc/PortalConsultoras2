using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarLugaresPagoModel
    {
        public int LugarPagoID { get; set; }
        public int PaisID { set; get; }
        //public int CampaniaID { set; get; }
        public string Nombre { set; get; }
        public string UrlSitio { set; get; }
        public string ArchivoLogo { set; get; }
        public string ArchivoLogoAnterior { set; get; }
        public string ArchivoInstructivo { set; get; }
        //public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}