using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Search.ResponsePromociones.Estructura
{
    public class PromocionModel
    {
        public string CodigoObservacion { get; set; }
        public string Observacion { get; set; }
        public Estrategia Promocion { get; set; }
        public List<Estrategia> Condiciones { get; set; }
    }
}