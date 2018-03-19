using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;

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