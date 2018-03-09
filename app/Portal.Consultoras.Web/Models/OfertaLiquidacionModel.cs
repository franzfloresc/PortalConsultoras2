using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaLiquidacionModel
    {
        public bool MostrarVerMas { get; set; }

        public List<OfertaProductoModel> ListaProductos { get; set; }
    }
}