using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [Serializable]
    [DataContract]
    public class BEContenidoRevista
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public string NroCampania { get; set; }
        [DataMember]
        public string RutaImagenPortada { get; set; }
    }
}
