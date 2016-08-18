using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaMatrizModel
    {
        public IEnumerable<OfertaProductoModel> lstOfertaProductoModel { get; set; }
    }
}