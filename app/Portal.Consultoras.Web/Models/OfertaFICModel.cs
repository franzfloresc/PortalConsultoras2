using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaFICModel
    {
        public int PaisID { get; set; }
        public int CampaniaID { set; get; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public string CUV { get; set; }
        public IEnumerable<CampaniaModel> listaCampanias { set; get; }
        public IEnumerable<RegionModel> listaRegiones { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}