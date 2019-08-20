using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEChatBotInsertDetalleResultadosRequest
    {
        [DataMember]
        public int ResultadosID { get; set; }

        [DataMember]
        public DateTime FechaFin { get; set; }

        [DataMember]
        public List<RespuestasModel> Respuestas { get; set; }

        [DataContract]
        public class RespuestasModel
        {
            
            [DataMember]
            public int ResultadosID { get; set; }
            [DataMember]
            public int PreguntaID { get; set; }
            [DataMember]
            public int CalificacionID { get; set; }
            [DataMember]
            public string Cualitativo { get; set; }

        }

    }

    
}
