using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Recomendaciones
{
    [Serializable]
    public class RecomendacionesConfiguracionModel
    {
        public RecomendacionesConfiguracionModel()
        {
            ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>();
        }

        public IList<ConfiguracionPaisDatosModel> ConfiguracionPaisDatos { get; set; }
    }
}