using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.ServiceCatalogoPersonalizado.Entities
{
    public class ProductoJetlore
    {
        public List<Deal> deals { get; set; }
    }

    public class Deal
    {
        public string id { get; set; }
        public string title { get; set; }
        public string url { get; set; }
        public string img { get; set; }
        public int original_price { get; set; }
        public int current_price { get; set; }
        public object add_info { get; set; }
    }
}