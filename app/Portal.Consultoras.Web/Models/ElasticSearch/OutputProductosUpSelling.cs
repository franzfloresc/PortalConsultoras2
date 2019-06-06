using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.ElasticSearch
{
    public class OutputProductosUpSelling
    {
        public bool success { get; set; }
        public string message { get; set; }
        public IList<EstrategiaPersonalizadaProductoModel> result { get; set; }
    }
}