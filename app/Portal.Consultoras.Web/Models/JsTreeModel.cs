using System;

namespace Portal.Consultoras.Web.Models
{
    public class JsTreeModel
    {
        public string data { get; set; }
        public JsTreeAttribute attr { get; set; }
        public JsTreeModel[] children { get; set; }
    }

    public class JsTreeModel2
    {
        public string data { get; set; }
        public JsTreeAttribute_ attr { get; set; }
        public JsTreeModel2[] children { get; set; }
    }

    public class JsTreeAttribute
    {
        public int id { get; set; }
        public bool selected { get; set; }
        public string @class { get; set; }
        public Int16 diasDuracionCronograma { get; set; }
    }

    public class JsTreeAttribute_
    {
        public int tipo { get; set; }
        public string CodigoZona { get; set; }
        public string CodigoCampania { get; set; }
        public string CodigoConsultora { get; set; }
        public bool selected { get; set; }
        public string @class { get; set; }
    }
}