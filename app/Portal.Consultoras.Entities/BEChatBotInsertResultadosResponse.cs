using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEChatBotInsertResultadosResponse
    {
    
        [DataMember]
        public int ResultadoId { get; set; }

        public BEChatBotInsertResultadosResponse()
        {
       
        }
    }
}
