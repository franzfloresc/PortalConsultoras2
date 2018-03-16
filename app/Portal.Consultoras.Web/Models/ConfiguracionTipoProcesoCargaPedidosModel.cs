using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionTipoProcesoCargaPedidosModel
    {
        public int PaisID { set; get; }
        public IEnumerable<ZonaModel> listaZonasPROL { set; get; }
        public IEnumerable<ZonaModel> listaZonasNuevoPROL { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}