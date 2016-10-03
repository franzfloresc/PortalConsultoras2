using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoDetalleMobileModel
    {
        public List<PedidoDetalleMobileDetalleModel> Detalle { get; set; }
        public decimal Total { get; set; }

        public string DescripcionTotal { get; set; }

        public decimal TotalMinimo { get; set; }

        public string DescripcionTotalMinimo { get; set; }

        public decimal GanaciaEstimada { get; set; }
        public string DescripcionGanaciaEstimada { get; set; }

        public bool MostrarEscalaDescuento { get; set; }
        public decimal MontoEscalaDescuento { get; set; }
        public string DescripcionMontoEscalaDescuento { get; set; }
        public int PorcentajeEscala { get; set; }      
        
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

        public string HoraCierre { get; set; }

        public string Prol { get; set; }    /* SB20-287 */
        public string ProlTooltip { get; set; } /* SB20-287 */

        public void SetDetalleMobileFromDetalleWeb(List<BEPedidoWebDetalle> listDetalleWeb)
        {
            this.Detalle = new List<PedidoDetalleMobileDetalleModel>();
            foreach(var detalleWeb in listDetalleWeb)
            {
                this.Detalle.Add(new PedidoDetalleMobileDetalleModel {
                    PedidoDetalleID = detalleWeb.PedidoDetalleID,
                    MarcaID = detalleWeb.MarcaID,
                    Cantidad = detalleWeb.Cantidad,
                    PrecioUnidad = detalleWeb.PrecioUnidad,
                    ImporteTotal = detalleWeb.ImporteTotal,
                    Nombre = detalleWeb.Nombre,
                    Mensaje = detalleWeb.Mensaje,
                    DescripcionProd = detalleWeb.DescripcionProd,
                    CUV = detalleWeb.CUV,
                    IndicadorMontoMinimo = detalleWeb.IndicadorMontoMinimo,
                    TipoPedido = detalleWeb.TipoPedido,
                    ConfiguracionOfertaID = detalleWeb.ConfiguracionOfertaID,
                    IndicadorOfertaCUV = detalleWeb.IndicadorOfertaCUV,
                    TipoObservacion = detalleWeb.TipoObservacion
                });
            }
        }

        /* SB20-565 - INICIO */
        public int OfertaFinal { get; set; }
        public bool EsOfertaFinalZonaValida { get; set; }
        public List<BEEscalaDescuento> ListaParametriaOfertaFinal { get; set; }
        public bool EsFacturacion { get; set; }
        public bool EsConsultoraNueva { get; set; }
        public Portal.Consultoras.Web.Models.BarraConsultoraModel DataBarra { get; set; }
        public decimal MontoMinimo { get; set; }
        public decimal MontoMaximo { get; set; }
        /* SB20-565 - FINAL */
    }
}