using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoWebSetDetalleModel
    {
        public int SetDetalleId { get; set; }
        public int SetId { get; set; }

        public string CUV { get; set; }

        public int Cantidad { get; set; }

        public int FactorRepeticion { get; set; }

        public int PedidoDetalleId { get; set; }

        public int TipoOfertaSisID { get; set; }
    }
}
