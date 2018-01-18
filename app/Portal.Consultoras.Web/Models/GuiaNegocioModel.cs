using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class GuiaNegocioModel
    {
        public GuiaNegocioModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public bool TieneGND { get; set; }
        public bool BloqueoProductoDigital { get; set; }
        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
    }
}