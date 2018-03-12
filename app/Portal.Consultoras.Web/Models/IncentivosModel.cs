using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class IncentivosModel
    {
        public int PaisID { set; get; }
        public int CampaniaID { set; get; }
        public string ISO { get; set; }
        public IEnumerable<BEIncentivo> listaIncentivos { set; get; }
    }
}