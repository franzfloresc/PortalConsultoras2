using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;


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