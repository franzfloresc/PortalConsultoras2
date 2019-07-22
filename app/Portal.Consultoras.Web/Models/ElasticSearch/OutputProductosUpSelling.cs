using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.ElasticSearch
{
    public class OutputProductosUpSelling
    {
        public bool success { get; set; }
        public string message { get; set; }
        public List<Search.ResponseOferta.Estructura.Estrategia> result { get; set; }
    }
}