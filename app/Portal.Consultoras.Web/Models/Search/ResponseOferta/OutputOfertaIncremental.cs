    using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseOferta
{
    public class OutputOfertaIncremental
    {
        public bool success { get; set; }
        public string message { get; set; }
        public ResultProductos result { get; set; }
    }

    public class ResultProductos
    {
        public List<Estructura.Estrategia> cross { get; set; }
        public List<Estructura.Estrategia> sug { get; set; }
    }
}