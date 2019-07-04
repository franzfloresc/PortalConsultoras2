using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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