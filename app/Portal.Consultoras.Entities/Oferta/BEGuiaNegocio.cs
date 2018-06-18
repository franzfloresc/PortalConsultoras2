using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    public class BEGuiaNegocio
    {
        public BEGuiaNegocio()
        {
            ConfiguracionPaisDatos = new List<BEConfiguracionPaisDatos>();
        }

        public bool BloqueoProductoDigital { get; set; }
        public List<BEConfiguracionPaisDatos> ConfiguracionPaisDatos { get; set; }
    }
}