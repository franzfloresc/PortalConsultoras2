
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarApeZonaModel
    {
        public int ZonaID { get; set; }

        public string Codigo { get; set; }

        public int CantidadDias { get; set; }

        public IEnumerable<RegionModel> Regiones { get; set; }
    }
}