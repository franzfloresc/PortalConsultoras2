using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarRevistaViewModel
    {
        public IEnumerable<BECampania> ListaCampanias { get; set; }
        public IEnumerable<BEPais> ListaPaises { get; set; }
        public Int32 IdPais { get; set; }
    }
}