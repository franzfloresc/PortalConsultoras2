using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Recomendaciones
{
    public class RecomendacionesModel
    {
        public int Total { get; set; }
        public IList<Productos> Productos { get; set; }
    }
}