using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEListaConsultoraCatalogo
    {
        [DataMember]
        public int NumeroRegistros { get; set; }

        [DataMember]
        public List<BEConsultoraCatalogo> ConsultorasCatalogos { get; set; }
    }
}
