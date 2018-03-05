using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionPaisComponenteModel : ICloneable
    {
        public string ConfiguracionPaisComponenteID { get; set; }
        public int ConfiguracionPaisID { get; set; }
        public string PalancaCodigo { get; set; }
        public int CampaniaID { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }

        public int Accion { get; set; }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}