using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Recomendaciones
{
    public class RecomendacionesModel
    {
        public int Total { get; set; }
        public IList<Productos> Productos { get; set; }
    }
}