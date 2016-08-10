using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class JsTreeModel
    {
        public string data;
        public JsTreeAttribute attr;
        public JsTreeModel[] children;
    }

    public class JsTreeModel2
    {
        public string data;
        public JsTreeAttribute_ attr;
        public JsTreeModel2[] children;
    }

    public class JsTreeAttribute
    {
        public int id;
        public bool selected;
        public string @class;
        public Int16 diasDuracionCronograma;
    }

    public class JsTreeAttribute_
    {
        public int tipo;
        public string CodigoZona;
        public string CodigoCampania;
        public string CodigoConsultora;
        public bool selected;
        public string @class;
    }
}