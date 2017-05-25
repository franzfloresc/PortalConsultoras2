using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalSuscripcionModel
    {
        public string CodigoConsultora { get; set; }
        public int CampaniaID { get; set; }
        public DateTime FechaSuscripcion { get; set; }
        public DateTime FechaDesuscripcion { get; set; }
        public int EstadoRegistro { get; set; }
        public int EstadoEnvio { get; set; }
        public string IsoPais { get; set; }
        public string CodigoZona { get; set; }
        public string EMail { get; set; }
    }
}