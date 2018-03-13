using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ReportePedidoFICModel
    {
        public int PaisID { get; set; }
        public int CampaniaID { set; get; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public IEnumerable<CampaniaModel> listaCampanias { set; get; }
        public IEnumerable<RegionModel> listaRegiones { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}