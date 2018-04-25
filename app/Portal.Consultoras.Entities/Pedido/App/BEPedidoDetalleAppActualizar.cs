using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEPedidoDetalleAppActualizar
    {
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public short ClienteID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int UsuarioPrueba { get; set; }
        [DataMember]
        public int AceptacionConsultoraDA { get; set; }
    }
}
