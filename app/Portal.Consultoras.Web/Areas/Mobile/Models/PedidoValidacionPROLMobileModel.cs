using Portal.Consultoras.Web.Models;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoValidacionPROLMobileModel
    {
        public decimal MontoAhorroRevista { get; set; }

        public string CodigoISO { get; set; }

        public bool ObservacionInformativa { get; set; }

        public bool ObservacionRestrictiva { get; set; }

        public bool ErrorPROL { get; set; }

        public bool Reserva { get; set; }

        public bool ZonaValida { get; set; }

        public string BotonPROL { get; set; }

        public bool EsModificacion { get; set; }

        public bool EsDiaPROL { get; set; }

        public bool PROLSinStock { get; set; }

        public List<ObservacionModel> ListaObservacionesPROL { get; set; }

        public List<PedidoWebDetalleMobilModel> ListaProductos { get; set; }

        public int TipoProl { get; set; }

        public string PeriodoAnalisisPedido { get; set; }

        public bool ZonaNuevoProlM { get; set; }

        public bool ValidacionInteractiva { get; set; }

        public string MensajeValidacionInteractiva { get; set; }

        public decimal MontoAhorroCatalogo { get; set; }

        public decimal MontoDescuento { get; set; }

        public decimal MontoEscala { get; set; }
    }
}