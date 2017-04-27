using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceUnete;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Web.Annotations;

namespace Portal.Consultoras.Web.Models
{
    public class EventoPostulanteModel
    {
        public int EventoID { get; set; }
        public string Fecha { get; set; }
        public int TipoEventoId { get; set; }
        public string Evento { get; set; }
        public string Observacion { get; set; }
    }
}