using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class EstadoCuentaModel
    {
        public string MontoPagar { set; get; }
        public string Simbolo { set; get; }
        public string FechaVencimiento { set; get; }
        public string CorreoConsultora { set; get; }

        public DateTime Fecha { get; set; }
        public string Glosa { get; set; }
        public decimal Cargo { get; set; }
        public decimal Abono { get; set; }
        public int TipoMovimiento { get; set; }
        public string FechaVencimientoFormatDiaMes { get; set; }

        public EstadoCuentaModel()
        {
        }
    }
}