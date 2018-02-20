using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionPaisDatosModel : ICloneable
    {
        public int ConfiguracionPaisID { get; set; }
        public string PalancaCodigo { get; set; }
        public int CampaniaID { get; set; }
        public string Codigo { get; set; }
        public string Valor1 { get; set; }
        public string Valor2 { get; set; }
        public string Valor3 { get; set; }
        public string Descripcion { get; set; }
        public string Componente { get; set; }
        public bool Estado { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}