using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class SeguimientoMobileModel
    {
        public int PaisId { get; set; }
        public string CodigoConsultora { get; set; }
        public string NumeroPedido { get; set; }
        public int Campana { get; set; }
        public string Estado { get; set; }
        public int Etapa { get; set; }
        public string Situacion { get; set; }
        public DateTime? Fecha { get; set; }
        public string DiaMes { get; set; }
        public string HoraMinuto { get; set; }
        public List<SeguimientoMobileModel> ListaEstadoSeguimiento { get; set; }
        public string ValorTurno { get; set; }
        public string HoraEstimadaDesdeHasta { get; set; } = string.Empty;
    }
}