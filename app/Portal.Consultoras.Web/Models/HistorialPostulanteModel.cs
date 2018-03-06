using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class HistorialPostulanteModel
    {
        public int SolicitudPostulanteID { get; set; }
        public string CodigoISO { get; set; }

        public string NombreCompleto { get; set; }
        public List<EventoPostulanteModel> ListaEventos { get; set; }
    }
}