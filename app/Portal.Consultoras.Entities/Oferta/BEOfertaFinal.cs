using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEOfertaFinal
    {
        public BEOfertaFinal()
        {
            Estado = false;
            Algoritmo = string.Empty;
        }

        [DataMember]
        public bool Estado { get; set; }
        [DataMember]
        public string Algoritmo { get; set; }
    }
}
