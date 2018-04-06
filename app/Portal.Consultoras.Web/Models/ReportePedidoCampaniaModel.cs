using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ReportePedidoCampaniaModel
    {
        public int PaisID { get; set; }
        public int CampaniaID { set; get; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public IEnumerable<CampaniaModel> listaCampanias { set; get; }
        public IEnumerable<RegionModel> listaRegiones { set; get; }
        public IEnumerable<ZonaModel> listaZonas { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }

        public string CodigoConsultora { get; set; }
        public string Territorio { get; set; }
        public string CUV { get; set; }
        public string CodigoProducto { get; set; }
        public string UnidadesDemandadas { get; set; }
        public string MontoDemandado { get; set; }
        public string TipoOferta { get; set; }
        public string Origen { get; set; }
        public string FechaUltima { get; set; }

        public string CodConsultoratxt { get; set; }
        public string CodConsultoratxt_ID { get; set; }

        public string vpage { set; get; }
        public string vsortname { set; get; }
        public string vsortorder { set; get; }
        public string vrowNum { set; get; }
        public string Usuario { set; get; }
    }
}