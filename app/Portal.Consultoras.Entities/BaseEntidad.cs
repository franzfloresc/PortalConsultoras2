using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BaseEntidad
    {
        [DataMember]
        public int PaisID { get; set; }
    }
}
