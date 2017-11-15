using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionPaisDatosModel : ICloneable
    {
        public int ConfiguracionPaisID { get; set; }
        public int CampaniaId { get; set; }
        public int BloquearDiasAntesFacturar { get; set; }
        public int CantidadCampaniaEfectiva { get; set; }
        public string NombreComercialActiva { get; set; }
        public string NombreComercialNoActiva { get; set; }
        public string LogoComercialActiva { get; set; }
        public string LogoComercialNoActiva { get; set; }

        public IList<ConfiguracionPaisDatosDetalleModel> ConfiguracionPaisDatosDetalle { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}