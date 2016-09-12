using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionValidacionNuevoPROLModel
    {
        public int PaisID { set; get; }
        public IEnumerable<ZonaModel> listaZonasPROL { set; get; }
        public IEnumerable<ZonaModel> listaZonasNuevoPROL { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }
    }
}