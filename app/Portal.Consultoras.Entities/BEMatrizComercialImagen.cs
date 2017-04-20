using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMatrizComercialImagen
    {
        [DataMember]
        public string Foto { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }
    }
}
