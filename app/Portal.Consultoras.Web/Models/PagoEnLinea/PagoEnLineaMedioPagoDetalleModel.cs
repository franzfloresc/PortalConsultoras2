using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaMedioPagoDetalleModel
    {
        public int PagoEnLineaMedioPagoDetalleId { get; set; }
        public int PagoEnLineaMedioPagoId { get; set; }
        public string Descripcion { get; set; }
        public int Orden { get; set; }
        public string TipoVisualizacionTyC { get; set; }
        public string TerminosCondiciones { get; set; }
        public string TipoPasarelaCodigoPlataforma { get; set; }
        public string ExpresionRegularTarjeta { get; set; }
        public string TipoTarjeta { get; set; }
        public string RutaIcono { get; set; }
        public bool Estado { get; set; }
    }
}