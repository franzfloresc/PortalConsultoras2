using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable()]
    public class PedidoWebMobilModel
    {
        public PedidoWebMobilModel()
        {
            ListaPedidoWebDetalle = new List<PedidoWebClienteMobilModel>();
        }

        public int PedidoId { get; set; }

        public int PaisID { get; set; }

        public string CodigoISO { get; set; }

        public string Simbolo { get; set; }

        public int CampaniaID { get; set; }

        public bool TieneDescuentoCuv { get; set; }

        public decimal ImporteTotal { get; set; }

        public string ImporteTotalString { get; set; }

        public decimal Descuento { get; set; }

        public string DescuentoString { get; set; }

        public int CantidadProductos { get; set; }

        public decimal Flete { get; set; }

        public decimal Subtotal { get; set; }

        public string SubtotalString { get; set; }

        public string EstadoPedidoDesc { get; set; }

        public string Direccion { get; set; }

        public string CodigoUsuarioCreacion { get; set; }

        public List<PedidoWebClienteMobilModel> ListaPedidoWebDetalle { get; set; }

        public List<ServiceCliente.BECliente> ListaClientes { get; set; }
    }
}