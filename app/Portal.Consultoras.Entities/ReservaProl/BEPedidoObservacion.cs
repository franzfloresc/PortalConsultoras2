using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ReservaProl
{
    [DataContract]
    public class BEPedidoObservacion
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Caso { get; set; }
    }
}
