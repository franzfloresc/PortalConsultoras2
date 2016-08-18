using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaLiquidacionModel
    {
        public bool MostrarVerMas { get; set; }

        public List<OfertaProductoModel> ListaProductos { get; set; }
    }
}