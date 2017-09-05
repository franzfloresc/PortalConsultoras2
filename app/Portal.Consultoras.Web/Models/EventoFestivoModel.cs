using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class EventoFestivoModel
    {
        public string Nombre { get; set; }
        public string Alcanse { get; set; }
        public string Periodo { get; set; }
        public string Inicio { get; set; }
        public string Fin { get; set; }
        public string Perzonalizacion { get; set; }
        public bool Estado { get; set; }
    }
}