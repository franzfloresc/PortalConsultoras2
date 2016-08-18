using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class EstadoCuentaMobilModel
    {
        public string MontoPagar { set; get; }
        public string Simbolo { set; get; }
        public string FechaVencimiento { set; get; }
        public string CorreoConsultora { set; get; }
        public string FechaConvertida { set; get; }
        public DateTime Fecha { get; set; }
        public string Glosa { get; set; }
        public decimal Cargo { get; set; }
        public decimal Abono { get; set; }
        public int TipoMovimiento { get; set; }
        public List<EstadoCuentaMobilModel> ListaEstadoCuenta { get; set; }
        public int PaisID { get; set; }
        public string CodigoISO { get; set; }
    }
}