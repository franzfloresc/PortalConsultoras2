using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEntityBase
    {
        [DataMember]
        public string CreatedBy { get; set; }
        [DataMember]
        public DateTime? CreateOn { get; set; }
        [DataMember]
        public string CreateHost { get; set; }
        [DataMember]
        public string ModifiedBy { get; set; }
        [DataMember]
        public DateTime? ModifiedOn { get; set; }
        [DataMember]
        public int ModifiedHost { get; set; }
        [DataMember]
        public bool Status { get; set; }
    }
}
