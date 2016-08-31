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

    public class NumericFields
    {
    }

    public class BooleanFields
    {
    }

    public class TextFields
    {
        public string brand { get; set; }
        public string promotion_code { get; set; }
    }

    public class ListFields
    {
    }

    public class DateFields
    {
    }

    public class AddInfo
    {
        public NumericFields numericFields { get; set; }
        public BooleanFields booleanFields { get; set; }
        public TextFields textFields { get; set; }
        public ListFields listFields { get; set; }
        public DateFields dateFields { get; set; }
    }

    public class Deal
    {
        public string id { get; set; }
        public string title { get; set; }
        public string url { get; set; }
        public string img { get; set; }
        public int original_price { get; set; }
        public int current_price { get; set; }
        public AddInfo add_info { get; set; }
    }
}