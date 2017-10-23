using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EventoFestivoModel
    {
        public string Nombre { get; set; }
        public string Alcance { get; set; }
        public string Periodo { get; set; }
        public string Inicio { get; set; }
        public string Fin { get; set; }
        public string Personalizacion { get; set; }
        public bool Estado { get; set; }
    }
}