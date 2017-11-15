using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionPaisDatosDetalleModel : ICloneable
    {
        public string Valor1 { get; set; }
        public string Valor2 { get; set; }
        public string Valor3 { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}