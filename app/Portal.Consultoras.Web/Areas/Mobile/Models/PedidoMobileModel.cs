using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoMobileModel
    {
        public List<BEEstrategia> ListaEstrategias { get; set; }

        public int PaisId { get; set; }

        public string Simbolo { get; set; }

        public decimal Total { get; set; }
        public string TotalStr { get; set; }

        public string DescripcionTotal { get; set; }

        public decimal TotalMinimo { get; set; }
        public string TotalMinimoStr { get; set; }

        public string DescripcionTotalMinimo { get; set; }

        public List<BEPedidoWebDetalle> ListaProductos { get; set; }

        public int CantidadProductos { get; set; }

        public string CampaniaActual { get; set; }
        
        public string CampaniaNro { get; set; }

        public string DescripcionCampaniaActual
        {
            get
            {
                return "C-" + (string.IsNullOrEmpty(CampaniaActual) ? "00" : CampaniaActual.Substring(CampaniaActual.Length - 2));
            }
        }

        public string CodigoIso { get; set; }

        public List<ServiceCliente.BECliente> ListaClientes { get; set; }

        public int ClienteId { get; set; }

        public string Nombre { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }
        
        public string GananciaFormat { get; set; }

    }
}