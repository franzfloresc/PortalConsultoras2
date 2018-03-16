namespace Portal.Consultoras.Web.Models
{
    public class EventoPostulanteModel
    {
        public int EventoID { get; set; }
        public string Fecha { get; set; }
        public int TipoEventoId { get; set; }
        public string Evento { get; set; }
        public string Observacion { get; set; }
        public string ObservacionParte2 { get; set; }
    }
}