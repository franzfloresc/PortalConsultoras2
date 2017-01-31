using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Models
{
    public class CatalogoPersonalizadoModel
    {
        public List<BETablaLogicaDatos> FiltersBySorting { get; set; }
        public List<BETablaLogicaDatos> FiltersByCategory { get; set; }
        public List<BETablaLogicaDatos> FiltersByBrand { get; set; }
        public List<BETablaLogicaDatos> FiltersByPublished { get; set; }
    }
}