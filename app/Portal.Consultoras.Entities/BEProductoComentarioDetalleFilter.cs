using System;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoComentarioFilter
    {
        [DataMember]
        public Int16 Estado { get; set; }

        [DataMember]
        public Int16 Tipo { get; set; }

        [DataMember]
        public string Valor { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int Limite { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public Int16 Ordenar { get; set; }

        public BEProductoComentarioFilter()
        { }

        
    }
}