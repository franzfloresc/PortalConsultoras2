using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEChatBotListResultados : BaseEntidad
    {
       
        [DataMember]
        public int ResultadosID { get; set; }
        [DataMember]
        public string OperadorID { get; set; }
        [DataMember]
        public string NombreOperador { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreConsultora { get; set; }
        [DataMember]
        public DateTime? FechaInicio { get; set; }
        [DataMember]
        public DateTime? FechaFin { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string Pais { get; set; }
        [DataMember]
        public string ConversacionID { get; set; }
        [DataMember]
        public string CanalDescripcion { get; set; }
        [DataMember]
        public int Resp1 { get; set; }
        [DataMember]
        public int Resp2 { get; set; }
        [DataMember]
        public int Resp3 { get; set; }
        [DataMember]
        public string RespDescrip1 { get; set; }
        [DataMember]
        public string RespDescrip2 { get; set; }
        [DataMember]
        public string RespDescrip3 { get; set; }
        [DataMember]
        public string Cualitativo { get; set; }

    }
}
