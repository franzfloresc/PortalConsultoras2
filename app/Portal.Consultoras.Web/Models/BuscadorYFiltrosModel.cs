using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class BuscadorYFiltrosModel
    {
        public BuscadorYFiltrosModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public int ConfiguracionPaisID { get; set; }
        public int CampaniaID { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
    }
}