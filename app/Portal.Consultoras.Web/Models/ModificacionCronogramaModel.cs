using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ModificacionCronogramaModel
    {
        public int PaisID { get; set; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public IEnumerable<RegionModel> listaRegiones { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}