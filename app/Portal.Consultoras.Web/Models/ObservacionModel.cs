using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ObservacionModel
    {
        public string CUV { get; set; }
        public int Tipo { get; set; }
        public string Descripcion { get; set; }
        public int Caso { get; set; }
    }
}