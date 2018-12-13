using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.LimiteVenta
{
    [DataContract]
    public class BERespValidarLimiteVenta
    {
        [DataMember]
        public bool TieneLimite { get; set; }
        [DataMember]
        public int UnidadesMaximas { get; set; }

        public BERespValidarLimiteVenta(bool tieneLimite, int unidadesMaximas)
        {
            TieneLimite = tieneLimite;
            UnidadesMaximas = unidadesMaximas;
        }
        public BERespValidarLimiteVenta(bool tieneLimite) : this(tieneLimite, 0) { }
    }
}
