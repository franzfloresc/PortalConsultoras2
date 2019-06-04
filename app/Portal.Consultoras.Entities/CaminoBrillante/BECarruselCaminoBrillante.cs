using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BECarruselCaminoBrillante
    {
        [DataMember]
        public List<BEItemCarruselCaminoBrillante> Items { get; set; }
        [DataMember]
        public bool VerMas { get; set; }

        public BECarruselCaminoBrillante() {
            Items = new List<BEItemCarruselCaminoBrillante>();
            VerMas = true;
        }
    }

    [DataContract]
    public class BEItemCarruselCaminoBrillante
    {
        [DataMember]
        public BEKitCaminoBrillante Kit { get; set; }
        [DataMember]
        public BEDemostradoresCaminoBrillante Demostrador { get; set; }
    }

}