using System.Collections.Generic;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConfiguracionZonasModel
    {
        public ConfiguracionZonasModel()
        {
        }

        public List<ParametroUneteBE> ListaZonasValidacionZonasActivas { get; set; }
        public List<ParametroUneteBE> ListaZonasValidacionZonasInactivas { get; set; }
    }
}