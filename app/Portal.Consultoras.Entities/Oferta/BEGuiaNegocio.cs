using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    public class BEGuiaNegocio
    {
        public BEGuiaNegocio()
        {
            ConfiguracionPaisDatos = new List<BEConfiguracionPaisDatos>();
        }

        public bool TieneGND { get; set; }
        public bool BloqueoProductoDigital { get; set; }
        public IList<BEConfiguracionPaisDatos> ConfiguracionPaisDatos { get; set; }
    }
}
