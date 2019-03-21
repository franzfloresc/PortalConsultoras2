using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ArmaTuPackModel
    {
        public ArmaTuPackModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
            TieneAtp = false;
            TieneLanding = true;
        }

        public bool TieneAtp { get; set; }
        public bool TieneLanding { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
    }
}