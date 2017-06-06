using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class MensajeModel
    {
        public string TextoMensaje { get; set; }
        public string DataRegZonaSeccion { get; set; }
        public string Latitud { get; set; }
        public string Longitud {get;set;}

        public string ResetearBotones { get; set; }
    }
}