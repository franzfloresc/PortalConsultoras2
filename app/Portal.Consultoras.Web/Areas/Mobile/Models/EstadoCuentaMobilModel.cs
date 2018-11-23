using Portal.Consultoras.Web.Models;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class EstadoCuentaMobilModel
    {
        public string Simbolo { set; get; }
        public string CorreoConsultora { set; get; }
        public string MontoPagarStr { set; get; }
        public string FechaVencimiento { set; get; }
        public string Glosa { get; set; }
        public string MontoStr { get; set; }
        public string FechaUltimoMovimiento { set; get; }
        public string FechaUltimoMovimientoFormatDiaMes { get; set; }
        public List<EstadoCuentaDetalleMobilModel> ListaEstadoCuentaDetalle { get; set; }
        public EstadoCuentaModel UltimoMovimiento { get; set; }

        public bool TienePagoEnLinea { get; set; }
        public bool MostrarPagoEnLinea { get; set; }  
    }
}