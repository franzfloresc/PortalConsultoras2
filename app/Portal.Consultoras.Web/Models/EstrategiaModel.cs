using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class EstrategiaModel
    {
        public int TipoEstrategiaID { get; set; }
        public int CampaniaID { get; set; }
        public int PaisID { get; set; }
        public string CodigoCampania { get; set; }
        public IEnumerable<CampaniaModel> listaCampania { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public IEnumerable<TipoEstrategiaModel> ListaTipoEstrategia { get; set; }
        public IEnumerable<EtiquetaModel> ListaEtiquetas { get; set; }
        public string ArbolDeZonas { get; set; }
        public IEnumerable<PedidoAsociadoModel> PedidosAsociados { get; set; }
        public string UrlS3 { get; set; }
        public bool habilitarNemotecnico { get; set; }
        public string ExpValidacionNemotecnico { get; set; }
        public int TipoVistaEstrategia { get; set; }
    }
}