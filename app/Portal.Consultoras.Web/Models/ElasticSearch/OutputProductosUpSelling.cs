using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.ElasticSearch
{
    public class OutputProductosUpSelling
    {
        public bool success { get; set; }
        public string message { get; set; }
        public IList<EstrategiaPersonalizadaProductoModel> result { get; set; }
    }
}