using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultarEstadoCrediticiaModel
    {
        public int SolicitudPostulanteID { get; set; }

        public int EstadoBuroCrediticioID { get; set; }

        public string Mensaje { get; set; }
    }
}