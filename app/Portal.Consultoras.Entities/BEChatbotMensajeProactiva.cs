using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEChatbotProactivaMensaje
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string NombreMensaje { get; set; }
        [DataMember]
        public List<Tuple<string, string>> Variables { get; set; }
    }
}
