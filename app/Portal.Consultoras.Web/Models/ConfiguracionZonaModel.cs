using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionZonaModel
    {

        public IEnumerable<ServiceUnete.ParametroUneteBE> ListaZonasValidacionActivas { set; get; }
        public IEnumerable<ServiceUnete.ParametroUneteBE> ListaZonasValidacionInactivas { set; get; }

    }
}