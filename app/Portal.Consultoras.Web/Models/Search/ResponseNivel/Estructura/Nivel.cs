using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseNivel.Estructura
{
    public class Nivel
    {
        public string _id { get; set; }
        public int NivelId { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }
}