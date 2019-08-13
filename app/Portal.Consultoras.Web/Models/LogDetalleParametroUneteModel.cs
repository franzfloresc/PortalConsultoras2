using System;

namespace Portal.Consultoras.Web.Models
{
    public class LogDetalleParametroUneteModel
    {
        public int IdLogDetalle { get; set; }

        public Int32 IdParametroUnete { get; set; }

        public string Nombre { get; set; }

        public int? Valor { get; set; }

        public string Descripcion { get; set; }

        public int FKIdTipoParametro { get; set; }

        public int FKIdParametroUnete { get; set; }

        public int Estado { get; set; }

        public string CodigoUsuario { get; set; }

        public DateTime FechaHora { get; set; }

        public string Fecha { get; set; }

        public string Hora { get; set; }

        public int IdCarga { get; set; }
    }
}