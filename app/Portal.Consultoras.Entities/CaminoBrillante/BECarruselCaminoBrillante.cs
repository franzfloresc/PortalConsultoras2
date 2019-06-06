using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BECarruselCaminoBrillante
    {
        [DataMember]
        public List<BEOfertaCaminoBrillante> Items { get; set; }
        [DataMember]
        public bool VerMas { get; set; }

        public BECarruselCaminoBrillante() {
            Items = new List<BEOfertaCaminoBrillante>();
            VerMas = true;
        }
    }

}