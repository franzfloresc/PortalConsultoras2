using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class LugaresPagoModel
    {
        public int PaisID { set; get; }
        public int CampaniaID { set; get; }
        public string ISO { get; set; }
        public IEnumerable<BELugarPago> listaLugaresPago { set; get; }
    }
}