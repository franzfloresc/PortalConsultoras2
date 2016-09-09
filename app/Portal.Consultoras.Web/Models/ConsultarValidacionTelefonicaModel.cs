using System;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultarValidacionTelefonicaModel
    {
        public int SolicitudPostulanteId { get; set; }
        public int EstadoTelefonico { get; set; }
        public int? MotivoRechazoTelefonico { get; set; }
        public DateTime? FechaRegValidacionTelefonica { get; set; }
    }
}