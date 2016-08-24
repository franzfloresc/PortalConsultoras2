using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoDetalleMobileModel
    {
        public List<BEPedidoWebDetalle> Detalle { get; set; }

        public decimal Total { get; set; }

        public string DescripcionTotal { get; set; }

        public decimal TotalMinimo { get; set; }

        public string DescripcionTotalMinimo { get; set; }
        
        public string Simbolo { get; set; }

        public bool EliminadoTemporal { get; set; }
        
        public int PaisID {get; set;}

        public string CodigoISO { get; set; }

        public string Email { get; set; }

        public int ModificacionPedidoProl { get; set; }

        public bool ModificaPedidoReservado { get; set; }

        public string FlagValidacionPedido { get; set; }

        public string BotonPROL { get; set; }

        public string MensajeGuardarCO { get; set; }

        public int EstadoPedido { get; set; }

        public int CantidadProductos { get; set; }

        public string CampaniaActual { get; set; }

        public string DescripcionCampaniaActual
        {
            get
            {
                return "C-" + (string.IsNullOrEmpty(CampaniaActual) ? "00" : CampaniaActual.Substring(CampaniaActual.Length - 2));
            }
        }


        public bool PedidoConProductosExceptuadosMontoMinimo { get; set; }

        public bool PedidoConDescuentoCuv { get; set; }

        public decimal SubTotal { get; set; }

        public string DescripcionSubTotal { get; set; }

        public decimal Descuento { get; set; }

        public string DescripcionDescuento { get; set; }
        public string MontoConDsctoStr { get; set; }
        
        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoAhorroRevista { get; set; }

        public string GananciaFormat { get; set; }

        public string MensajeCierreCampania { get; set; }

        public string FechaFacturacionPedido { get; set; }
    }
}