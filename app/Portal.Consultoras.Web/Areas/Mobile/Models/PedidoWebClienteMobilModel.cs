using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable()]
    public class PedidoWebClienteMobilModel
    {
        public PedidoWebClienteMobilModel()
        {
            ListaPedidoWebDetalleProductos = new List<PedidoWebDetalleMobilModel>();
        }

        public int CampaniaID { set; get; }

        public Int16 ClienteID { set; get; }

        public string Nombre { get; set; }

        public string eMail { get; set; }

        public decimal ImporteTotalPedido { get; set; }

        public string CUV { get; set; }

        public string DescripcionProd { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnidad { get; set; }

        public decimal ImporteTotal { get; set; }

        public decimal ImportePagar { get; set; }

        public decimal ImporteDescuento { get; set; }

        public int PedidoID { get; set; }

        public List<PedidoWebDetalleMobilModel> ListaPedidoWebDetalleProductos { get; set; }

    }
}