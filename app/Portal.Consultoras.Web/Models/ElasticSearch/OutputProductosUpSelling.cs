using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.ElasticSearch
{
    public class OutputProductosUpSelling
    {
        public bool success { get; set; }
        public string message { get; set; }
        public IList<EstrategiaPersonalizadaProductoModel> result { get; set; }
    }

    public class OutputProductosIncremental
    {
        public bool success { get; set; }
        public string message { get; set; }
        public ResultProductos result { get; set; }
    }
    public class ResultProductos
    {
        public IList<EstrategiaPersonalizadaProductoModel> crosssell { get; set; }
        public IList<EstrategiaPersonalizadaProductoModel> suggested { get; set; }
    }
}