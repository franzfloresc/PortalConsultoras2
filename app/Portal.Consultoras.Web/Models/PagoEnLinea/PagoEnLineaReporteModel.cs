using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaReporteModel
    {
        public int PaisId { get; set; }
        public int CampaniaId { get; set; }
        public int RegionId { get; set; }
        public int ZonaId { get; set; }
        public IEnumerable<CampaniaModel> lista { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public IEnumerable<ZonaModel> listaZonas { get; set; }
        public IEnumerable<RegionModel> listaRegiones { get; set; }
    }
}