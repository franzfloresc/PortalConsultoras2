using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BaseEntidad
    {
        [DataMember]
        public int PaisID { get; set; }
    }
}
