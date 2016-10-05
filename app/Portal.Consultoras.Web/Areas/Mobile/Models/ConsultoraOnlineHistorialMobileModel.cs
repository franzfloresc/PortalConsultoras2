using Portal.Consultoras.Web.Models;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class ConsultoraOnlineHistorialMobileModel
    {
        public ConsultoraOnlineHistorialMobileModel()
        {
            CampaniasConsultoraOnline = new List<CampaniaModel>();
        }

        public List<CampaniaModel> CampaniasConsultoraOnline { get; set; }
        public int CampaniaActualConsultoraOnline { get; set; }
        //public List<MisPedidosMotivoRechazoModel> MotivosRechazo { get; set; }
    }
}
