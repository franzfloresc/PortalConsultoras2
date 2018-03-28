using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoWebSetModel
    {
        public int SetId { get; set; }

        public int PedidoId { get; set; }

        public string NombreSet { get; set; }

        public int Cantidad { get; set; }

        public decimal Precio { get; set; }

        public int TipoEstrategiaId { get; set; }

        /// <summary>
        /// Campana
        /// </summary>
        public int CodigoCampana { get; set; }

        public long ConsultoraId { get; set; }

        public int OrdenPedido { get; set; }

        public IList<PedidoWebSetDetalleModel> Detalles { get; set; }

        //audit
    }
}
