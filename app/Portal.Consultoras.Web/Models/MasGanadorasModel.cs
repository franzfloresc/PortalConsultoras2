using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class MasGanadorasModel
    {
        public MasGanadorasModel()
        {
            TieneLanding = true;
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public bool TieneMG { get; set; }
        public bool TieneLanding { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }

    }
}