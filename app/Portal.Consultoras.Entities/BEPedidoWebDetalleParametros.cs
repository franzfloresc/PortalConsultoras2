using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebDetalleParametros
    {
        [DataMember]
        public int PaisId { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public long ConsultoraId { get; set; }
        [DataMember]
        public string Consultora { get; set; }
        [DataMember]
        public bool EsBpt { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int NumeroPedido { get; set; }
    }
}
