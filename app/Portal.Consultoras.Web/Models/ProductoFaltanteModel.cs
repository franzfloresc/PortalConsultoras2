using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ProductoFaltanteModel
    {
        public string Categoria { set; get; }
        public int CantidadDetalles { get { return this.Detalle.Count; } }
        public List<BEProductoFaltante> Detalle { set; get; }
    }
}