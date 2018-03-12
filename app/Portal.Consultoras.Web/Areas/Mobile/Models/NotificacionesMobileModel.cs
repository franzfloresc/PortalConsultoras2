using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class NotificacionesMobileModel
    {

        public string NombreConsultora { get; set; }
        public List<BENotificaciones> ListaNotificaciones { get; set; }
        public List<BENotificacionesDetalle> ListaNotificacionesDetalle { get; set; }
        public List<BENotificacionesDetallePedido> ListaNotificacionesDetallePedido { get; set; }
        public int Origen { get; set; }
        public string Observaciones { get; set; }
        public int estado { get; set; }
        public bool FacturaHoy { get; set; }
        public DateTime FechaFacturacion { get; set; }
        public int Campania { get; set; }
        public string Asunto { get; set; }
        public bool TieneDescuentoCuv { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Descuento { get; set; }
        public decimal Total { get; set; }
        public Converter<decimal, string> DecimalToString { get; set; }
    }
}