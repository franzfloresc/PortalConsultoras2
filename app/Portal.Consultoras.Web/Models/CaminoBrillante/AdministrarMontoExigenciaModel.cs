using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class AdministrarMontoExigenciaModel
    {
        public int MontoID { get; set; }
        public string CodigoCampania { get; set; }
        public string CodigoRegion { get; set; }
        public string CodigoZona { get; set; }
        public string Monto { get; set; }
        public string AlcansoIncentivo { get; set; }

        public int PaisID { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
        public int CampaniaID { get; set; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public string RegionID { get; set; }
        public IEnumerable<RegionModel> listaRegion { set; get; }
        public string ZonaID { get; set; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
    }
}