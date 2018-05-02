using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    public class BEOfertaDelDia
    {
        public BEOfertaDelDia()
        {
            ConfiguracionPaisDatos = new List<BEConfiguracionPaisDatos>();
        }

        public IList<BEConfiguracionPaisDatos> ConfiguracionPaisDatos { get; set; }
        public bool BloqueoProductoDigital { get; set; }
    }
}
