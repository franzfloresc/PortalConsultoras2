using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class BuscadorYFiltrosConfiguracionModel
    {
        public BuscadorYFiltrosConfiguracionModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
    }
}