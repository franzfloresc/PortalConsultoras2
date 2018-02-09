using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class HerramientasVentaModel
    {
        public HerramientasVentaModel()
        {
            TieneHV = false;
        }

        public int ConfiguracionPaisID { get; set; }
        public int CampaniaID { get; set; }
        public int BloquearDiasAntesFacturar { get; set; }
        public bool TieneHV { get; set; }

        public bool TieneHerramientasVenta()
        {
            return TieneHV;
        }
    }
}