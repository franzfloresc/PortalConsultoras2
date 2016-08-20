using System.Collections.Generic;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;

namespace Portal.Consultoras.Web.Models
{
    public class GestionParametroPageModel
    {
        public bool ValidacionTelefonicaTieneHijos { get; set; }

        public ParametroUneteBE ParametroCorreo { get; set; }
        public ParametroUneteBE ParametroTelefonico { get; set; }

        public IEnumerable<ParametroUneteBE> ListaZonasValidacionTelefonicaActiva { get; set; }
        public IEnumerable<ParametroUneteBE> ListaZonasValidacionTelefonicaInactivas { get; set; }
    }
}