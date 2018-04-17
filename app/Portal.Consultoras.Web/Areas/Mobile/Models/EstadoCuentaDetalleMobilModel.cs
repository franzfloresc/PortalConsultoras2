using System;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class EstadoCuentaDetalleMobilModel
    {
        public string FechaVencimiento { set; get; }
        public string FechaVencimientoFormatDiaMes { get; set; }
        public string Glosa { get; set; }
        public string MontoStr { get; set; }
        public DateTime Fecha { get; set; }
        public int TipoMovimiento { get; set; }
    }
}