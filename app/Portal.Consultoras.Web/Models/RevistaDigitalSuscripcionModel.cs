using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalSuscripcionModel
    {
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public DateTime FechaSuscripcion { get; set; }
        [DataMember]
        public DateTime FechaDesuscripcion { get; set; }
        [DataMember]
        public int EstadoRegistro { get; set; }
        [DataMember]
        public int EstadoEnvio { get; set; }
        [DataMember]
        public string IsoPais { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string EMail { get; set; }
    }
}