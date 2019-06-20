using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BEProductoEstraProgNuevas
    {
        [DataMember]
        public string Cuv { get; set; }
        [DataMember]
        public bool EsCuponIndependiente { get; set; }
    }
}
