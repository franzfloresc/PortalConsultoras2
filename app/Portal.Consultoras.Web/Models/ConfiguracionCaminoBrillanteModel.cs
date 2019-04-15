using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionCaminoBrillante
    {
        public string Logro { get; set; }
        public string Indicador { get; set; }
        public int Orden { get; set; }
        public string Valor { get; set; }
        public string ComoLograrlo_Estado { get; set; }
        public string ComoLograrlo_Titulo { get; set; }
        public string ComoLograrlo_Descripcion { get; set; }
        public string Estado { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
    }
}