using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEChatBotInsertResultadosRequest : BaseEntidad
    {       
        [DataMember]
        public string OperadorID { get; set; }
        [DataMember]
        public string NombreOperador { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreConsultora { get; set; }
        [DataMember]
        public DateTime FechaInicio { get; set; }
        [DataMember]
        public DateTime FechaFin { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string Pais { get; set; }
        [DataMember]
        public string ConversacionID { get; set; }
        [DataMember]
        public int CanalID { get; set; }        
    }
}
